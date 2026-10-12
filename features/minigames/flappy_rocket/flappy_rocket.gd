# res://features/minigames/flappy_rocket/flappy_rocket.gd
extends Control

const GAME_ID: String = "flappy_rocket"

@export var ship_hframes: int = 4
@export var explosion_hframes: int = 6

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var pipes_container: Node2D = $PipesContainer
@onready var rocket_area: Area2D = $RocketArea
@onready var rocket_sprite: Sprite2D = $RocketArea/RocketSprite
@onready var rocket_collision: CollisionShape2D = $RocketArea/CollisionShape2D
@onready var explosion_sprite: Sprite2D = $ExplosionSprite
@onready var touch_button: Button = $TouchScreenButton

@onready var score_title: Label = $HUD/TopPanel/Margin/HBox/ScoreBox/ScoreTitle
@onready var level_label: Label = $HUD/TopPanel/Margin/HBox/LevelLabel
@onready var exit_button: Button = $HUD/TopPanel/Margin/HBox/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

const GRAVITY: float = 1000.0
const FLAP_FORCE: float = -350.0

var velocity_y: float = 0.0
var current_level: int = 1
var target_pipes: int = 8
var pipe_speed: float = 210.0
var pipe_gap: float = 230.0
var spawn_interval: float = 2.0

var pipes_passed: int = 0
var game_started: bool = false
var game_over: bool = false
var spawn_timer: float = 0.0
var anim_timer: float = 0.0

var tex_ship: Texture2D
var tex_explosion: Texture2D
var tex_bar: Texture2D
var current_session_token: String = ""

var retry_cooldown_left: int = 0
var retry_tick_accum: float = 0.0

func _ready() -> void:
	touch_button.focus_mode = Control.FOCUS_NONE
	exit_button.pressed.connect(_return_to_hub)
	action_button.pressed.connect(_return_to_hub)
	retry_button.pressed.connect(_on_retry_pressed)
	touch_button.pressed.connect(_flap)
	rocket_area.area_entered.connect(_on_rocket_collision)
	
	_load_assets()
	_apply_level_parameters()
	_setup_collision()
	_update_ui()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE and event.pressed and not event.is_echo()):
		_flap()
		get_viewport().set_input_as_handled()

func _load_assets() -> void:
	var bg_p = "res://assets/sprites/minigames/flappy_rocket/bg.png"
	if ResourceLoader.exists(bg_p): bg_texture.texture = load(bg_p)
		
	var s_p = "res://assets/sprites/minigames/flappy_rocket/ship.png"
	if ResourceLoader.exists(s_p):
		tex_ship = load(s_p)
		rocket_sprite.texture = tex_ship
		rocket_sprite.hframes = max(1, ship_hframes)
		rocket_sprite.frame = 0
		var frame_w: float = float(tex_ship.get_width()) / float(max(1, ship_hframes))
		var final_scale: float = 75.0 / maxf(1.0, frame_w)
		rocket_sprite.scale = Vector2(final_scale, final_scale)
		
	var e_p = "res://assets/sprites/minigames/flappy_rocket/explosion.png"
	if ResourceLoader.exists(e_p):
		tex_explosion = load(e_p)
		explosion_sprite.texture = tex_explosion
		explosion_sprite.hframes = max(1, explosion_hframes)
		var exp_w: float = float(tex_explosion.get_width()) / float(max(1, explosion_hframes))
		var exp_scale: float = 90.0 / maxf(1.0, exp_w)
		explosion_sprite.scale = Vector2(exp_scale, exp_scale)
		
	var b_p = "res://assets/sprites/minigames/flappy_rocket/bar_green.png"
	if ResourceLoader.exists(b_p): tex_bar = load(b_p)

func _setup_collision() -> void:
	var shape := CircleShape2D.new()
	shape.radius = 20.0
	rocket_collision.shape = shape

func set_game_level(lvl: int) -> void: current_level = clamp(lvl, 1, 4)
func set_session_token(token: String) -> void: current_session_token = token

