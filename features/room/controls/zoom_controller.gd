# res://features/room/controls/zoom_controller.gd
class_name ZoomController
extends Node

var current_zoom: float = 1.0
var current_pan: Vector2 = Vector2.ZERO
var min_zoom: float = 1.0
var max_zoom: float = 2.8

var zoom_tween: Tween = null
var hud_layer: CanvasLayer = null
var reset_btn: Button = null

var touch_points: Dictionary = {}
var start_distance: float = 0.0
var start_zoom: float = 1.0
var start_midpoint: Vector2 = Vector2.ZERO
var start_pan: Vector2 = Vector2.ZERO
var is_pinching: bool = false

func _ready() -> void:
	_setup_hud()

func _setup_hud() -> void:
	hud_layer = CanvasLayer.new()
	hud_layer.name = "GlobalZoomHudLayer"
	hud_layer.layer = 127
	add_child(hud_layer)

	reset_btn = Button.new()
	reset_btn.name = "ResetZoomBtn"
	reset_btn.visible = false
	reset_btn.custom_minimum_size = Vector2(190, 40)
	reset_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	reset_btn.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	reset_btn.anchor_left = 0.5
	reset_btn.anchor_right = 0.5
	reset_btn.anchor_top = 1.0
	reset_btn.anchor_bottom = 1.0
	reset_btn.offset_left = -95.0
	reset_btn.offset_right = 95.0
	reset_btn.offset_top = -58.0
	reset_btn.offset_bottom = -18.0
	reset_btn.text = "🔍 Restablecer Lupa"
	reset_btn.pressed.connect(func(): reset_zoom(true))
	hud_layer.add_child(reset_btn)

func _input(event: InputEvent) -> void:
	var vp_size: Vector2 = get_viewport().get_visible_rect().size

	# 1. TECLAS '+' Y '-' EN PC (Se quitó la rueda del ratón para no trabar el scroll)
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode in [KEY_PLUS, KEY_KP_ADD, KEY_EQUAL]:
			_step_zoom(1.20, vp_size / 2.0)
			get_viewport().set_input_as_handled()
			return
		elif event.keycode in [KEY_MINUS, KEY_KP_SUBTRACT]:
			_step_zoom(0.80, vp_size / 2.0)
			get_viewport().set_input_as_handled()
			return
		elif event.keycode in [KEY_ESCAPE, KEY_SPACE] and current_zoom > 1.05:
			reset_zoom(true)
			return

	# 2. CELULAR: PINCH TO ZOOM CON 2 DEDOS (NO INTERCEPTA 1 DEDO PARA PERMITIR SCROLL FLUIDO)
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_points[event.index] = event.position
			if touch_points.size() >= 2:
				_start_pinch()
				get_viewport().set_input_as_handled()
		else:
			touch_points.erase(event.index)
			if touch_points.size() < 2:
				is_pinching = false
				start_distance = 0.0

	elif event is InputEventScreenDrag:
		touch_points[event.index] = event.position
		if touch_points.size() >= 2 and start_distance > 10.0:
			var pts = touch_points.values()
			var cur_dist = pts[0].distance_to(pts[1])
			var cur_mid = (pts[0] + pts[1]) / 2.0

			var factor = cur_dist / start_distance
			var target_zoom = clampf(start_zoom * factor, min_zoom, max_zoom)

			var content_pt = (start_midpoint - start_pan) / start_zoom
			current_zoom = target_zoom
			current_pan = cur_mid - (content_pt * current_zoom)
			_clamp_pan(vp_size)
			_apply_transform()
			get_viewport().set_input_as_handled()
		# Si es 1 dedo y no hay zoom, se deja pasar libre para que todos los scrolls funcionen fluidos sin trabarse

func _start_pinch() -> void:
	is_pinching = true
	var pts = touch_points.values()
	start_distance = maxf(12.0, pts[0].distance_to(pts[1]))
	start_zoom = current_zoom
	start_midpoint = (pts[0] + pts[1]) / 2.0
	start_pan = current_pan

func _step_zoom(factor: float, center_pos: Vector2) -> void:
	var vp_size: Vector2 = get_viewport().get_visible_rect().size
	var target_zoom: float = clampf(current_zoom * factor, min_zoom, max_zoom)

	if target_zoom <= 1.03:
		current_zoom = 1.0
		current_pan = Vector2.ZERO
	else:
		var content_pt: Vector2 = (center_pos - current_pan) / current_zoom
		current_zoom = target_zoom
		current_pan = center_pos - (content_pt * current_zoom)
		_clamp_pan(vp_size)

	_apply_transform()

func _clamp_pan(vp_size: Vector2) -> void:
	if current_zoom <= 1.0:
		current_pan = Vector2.ZERO
		return
	var min_pan: Vector2 = vp_size * (1.0 - current_zoom)
	current_pan.x = clampf(current_pan.x, min_pan.x, 0.0)
	current_pan.y = clampf(current_pan.y, min_pan.y, 0.0)

func _apply_transform() -> void:
	var t := Transform2D(Vector2(current_zoom, 0), Vector2(0, current_zoom), current_pan)
	get_viewport().global_canvas_transform = t

	if hud_layer and is_instance_valid(hud_layer):
		hud_layer.transform = t.affine_inverse()

	if reset_btn and is_instance_valid(reset_btn):
		reset_btn.visible = (current_zoom > 1.05)
		if reset_btn.visible:
			reset_btn.text = "🔍 Restablecer Lupa (%.1fx)" % current_zoom

func reset_zoom(animated: bool = true) -> void:
	touch_points.clear()
	start_distance = 0.0
	is_pinching = false

	if animated:
		if zoom_tween and zoom_tween.is_running(): zoom_tween.kill()
		zoom_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		zoom_tween.tween_method(func(v): current_zoom = v; _apply_transform(), current_zoom, 1.0, 0.2)
		zoom_tween.tween_method(func(v): current_pan = v; _apply_transform(), current_pan, Vector2.ZERO, 0.2)
	else:
		current_zoom = 1.0
		current_pan = Vector2.ZERO
		_apply_transform()
