# res://features/minigames/_shared/minigames_hub.gd
extends Control

const FUSE_PUZZLE_SCENE = preload("res://features/minigames/_shared/fuse_puzzle.tscn")
const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")

@onready var back_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var power_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/PowerPill/Margin/HBox/PowerLabel
@onready var watt_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilowat_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel
@onready var games_grid: GridContainer = $CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesGrid

var game_buttons: Dictionary = {}
var game_levels: Dictionary = {"coinclick": 1, "flappy_rocket": 1, "coin_match": 1, "crypto_memory": 1}
var game_level_progress: Dictionary = {"coinclick": 0, "flappy_rocket": 0, "coin_match": 0, "crypto_memory": 0}
var game_is_infinite: Dictionary = {"coinclick": false, "flappy_rocket": false, "coin_match": false, "crypto_memory": false}
var game_reset_seconds: Dictionary = {"coinclick": 86400, "flappy_rocket": 86400, "coin_match": 86400, "crypto_memory": 86400}

var game_reset_labels: Dictionary = {}
var game_diff_bars: Dictionary = {}
var game_diff_labels: Dictionary = {}

var is_captcha_locked: bool = false
var active_puzzle = null
var second_timer: float = 0.0

func _ready() -> void:
	if chip_label == null: chip_label = find_child("ChipLabel", true, false)
	back_button.pressed.connect(_on_back_pressed)
	_update_hud()
	_load_user_games_data()

func _process(delta: float) -> void:
	_update_cooldown_buttons()
	_update_hud()
	
	second_timer += delta
	if second_timer >= 1.0:
		second_timer = 0.0
		_tick_difficulty_resets()

func _tick_difficulty_resets() -> void:
	for gid in game_reset_seconds.keys():
		var rem: int = game_reset_seconds[gid]
		if rem > 0:
			rem -= 1
			game_reset_seconds[gid] = rem
			
			var h: int = int(float(rem) / 3600.0)
			var m: int = int(float(rem % 3600) / 60.0)
			var s: int = rem % 60
			
			if game_reset_labels.has(gid) and is_instance_valid(game_reset_labels[gid]):
				game_reset_labels[gid].text = "🔄 Reinicio (24h): %02d:%02d:%02d" % [h, m, s]
				
			if rem <= 0:
				game_levels[gid] = 1
				game_level_progress[gid] = 0
				game_is_infinite[gid] = false
				game_reset_seconds[gid] = 86400
				if game_diff_bars.has(gid) and is_instance_valid(game_diff_bars[gid]):
					game_diff_bars[gid].value = 1
				if game_diff_labels.has(gid) and is_instance_valid(game_diff_labels[gid]):
					game_diff_labels[gid].text = "⚡ Dificultad: 1 / 4 (0/6 victorias)"

func _update_hud() -> void:
	if power_label and is_instance_valid(power_label):
		power_label.text = "%.9f KWP" % GameManager.total_kwp
	if watt_label and is_instance_valid(watt_label):
		watt_label.text = "%.4f" % GameManager.watt
	if kilowat_label and is_instance_valid(kilowat_label):
		kilowat_label.text = "%.6f" % GameManager.kilowat
	if chip_label and is_instance_valid(chip_label):
		chip_label.text = "%.0f" % GameManager.casino_tokens
		
	# Actualizar el título con el rango del jugador
	var chat_lvl: int = GameManager.get_profession_level("chatarrero")
	var title_node = find_child("Title", true, false)
	if title_node and is_instance_valid(title_node):
		title_node.text = "⚡ CENTRAL DE MINIJUEGOS  |  🛠️ Chatarrero Nv. %d / 25" % chat_lvl

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://features/room/main_room.tscn")

