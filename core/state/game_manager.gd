# res://core/state/game_manager.gd
extends Node

# --- Perfil del Jugador en Memoria ---
var username: String = ""
var watt: float = 0.0
var kilowat: float = 0.0
var casino_tokens: float = 0.0

# --- Potencia en KWP ---
var total_kwp: float = 0.0
var temporary_kwp: float = 0.0
var referral_power_kwp: float = 0.0

# --- Reparto de Minería (% Watts vs % kW) ---
var mining_split_watt: float = 50.0
var last_split_change_time: int = 0

var active_kw_rates: Dictionary = {}
var total_kw_per_minute: float = 0.0

var has_claimed_welcome_gift: bool = false
var open_battle_pass_on_room: bool = false
var target_shop_category: String = "generators"

# --- Fondos de Habitación ---
var unlocked_backgrounds: Array = ["default"]
var equipped_background: String = "default"

# --- Registro de Cooldowns y Timers ---
var minigame_cooldown_ticks: Dictionary = {}
var active_generator_powers: Dictionary = {}
var has_active_generator: bool = false

var last_minigame_time: int = 0
var decay_timer: float = 0.0
var online_quest_timer: float = 0.0
var cycle_60s_timer: float = 0.0

# --- Caché del Inventario y Repuestos ---
var player_racks: Array = []
var player_generators: Array = []
var player_parts: Array = [] # [{part_type: "cable", part_level: 1, quantity: 10}]

# --- Estado Persistente del Chat y Amigos ---
var saved_chat_channel_mode: String = "global"
var saved_active_friend_id: String = ""
var saved_active_friend_name: String = ""
var saved_is_chat_minimized: bool = false
var pending_friend_requests_count: int = 0

# --- Estado RPG del Jugador (Fase 1) ---
var player_materials: Array = [] # [{ "material_type": "cobre", "tier": 1, "quantity": 10 }]
var player_professions: Dictionary = {
	"chatarrero_level": 0, "chatarrero_xp": 0,
	"ingeniero_level": 0, "ingeniero_xp": 0,
	"corredor_level": 0, "corredor_xp": 0
}
var player_talents: Array = []
var talent_points: int = 0

var global_zoom: Node = null

func _ready() -> void:
	if not EventBus.auth_signed_out.is_connected(_on_signed_out):
		EventBus.auth_signed_out.connect(_on_signed_out)
	_setup_global_zoom()

func _setup_global_zoom() -> void:
	# Eliminar cualquier controlador huérfano en el viewport raíz
	var root_node = get_tree().root
	for child in root_node.get_children():
		if child.name.begins_with("GlobalZoomController") or child.name.begins_with("OldZoom"):
			child.queue_free()

func _process(delta: float) -> void:
	_process_online_power_decay(delta)
	_process_online_quest_timer(delta)
	_process_continuous_mining(delta)

# ====================================================================
# MINADO CONTINUO Y ECONOMÍA
# ====================================================================

func _process_continuous_mining(delta: float) -> void:
	if not has_active_generator or total_kw_per_minute <= 0.0:
		return
		
	cycle_60s_timer += delta
	if cycle_60s_timer >= 60.0:
		cycle_60s_timer -= 60.0
		
		var watt_share: float = mining_split_watt / 100.0
		var kilo_share: float = (100.0 - mining_split_watt) / 100.0
		
		var effective_min_rate: float = total_kw_per_minute * 0.90
		var earned_kilo: float = effective_min_rate * kilo_share
		var earned_watt: float = (effective_min_rate * watt_share) * 1000.0
		
		kilowat += earned_kilo
		watt += earned_watt
		
		EventBus.currencies_updated.emit(watt, kilowat)
		sync_passive_income()

func _process_online_power_decay(delta: float) -> void:
	if temporary_kwp <= 0.0:
		return
		
	decay_timer += delta
	if decay_timer >= 10.0:
		decay_timer = 0.0
		var now: int = int(Time.get_unix_time_from_system())
		var elapsed: int = now - last_minigame_time
		
		if elapsed > 1800:
			var chunk_size: float = 0.000000001
			temporary_kwp = maxf(0.0, temporary_kwp - (chunk_size * (delta / 600.0)))
			_recalc_total_power()

func _process_online_quest_timer(delta: float) -> void:
	online_quest_timer += delta
	if online_quest_timer >= 60.0:
		online_quest_timer = 0.0
		SupabaseClient.send_request("/rest/v1/rpc/track_quest_action", HTTPClient.METHOD_POST, {"p_action_type": "online_minute", "p_amount": 1}, true)

