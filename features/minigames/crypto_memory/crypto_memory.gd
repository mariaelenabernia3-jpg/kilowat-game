# res://features/minigames/crypto_memory/crypto_memory.gd
extends Control

const COIN_HFRAMES: int = 12
const CARD_SIZE: Vector2 = Vector2(86, 86)
const GAME_ID: String = "crypto_memory"

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var grid_container: GridContainer = $PlayArea/CenterBoard/BoardPanel/Margin/CardsGrid
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
var total_pairs_needed: int = 4
var pairs_found: int = 0
var time_remaining: float = 50.0

var current_session_token: String = ""
var game_over: bool = false
var can_flip: bool = true

var first_card = null
var second_card = null
var coin_textures: Array[Texture2D] = []

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
	_setup_board()
	_update_ui()

func _load_assets() -> void:
	var bg_path = "res://assets/sprites/minigames/crypto_memory/bg.png"
	if ResourceLoader.exists(bg_path): bg_texture.texture = load(bg_path)
	elif ResourceLoader.exists("res://assets/sprites/minigames/coin_match/bg.png"):
		bg_texture.texture = load("res://assets/sprites/minigames/coin_match/bg.png")
		
	var file_names = [
		"card_btc.png", "card_eth.png", "card_bnb.png", "card_usdt.png",
		"card_rlt.png", "card_xrp.png", "card_xmr.png", "card_ltc.png",
		"card_eos.png", "card_rocket.png"
	]
	coin_textures.clear()
	for fn in file_names:
		var p1 = "res://assets/sprites/minigames/crypto_memory/" + fn
		var p2 = "res://assets/sprites/minigames/coin_match/" + fn
		if ResourceLoader.exists(p1): coin_textures.append(load(p1))
		elif ResourceLoader.exists(p2): coin_textures.append(load(p2))

func _apply_level_parameters() -> void:
	match current_level:
		1: total_pairs_needed = 4; time_remaining = 50.0; grid_container.columns = 4
		2: total_pairs_needed = 6; time_remaining = 45.0; grid_container.columns = 4
		3: total_pairs_needed = 8; time_remaining = 40.0; grid_container.columns = 4
		4: total_pairs_needed = 10; time_remaining = 35.0; grid_container.columns = 5

func _setup_board() -> void:
	for child in grid_container.get_children(): child.queue_free()
	pairs_found = 0; first_card = null; second_card = null; can_flip = true
	var deck: Array[int] = []
	var max_types: int = max(1, coin_textures.size())
	
	for pair_idx in range(total_pairs_needed):
		var coin_id: int = pair_idx % max_types
		deck.append(coin_id); deck.append(coin_id)
		
	deck.shuffle()
	for i in range(deck.size()):
		var card_btn = _create_card_button(deck[i])
		grid_container.add_child(card_btn)

func _create_card_button(coin_id: int) -> Control:
	var card_root := Control.new()
	card_root.custom_minimum_size = CARD_SIZE; card_root.size = CARD_SIZE
	
	var spr := Sprite2D.new()
	spr.name = "Sprite"
	spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	spr.centered = true
	spr.position = CARD_SIZE / 2.0
	
	if coin_id < coin_textures.size(): spr.texture = coin_textures[coin_id]
	elif coin_textures.size() > 0: spr.texture = coin_textures[0]
		
	spr.hframes = COIN_HFRAMES; spr.frame = 0
	if spr.texture:
		var frame_w: float = float(spr.texture.get_width()) / float(COIN_HFRAMES)
		var scale_factor: float = (CARD_SIZE.x - 6.0) / maxf(1.0, frame_w)
		spr.scale = Vector2(scale_factor, scale_factor)
	card_root.add_child(spr)
	
	var btn := Button.new()
	btn.name = "TouchArea"
	btn.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn.flat = true
	
	card_root.set_meta("coin_id", coin_id)
	card_root.set_meta("is_revealed", false)
	card_root.set_meta("is_matched", false)
	card_root.set_meta("sprite", spr)
	btn.pressed.connect(func(): _on_card_pressed(card_root))
	card_root.add_child(btn)
	return card_root

