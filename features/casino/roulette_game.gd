# res://features/casino/roulette_game.gd
extends Control

@onready var back_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var chip_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel
@onready var watt_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilo_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel

@onready var spin_button: Button = $CanvasLayerUI/MainVBox/Body/VBox/ControlsBox/SpinButton
@onready var free_timer_lbl: Label = $CanvasLayerUI/MainVBox/Body/VBox/ControlsBox/FreeTimerLabel
@onready var status_toast_lbl: Label = $CanvasLayerUI/MainVBox/Body/VBox/StatusToast
@onready var wheel_container: Control = $CanvasLayerUI/MainVBox/Body/VBox/WheelArea/Center/WheelContainer

# Texturas oficiales del juego
const TEX_WATT = preload("res://assets/sprites/ui/icon_watt.png")
const TEX_CHIP = preload("res://assets/sprites/ui/icon_chip.png")
const TEX_PASS = preload("res://assets/sprites/ui/icon_battlepass.png")
const TEX_SPARK = preload("res://assets/sprites/generators/ecoflow_spark.png")

var wheel_disc: Control = null
var is_spinning: bool = false
var can_free_spin: bool = false
var free_seconds_left: int = 0
var timer_tick: float = 0.0

const TOTAL_SLOTS: int = 8
const SLICE_ANGLE: float = TAU / 8.0 # 45 grados por casilla

# Datos de las 8 casillas con sus colores, iconos reales y textos (sin mostrar probabilidades)
var slots_data: Array = []

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	spin_button.pressed.connect(_on_spin_pressed)
	
	_setup_slots_data()
	_build_centered_wheel()
	_update_hud()
	_check_status_from_server()

func _setup_slots_data() -> void:
	slots_data = [
		{"name": "+25 XP", "icon": TEX_PASS, "color": Color(0.14, 0.26, 0.44), "tint": Color.WHITE, "icon_size": Vector2(22, 22)},
		{"name": "+0.02 W", "icon": TEX_WATT, "color": Color(0.12, 0.38, 0.28), "tint": Color.WHITE, "icon_size": Vector2(20, 20)},
		{"name": "+50 XP", "icon": TEX_PASS, "color": Color(0.20, 0.22, 0.48), "tint": Color.WHITE, "icon_size": Vector2(22, 22)},
		{"name": "+kWp", "icon": TEX_WATT, "color": Color(0.12, 0.42, 0.52), "tint": Color(0.35, 0.95, 1.0), "icon_size": Vector2(20, 20)},
		{"name": "+0.15 W", "icon": TEX_WATT, "color": Color(0.15, 0.46, 0.32), "tint": Color.WHITE, "icon_size": Vector2(20, 20)},
		{"name": "1 CHIP", "icon": TEX_CHIP, "color": Color(0.55, 0.16, 0.45), "tint": Color.WHITE, "icon_size": Vector2(22, 22)},
		{"name": "+0.50 W", "icon": TEX_WATT, "color": Color(0.18, 0.55, 0.35), "tint": Color.WHITE, "icon_size": Vector2(20, 20)},
		{"name": "SPARK", "icon": TEX_SPARK, "color": Color(0.68, 0.52, 0.12), "tint": Color.WHITE, "icon_size": Vector2(26, 26)}
	]

func _process(delta: float) -> void:
	_update_hud()
	if free_seconds_left > 0 and not can_free_spin:
		timer_tick += delta
		if timer_tick >= 1.0:
			timer_tick = 0.0
			free_seconds_left -= 1
			_update_spin_button_ui()

func _update_hud() -> void:
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens
	if watt_lbl and is_instance_valid(watt_lbl):
		watt_lbl.text = "%.4f" % GameManager.watt
	if kilo_lbl and is_instance_valid(kilo_lbl):
		kilo_lbl.text = "%.6f" % GameManager.kilowat

func _on_back_pressed() -> void:
	if is_spinning: return
	get_tree().change_scene_to_file("res://features/casino/mines/casino_hub.tscn")

func _check_status_from_server() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_roulette_status", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		can_free_spin = bool(res["data"].get("can_free_spin", false))
		free_seconds_left = int(res["data"].get("free_spin_in_seconds", 0))
	_update_spin_button_ui()