# ====================================================================
# POTENCIA Y GENERADORES
# ====================================================================

func add_temporary_power(amount: float) -> void:
	temporary_kwp += amount
	last_minigame_time = int(Time.get_unix_time_from_system())
	_recalc_total_power()

func set_generator_power(gen_id: String, is_active: bool, kwp_amount: float, kw_rate: float = 0.000000001) -> void:
	if gen_id == "": gen_id = "default_plant"
	if kwp_amount <= 0.0: kwp_amount = 0.000000001
		
	if is_active:
		active_generator_powers[gen_id] = kwp_amount
		active_kw_rates[gen_id] = kw_rate
	else:
		active_generator_powers.erase(gen_id)
		active_kw_rates.erase(gen_id)
		
	_recalc_total_power()

func _recalc_total_power() -> void:
	var gen_sum: float = 0.0
	for p in active_generator_powers.values():
		gen_sum += float(p)
		
	total_kwp = gen_sum + temporary_kwp + referral_power_kwp
	
	var gen_rates_sum: float = 0.0
	for r in active_kw_rates.values():
		gen_rates_sum += float(r)
	total_kw_per_minute = gen_rates_sum + referral_power_kwp
	
	has_active_generator = (active_generator_powers.size() > 0 or referral_power_kwp > 0.0)
	EventBus.power_updated.emit(total_kwp)

# ====================================================================
# SINCRONIZACIÓN CON SUPABASE
# ====================================================================

func load_profile() -> bool:
	if SupabaseClient.current_user_id == "":
		EventBus.profile_error.emit("No hay sesión activa.")
		return false
		
	await SupabaseClient.send_request("/rest/v1/rpc/apply_offline_power_decay", HTTPClient.METHOD_POST, {}, true)
	
	var endpoint: String = "/rest/v1/profiles?id=eq." + SupabaseClient.current_user_id + "&select=*"
	var res: Dictionary = await SupabaseClient.send_request(endpoint, HTTPClient.METHOD_GET, {}, true)
	
	if not res.get("success", false):
		EventBus.profile_error.emit("Error al obtener perfil: " + str(res.get("error", "")))
		return false
		
	var data = res.get("data")
	if typeof(data) == TYPE_ARRAY and data.size() > 0:
		var profile: Dictionary = data[0]
		username = str(profile.get("username", ""))
		watt = float(profile.get("watt", 0.0))
		kilowat = float(profile.get("kilowat", 0.0))
		casino_tokens = float(profile.get("casino_tokens", 0.0))
		temporary_kwp = float(profile.get("temporary_kwp", 0.0))
		referral_power_kwp = float(profile.get("referral_power_kwp", 0.0))
		mining_split_watt = float(profile.get("mining_split_watt", 50.0))
		
		last_split_change_time = _parse_iso_datetime(str(profile.get("last_split_change_at", "")))
		has_claimed_welcome_gift = bool(profile.get("has_claimed_welcome_gift", false))
		
		if not has_claimed_welcome_gift:
			await claim_welcome_gift()

		var raw_bgs = profile.get("unlocked_backgrounds", ["default"])
		if typeof(raw_bgs) == TYPE_ARRAY:
			unlocked_backgrounds = raw_bgs
		elif typeof(raw_bgs) == TYPE_STRING:
			var clean_str = raw_bgs.replace("{", "").replace("}", "").replace('"', "").strip_edges()
			unlocked_backgrounds = clean_str.split(",") if clean_str != "" else ["default"]
		else:
			unlocked_backgrounds = ["default"]
			
		equipped_background = str(profile.get("equipped_background", "default"))
		
		var parsed_mg_time = _parse_iso_datetime(str(profile.get("last_minigame_at", "")))
		last_minigame_time = parsed_mg_time if parsed_mg_time > 0 else int(Time.get_unix_time_from_system())
			
		await load_player_inventory()
		await load_player_rpg_state()
		await sync_passive_income()
		
		_recalc_total_power()
		EventBus.profile_loaded.emit(profile)
		EventBus.currencies_updated.emit(watt, kilowat)
		return true
	return false