func _on_card_pressed(card: Control) -> void:
	if game_over or not can_flip: return
	if card.get_meta("is_revealed") or card.get_meta("is_matched"): return
		
	_flip_card_open(card)
	if first_card == null: first_card = card
	elif second_card == null:
		second_card = card
		can_flip = false
		_check_match()

func _flip_card_open(card: Control) -> void:
	card.set_meta("is_revealed", true)
	var spr: Sprite2D = card.get_meta("sprite")
	spr.frame = 4; await get_tree().create_timer(0.04).timeout
	spr.frame = 5; await get_tree().create_timer(0.04).timeout
	spr.frame = 6; await get_tree().create_timer(0.04).timeout
	spr.frame = 7

func _flip_card_closed(card: Control) -> void:
	card.set_meta("is_revealed", false)
	var spr: Sprite2D = card.get_meta("sprite")
	spr.frame = 6; await get_tree().create_timer(0.04).timeout
	spr.frame = 5; await get_tree().create_timer(0.04).timeout
	spr.frame = 4; await get_tree().create_timer(0.04).timeout
	spr.frame = 0

func _play_match_sparkle(card: Control) -> void:
	card.set_meta("is_matched", true)
	var spr: Sprite2D = card.get_meta("sprite")
	spr.frame = 8; await get_tree().create_timer(0.05).timeout
	spr.frame = 9; await get_tree().create_timer(0.05).timeout
	spr.frame = 10; await get_tree().create_timer(0.05).timeout
	spr.frame = 11; await get_tree().create_timer(0.07).timeout
	spr.frame = 7

func _check_match() -> void:
	var id1: int = first_card.get_meta("coin_id")
	var id2: int = second_card.get_meta("coin_id")
	if id1 == id2:
		pairs_found += 1
		_update_ui()
		_play_match_sparkle(first_card)
		_play_match_sparkle(second_card)
		first_card = null; second_card = null; can_flip = true
		if pairs_found >= total_pairs_needed: _on_game_won()
	else:
		await get_tree().create_timer(0.55).timeout
		_flip_card_closed(first_card)
		_flip_card_closed(second_card)
		first_card = null; second_card = null; can_flip = true

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
	score_label.text = "PAREJAS: %d / %d" % [pairs_found, total_pairs_needed]
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
		"p_session_token": current_session_token, "p_score_achieved": pairs_found
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
		if bool(data.get("has_dropped_part", false)):
			var p_type = str(data.get("dropped_part_type", "repuesto")).capitalize()
			var p_lvl = int(data.get("dropped_part_level", 1))
			var p_qty = int(data.get("dropped_part_qty", 1))
			result_message.text += "\n📦 ¡Recompensa de Taller: +%d %s (Nv. %d)!" % [p_qty, p_type, p_lvl]
			await GameManager.load_player_inventory()

		cooldown_label.text = "Cooldown de %d segundos." % cd
	else:
		result_message.text = "¡Nivel superado!\n(Modo sin conexión)"
		retry_cooldown_left = 5
		_update_retry_button()

func _on_game_lost(reason: String) -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "DERROTA"
	result_title.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	result_message.text = reason + "\nNo obtienes recompensa. Vuelve a intentarlo."
	cooldown_label.text = ""
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID, "p_won": false, "p_session_token": current_session_token
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	var cd: int = int(res.get("data", {}).get("cooldown_seconds", 5)) if res.get("success", false) else 5
	GameManager.set_cooldown_seconds(GAME_ID, cd)
	retry_cooldown_left = cd
	_update_retry_button()

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
		var new_scene = load("res://features/minigames/crypto_memory/crypto_memory.tscn").instantiate()
		new_scene.set_game_level(new_lvl)
		new_scene.set_session_token(new_token)
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
	else:
		_return_to_hub()

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")