func _update_spin_button_ui() -> void:
	if is_spinning:
		spin_button.disabled = true
		spin_button.text = "🎡 Girando la ruleta..."
		free_timer_lbl.text = ""
		return

	if can_free_spin:
		spin_button.disabled = false
		spin_button.text = "🎁 ¡GIRO GRATIS DEL DÍA!"
		var st_free := StyleBoxFlat.new()
		st_free.bg_color = Color(0.15, 0.75, 0.45)
		st_free.set_corner_radius_all(8)
		spin_button.add_theme_stylebox_override("normal", st_free)
		spin_button.add_theme_color_override("font_color", Color(0.04, 0.12, 0.04))
		free_timer_lbl.text = "Tienes 1 tiro gratis disponible cada 24 horas."
		free_timer_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	else:
		spin_button.disabled = false
		spin_button.text = "⚡ GIRAR POR 0.20 WATT"
		var st_paid := StyleBoxFlat.new()
		st_paid.bg_color = Color(0.15, 0.7, 0.95)
		st_paid.set_corner_radius_all(8)
		spin_button.add_theme_stylebox_override("normal", st_paid)
		spin_button.add_theme_color_override("font_color", Color(0.02, 0.08, 0.15))
		
		var h = int(float(free_seconds_left) / 3600.0)
		var m = int(float(free_seconds_left % 3600) / 60.0)
		var s = free_seconds_left % 60
		free_timer_lbl.text = "Siguiente tiro gratis en: %02d:%02d:%02d" % [h, m, s]
		free_timer_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))

# ====================================================================
# CONSTRUCCIÓN DEL DISCO CENTRADO EN (180, 180) SIN DESPLAZAMIENTO
# ====================================================================

func _build_centered_wheel() -> void:
	for c in wheel_container.get_children(): c.queue_free()

	# El disco rota fijado exactamente en el centro (180, 180) del cuadro
	wheel_disc = Control.new()
	wheel_disc.name = "WheelDisc"
	wheel_disc.position = Vector2(180, 180)
	wheel_disc.size = Vector2.ZERO
	wheel_container.add_child(wheel_disc)

	# 1. Dibujar los polígonos de las 8 casillas centradas en (0, 0)
	var wedge_drawer := Control.new()
	wedge_drawer.name = "WedgeDrawer"
	wedge_drawer.draw.connect(_draw_slices_polygons)
	wheel_disc.add_child(wedge_drawer)

	# 2. Agregar los iconos y textos dentro de cada casilla
	var radius := 165.0
	for i in range(TOTAL_SLOTS):
		var mid_a := i * SLICE_ANGLE
		var data = slots_data[i]

		# Contenedor alineado con el ángulo del sector
		var slice_holder := Control.new()
		slice_holder.rotation = mid_a
		wheel_disc.add_child(slice_holder)

		var hbox := HBoxContainer.new()
		hbox.position = Vector2(55, -13)
		hbox.custom_minimum_size = Vector2(95, 26)
		hbox.add_theme_constant_override("separation", 6)
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		slice_holder.add_child(hbox)

		# Icono real del premio
		var icon_rect := TextureRect.new()
		icon_rect.texture = data["icon"]
		icon_rect.custom_minimum_size = data["icon_size"]
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.modulate = data["tint"]
		icon_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		hbox.add_child(icon_rect)

		# Texto del premio
		var lbl := Label.new()
		lbl.text = data["name"]
		lbl.add_theme_font_size_override("font_size", 11)
		lbl.add_theme_color_override("font_color", Color(1, 1, 1))
		lbl.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
		lbl.add_theme_constant_override("shadow_outline_size", 2)
		lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		hbox.add_child(lbl)

	# 3. Núcleo central
	var hub_drawer := Control.new()
	hub_drawer.draw.connect(func():
		hub_drawer.draw_circle(Vector2.ZERO, 34.0, Color(0.08, 0.10, 0.15))
		hub_drawer.draw_circle(Vector2.ZERO, 26.0, Color(0.12, 0.16, 0.24))
		hub_drawer.draw_arc(Vector2.ZERO, 26.0, 0, TAU, 32, Color(0.35, 0.88, 1.0), 2.0, true)
		hub_drawer.draw_string(ThemeDB.fallback_font, Vector2(-10, 6), "⚡", HORIZONTAL_ALIGNMENT_CENTER, 20, 18, Color(1, 0.85, 0.2))
	)
	wheel_disc.add_child(hub_drawer)