func load_player_inventory() -> void:
	var uid: String = SupabaseClient.current_user_id
	if uid == "": return
	
	var res_racks: Dictionary = await SupabaseClient.send_request("/rest/v1/player_racks?user_id=eq." + uid + "&select=*", HTTPClient.METHOD_GET, {}, true)
	if res_racks.get("success", false) and typeof(res_racks.get("data")) == TYPE_ARRAY:
		player_racks = res_racks["data"]
		
	var res_gens: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_player_generators_secure", HTTPClient.METHOD_POST, {}, true)
	if res_gens.get("success", false) and typeof(res_gens.get("data")) == TYPE_DICTIONARY:
		var fetched_gens = res_gens["data"].get("generators", [])
		if typeof(fetched_gens) == TYPE_ARRAY:
			player_generators = fetched_gens

	# Cargar inventario de repuestos
	var res_parts: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_player_parts", HTTPClient.METHOD_POST, {}, true)
	if res_parts.get("success", false) and typeof(res_parts.get("data")) == TYPE_DICTIONARY:
		player_parts = res_parts["data"].get("parts", [])

func sync_passive_income() -> void:
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/sync_generator_income", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var res_prof: Dictionary = await SupabaseClient.send_request("/rest/v1/profiles?id=eq." + SupabaseClient.current_user_id + "&select=watt,kilowat,referral_power_kwp", HTTPClient.METHOD_GET, {}, true)
		if res_prof.get("success", false) and typeof(res_prof.get("data")) == TYPE_ARRAY and res_prof["data"].size() > 0:
			watt = float(res_prof["data"][0].get("watt", watt))
			kilowat = float(res_prof["data"][0].get("kilowat", kilowat))
			referral_power_kwp = float(res_prof["data"][0].get("referral_power_kwp", referral_power_kwp))
			_recalc_total_power()
			EventBus.currencies_updated.emit(watt, kilowat)

# ====================================================================
# TALLER MECÁNICO Y PIEZAS (BLINDADO PARA PARCHE .PCK)
# ====================================================================

## Suma las piezas ganadas en memoria inmediatamente
func add_part_locally(part_type: String, part_level: int, qty: int) -> void:
	var clean_type = part_type.strip_edges().to_lower()
	var found = false
	for p in player_parts:
		var p_t = str(p.get("part_type", "")).strip_edges().to_lower()
		var p_l = int(p.get("part_level", p.get("level", 0)))
		if p_t == clean_type and p_l == part_level:
			p["quantity"] = int(p.get("quantity", 0)) + qty
			found = true
			break
	if not found:
		player_parts.append({
			"part_type": clean_type,
			"part_level": part_level,
			"quantity": qty
		})

## Descuenta piezas en memoria al reparar o mejorar
func deduct_part_locally(part_type: String, part_level: int, qty: int) -> void:
	var clean_type = part_type.strip_edges().to_lower()
	for p in player_parts:
		var p_t = str(p.get("part_type", "")).strip_edges().to_lower()
		var p_l = int(p.get("part_level", p.get("level", 0)))
		if p_t == clean_type and p_l == part_level:
			p["quantity"] = maxi(0, int(p.get("quantity", 0)) - qty)
			break

## Búsqueda flexible insensible a mayúsculas
func get_part_quantity(part_type: String, part_level: int) -> int:
	var target_type = part_type.strip_edges().to_lower()
	for p in player_parts:
		var p_t = str(p.get("part_type", "")).strip_edges().to_lower()
		var p_l = int(p.get("part_level", p.get("level", 0)))
		if p_t == target_type and p_l == part_level:
			return int(p.get("quantity", 0))
	return 0

