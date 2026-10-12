# res://features/minigames/coin_click/coin_click.gd
extends Control

const GAME_ID: String = "coinclick"
const FUSE_PUZZLE_SCENE = preload("res://features/minigames/_shared/fuse_puzzle.tscn")
var active_puzzle = null

@export_group("Configuración Mago (Hamster)")
@export var wizard_hframes: int = 6
@export var wizard_vframes: int = 1
@export_range(1.0, 6.0, 0.1) var wizard_scale: float = 2.6

@export_group("Configuración Moneda")
@export var coin_hframes: int = 4
@export var coin_vframes: int = 1
@export_range(1.0, 6.0, 0.1) var coin_scale: float = 2.8

@export_group("Configuración Bomba")
@export var bomb_hframes: int = 4
@export var bomb_vframes: int = 1
@export_range(1.0, 6.0, 0.1) var bomb_scale: float = 2.6

@export_group("Velocidad de Animación")
@export_range(2.0, 30.0, 1.0) var animation_fps: float = 10.0

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var fallback_wall: ColorRect = $FallbackWall
@onready var wizard_sprite: Sprite2D = $PlayArea/WizardSprite
@onready var droppables_container: Node2D = $PlayArea/DroppablesContainer

@onready var score_label: Label = $HUD/TopPanel/MarginContainer/HBoxContainer/ScoreBox/ScoreLabel
@onready var level_label: Label = $HUD/TopPanel/MarginContainer/HBoxContainer/LevelLabel
@onready var timer_label: Label = $HUD/TopPanel/MarginContainer/HBoxContainer/TimeBox/TimerLabel
@onready var exit_button: Button = $HUD/TopPanel/MarginContainer/HBoxContainer/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

var current_level: int = 1
var coins_target: int = 8
var wizard_speed: float = 200.0
var drop_fall_speed: float = 190.0
var drop_interval: float = 1.3
var time_remaining: float = 45.0

var wizard_dir: float = 1.0
var drop_timer: float = 0.0
var anim_timer: float = 0.0
var coins_collected: int = 0
var game_over: bool = false

var tex_wizard: Texture2D
var tex_coin: Texture2D
var tex_bomb: Texture2D
var current_session_token: String = ""

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
	_update_ui()

func _load_assets() -> void:
	var bg_path = "res://assets/sprites/minigames/coinclick/bg.png"
	if ResourceLoader.exists(bg_path):
		bg_texture.texture = load(bg_path)
		fallback_wall.visible = false
	else:
		fallback_wall.visible = true

	var w_path = "res://assets/sprites/minigames/coinclick/wizard.png"
	if ResourceLoader.exists(w_path):
		tex_wizard = load(w_path)
		wizard_sprite.texture = tex_wizard
		wizard_sprite.hframes = wizard_hframes
		wizard_sprite.vframes = wizard_vframes
		wizard_sprite.frame = 0
		wizard_sprite.scale = Vector2(wizard_scale, wizard_scale)

	var c_path = "res://assets/sprites/minigames/coinclick/coin.png"
	if ResourceLoader.exists(c_path): tex_coin = load(c_path)
	var b_path = "res://assets/sprites/minigames/coinclick/bomb.png"
	if ResourceLoader.exists(b_path): tex_bomb = load(b_path)

func _apply_level_parameters() -> void:
	match current_level:
		1: coins_target = 8; wizard_speed = 200.0; drop_fall_speed = 190.0; drop_interval = 1.3; time_remaining = 45.0
		2: coins_target = 14; wizard_speed = 300.0; drop_fall_speed = 260.0; drop_interval = 1.0; time_remaining = 40.0
		3: coins_target = 20; wizard_speed = 420.0; drop_fall_speed = 340.0; drop_interval = 0.75; time_remaining = 35.0
		4: coins_target = 26; wizard_speed = 520.0; drop_fall_speed = 420.0; drop_interval = 0.6; time_remaining = 30.0

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return
		
	wizard_sprite.position.x += wizard_speed * wizard_dir * delta
	if wizard_sprite.position.x <= 160.0:
		wizard_sprite.position.x = 160.0; wizard_dir = 1.0; wizard_sprite.flip_h = false
	elif wizard_sprite.position.x >= 1120.0:
		wizard_sprite.position.x = 1120.0; wizard_dir = -1.0; wizard_sprite.flip_h = true

	var frame_interval: float = 1.0 / maxf(1.0, animation_fps)
	anim_timer += delta
	if anim_timer >= frame_interval:
		anim_timer = 0.0
		var total_wiz_frames: int = wizard_sprite.hframes * wizard_sprite.vframes
		if total_wiz_frames > 1:
			wizard_sprite.frame = (wizard_sprite.frame + 1) % total_wiz_frames
			
		for drop in droppables_container.get_children():
			var spr: Sprite2D = drop.get_node_or_null("Sprite")
			if spr:
				var total_drop_frames: int = spr.hframes * spr.vframes
				if total_drop_frames > 1:
					spr.frame = (spr.frame + 1) % total_drop_frames

	drop_timer += delta
	if drop_timer >= drop_interval:
		drop_timer = 0.0
		_spawn_droppable()

	for drop in droppables_container.get_children():
		drop.position.y += drop_fall_speed * delta
		if drop.position.y >= 710.0:
			if drop.get_meta("is_bomb") == false:
				_on_game_lost("¡Una moneda tocó el suelo!")
				return
			else:
				drop.queue_free()

	time_remaining -= delta
	if time_remaining <= 0.0:
		time_remaining = 0.0
		_on_game_lost("¡Se agotó el tiempo!")

	_update_ui()

