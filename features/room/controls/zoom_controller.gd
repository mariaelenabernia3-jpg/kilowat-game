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
var mobile_zoom_bar: HBoxContainer = null

# Seguimiento Multi-Touch Android
var touch_points: Dictionary = {}
var start_distance: float = 0.0
var start_zoom: float = 1.0
var start_midpoint: Vector2 = Vector2.ZERO
var start_pan: Vector2 = Vector2.ZERO
var is_pinching: bool = false

# Control PC
var is_dragging_pc: bool = false
var last_scene: Node = null

func _ready() -> void:
	_setup_hud()

func _setup_hud() -> void:
	# Capa visual independiente inmune al escalado
	hud_layer = CanvasLayer.new()
	hud_layer.name = "GlobalZoomHudLayer"
	hud_layer.layer = 127
	add_child(hud_layer)

	# 1. Botón de restablecer (Centro inferior - aparece solo con zoom)
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
	reset_btn.grow_horizontal = Control.GROW_DIRECTION_BOTH
	reset_btn.grow_vertical = Control.GROW_DIRECTION_BEGIN

	var b_st := StyleBoxFlat.new()
	b_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	b_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	b_st.set_border_width_all(2)
	b_st.set_corner_radius_all(20)
	b_st.shadow_color = Color(0.15, 0.6, 0.85, 0.4)
	b_st.shadow_size = 8
	reset_btn.add_theme_stylebox_override("normal", b_st)
	reset_btn.add_theme_stylebox_override("hover", b_st)
	reset_btn.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
	reset_btn.add_theme_font_size_override("font_size", 12)
	reset_btn.text = "🔍 Restablecer Lupa"
	reset_btn.pressed.connect(func(): reset_zoom(true))
	hud_layer.add_child(reset_btn)

	# 2. Botones rápidos de lupa (+ / -) flotantes en la esquina inferior derecha
	mobile_zoom_bar = HBoxContainer.new()
	mobile_zoom_bar.name = "MobileZoomBar"
	mobile_zoom_bar.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	mobile_zoom_bar.anchor_left = 1.0
	mobile_zoom_bar.anchor_right = 1.0
	mobile_zoom_bar.anchor_top = 1.0
	mobile_zoom_bar.anchor_bottom = 1.0
	mobile_zoom_bar.offset_left = -115.0
	mobile_zoom_bar.offset_right = -18.0
	mobile_zoom_bar.offset_top = -62.0
	mobile_zoom_bar.offset_bottom = -22.0
	mobile_zoom_bar.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	mobile_zoom_bar.grow_vertical = Control.GROW_DIRECTION_BEGIN
	mobile_zoom_bar.add_theme_constant_override("separation", 6)

	var btn_out := Button.new()
	btn_out.text = "🔍-"
	btn_out.custom_minimum_size = Vector2(44, 38)
	btn_out.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_out.pressed.connect(func(): _step_zoom(0.80, get_viewport().get_visible_rect().size / 2.0))
	mobile_zoom_bar.add_child(btn_out)

	var btn_in := Button.new()
	btn_in.text = "🔍+"
	btn_in.custom_minimum_size = Vector2(44, 38)
	btn_in.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_in.pressed.connect(func(): _step_zoom(1.25, get_viewport().get_visible_rect().size / 2.0))
	mobile_zoom_bar.add_child(btn_in)

	hud_layer.add_child(mobile_zoom_bar)

func _process(_delta: float) -> void:
	var cur = get_tree().current_scene
	if cur != null and cur != last_scene:
		last_scene = cur
		if current_zoom > 1.02:
			reset_zoom(false)

func _input(event: InputEvent) -> void:
	var vp_size: Vector2 = get_viewport().get_visible_rect().size

	# =========================================================================
	# A) GESTOS NATIVOS DE ANDROID (ScaleGestureDetector del OS)
	# =========================================================================
	if event is InputEventMagnifyGesture:
		_step_zoom(event.factor, event.position)
		get_viewport().set_input_as_handled()
		return

	if event is InputEventPanGesture:
		if current_zoom > 1.05:
			current_pan -= event.delta * 1.5
			_clamp_pan(vp_size)
			_apply_transform()
			get_viewport().set_input_as_handled()
		return

	# =========================================================================
	# B) RECONOCIMIENTO MULTI-TOUCH ROBUSTO PARA ANDROID
	# =========================================================================
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_points[event.index] = event.position
		else:
			touch_points.erase(event.index)
			if touch_points.size() < 2:
				is_pinching = false
				start_distance = 0.0
				if current_zoom < 1.03:
					reset_zoom(true)

		# Si hay 2 dedos en la pantalla, inicializar el pellizco
		if touch_points.size() >= 2:
			_start_pinch()
			get_viewport().set_input_as_handled()

	elif event is InputEventScreenDrag:
		touch_points[event.index] = event.position

		# GESTO DE PELLIZCO ACTIVO
		if touch_points.size() >= 2:
			if not is_pinching or start_distance <= 10.0:
				_start_pinch()

			if start_distance > 10.0:
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

		# ARRASTRE CON 1 DEDO POR LA PANTALLA CON ZOOM ACTIVO
		elif touch_points.size() == 1 and current_zoom > 1.05 and not is_pinching:
			current_pan += event.relative
			_clamp_pan(vp_size)
			_apply_transform()
			get_viewport().set_input_as_handled()

	# =========================================================================
	# C) CONTROLES PC (RUEDA DEL RATÓN / CLIC DERECHO)
	# =========================================================================
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_step_zoom(1.18, event.position)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_step_zoom(0.82, event.position)
		elif event.button_index in [MOUSE_BUTTON_RIGHT, MOUSE_BUTTON_MIDDLE]:
			is_dragging_pc = event.pressed and (current_zoom > 1.0)

	elif event is InputEventMouseMotion and is_dragging_pc:
		if current_zoom > 1.0:
			current_pan += event.relative
			_clamp_pan(vp_size)
			_apply_transform()

	elif event is InputEventKey and event.pressed and not event.echo:
		if event.keycode in [KEY_ESCAPE, KEY_SPACE] and current_zoom > 1.05:
			reset_zoom(true)

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

	# Evitar que la botonera de zoom se deforme con el escalado
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
	is_dragging_pc = false

	if current_zoom == 1.0 and current_pan == Vector2.ZERO:
		if reset_btn: reset_btn.visible = false
		return

	if animated:
		if zoom_tween and zoom_tween.is_running(): zoom_tween.kill()
		zoom_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		zoom_tween.tween_method(func(v): current_zoom = v; _apply_transform(), current_zoom, 1.0, 0.2)
		zoom_tween.tween_method(func(v): current_pan = v; _apply_transform(), current_pan, Vector2.ZERO, 0.2)
		zoom_tween.chain().tween_callback(func():
			current_zoom = 1.0
			current_pan = Vector2.ZERO
			_apply_transform()
		)
	else:
		current_zoom = 1.0
		current_pan = Vector2.ZERO
		_apply_transform()