## Carga directa desde la tabla player_parts de Supabase con fallback a RPC
func load_player_parts() -> void:
	var uid = SupabaseClient.current_user_id
	if uid == "": return

	# 1. Consulta REST directa (rápida y estándar)
	var res = await SupabaseClient.send_request("/rest/v1/player_parts?user_id=eq." + uid + "&select=*&quantity=gt.0", HTTPClient.METHOD_GET, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_ARRAY:
		player_parts = res["data"]
		return

	# 2. Fallback por RPC
	var res_rpc = await SupabaseClient.send_request("/rest/v1/rpc/get_player_parts", HTTPClient.METHOD_POST, {}, true)
	if res_rpc.get("success", false) and typeof(res_rpc.get("data")) == TYPE_DICTIONARY:
		player_parts = res_rpc["data"].get("parts", [])

func repair_generator_secure(gen_db_id: String) -> Dictionary:
	var gen: Dictionary = {}
	for g in player_generators:
		if str(g.get("id", "")) == gen_db_id:
			gen = g
			break

	if gen.is_empty():
		return {"success": false, "error": "Generador no encontrado"}

	var gtype = str(gen.get("generator_type", ""))
	var tier = get_generator_tier(gtype)
	
	# Matriz de requisitos por Tier
	var req_c = 0; var req_v = 0; var req_p = 0; var req_chip = 0; var req_cond = 0
	match tier:
		1: req_c = 6; req_v = 4
		2: req_c = 8; req_v = 5
		3: req_c = 10; req_v = 6; req_p = 4
		4: req_c = 12; req_v = 8; req_chip = 4
		5: req_c = 15; req_v = 10; req_chip = 6; req_cond = 4

	if req_c > 0 and get_part_quantity("cable", tier) < req_c:
		return {"success": false, "error": "Faltan Cables Nv.%d (%d requeridos)" % [tier, req_c]}
	if req_v > 0 and get_part_quantity("ventilador", tier) < req_v:
		return {"success": false, "error": "Faltan Ventiladores Nv.%d (%d requeridos)" % [tier, req_v]}
	if req_p > 0 and get_part_quantity("panel", tier) < req_p:
		return {"success": false, "error": "Faltan Paneles Nv.%d (%d requeridos)" % [tier, req_p]}
	if req_chip > 0 and get_part_quantity("chip", tier) < req_chip:
		return {"success": false, "error": "Faltan Microchips Nv.%d (%d requeridos)" % [tier, req_chip]}
	if req_cond > 0 and get_part_quantity("condensador", tier) < req_cond:
		return {"success": false, "error": "Faltan Condensadores Nv.%d (%d requeridos)" % [tier, req_cond]}

	var res = await SupabaseClient.send_request("/rest/v1/rpc/repair_generator", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	if res.get("success", false) and res.get("data", {}).get("success", false):
		if req_c > 0: deduct_part_locally("cable", tier, req_c)
		if req_v > 0: deduct_part_locally("ventilador", tier, req_v)
		if req_p > 0: deduct_part_locally("panel", tier, req_p)
		if req_chip > 0: deduct_part_locally("chip", tier, req_chip)
		if req_cond > 0: deduct_part_locally("condensador", tier, req_cond)
		
		# Restaurar durabilidad local
		gen["durability"] = 100.0
		await load_player_inventory()
		return {"success": true}
		
	var err = res.get("data", {}).get("error", "Error al reparar generador")
	return {"success": false, "error": err}

## Helper para obtener el Tier de cualquier generador
func get_generator_tier(gtype: String) -> int:
	match gtype:
		"planta_meme", "dinamo_manual", "ecoflow_spark", "bateria_plomo": return 1
		"ecoflow_spark_plus", "panel_solar", "molino_eolico": return 2
		"delta_mini", "inverter_silencioso": return 3
		"ecoflow_thunder_pro", "pro_electrico", "turbina_hidro": return 4
		"ecoflow_ultra", "cyber_tank", "reactor_magnetico": return 5
		_: return 1

func upgrade_generator_secure(gen_db_id: String) -> Dictionary:
	var gen: Dictionary = {}
	for g in player_generators:
		if str(g.get("id", "")) == gen_db_id:
			gen = g
			break

	if gen.is_empty():
		return {"success": false, "error": "Generador no encontrado"}

	var lvl = int(gen.get("level", 1))
	if lvl >= 4:
		return {"success": false, "error": "Ya se encuentra en el nivel máximo (Nivel 4)."}

	var target_lvl = lvl + 1
	var gtype = str(gen.get("generator_type", ""))
	var tier = get_generator_tier(gtype)

	# Escala de piezas según el nivel objetivo
	var req_c = 10 if target_lvl == 2 else (16 if target_lvl == 3 else 24)
	var req_v = 8 if target_lvl == 2 else (12 if target_lvl == 3 else 18)
	var req_p = 6 if target_lvl == 2 else (10 if target_lvl == 3 else 14)
	var req_chip = 4 if target_lvl == 2 else (6 if target_lvl == 3 else 8)
	var req_cond = 2 if target_lvl == 2 else (3 if target_lvl == 3 else 4)

	# Ajustar según el Tier del generador
	if tier == 1: req_p = 0
	if tier <= 2: req_chip = 0; req_cond = 0
	if tier <= 4: req_cond = 0

	# Comprobar existencias locales
	if req_c > 0 and get_part_quantity("cable", tier) < req_c:
		return {"success": false, "error": "Faltan Cables Nv.%d (%d requeridos)" % [tier, req_c]}
	if req_v > 0 and get_part_quantity("ventilador", tier) < req_v:
		return {"success": false, "error": "Faltan Ventiladores Nv.%d (%d requeridos)" % [tier, req_v]}
	if req_p > 0 and get_part_quantity("panel", tier) < req_p:
		return {"success": false, "error": "Faltan Paneles Nv.%d (%d requeridos)" % [tier, req_p]}
	if req_chip > 0 and get_part_quantity("chip", tier) < req_chip:
		return {"success": false, "error": "Faltan Microchips Nv.%d (%d requeridos)" % [tier, req_chip]}
	if req_cond > 0 and get_part_quantity("condensador", tier) < req_cond:
		return {"success": false, "error": "Faltan Condensadores Nv.%d (%d requeridos)" % [tier, req_cond]}

	var res = await SupabaseClient.send_request("/rest/v1/rpc/upgrade_generator_level", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	if res.get("success", false) and res.get("data", {}).get("success", false):
		if req_c > 0: deduct_part_locally("cable", tier, req_c)
		if req_v > 0: deduct_part_locally("ventilador", tier, req_v)
		if req_p > 0: deduct_part_locally("panel", tier, req_p)
		if req_chip > 0: deduct_part_locally("chip", tier, req_chip)
		if req_cond > 0: deduct_part_locally("condensador", tier, req_cond)
		
		gen["level"] = target_lvl
		await load_player_inventory()
		return {"success": true, "new_level": target_lvl}
		
	var err = res.get("data", {}).get("error", "Error al subir de nivel") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red"
	return {"success": false, "error": err}

# ====================================================================
# ACCIONES DE JUEGO (RPCS)
# ====================================================================

func get_owned_generator_count(gen_type: String) -> int:
	var count: int = 0
	for g in player_generators:
		if str(g.get("generator_type", "")) == gen_type:
			count += 1
	return count

func get_remaining_split_cooldown() -> int:
	var now: int = int(Time.get_unix_time_from_system())
	var elapsed: int = now - last_split_change_time
	if elapsed < 21600:
		return 21600 - elapsed
	return 0

func save_mining_split_secure(new_split_watt: float) -> Dictionary:
	var body = {"p_split_watt": new_split_watt}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/set_mining_split_secure", HTTPClient.METHOD_POST, body, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		mining_split_watt = new_split_watt
		last_split_change_time = int(Time.get_unix_time_from_system())
		return {"success": true}
	else:
		var err = res["data"].get("error", "Error al guardar reparto.") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red."
		return {"success": false, "error": err}

func buy_shop_item_secure(item_id: String, category: String, price: float, currency: String) -> Dictionary:
	var body = {
		"p_item_id": item_id,
		"p_category": category,
		"p_price": price,
		"p_currency": currency
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/purchase_shop_item", HTTPClient.METHOD_POST, body, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		watt = float(res["data"].get("new_watt", watt))
		kilowat = float(res["data"].get("new_kilowat", kilowat))
		EventBus.currencies_updated.emit(watt, kilowat)
		await load_player_inventory()
		return {"success": true}
	else:
		var err = res["data"].get("error", "Error en la compra.") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de conexión."
		return {"success": false, "error": err}

func claim_welcome_gift() -> Dictionary:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/claim_welcome_gift_popup", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false) == true:
		has_claimed_welcome_gift = true
		await load_player_inventory()
		return {"success": true}
	var err_msg = res["data"].get("error", "Error al reclamar kit.") if typeof(res.get("data")) == TYPE_DICTIONARY else "Error de red."
	return {"success": false, "error": err_msg}

func place_rack_in_slot(rack_db_id: String, slot_index: int) -> bool:
	for r in player_racks:
		var r_id = str(r.get("id", r.get("rack_id", "")))
		if r_id == rack_db_id:
			r["slot_index"] = slot_index
		elif int(r.get("slot_index", -1)) == slot_index:
			r["slot_index"] = -1

	var body = {"p_rack_id": rack_db_id, "p_slot_index": slot_index}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/place_rack_secure", HTTPClient.METHOD_POST, body, true)
	return res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)

func place_generator_in_rack(gen_db_id: String, rack_db_id: String, slot_in_rack: int) -> Dictionary:
	var body = {
		"p_gen_id": str(gen_db_id).strip_edges(),
		"p_rack_id": str(rack_db_id).strip_edges(),
		"p_slot_in_rack": slot_in_rack
	}
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/place_generator_secure", HTTPClient.METHOD_POST, body, true)
	var is_ok: bool = res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)
	
	if is_ok:
		for g in player_generators:
			var g_id = str(g.get("id", g.get("gen_id", "")))
			if g_id == gen_db_id:
				g["rack_id"] = rack_db_id
				g["slot_in_rack"] = slot_in_rack
				break
		return {"success": true}
	else:
		var err_msg = "Error desconocido al colocar generador"
		if typeof(res.get("data")) == TYPE_DICTIONARY:
			var d = res["data"]
			if d.has("error"): err_msg = str(d["error"])
			elif d.has("message"): err_msg = str(d["message"])
		elif res.has("error") and res["error"] != "":
			err_msg = str(res["error"])
			
		return {"success": false, "error": err_msg}

func unmount_generator(gen_db_id: String) -> bool:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/unmount_generator_secure", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	for g in player_generators:
		if str(g.get("id", g.get("gen_id", ""))) == gen_db_id:
			g["rack_id"] = null
			g["slot_in_rack"] = -1
			break
	return res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)

func unmount_rack_complete(rack_db_id: String) -> bool:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/unmount_rack_complete", HTTPClient.METHOD_POST, {"p_rack_id": rack_db_id}, true)
	for r in player_racks:
		if str(r.get("id", r.get("rack_id", ""))) == rack_db_id:
			r["slot_index"] = -1
			break
	for g in player_generators:
		if str(g.get("rack_id", "")) == rack_db_id:
			g["rack_id"] = null
			g["slot_in_rack"] = -1
	return res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)