func _load_user_games_data() -> void:
	var uid = SupabaseClient.current_user_id
	if uid != "":
		for gid in ["coinclick", "flappy_rocket", "coin_match", "crypto_memory"]:
			var res = await SupabaseClient.send_request("/rest/v1/rpc/get_minigame_status", HTTPClient.METHOD_POST, {"p_game_id": gid}, true)
			if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
				var data = res["data"]
				game_levels[gid] = int(data.get("current_level", 1))
				game_level_progress[gid] = int(data.get("wins_in_level", 0))
				game_is_infinite[gid] = bool(data.get("is_infinite", false))
				var rem_sec = int(data.get("remaining_seconds", 0))
				game_reset_seconds[gid] = int(data.get("difficulty_reset_in", 86400))
				
				if bool(data.get("requires_captcha", false)):
					is_captcha_locked = true
					
				var local_rem = GameManager.get_remaining_cooldown_seconds(gid)
				if rem_sec > local_rem:
					GameManager.set_cooldown_seconds(gid, rem_sec)

	_build_games_grid()

func _load_thumb_texture(game_id: String) -> Texture2D:
	var paths = [
		"res://assets/sprites/minigames/" + game_id + "/thumb.webp",
		"res://assets/sprites/minigames/" + game_id + "/thumb.jpg",
		"res://assets/sprites/minigames/" + game_id + "/thumb.png"
	]
	for p in paths:
		if ResourceLoader.exists(p):
			var r = load(p)
			if r is Texture2D: return r
	return WATT_ICON

func _update_cooldown_buttons() -> void:
	for gid in game_buttons.keys():
		var btn: Button = game_buttons[gid]
		if btn == null or not is_instance_valid(btn): continue
		
		var rem: int = GameManager.get_remaining_cooldown_seconds(gid)
		if rem > 0:
			btn.disabled = true
			var m = int(float(rem) / 60.0)
			var s = rem % 60
			btn.text = "⏳ Espera %02d:%02d" % [m, s]
			var st_cd := StyleBoxFlat.new()
			st_cd.bg_color = Color(0.12, 0.14, 0.18, 0.95)
			st_cd.border_color = Color(0.25, 0.3, 0.4)
			st_cd.set_border_width_all(1)
			st_cd.set_corner_radius_all(6)
			btn.add_theme_stylebox_override("disabled", st_cd)
			btn.add_theme_color_override("font_disabled_color", Color(1.0, 0.85, 0.3))
		elif is_captcha_locked:
			btn.disabled = false
			btn.text = "⚠️ VERIFICAR"
			var st_warn := StyleBoxFlat.new()
			st_warn.bg_color = Color(0.35, 0.2, 0.05, 1.0)
			st_warn.border_color = Color(1.0, 0.7, 0.1)
			st_warn.set_border_width_all(2)
			st_warn.set_corner_radius_all(6)
			btn.add_theme_stylebox_override("normal", st_warn)
			btn.add_theme_color_override("font_color", Color(1.0, 0.9, 0.4))
		else:
			btn.disabled = false
			btn.text = "⚡ JUGAR AHORA"
			var st_act := StyleBoxFlat.new()
			st_act.bg_color = Color(0.15, 0.75, 0.45, 1.0)
			st_act.border_color = Color(0.4, 1.0, 0.6)
			st_act.set_border_width_all(2)
			st_act.set_corner_radius_all(6)
			btn.add_theme_stylebox_override("normal", st_act)
			btn.add_theme_stylebox_override("hover", st_act)
			btn.add_theme_color_override("font_color", Color(0.04, 0.12, 0.04))

