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

var global_zoom: Node = null

func _ready() -> void:
	if not EventBus.auth_signed_out.is_connected(_on_signed_out):
		EventBus.auth_signed_out.connect(_on_signed_out)
	_setup_global_zoom()

func _setup_global_zoom() -> void:
	var old_z = get_node_or_null("GlobalZoomController")
	if old_z:
		old_z.name = "OldZoom_Disposed"
		old_z.queue_free()

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
	var req_cable_lvl = 1; var req_cable_qty = 6
	var req_vent_lvl = 1; var req_vent_qty = 4

	if gtype in ["ecoflow_ultra", "cyber_tank"]:
		req_cable_lvl = 4; req_cable_qty = 12; req_vent_lvl = 4; req_vent_qty = 8
	elif gtype in ["ecoflow_thunder_pro", "pro_electrico"]:
		req_cable_lvl = 3; req_cable_qty = 10; req_vent_lvl = 3; req_vent_qty = 6
	elif gtype in ["ecoflow_spark_plus", "delta_mini", "panel_solar"]:
		req_cable_lvl = 2; req_cable_qty = 8; req_vent_lvl = 2; req_vent_qty = 5

	if get_part_quantity("cable", req_cable_lvl) < req_cable_qty or get_part_quantity("ventilador", req_vent_lvl) < req_vent_qty:
		return {"success": false, "error": "No tienes suficientes piezas para reparar esta planta."}

	var res = await SupabaseClient.send_request("/rest/v1/rpc/repair_generator", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	if res.get("success", false) and res.get("data", {}).get("success", false):
		deduct_part_locally("cable", req_cable_lvl, req_cable_qty)
		deduct_part_locally("ventilador", req_vent_lvl, req_vent_qty)
		await load_player_inventory()
		return {"success": true}
	var err = res.get("data", {}).get("error", "Error al reparar generador")
	return {"success": false, "error": err}

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
	var req_part_lvl = lvl
	var req_c = 20 if target_lvl == 2 else 15
	var req_v = 15
	var req_p = 10 if target_lvl < 4 else 12

	if get_part_quantity("cable", req_part_lvl) < req_c or get_part_quantity("ventilador", req_part_lvl) < req_v or get_part_quantity("panel", req_part_lvl) < req_p:
		return {"success": false, "error": "Piezas insuficientes para subir a Nivel %d." % target_lvl}

	var res = await SupabaseClient.send_request("/rest/v1/rpc/upgrade_generator_level", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	if res.get("success", false) and res.get("data", {}).get("success", false):
		deduct_part_locally("cable", req_part_lvl, req_c)
		deduct_part_locally("ventilador", req_part_lvl, req_v)
		deduct_part_locally("panel", req_part_lvl, req_p)
		await load_player_inventory()
		return {"success": true, "new_level": int(res["data"].get("new_level", target_lvl))}
	var err = res.get("data", {}).get("error", "Error al subir de nivel")
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

func place_generator_in_rack(gen_db_id: String, rack_db_id: String, slot_in_rack: int) -> bool:
	var body = {"p_gen_id": gen_db_id, "p_rack_id": rack_db_id, "p_slot_in_rack": slot_in_rack}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/place_generator_secure", HTTPClient.METHOD_POST, body, true)
	var ok: bool = res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)
	
	if ok:
		for g in player_generators:
			var g_id = str(g.get("id", g.get("gen_id", "")))
			if g_id == gen_db_id or gen_db_id == "":
				g["rack_id"] = rack_db_id
				g["slot_in_rack"] = slot_in_rack
				break
	return ok

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

func _parse_iso_datetime(dt_str: String) -> int:
	if dt_str == "" or dt_str == "null":
		return 0
	var clean: String = dt_str.replace("Z", "")
	if "+" in clean: clean = clean.split("+")[0]
	if "." in clean: clean = clean.split(".")[0]
	return int(Time.get_unix_time_from_datetime_string(clean))