func equip_background(bg_id: String) -> bool:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/equip_room_background", HTTPClient.METHOD_POST, {"p_bg_id": bg_id}, true)
	if res.get("success", false) and res["data"].get("success", false):
		equipped_background = bg_id
		return true
	return false

func set_cooldown_seconds(game_id: String, seconds: int) -> void:
	if seconds > 0:
		minigame_cooldown_ticks[game_id] = Time.get_ticks_msec() + (seconds * 1000)
	else:
		minigame_cooldown_ticks.erase(game_id)

func get_remaining_cooldown_seconds(game_id: String) -> int:
	if not minigame_cooldown_ticks.has(game_id):
		return 0
	var target_ticks: int = minigame_cooldown_ticks[game_id]
	var current_ticks: int = Time.get_ticks_msec()
	if current_ticks < target_ticks:
		return int(ceil(float(target_ticks - current_ticks) / 1000.0))
	minigame_cooldown_ticks.erase(game_id)
	return 0

func _on_signed_out() -> void:
	username = ""
	watt = 0.0
	kilowat = 0.0
	casino_tokens = 0.0
	total_kwp = 0.0
	temporary_kwp = 0.0
	referral_power_kwp = 0.0
	mining_split_watt = 50.0
	last_split_change_time = 0
	target_shop_category = "generators"
	unlocked_backgrounds = ["default"]
	equipped_background = "default"
	active_generator_powers.clear()
	minigame_cooldown_ticks.clear()
	has_active_generator = false
	cycle_60s_timer = 0.0
	online_quest_timer = 0.0
	player_racks.clear()
	player_generators.clear()
	player_parts.clear()
	has_claimed_welcome_gift = false
	open_battle_pass_on_room = false
	saved_chat_channel_mode = "global"
	saved_active_friend_id = ""
	saved_active_friend_name = ""
	saved_is_chat_minimized = false
	pending_friend_requests_count = 0
	player_materials.clear()
	player_talents.clear()
	talent_points = 0
	player_professions = {
		"chatarrero_level": 0, "chatarrero_xp": 0,
		"ingeniero_level": 0, "ingeniero_xp": 0,
		"corredor_level": 0, "corredor_xp": 0
	}