func _build_games_grid() -> void:
	for child in games_grid.get_children(): child.queue_free()
	game_buttons.clear()
	game_reset_labels.clear()
	game_diff_bars.clear()
	game_diff_labels.clear()

	var catalog = [
		{
			"id": "coinclick", 
			"title": "CoinClick", 
			"badge": "🔥 ESCALA KWP", 
			"color": Color(1.0, 0.75, 0.15), 
			"desc": "Atrapa monedas del mago. 6 victorias por nivel para subir. Gana hasta +0.000000014 KWP. Modo infinito en Nv 4 (2m cooldown)."
		},
		{
			"id": "flappy_rocket", 
			"title": "Flappy Rocket", 
			"badge": "⭐ ESCALA KWP", 
			"color": Color(0.25, 0.95, 0.5), 
			"desc": "Esquiva barreras eléctricas. 6 carreras por nivel. Escala de 1 a 14 nano-KWP. Descenso a las 20h y reinicio a las 24h."
		},
		{
			"id": "coin_match", 
			"title": "Coin Match", 
			"badge": "🧩 PUZZLE", 
			"color": Color(0.85, 0.35, 1.0), 
			"desc": "Combina criptomonedas. 6 victorias por nivel. Recompensas crecientes por rango (+1, +4, +8 y +14 nano-KWP)."
		},
		{
			"id": "crypto_memory", 
			"title": "Crypto Memory", 
			"badge": "⚡ MEMORIA", 
			"color": Color(0.35, 0.85, 1.0), 
			"desc": "Encuentra las parejas de cartas. 4 niveles de dificultad (6 victorias c/u). Modo infinito con 2 min de cooldown al completar Nv 4."
		}
	]

	for g in catalog:
		var gid = str(g["id"])
		var border_c: Color = g["color"]
		
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(275, 440)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		var card_st := StyleBoxFlat.new()
		card_st.bg_color = Color(0.08, 0.10, 0.14, 0.95)
		card_st.border_color = border_c
		card_st.set_border_width_all(2)
		card_st.set_corner_radius_all(10)
		card_st.shadow_color = Color(border_c.r, border_c.g, border_c.b, 0.25)
		card_st.shadow_size = 8
		card.add_theme_stylebox_override("panel", card_st)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 14)
		margin.add_theme_constant_override("margin_top", 12)
		margin.add_theme_constant_override("margin_right", 14)
		margin.add_theme_constant_override("margin_bottom", 14)
		card.add_child(margin)
		
		var vbox := VBoxContainer.new()
		vbox.add_theme_constant_override("separation", 8)
		margin.add_child(vbox)
		
		# Cabecera
		var top_row := HBoxContainer.new()
		var badge_lbl := Label.new()
		badge_lbl.text = " " + str(g["badge"]) + " "
		badge_lbl.add_theme_font_size_override("font_size", 10)
		badge_lbl.add_theme_color_override("font_color", border_c)
		
		var badge_pill := PanelContainer.new()
		var b_st := StyleBoxFlat.new()
		b_st.bg_color = Color(0.12, 0.15, 0.22, 0.8)
		b_st.border_color = border_c
		b_st.set_border_width_all(1)
		b_st.set_corner_radius_all(4)
		badge_pill.add_theme_stylebox_override("panel", b_st)
		badge_pill.add_child(badge_lbl)
		top_row.add_child(badge_pill)
		
		var title_lbl := Label.new()
		title_lbl.text = " " + str(g["title"])
		title_lbl.add_theme_font_size_override("font_size", 16)
		title_lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0))
		top_row.add_child(title_lbl)
		vbox.add_child(top_row)
		
		# Miniatura
		var thumb_panel := PanelContainer.new()
		thumb_panel.custom_minimum_size = Vector2(0, 135)
		thumb_panel.clip_contents = true
		var tp_st := StyleBoxFlat.new()
		tp_st.bg_color = Color(0.04, 0.05, 0.07, 0.9)
		tp_st.border_color = Color(0.18, 0.25, 0.35, 0.6)
		tp_st.set_border_width_all(1)
		tp_st.set_corner_radius_all(8)
		thumb_panel.add_theme_stylebox_override("panel", tp_st)
		
		var thumb_rect := TextureRect.new()
		thumb_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		thumb_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumb_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		thumb_rect.texture = _load_thumb_texture(gid)
		thumb_panel.add_child(thumb_rect)
		vbox.add_child(thumb_panel)
		
		# Descripción
		var desc_lbl := Label.new()
		desc_lbl.text = str(g["desc"])
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.75, 0.8, 0.88, 0.85))
		desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		desc_lbl.custom_minimum_size = Vector2(0, 36)
		vbox.add_child(desc_lbl)
		
		# Dificultad (1 a 4 con 6 victorias)
		var diff_box := VBoxContainer.new()
		diff_box.add_theme_constant_override("separation", 4)
		
		var lvl_val: int = game_levels.get(gid, 1)
		var progress_val: int = game_level_progress.get(gid, 0)
		var is_inf: bool = game_is_infinite.get(gid, false)
		
		var diff_lbl := Label.new()
		if is_inf and lvl_val == 4:
			diff_lbl.text = "⚡ Nivel 4: MODO INFINITO (2m cd)"
			diff_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		elif is_inf and lvl_val == 3:
			diff_lbl.text = "⏳ Nivel 3: MODO DESCANSO (2m cd)"
			diff_lbl.add_theme_color_override("font_color", Color(1.0, 0.5, 0.3))
		else:
			diff_lbl.text = "⚡ Dificultad: %d / 4 (%d/6 victorias)" % [lvl_val, progress_val]
			diff_lbl.add_theme_color_override("font_color", Color(0.35, 0.85, 1.0))
			
		diff_lbl.add_theme_font_size_override("font_size", 11)
		diff_box.add_child(diff_lbl)
		game_diff_labels[gid] = diff_lbl
		
		var diff_bar := ProgressBar.new()
		diff_bar.custom_minimum_size = Vector2(0, 6)
		diff_bar.max_value = 4
		diff_bar.value = lvl_val
		diff_bar.show_percentage = false
		diff_box.add_child(diff_bar)
		game_diff_bars[gid] = diff_bar
		vbox.add_child(diff_box)
		
		# Reloj de reinicio de 24h
		var reset_lbl := Label.new()
		var rem_t: int = game_reset_seconds.get(gid, 86400)
		var h = int(float(rem_t) / 3600.0)
		var m = int(float(rem_t % 3600) / 60.0)
		var s = rem_t % 60
		reset_lbl.text = "🔄 Reinicio (24h): %02d:%02d:%02d" % [h, m, s]
		reset_lbl.add_theme_color_override("font_color", Color(0.65, 0.7, 0.8, 0.8))
		reset_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(reset_lbl)
		game_reset_labels[gid] = reset_lbl
		
		vbox.add_spacer(false)
		
		# Botón JUGAR
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(0, 42)
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.text = "⚡ JUGAR AHORA"
		btn.add_theme_font_size_override("font_size", 13)
		btn.pressed.connect(func(): _start_game_flow(gid))
		vbox.add_child(btn)
		
		game_buttons[gid] = btn
		games_grid.add_child(card)

