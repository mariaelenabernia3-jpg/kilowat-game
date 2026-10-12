# res://features/minigames/coin_match/coin_match.gd
extends Control

const GAME_ID: String = "coin_match"
const GRID_ROWS: int = 7
const GRID_COLS: int = 7
const CELL_SIZE: float = 64.0
const COIN_HFRAMES: int = 7

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var board_container: Control = $PlayArea/BoardContainer
@onready var highlight_rect: ReferenceRect = $PlayArea/HighlightRect

@onready var score_label: Label = $HUD/TopPanel/Margin/HBox/ScoreBox/ScoreLabel
@onready var level_label: Label = $HUD/TopPanel/Margin/HBox/LevelLabel
@onready var timer_label: Label = $HUD/TopPanel/Margin/HBox/TimeBox/TimerLabel
@onready var exit_button: Button = $HUD/TopPanel/Margin/HBox/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

var current_level: int = 1
var target_score: int = 800
var current_score: int = 0
var time_remaining: float = 50.0
var num_coin_types: int = 5

var current_session_token: String = ""
var game_over: bool = false
var is_processing_matches: bool = false

var grid_data: Array = []
var grid_sprites: Array = []
var selected_cell: Vector2i = Vector2i(-1, -1)
var tex_coins: Texture2D

var retry_cooldown_left: int = 0
var retry_tick_accum: float = 0.0

func set_session_token(token: String) -> void: current_session_token = token
func set_game_level(lvl: int) -> void: current_level = clamp(lvl, 1, 4)

func _ready() -> void:
	exit_button.pressed.connect(_return_to_hub)
	action_button.pressed.connect(_return_to_hub)
	retry_button.pressed.connect(_on_retry_pressed)
	
	_load_assets()
	_apply_level_parameters()
	_setup_board_ui()
	_init_grid()
	_update_ui()

func _load_assets() -> void:
	var bg_path = "res://assets/sprites/minigames/coin_match/bg.png"
	if ResourceLoader.exists(bg_path): bg_texture.texture = load(bg_path)
	var coins_path = "res://assets/sprites/minigames/coin_match/coins.png"
	if ResourceLoader.exists(coins_path): tex_coins = load(coins_path)

func _apply_level_parameters() -> void:
	match current_level:
		1: target_score = 800; time_remaining = 50.0; num_coin_types = 5
		2: target_score = 1500; time_remaining = 45.0; num_coin_types = 5
		3: target_score = 2400; time_remaining = 40.0; num_coin_types = 6
		4: target_score = 3400; time_remaining = 35.0; num_coin_types = 7

func _setup_board_ui() -> void:
	var total_w: float = GRID_COLS * CELL_SIZE
	var total_h: float = GRID_ROWS * CELL_SIZE
	board_container.custom_minimum_size = Vector2(total_w, total_h)
	board_container.size = Vector2(total_w, total_h)
	board_container.position = Vector2((1280.0 - total_w) / 2.0, (720.0 - total_h) / 2.0 + 25.0)
	highlight_rect.visible = false
	highlight_rect.size = Vector2(CELL_SIZE, CELL_SIZE)

func _init_grid() -> void:
	grid_data.clear(); grid_sprites.clear()
	for child in board_container.get_children(): child.queue_free()

	for r in range(GRID_ROWS):
		var row_data = []; var row_sprites = []
		for c in range(GRID_COLS): row_data.append(-1); row_sprites.append(null)
		grid_data.append(row_data); grid_sprites.append(row_sprites)

	for r in range(GRID_ROWS):
		for c in range(GRID_COLS):
			var possible_types = []
			for t in range(num_coin_types):
				if c >= 2 and grid_data[r][c-1] == t and grid_data[r][c-2] == t: continue
				if r >= 2 and grid_data[r-1][c] == t and grid_data[r-2][c] == t: continue
				possible_types.append(t)
			var chosen_type: int = possible_types[randi() % possible_types.size()]
			grid_data[r][c] = chosen_type
			_create_coin_sprite(r, c, chosen_type)