func _apply_level_parameters() -> void:
	match current_level:
		1: target_pipes = 8; pipe_speed = 210.0; pipe_gap = 230.0; spawn_interval = 2.0
		2: target_pipes = 14; pipe_speed = 310.0; pipe_gap = 195.0; spawn_interval = 1.6
		3: target_pipes = 20; pipe_speed = 410.0; pipe_gap = 170.0; spawn_interval = 1.3
		4: target_pipes = 28; pipe_speed = 500.0; pipe_gap = 150.0; spawn_interval = 1.0

func _flap() -> void:
	if game_over: return
	game_started = true
	velocity_y = FLAP_FORCE

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return

	anim_timer += delta
	if anim_timer >= 0.1:
		anim_timer = 0.0
		if rocket_sprite.hframes > 1:
			rocket_sprite.frame = (rocket_sprite.frame + 1) % rocket_sprite.hframes

	if not game_started:
		rocket_area.position.y = 360.0 + sin(Time.get_ticks_msec() * 0.005) * 12.0
		return

	velocity_y += GRAVITY * delta
	rocket_area.position.y += velocity_y * delta
	rocket_area.rotation = clampf(velocity_y * 0.0016, -0.4, 0.6)

	if rocket_area.position.y <= 60.0 or rocket_area.position.y >= 710.0:
		_trigger_crash()
		return

	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		_spawn_pipe_pair()

	for pair in pipes_container.get_children():
		pair.position.x -= pipe_speed * delta
		if not pair.get_meta("passed") and pair.position.x < rocket_area.position.x:
			pair.set_meta("passed", true)
			pipes_passed += 1
			_update_ui()
			if pipes_passed >= target_pipes:
				_on_game_won()
				return
		if pair.position.x < -200.0: pair.queue_free()

func _spawn_pipe_pair() -> void:
	if tex_bar == null: return
	var pair_node := Node2D.new()
	pair_node.position.x = 1350.0
	pair_node.set_meta("passed", false)

	var center_y: float = randf_range(220.0, 500.0)
	var half_gap: float = pipe_gap / 2.0

	var top_pipe = _create_pipe_segment(true)
	top_pipe.position.y = center_y - half_gap
	pair_node.add_child(top_pipe)

	var bottom_pipe = _create_pipe_segment(false)
	bottom_pipe.position.y = center_y + half_gap
	pair_node.add_child(bottom_pipe)
	pipes_container.add_child(pair_node)

func _create_pipe_segment(is_top: bool) -> Area2D:
	var area := Area2D.new()
	var bar_w: float = float(tex_bar.get_width())
	var bar_h: float = float(tex_bar.get_height())
	
	var spr := Sprite2D.new()
	spr.texture = tex_bar
	spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	spr.centered = false
	
	if is_top:
		spr.flip_v = true; spr.modulate = Color(1.0, 0.35, 0.35); spr.position = Vector2(-bar_w / 2.0, -bar_h)
	else:
		spr.modulate = Color(0.4, 1.0, 0.4); spr.position = Vector2(-bar_w / 2.0, 0.0)
	area.add_child(spr)

	var col := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(bar_w * 0.7, bar_h)
	col.shape = rect
	col.position = Vector2(0, -bar_h / 2.0 if is_top else bar_h / 2.0)
	area.add_child(col)
	return area

func _on_rocket_collision(_area: Area2D) -> void: _trigger_crash()

func _trigger_crash() -> void:
	if game_over: return
	game_over = true
	rocket_area.visible = false
	explosion_sprite.position = rocket_area.position
	explosion_sprite.visible = true
	
	for i in range(explosion_hframes):
		explosion_sprite.frame = i
		await get_tree().create_timer(0.07).timeout
		
	explosion_sprite.visible = false
	_on_game_lost("¡Has colisionado!")

func _update_ui() -> void:
	score_title.text = "BARRAS: %d / %d" % [pipes_passed, target_pipes]
	level_label.text = "DIFICULTAD: %d" % current_level

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
		"p_score_achieved": pipes_passed
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
		_return_to_hub()
		return
		
	if res.get("success", false) and res["data"].get("success", false):
		var new_token: String = str(res["data"].get("session_token", ""))
		var new_lvl: int = int(res["data"].get("current_level", current_level))
		var new_scene = load("res://features/minigames/flappy_rocket/flappy_rocket.tscn").instantiate()
		new_scene.set_game_level(new_lvl)
		new_scene.set_session_token(new_token)
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
	else:
		_return_to_hub()

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")