func _draw_slices_polygons() -> void:
	var canvas = wheel_disc.get_node("WedgeDrawer")
	var radius := 165.0

	# Borde exterior de titanio
	canvas.draw_circle(Vector2.ZERO, radius + 8.0, Color(0.06, 0.08, 0.12))
	canvas.draw_arc(Vector2.ZERO, radius + 4.0, 0, TAU, 64, Color(0.35, 0.88, 1.0), 3.0, true)

	for i in range(TOTAL_SLOTS):
		var start_a := (i * SLICE_ANGLE) - (SLICE_ANGLE / 2.0)
		var end_a := start_a + SLICE_ANGLE
		var col: Color = slots_data[i]["color"]

		var points := PackedVector2Array([Vector2.ZERO])
		for step in range(16):
			var a = lerp(start_a, end_a, float(step) / 15.0)
			points.append(Vector2(cos(a), sin(a)) * radius)

		canvas.draw_colored_polygon(points, col)
		# Línea divisoria
		canvas.draw_line(Vector2.ZERO, Vector2(cos(start_a), sin(start_a)) * radius, Color(0.06, 0.08, 0.12, 0.9), 2.0, true)

func _on_spin_pressed() -> void:
	if is_spinning: return

	if not can_free_spin and GameManager.watt < 0.20:
		_show_toast("⚠️ Saldo insuficiente. Necesitas 0.20 WATT para girar.")
		return

	is_spinning = true
	_update_spin_button_ui()

	# Pedir confirmación de tirada a Supabase
	var res = await SupabaseClient.send_request("/rest/v1/rpc/spin_roulette_wheel", HTTPClient.METHOD_POST, {}, true)

	if not res.get("success", false) or not res.get("data", {}).get("success", false):
		is_spinning = false
		var err = res.get("data", {}).get("error", "Error al procesar el tiro.")
		_show_toast("⚠️ " + str(err))
		_check_status_from_server()
		return

	var slot_index: int = int(res["data"].get("slot_index", 0))
	var prize_name: String = str(res["data"].get("reward_title", "Premio"))
	var was_free: bool = bool(res["data"].get("was_free", false))

	# ⚡ DESCUENTO INMEDIATO: Restar los 0.20 WATT en pantalla antes de que empiece a girar
	if not was_free:
		GameManager.watt = maxf(0.0, GameManager.watt - 0.20)
		EventBus.currencies_updated.emit(GameManager.watt, GameManager.kilowat)
		_update_hud()
	else:
		can_free_spin = false
		_update_spin_button_ui()

	# 🎡 La ruleta gira durante 4.2 segundos
	await _animate_wheel_spin(slot_index)

	# Al detenerse la ruleta, sincronizar con la central para sumar el premio ganado
	await GameManager.load_profile()
	_update_hud()
	_show_toast("🎉 ¡GANASTE: %s!" % prize_name)

	is_spinning = false
	_check_status_from_server()

func _animate_wheel_spin(target_slot: int) -> void:
	# La flecha roja está fija ARRIBA (-90 grados o -PI/2)
	# Calculamos el ángulo exacto para que el sector ganador quede centrado bajo la flecha
	var target_sector_angle: float = -(target_slot * SLICE_ANGLE) - (PI / 2.0)
	
	# 6 vueltas completas de giro antes de frenar
	var full_turns: float = TAU * 6.0
	var final_rotation: float = full_turns + target_sector_angle

	var tw := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	wheel_disc.rotation = 0.0
	tw.tween_property(wheel_disc, "rotation", final_rotation, 4.2)
	await tw.finished

func _show_toast(msg: String) -> void:
	status_toast_lbl.text = msg
	status_toast_lbl.modulate.a = 1.0
	var tw := create_tween()
	tw.tween_property(status_toast_lbl, "modulate:a", 0.0, 0.8).set_delay(3.0)