func _create_coin_sprite(r: int, c: int, type_idx: int) -> Sprite2D:
	var spr := Sprite2D.new()
	spr.texture = tex_coins
	spr.hframes = COIN_HFRAMES
	spr.frame = type_idx
	spr.centered = true
	spr.position = Vector2((c + 0.5) * CELL_SIZE, (r + 0.5) * CELL_SIZE)
	if tex_coins:
		var frame_w: float = float(tex_coins.get_width()) / float(COIN_HFRAMES)
		var s: float = 46.0 / maxf(1.0, frame_w)
		spr.scale = Vector2(s, s)
	board_container.add_child(spr)
	grid_sprites[r][c] = spr
	return spr

func _input(event: InputEvent) -> void:
	if game_over or is_processing_matches: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var board_rect: Rect2 = board_container.get_global_rect()
		if board_rect.has_point(event.position):
			var local_pos: Vector2 = board_container.get_local_mouse_position()
			var col = int(local_pos.x / CELL_SIZE)
			var row = int(local_pos.y / CELL_SIZE)
			if row >= 0 and row < GRID_ROWS and col >= 0 and col < GRID_COLS:
				_handle_cell_clicked(Vector2i(col, row))

func _handle_cell_clicked(cell: Vector2i) -> void:
	if selected_cell == Vector2i(-1, -1):
		selected_cell = cell; _highlight_cell(cell)
	else:
		var diff: Vector2i = (cell - selected_cell).abs()
		var is_adjacent: bool = (diff.x == 1 and diff.y == 0) or (diff.x == 0 and diff.y == 1)
		if is_adjacent:
			var first = selected_cell
			selected_cell = Vector2i(-1, -1)
			highlight_rect.visible = false
			_try_swap(first, cell)
		else:
			selected_cell = cell; _highlight_cell(cell)

func _highlight_cell(cell: Vector2i) -> void:
	highlight_rect.visible = true
	highlight_rect.global_position = board_container.global_position + Vector2(cell.x * CELL_SIZE, cell.y * CELL_SIZE)

func _try_swap(a: Vector2i, b: Vector2i) -> void:
	is_processing_matches = true
	_swap_cells(a, b); await _animate_swap(a, b)
	var matches = _find_all_matches()
	if matches.is_empty():
		_swap_cells(a, b); await _animate_swap(a, b)
		is_processing_matches = false
	else:
		await _resolve_board_cascade()

func _swap_cells(a: Vector2i, b: Vector2i) -> void:
	var temp_type = grid_data[a.y][a.x]
	grid_data[a.y][a.x] = grid_data[b.y][b.x]; grid_data[b.y][b.x] = temp_type
	var temp_spr = grid_sprites[a.y][a.x]
	grid_sprites[a.y][a.x] = grid_sprites[b.y][b.x]; grid_sprites[b.y][b.x] = temp_spr

func _animate_swap(a: Vector2i, b: Vector2i) -> void:
	var spr_a: Sprite2D = grid_sprites[a.y][a.x]
	var spr_b: Sprite2D = grid_sprites[b.y][b.x]
	if spr_a == null and spr_b == null: return
	var target_a := Vector2((a.x + 0.5) * CELL_SIZE, (a.y + 0.5) * CELL_SIZE)
	var target_b := Vector2((b.x + 0.5) * CELL_SIZE, (b.y + 0.5) * CELL_SIZE)
	var tween = create_tween().set_parallel(true)
	if spr_a and is_instance_valid(spr_a): tween.tween_property(spr_a, "position", target_a, 0.16).set_trans(Tween.TRANS_QUAD)
	if spr_b and is_instance_valid(spr_b): tween.tween_property(spr_b, "position", target_b, 0.16).set_trans(Tween.TRANS_QUAD)
	await tween.finished