func _spawn_droppable() -> void:
	var is_bomb: bool = (randf() < 0.35)
	var spawn_pos := Vector2(wizard_sprite.position.x, wizard_sprite.position.y + 40.0)

	var item_node := Node2D.new()
	item_node.position = spawn_pos
	item_node.set_meta("is_bomb", is_bomb)

	var spr := Sprite2D.new()
	spr.name = "Sprite"
	spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	if is_bomb:
		spr.texture = tex_bomb
		spr.hframes = bomb_hframes; spr.vframes = bomb_vframes; spr.scale = Vector2(bomb_scale, bomb_scale)
	else:
		spr.texture = tex_coin
		spr.hframes = coin_hframes; spr.vframes = coin_vframes; spr.scale = Vector2(coin_scale, coin_scale)
		
	spr.frame = 0
	item_node.add_child(spr)

	var btn := Button.new()
	btn.custom_minimum_size = Vector2(64, 64)
	btn.position = Vector2(-32, -32)
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn.flat = true
	btn.pressed.connect(func(): _on_item_clicked(item_node, is_bomb))
	item_node.add_child(btn)
	droppables_container.add_child(item_node)

func _on_item_clicked(item: Node2D, is_bomb: bool) -> void:
	if game_over: return
	if is_bomb:
		item.queue_free()
		_on_game_lost("¡Tocaste una bomba!")
	else:
		item.queue_free()
		coins_collected += 1
		_update_ui()
		if coins_collected >= coins_target: _on_game_won()

func _update_ui() -> void:
	score_label.text = "MONEDAS: %d / %d" % [coins_collected, coins_target]
	level_label.text = "DIFICULTAD: %d" % current_level
	timer_label.text = "00:%02d" % int(time_remaining)

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
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID,
		"p_won": true,
		"p_session_token": current_session_token,
		"p_score_achieved": coins_collected
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
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID,
		"p_won": false,
		"p_session_token": current_session_token
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	var cd: int = int(res.get("data", {}).get("cooldown_seconds", 5)) if res.get("success", false) else 5
	GameManager.set_cooldown_seconds(GAME_ID, cd)
	retry_cooldown_left = cd
	_update_retry_button()

func _on_retry_pressed() -> void:
	if retry_cooldown_left > 0: return
	retry_button.disabled = true
	retry_button.text = "Iniciando..."
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": GAME_ID}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		_trigger_in_game_captcha()
		return
		
	if not res.get("success", false) or not res["data"].get("success", false):
		retry_cooldown_left = int(res.get("data", {}).get("remaining_seconds", 3))
		_update_retry_button()
		return
		
	var new_token: String = str(res["data"].get("session_token", ""))
	var new_lvl: int = int(res["data"].get("current_level", current_level))
	_restart_game_scene(new_lvl, new_token)

func _trigger_in_game_captcha() -> void:
	if active_puzzle == null:
		active_puzzle = FUSE_PUZZLE_SCENE.instantiate()
		$HUD.add_child(active_puzzle)
		active_puzzle.puzzle_completed.connect(func(success: bool):
			if success: _on_retry_pressed()
			else:
				retry_cooldown_left = 30
				_update_retry_button()
		)
	active_puzzle.open_challenge()

func _restart_game_scene(new_lvl: int, new_token: String) -> void:
	var path: String = "res://features/minigames/coin_click/coin_click.tscn"
	var new_scene = load(path).instantiate()
	new_scene.set_game_level(new_lvl)
	new_scene.set_session_token(new_token)
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")