func _parse_iso_datetime(dt_str: String) -> int:
	if dt_str == "" or dt_str == "null":
		return 0
	var clean: String = dt_str.replace("Z", "")
	if "+" in clean: clean = clean.split("+")[0]
	if "." in clean: clean = clean.split(".")[0]
	return int(Time.get_unix_time_from_datetime_string(clean))
	
## Envía la solicitud de fabricación al servidor y sincroniza inventarios de inmediato
func craft_piece_secure(piece_type: String, tier: int, qty: int = 1) -> Dictionary:
	var body = {
		"p_piece_type": piece_type.strip_edges().to_lower(),
		"p_tier": tier,
		"p_quantity": qty
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/craft_workshop_piece", HTTPClient.METHOD_POST, body, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		var crafted_qty = int(d.get("quantity_crafted", qty))
		var clean_type = piece_type.strip_edges().to_lower()
		
		# 1. Sumar pieza localmente
		add_part_locally(clean_type, tier, crafted_qty)
		
		# 2. Descontar materiales de memoria local
		match clean_type:
			"cable":
				deduct_material_locally("cobre", tier, 4 * qty)
				deduct_material_locally("plastico", tier, 2 * qty)
			"ventilador":
				deduct_material_locally("hierro", tier, 4 * qty)
				deduct_material_locally("plastico", tier, 2 * qty)
			"panel":
				deduct_material_locally("silicio", tier, 3 * qty)
				deduct_material_locally("cobre", tier, 3 * qty)
			"chip":
				deduct_material_locally("silicio", tier, 4 * qty)
				deduct_material_locally("cobre", tier, 2 * qty)
				deduct_material_locally("hierro", tier, 1 * qty)
			"condensador":
				deduct_material_locally("cobre", tier, 5 * qty)
				deduct_material_locally("silicio", tier, 5 * qty)
				deduct_material_locally("hierro", tier, 5 * qty)
				
		# 3. Actualizar datos de Ingeniero
		if d.has("new_level"):
			player_professions["ingeniero_level"] = int(d["new_level"])
			
		return {"success": true, "data": d}
	else:
		var err = res.get("data", {}).get("error", "Error al fabricar") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red"
		return {"success": false, "error": err}

# ====================================================================
# SISTEMA RPG: GESTIÓN DE MATERIALES Y PROFESIONES
# ====================================================================

## Carga el estado RPG unificado desde Supabase
func load_player_rpg_state() -> void:
	if SupabaseClient.current_user_id == "": return
	
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_player_rpg_state", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		talent_points = int(d.get("talent_points", 0))
		player_materials = d.get("materials", [])
		player_professions = d.get("professions", player_professions)
		player_talents = d.get("talents", [])

## Consulta la cantidad de un material específico
func get_material_quantity(mat_type: String, tier: int) -> int:
	var clean_type = mat_type.strip_edges().to_lower()
	for m in player_materials:
		if str(m.get("material_type", "")).strip_edges().to_lower() == clean_type and int(m.get("tier", 1)) == tier:
			return int(m.get("quantity", 0))
	return 0

## Agrega materiales inmediatamente en memoria local (ej: drop de minijuegos)
func add_material_locally(mat_type: String, tier: int, qty: int) -> void:
	var clean_type = mat_type.strip_edges().to_lower()
	var found = false
	for m in player_materials:
		if str(m.get("material_type", "")).strip_edges().to_lower() == clean_type and int(m.get("tier", 1)) == tier:
			m["quantity"] = int(m.get("quantity", 0)) + qty
			found = true
			break
	if not found:
		player_materials.append({
			"material_type": clean_type,
			"tier": tier,
			"quantity": qty
		})

## Descuenta materiales en memoria local (ej: crafteo en taller)
func deduct_material_locally(mat_type: String, tier: int, qty: int) -> void:
	var clean_type = mat_type.strip_edges().to_lower()
	for m in player_materials:
		if str(m.get("material_type", "")).strip_edges().to_lower() == clean_type and int(m.get("tier", 1)) == tier:
			m["quantity"] = maxi(0, int(m.get("quantity", 0)) - qty)
			break

## Devuelve el nivel actual de una profesión (0 a 25)
func get_profession_level(prof_name: String) -> int:
	var key = prof_name.to_lower() + "_level"
	return int(player_professions.get(key, 0))

## Devuelve la XP acumulada en una profesión
func get_profession_xp(prof_name: String) -> int:
	var key = prof_name.to_lower() + "_xp"
	return int(player_professions.get(key, 0))
	
## Procesa las recompensas RPG de minijuegos y genera el texto para el mensaje de victoria
func process_minigame_rpg_rewards(data: Dictionary) -> String:
	var msg: String = ""
	
	# 1. Procesar Material obtenido
	if bool(data.get("has_dropped_material", false)):
		var mat_type: String = str(data.get("material_type", "cobre")).strip_edges().to_lower()
		var tier: int = int(data.get("material_tier", 1))
		var qty: int = int(data.get("material_qty", 1))
		
		# Sumar de inmediato a la memoria local
		add_material_locally(mat_type, tier, qty)
		
		var mat_names = {
			"cobre": "Cobre Bruto",
			"plastico": "Plástico Reciclado",
			"silicio": "Silicio / Cuarzo",
			"hierro": "Chatarra de Hierro"
		}
		var display_name = mat_names.get(mat_type, mat_type.capitalize())
		msg += "\n📦 Botín: +%d %s (Tier %d)" % [qty, display_name, tier]
		
	# 2. Procesar XP y Nivel de Chatarrero
	var xp_gained: int = int(data.get("chatarrero_xp_gained", 0))
	if xp_gained > 0:
		msg += "\n⭐ +%d XP de Chatarrero" % xp_gained
		
	if bool(data.get("chatarrero_leveled_up", false)):
		var new_lvl: int = int(data.get("new_chatarrero_level", 1))
		player_professions["chatarrero_level"] = new_lvl
		msg += "\n🎉 ¡SUBISTE A NIVEL %d DE CHATARRERO!" % new_lvl
		
	return msg
	
## Obtiene la lista de contratos diarios del servidor
func get_daily_contracts_secure() -> Array:
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_or_create_daily_contracts", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		return res["data"].get("contracts", [])
	return []

## Entrega el contrato, descuenta los recursos y actualiza monedas en memoria local
func deliver_contract_secure(contract_dict: Dictionary) -> Dictionary:
	var c_id = str(contract_dict.get("id", ""))
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/deliver_daily_contract", HTTPClient.METHOD_POST, {"p_contract_id": c_id}, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		
		# 1. Deducir recursos localmente
		var p_type = str(contract_dict.get("req_piece_type", ""))
		var p_tier = int(contract_dict.get("req_piece_tier", 1))
		var p_qty = int(contract_dict.get("req_piece_qty", 1))
		var req_w = float(contract_dict.get("req_watt", 0.0))
		
		deduct_part_locally(p_type, p_tier, p_qty)
		watt = maxf(0.0, watt - req_w)
		
		# 2. Sumar recompensas
		talent_points += int(d.get("reward_talent_points", 1))
		casino_tokens += int(d.get("reward_casino_tokens", 1))
		
		EventBus.currencies_updated.emit(watt, kilowat)
		return {"success": true, "data": d}
	else:
		var err = res.get("data", {}).get("error", "Error al entregar") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red"
		return {"success": false, "error": err}
		
## Devuelve el nivel desbloqueado de un talento específico (0 si no lo tiene, max 3)
func get_talent_level(talent_id: String) -> int:
	for t in player_talents:
		if str(t.get("talent_id", "")) == talent_id:
			return int(t.get("level", 1))
	return 0

## Envía la mejora al servidor y extrae el error real si algo falla
func upgrade_talent_secure(talent_id: String, branch: String, cost_points: int, cost_watt: float, prereq_id: String = "") -> Dictionary:
	var body = {
		"p_talent_id": talent_id,
		"p_branch": branch,
		"p_cost_points": cost_points,
		"p_cost_watt": cost_watt,
		"p_prereq_id": prereq_id
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/upgrade_player_talent", HTTPClient.METHOD_POST, body, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		var new_lvl = int(d.get("new_level", 1))
		
		# Deducir en memoria local
		talent_points = maxi(0, talent_points - cost_points)
		watt = maxf(0.0, watt - cost_watt)
		EventBus.currencies_updated.emit(watt, kilowat)
		
		var found = false
		for t in player_talents:
			if str(t.get("talent_id", "")) == talent_id:
				t["level"] = new_lvl
				found = true
				break
		if not found:
			player_talents.append({
				"talent_id": talent_id,
				"talent_branch": branch,
				"level": new_lvl
			})
			
		return {"success": true, "data": d}
	else:
		# Extraer el error real de Supabase (sea "error", "message" o "msg")
		var err_msg = "Error de conexión"
		if typeof(res.get("data")) == TYPE_DICTIONARY:
			var d = res["data"]
			if d.has("error"): err_msg = str(d["error"])
			elif d.has("message"): err_msg = str(d["message"])
			elif d.has("msg"): err_msg = str(d["msg"])
		elif res.has("error") and res["error"] != "":
			err_msg = str(res["error"])
			
		return {"success": false, "error": err_msg}