func _find_all_matches() -> Array:
	var matched_cells = []
	for r in range(GRID_ROWS):
		var match_len = 1
		for c in range(1, GRID_COLS):
			if grid_data[r][c] != -1 and grid_data[r][c] == grid_data[r][c-1]: match_len += 1
			else:
				if match_len >= 3:
					for i in range(c - match_len, c):
						var p = Vector2i(i, r); if not p in matched_cells: matched_cells.append(p)
				match_len = 1
		if match_len >= 3:
			for i in range(GRID_COLS - match_len, GRID_COLS):
				var p = Vector2i(i, r); if not p in matched_cells: matched_cells.append(p)

	for c in range(GRID_COLS):
		var match_len = 1
		for r in range(1, GRID_ROWS):
			if grid_data[r][c] != -1 and grid_data[r][c] == grid_data[r-1][c]: match_len += 1
			else:
				if match_len >= 3:
					for i in range(r - match_len, r):
						var p = Vector2i(c, i); if not p in matched_cells: matched_cells.append(p)
				match_len = 1
		if match_len >= 3:
			for i in range(GRID_ROWS - match_len, GRID_ROWS):
				var p = Vector2i(c, i); if not p in matched_cells: matched_cells.append(p)
	return matched_cells

func _resolve_board_cascade() -> void:
	var matches = _find_all_matches()
	while not matches.is_empty():
		current_score += matches.size() * 100
		_update_ui()
		var pop_tween: Tween = create_tween().set_parallel(true)
		for cell in matches:
			var spr = grid_sprites[cell.y][cell.x]
			if spr and is_instance_valid(spr):
				pop_tween.tween_property(spr, "scale", Vector2.ZERO, 0.15)
				pop_tween.tween_property(spr, "modulate:a", 0.0, 0.15)
		await pop_tween.finished
		
		for cell in matches:
			if grid_sprites[cell.y][cell.x] and is_instance_valid(grid_sprites[cell.y][cell.x]):
				grid_sprites[cell.y][cell.x].queue_free()
				grid_sprites[cell.y][cell.x] = null
			grid_data[cell.y][cell.x] = -1

		await _apply_gravity()
		await _refill_board()

		if current_score >= target_score and not game_over:
			_on_game_won()
			is_processing_matches = false
			return
		matches = _find_all_matches()
	is_processing_matches = false

func _apply_gravity() -> void:
	var fall_tween: Tween = null
	var has_fall = false
	for c in range(GRID_COLS):
		var empty_slots = 0
		for r in range(GRID_ROWS - 1, -1, -1):
			if grid_data[r][c] == -1: empty_slots += 1
			elif empty_slots > 0:
				var new_row = r + empty_slots
				grid_data[new_row][c] = grid_data[r][c]; grid_data[r][c] = -1
				var spr = grid_sprites[r][c]
				grid_sprites[new_row][c] = spr; grid_sprites[r][c] = null
				if spr and is_instance_valid(spr):
					if fall_tween == null: fall_tween = create_tween().set_parallel(true)
					var target_pos := Vector2((c + 0.5) * CELL_SIZE, (new_row + 0.5) * CELL_SIZE)
					fall_tween.tween_property(spr, "position", target_pos, 0.2).set_trans(Tween.TRANS_BOUNCE)
					has_fall = true
	if fall_tween and has_fall: await fall_tween.finished

func _refill_board() -> void:
	var spawn_tween: Tween = null
	var has_spawn = false
	for c in range(GRID_COLS):
		for r in range(GRID_ROWS):
			if grid_data[r][c] == -1:
				var new_type = randi() % num_coin_types
				grid_data[r][c] = new_type
				var spr = _create_coin_sprite(r, c, new_type)
				spr.scale = Vector2.ZERO; spr.position.y = -CELL_SIZE
				if spawn_tween == null: spawn_tween = create_tween().set_parallel(true)
				var final_pos := Vector2((c + 0.5) * CELL_SIZE, (r + 0.5) * CELL_SIZE)
				spawn_tween.tween_property(spr, "position", final_pos, 0.22)
				var frame_w: float = float(tex_coins.get_width()) / float(COIN_HFRAMES)
				var final_s: float = 46.0 / maxf(1.0, frame_w)
				spawn_tween.tween_property(spr, "scale", Vector2(final_s, final_s), 0.22)
				has_spawn = true
	if spawn_tween and has_spawn: await spawn_tween.finished

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return
	time_remaining -= delta
	if time_remaining <= 0.0:
		time_remaining = 0.0; _on_game_lost("¡Se agotó el tiempo!")
	_update_ui()