func _start_game_flow(game_id: String) -> void:
	if GameManager.get_remaining_cooldown_seconds(game_id) > 0: return
	if is_captcha_locked:
		_trigger_human_verification(game_id)
		return
		
	var btn: Button = game_buttons.get(game_id)
	if btn: btn.disabled = true
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": game_id}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		is_captcha_locked = true
		_trigger_human_verification(game_id)
		return
		
	if not res.get("success", false) or not res["data"].get("success", false):
		var rem_sec = int(res["data"].get("remaining_seconds", 5))
		GameManager.set_cooldown_seconds(game_id, rem_sec)
		return
		
	var token: String = str(res["data"].get("session_token", ""))
	var lvl: int = int(res["data"].get("current_level", game_levels.get(game_id, 1)))
	game_levels[game_id] = lvl
	
	var scene_path = ""
	match game_id:
		"coinclick": scene_path = "res://features/minigames/coin_click/coin_click.tscn"
		"flappy_rocket": scene_path = "res://features/minigames/flappy_rocket/flappy_rocket.tscn"
		"coin_match": scene_path = "res://features/minigames/coin_match/coin_match.tscn"
		"crypto_memory": scene_path = "res://features/minigames/crypto_memory/crypto_memory.tscn"
		
	var game_scene = load(scene_path).instantiate()
	game_scene.set_game_level(lvl)
	game_scene.set_session_token(token)
	get_tree().root.add_child(game_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = game_scene

func _trigger_human_verification(target_game_id: String) -> void:
	if active_puzzle == null:
		active_puzzle = FUSE_PUZZLE_SCENE.instantiate()
		$CanvasLayerUI.add_child(active_puzzle)
		active_puzzle.puzzle_completed.connect(func(success: bool):
			if success:
				is_captcha_locked = false
				_start_game_flow(target_game_id)
			else:
				is_captcha_locked = true
				GameManager.set_cooldown_seconds(target_game_id, 60)
		)
	active_puzzle.open_challenge()