func _update_ui() -> void:
	score_label.text = "PUNTOS: %d / %d" % [current_score, target_score]
	level_label.text = "DIFICULTAD: %d" % current_level
	timer_label.text = "00:%02d" % int(ceil(time_remaining))

func _update_retry_button() -> void:
	if retry_button == null: return
	if retry_cooldown_left > 0:
		retry_button.disabled = true
		var m = int(float(retry_cooldown_left) / 60.0)
		var s = retry_cooldown_left % 60
		retry_button.text = "⏳ Espera %02d:%02d" % [m, s]
	else:
		retry_button.disabled = false
		retry_button.text = "🏁 Volver a Jugar"

func _on_game_won() -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "¡VICTORIA!"
	result_title.add_theme_color_override("font_color", Color(0.3, 1.0, 0.4))
	result_message.text = "Guardando victoria en la central..."

	var payload = {
		"p_game_id": GAME_ID, "p_won": true,
		"p_session_token": current_session_token, "p_score_achieved": current_score
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var data = res["data"]
		var reward = float(data.get("reward_kwp", 0.000000001))
		var cd = int(data.get("cooldown_seconds", 5))
		var wins_in_lvl = int(data.get("wins_in_level", 0))
		var leveled_up = bool(data.get("leveled_up", false))
		var new_lvl = int(data.get("current_level", current_level))
		var is_inf = bool(data.get("is_infinite", false))
		
		GameManager.set_cooldown_seconds(GAME_ID, cd)
		GameManager.add_temporary_power(reward)
		retry_cooldown_left = cd
		_update_retry_button()
		
		if is_inf and new_lvl == 4:
			result_message.text = "⚡ ¡NIVEL 4 INFINITO!\n+%.9f KWP ganado.\n(Cooldown entre partidas: 2 min)" % reward
		elif leveled_up:
			result_message.text = "⭐ ¡SUBISTE A NIVEL %d!\n+%.9f KWP ganado." % [new_lvl, reward]
		else:
			result_message.text = "¡Nivel superado!\n+%.9f KWP ganado.\n(Progreso nivel: %d / 6 victorias)" % [reward, wins_in_lvl]
			
		# Notificación de pieza obtenida
		# Notificación y guardado inmediato de pieza obtenida
		if bool(data.get("has_dropped_part", false)):
			var raw_type = str(data.get("dropped_part_type", "repuesto")).strip_edges().to_lower()
			var p_lvl = int(data.get("dropped_part_level", 1))
			var p_qty = int(data.get("dropped_part_qty", 1))
			result_message.text += "\n📦 ¡Recompensa de Taller: +%d %s (Nv. %d)!" % [p_qty, raw_type.capitalize(), p_lvl]
			
			# 1. Sumar inmediatamente a la memoria local (evita que se quede en 0)
			GameManager.add_part_locally(raw_type, p_lvl, p_qty)
			
			# 2. Sincronizar en segundo plano
			GameManager.load_player_parts()

func _on_game_lost(reason: String) -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "DERROTA"
	result_title.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	result_message.text = reason + "\nNo obtienes recompensa. Vuelve a intentarlo."
	cooldown_label.text = ""
	retry_cooldown_left = 5
	_update_retry_button()
	var payload = {"p_game_id": GAME_ID, "p_won": false, "p_session_token": current_session_token}
	SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)

func _on_retry_pressed() -> void:
	if retry_cooldown_left > 0: return
	retry_button.disabled = true; retry_button.text = "Iniciando..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": GAME_ID}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		_return_to_hub()
		return
	if res.get("success", false) and res["data"].get("success", false):
		var new_token = str(res["data"].get("session_token", ""))
		var new_lvl = int(res["data"].get("current_level", current_level))
		var new_scene = load("res://features/minigames/coin_match/coin_match.tscn").instantiate()
		new_scene.set_game_level(new_lvl)
		new_scene.set_session_token(new_token)
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
	else:
		_return_to_hub()

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")
