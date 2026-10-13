# res://features/progression/talents/talent_tree_modal.gd
class_name TalentTreeModal
extends Control

signal talents_updated()

# Nodos del lienzo
var canvas_view: Control
var circuit_drawer: Control
var inspector_panel: PanelContainer
var points_label: Label
var watt_label: Label
var status_lbl: Label

# Inspector Lateral
var insp_title: Label
var insp_branch: Label
var insp_level: Label
var insp_desc: Label
var insp_cost: Label
var insp_req: Label
var insp_buy_btn: Button

# Pan & Zoom del Árbol
var tree_offset: Vector2 = Vector2.ZERO
var tree_zoom: float = 1.0
var is_dragging: bool = false
var drag_start_mouse: Vector2 = Vector2.ZERO
var drag_start_offset: Vector2 = Vector2.ZERO

var selected_node_id: String = "core_root"
var nodes_data: Dictionary = {}

func _ready() -> void:
	visible = false
	_init_tree_catalog()
	_build_ui_layout()

func open_modal() -> void:
	visible = true
	# Centrar la vista en el núcleo inicial (0, 0)
	tree_zoom = 0.95
	tree_offset = Vector2(460, 360)
	selected_node_id = "core_root"
	
	_update_hud_counters()
	_inspect_node("core_root")
	circuit_drawer.queue_redraw()
	
	await GameManager.load_player_rpg_state()
	if visible:
		_update_hud_counters()
		_inspect_node(selected_node_id)
		circuit_drawer.queue_redraw()

# ====================================================================
# CATÁLOGO DE LOS 28 NODOS ESTELARES (ESTILO RISE OF KINGDOMS)
# ====================================================================
func _init_tree_catalog() -> void:
	nodes_data = {
		# --- NÚCLEO CENTRAL ---
		"core_root": {
			"name": "Núcleo de Operador", "icon": "⚡", "branch": "core", "pos": Vector2(0, 0), "prereq": "",
			"cost_pts": 2, "cost_watt": 0.50, "max_lvl": 1,
			"desc": "Conecta la central con el sistema neuronal. Desbloquea las tres grandes especializaciones energéticas."
		},

		# ============================================================
		# RAMA CHATARRERO (NORTE / ARRIBA) - COLOR NARANJA FUEGO
		# ============================================================
		"gate_chatarrero": {
			"name": "Protocolo Chatarrero", "icon": "🧲", "branch": "chatarrero", "pos": Vector2(0, -110), "prereq": "core_root",
			"cost_pts": 3, "cost_watt": 1.00, "max_lvl": 1,
			"desc": "Inicia la senda del reciclaje y minijuegos. Habilita los talentos de recolección de materiales."
		},
		"chat_iman": {
			"name": "Imán de Chatarra", "icon": "🧲", "branch": "chatarrero", "pos": Vector2(-100, -200), "prereq": "gate_chatarrero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Aumenta la cantidad de materiales brutos obtenidos en minijuegos (+15% por nivel)."
		},
		"chat_suerte": {
			"name": "Detector de Frecuencias", "icon": "🔍", "branch": "chatarrero", "pos": Vector2(100, -200), "prereq": "gate_chatarrero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Mayor probabilidad de conseguir materiales de Tiers superiores al ganar minijuegos (+10% por nivel)."
		},
		"chat_reflejos": {
			"name": "Reflejos Cinéticos", "icon": "⏱️", "branch": "chatarrero", "pos": Vector2(-160, -300), "prereq": "chat_iman",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Reduce el tiempo de enfriamiento (cooldown) entre partidas de minijuegos (-12% por nivel)."
		},
		"chat_reciclaje": {
			"name": "Extracción Rápida", "icon": "📦", "branch": "chatarrero", "pos": Vector2(0, -290), "prereq": "gate_chatarrero",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "+20% XP de Chatarrero por cada minijuego ganado con éxito."
		},
		"chat_doble": {
			"name": "Doble Hallazgo", "icon": "🎲", "branch": "chatarrero", "pos": Vector2(160, -300), "prereq": "chat_suerte",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "+8% de probabilidad por nivel de duplicar el botín completo al ganar un minijuego."
		},
		"chat_aleaciones": {
			"name": "Aleaciones Puras", "icon": "💎", "branch": "chatarrero", "pos": Vector2(-80, -400), "prereq": "chat_reflejos",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Al recolectar materiales Tier 3 o superior, probabilidad del 15% de recibir un lote adicional gratis."
		},
		"chat_maestria": {
			"name": "Maestro Chatarrero", "icon": "🪙", "branch": "chatarrero", "pos": Vector2(80, -400), "prereq": "chat_doble",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Añade una probabilidad del 2% al ganar en dificultad 4 de conseguir una Ficha de Casino adicional."
		},
		"chat_apex": {
			"name": "Sobrecarga de Recolección", "icon": "👑", "branch": "chatarrero", "pos": Vector2(0, -490), "prereq": "chat_reciclaje",
			"cost_pts": 12, "cost_watt": 6.00, "max_lvl": 1,
			"desc": "TALENTO MAESTRO: Todas las victorias en minijuegos otorgan el triple de materiales garantizados."
		},

		# ============================================================
		# RAMA INGENIERO (SURESTE / ABAJO DERECHA) - COLOR AZUL CIAN
		# ============================================================
		"gate_ingeniero": {
			"name": "Protocolo Ingeniero", "icon": "⚙️", "branch": "ingeniero", "pos": Vector2(110, 80), "prereq": "core_root",
			"cost_pts": 3, "cost_watt": 1.00, "max_lvl": 1,
			"desc": "Inicia la maestría del banco de trabajo y la electrónica. Habilita los talentos de crafteo."
		},
		"ing_ahorro": {
			"name": "Corte de Precisión", "icon": "✂️", "branch": "ingeniero", "pos": Vector2(210, 20), "prereq": "gate_ingeniero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "10% de probabilidad por nivel de recuperar la mitad de los materiales utilizados al fabricar una pieza."
		},
		"ing_resistencia": {
			"name": "Lubricación Sintética", "icon": "🛡️", "branch": "ingeniero", "pos": Vector2(210, 160), "prereq": "gate_ingeniero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "La durabilidad de todas las plantas instaladas en tu sala se desgasta un 10% más lento por nivel."
		},
		"ing_doble_craft": {
			"name": "Producción en Masa", "icon": "🔨", "branch": "ingeniero", "pos": Vector2(320, 20), "prereq": "ing_ahorro",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "+6% de probabilidad por nivel de fabricar una pieza duplicada gratis sin coste extra."
		},
		"ing_reparacion": {
			"name": "Mecánica Cuántica", "icon": "🔧", "branch": "ingeniero", "pos": Vector2(300, 90), "prereq": "gate_ingeniero",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Reparar generadores consume 1 Cable y 1 Ventilador menos por cada nivel de este talento."
		},
		"ing_sobrecarga_gen": {
			"name": "Disipación Criogénica", "icon": "❄️", "branch": "ingeniero", "pos": Vector2(320, 180), "prereq": "ing_resistencia",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Aumenta la vida útil de los generadores activos en 2 horas adicionales antes de apagarse."
		},
		"ing_calibracion": {
			"name": "Afinación de Bobinas", "icon": "🔋", "branch": "ingeniero", "pos": Vector2(420, 30), "prereq": "ing_doble_craft",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Los generadores de nivel 2 o superior reciben un +8% extra de potencia KWP permanente."
		},
		"ing_maestria": {
			"name": "Ingeniería de Plasma", "icon": "⚛️", "branch": "ingeniero", "pos": Vector2(420, 150), "prereq": "ing_sobrecarga_gen",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Probabilidad de que al reparar una planta quede al 110% de durabilidad (Sobrecarga Óptima)."
		},
		"ing_apex": {
			"name": "Reactor Perpetuo", "icon": "👑", "branch": "ingeniero", "pos": Vector2(500, 90), "prereq": "ing_reparacion",
			"cost_pts": 12, "cost_watt": 6.00, "max_lvl": 1,
			"desc": "TALENTO MAESTRO: Las reparaciones de plantas Tier 4 y 5 consumen un 40% menos de piezas de alta tecnología."
		},

		# ============================================================
		# RAMA CORREDOR (SUROESTE / ABAJO IZQUIERDA) - COLOR AMARILLO ORO
		# ============================================================
		"gate_corredor": {
			"name": "Protocolo Corredor", "icon": "💡", "branch": "corredor", "pos": Vector2(-110, 80), "prereq": "core_root",
			"cost_pts": 3, "cost_watt": 1.00, "max_lvl": 1,
			"desc": "Inicia la especialización en finanzas de la red y flujo de energía. Habilita contratos y comisiones reducidas."
		},
		"cor_flujo": {
			"name": "Transformador Pulido", "icon": "⚡", "branch": "corredor", "pos": Vector2(-210, 20), "prereq": "gate_corredor",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Incrementa la tasa de minado pasivo continuo de WATT en un +10% por nivel."
		},
		"cor_comision": {
			"name": "Bolsa de Valores P2P", "icon": "💼", "branch": "corredor", "pos": Vector2(-210, 160), "prereq": "gate_corredor",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Reduce la tarifa de comisión por vender en el Mercado P2P del 10% base al 8% / 6% / 4%."
		},
		"cor_contratos": {
			"name": "Negociador de la Red", "icon": "📜", "branch": "corredor", "pos": Vector2(-320, 20), "prereq": "cor_flujo",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Entregar Contratos Diarios otorga un +20% adicional de XP de profesiones por nivel."
		},
		"cor_reserva": {
			"name": "Subsidio Eléctrico", "icon": "🏷️", "branch": "corredor", "pos": Vector2(-300, 90), "prereq": "gate_corredor",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Los Contratos Diarios exigen un 20% menos de Watts para ser completados."
		},
		"cor_ranuras": {
			"name": "Licencia Mercantil", "icon": "🏪", "branch": "corredor", "pos": Vector2(-320, 180), "prereq": "cor_comision",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Desbloquea 1 espacio adicional simultáneo para publicar ventas en el Mercado P2P."
		},
		"cor_inversor": {
			"name": "Especulación de Red", "icon": "📈", "branch": "corredor", "pos": Vector2(-420, 30), "prereq": "cor_contratos",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Reduce el tiempo de bloqueo de calibración de Watts/kW de 6 horas a 4 horas."
		},
		"cor_maestria": {
			"name": "Magnate de la Central", "icon": "🏦", "branch": "corredor", "pos": Vector2(-420, 150), "prereq": "cor_ranuras",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Al completar los 3 contratos diarios, recibes un bono directo de 1 Ficha de Casino adicional."
		},
		"cor_apex": {
			"name": "Monopolio Eléctrico", "icon": "👑", "branch": "corredor", "pos": Vector2(-500, 90), "prereq": "cor_reserva",
			"cost_pts": 12, "cost_watt": 6.00, "max_lvl": 1,
			"desc": "TALENTO MAESTRO: Las ventas que realices en el Mercado P2P quedan completamente libres de comisión (0% tarifa)."
		}
	}

# ====================================================================
# CONSTRUCCIÓN DE LA INTERFAZ
# ====================================================================
func _build_ui_layout() -> void:
	for child in get_children(): child.queue_free()
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	# 1. Fondo
	var bg := ColorRect.new()
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	bg.color = Color(0.03, 0.04, 0.06, 1.0)
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)

	# 2. Lienzo Interactivo con Pan & Zoom
	canvas_view = Control.new()
	canvas_view.name = "CanvasView"
	canvas_view.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas_view.mouse_filter = Control.MOUSE_FILTER_PASS
	add_child(canvas_view)

	circuit_drawer = Control.new()
	circuit_drawer.name = "CircuitDrawer"
	circuit_drawer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	circuit_drawer.mouse_filter = Control.MOUSE_FILTER_PASS
	circuit_drawer.draw.connect(_draw_tree_canvas)
	canvas_view.add_child(circuit_drawer)

	# 3. TopBar HUD
	var top_panel := PanelContainer.new()
	top_panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top_panel.offset_bottom = 54.0
	var tp_st := StyleBoxFlat.new()
	tp_st.bg_color = Color(0.06, 0.08, 0.12, 0.95)
	tp_st.border_width_bottom = 2
	tp_st.border_color = Color(0.2, 0.5, 0.8, 0.8)
	top_panel.add_theme_stylebox_override("panel", tp_st)

	var tm := MarginContainer.new()
	tm.add_theme_constant_override("margin_left", 20); tm.add_theme_constant_override("margin_right", 20)
	top_panel.add_child(tm)

	var thbox := HBoxContainer.new()
	thbox.add_theme_constant_override("separation", 16)
	tm.add_child(thbox)

	var title := Label.new()
	title.text = "⚡ CONSTELACIÓN DE TALENTOS"
	title.add_theme_font_size_override("font_size", 16)
	title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	thbox.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	thbox.add_child(sp)

	points_label = Label.new()
	points_label.text = "🏅 Puntos: 0"
	points_label.add_theme_font_size_override("font_size", 13)
	points_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	thbox.add_child(points_label)

	watt_label = Label.new()
	watt_label.text = "⚡ Watts: 0.000"
	watt_label.add_theme_font_size_override("font_size", 13)
	watt_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
	thbox.add_child(watt_label)

	var btn_center := Button.new()
	btn_center.text = "🎯 Centrar"
	btn_center.custom_minimum_size = Vector2(80, 30)
	btn_center.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_center.pressed.connect(func():
		tree_offset = Vector2(460, 360)
		tree_zoom = 0.95
		circuit_drawer.queue_redraw()
	)
	thbox.add_child(btn_center)

	var close_btn := Button.new()
	close_btn.text = "✕ Salir"
	close_btn.custom_minimum_size = Vector2(70, 30)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): visible = false)
	thbox.add_child(close_btn)
	add_child(top_panel)

	# 4. Inspector Lateral Fijo (A la derecha)
	_build_inspector_card()

func _build_inspector_card() -> void:
	inspector_panel = PanelContainer.new()
	inspector_panel.name = "InspectorCard"
	inspector_panel.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	inspector_panel.anchor_left = 1.0
	inspector_panel.offset_left = -340.0
	inspector_panel.offset_top = 64.0
	inspector_panel.offset_bottom = -20.0
	inspector_panel.offset_right = -16.0
	inspector_panel.mouse_filter = Control.MOUSE_FILTER_STOP

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.14, 0.98)
	p_st.border_width_left = 2; p_st.border_width_top = 2; p_st.border_width_bottom = 2; p_st.border_width_right = 2
	p_st.border_color = Color(0.35, 0.88, 1.0, 0.9)
	p_st.set_corner_radius_all(10)
	p_st.shadow_color = Color(0.1, 0.5, 0.8, 0.3); p_st.shadow_size = 12
	inspector_panel.add_theme_stylebox_override("panel", p_st)

	var im := MarginContainer.new()
	im.add_theme_constant_override("margin_left", 16); im.add_theme_constant_override("margin_right", 16)
	im.add_theme_constant_override("margin_top", 16); im.add_theme_constant_override("margin_bottom", 16)
	inspector_panel.add_child(im)

	var ivbox := VBoxContainer.new()
	ivbox.add_theme_constant_override("separation", 10)
	im.add_child(ivbox)

	insp_branch = Label.new()
	insp_branch.text = "RAMA: CORE"
	insp_branch.add_theme_font_size_override("font_size", 11)
	insp_branch.add_theme_color_override("font_color", Color(0.5, 0.7, 0.9))
	ivbox.add_child(insp_branch)

	insp_title = Label.new()
	insp_title.text = "Núcleo de Operador"
	insp_title.add_theme_font_size_override("font_size", 16)
	insp_title.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
	ivbox.add_child(insp_title)

	insp_level = Label.new()
	insp_level.text = "Nivel: 0 / 1"
	insp_level.add_theme_font_size_override("font_size", 12)
	insp_level.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	ivbox.add_child(insp_level)

	var hsep := HSeparator.new()
	ivbox.add_child(hsep)

	insp_desc = Label.new()
	insp_desc.text = "Descripción..."
	insp_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	insp_desc.size_flags_vertical = Control.SIZE_EXPAND_FILL
	insp_desc.add_theme_font_size_override("font_size", 12)
	insp_desc.add_theme_color_override("font_color", Color(0.85, 0.9, 0.98))
	ivbox.add_child(insp_desc)

	insp_req = Label.new()
	insp_req.text = "★ Talento Inicial del Sistema"
	insp_req.add_theme_font_size_override("font_size", 11)
	ivbox.add_child(insp_req)

	insp_cost = Label.new()
	insp_cost.text = "Coste: 2 Puntos | 0.500 Watts"
	insp_cost.add_theme_font_size_override("font_size", 11)
	ivbox.add_child(insp_cost)

	status_lbl = Label.new()
	status_lbl.text = ""
	status_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_lbl.add_theme_font_size_override("font_size", 11)
	status_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
	ivbox.add_child(status_lbl)

	insp_buy_btn = Button.new()
	insp_buy_btn.text = "⚡ APRENDER TALENTO"
	insp_buy_btn.custom_minimum_size = Vector2(0, 44)
	insp_buy_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	insp_buy_btn.pressed.connect(_on_upgrade_clicked)
	ivbox.add_child(insp_buy_btn)

	add_child(inspector_panel)

# ====================================================================
# PAN, ZOOM Y CLIC EN EL ÁRBOL
# ====================================================================
func _input(event: InputEvent) -> void:
	if not visible: return

	# Evitar arrastrar si el clic está sobre el panel lateral o la barra superior
	var mouse_p = get_viewport().get_mouse_position()
	if mouse_p.y <= 56.0 or mouse_p.x >= (get_viewport_rect().size.x - 360.0):
		if event is InputEventMouseButton and not event.pressed:
			is_dragging = false
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				drag_start_mouse = event.position
				drag_start_offset = tree_offset
				_check_node_click(event.position)
			else:
				is_dragging = false
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_set_tree_zoom(tree_zoom * 1.12, event.position)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_set_tree_zoom(tree_zoom * 0.88, event.position)

	elif event is InputEventMouseMotion and is_dragging:
		tree_offset = drag_start_offset + (event.position - drag_start_mouse)
		circuit_drawer.queue_redraw()

func _set_tree_zoom(new_z: float, center_pt: Vector2) -> void:
	var clamped_z = clampf(new_z, 0.6, 1.6)
	var content_pt = (center_pt - tree_offset) / tree_zoom
	tree_zoom = clamped_z
	tree_offset = center_pt - (content_pt * tree_zoom)
	circuit_drawer.queue_redraw()

func _check_node_click(screen_pos: Vector2) -> void:
	var world_pos = (screen_pos - tree_offset) / tree_zoom
	for nid in nodes_data.keys():
		var n = nodes_data[nid]
		if world_pos.distance_to(n["pos"]) <= 28.0:
			_inspect_node(nid)
			return

# ====================================================================
# DIBUJO ESTELAR COMPLETO (TODOS LOS 28 NODOS VISIBLES)
# ====================================================================
func _draw_tree_canvas() -> void:
	# 1. Rótulos grandes de las 3 ramas flotando en el fondo
	var font = ThemeDB.fallback_font
	var north_lbl_pos = tree_offset + (Vector2(0, -560) * tree_zoom)
	circuit_drawer.draw_string(font, north_lbl_pos + Vector2(-110 * tree_zoom, 0), "🧲 RAMA CHATARRERO", HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color(1.0, 0.45, 0.15, 0.7))

	var east_lbl_pos = tree_offset + (Vector2(450, 230) * tree_zoom)
	circuit_drawer.draw_string(font, east_lbl_pos, "⚙️ RAMA INGENIERO", HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color(0.15, 0.75, 1.0, 0.7))

	var west_lbl_pos = tree_offset + (Vector2(-550, 230) * tree_zoom)
	circuit_drawer.draw_string(font, west_lbl_pos, "💡 RAMA CORREDOR", HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color(1.0, 0.85, 0.2, 0.7))

	# 2. Dibujar líneas de conexión entre nodos
	for nid in nodes_data.keys():
		var n = nodes_data[nid]
		var prereq_id = str(n["prereq"])
		if prereq_id != "" and nodes_data.has(prereq_id):
			var parent = nodes_data[prereq_id]
			var start_pt = tree_offset + (parent["pos"] * tree_zoom)
			var end_pt = tree_offset + (n["pos"] * tree_zoom)

			var child_unlocked = (GameManager.get_talent_level(nid) > 0)
			var parent_unlocked = (GameManager.get_talent_level(prereq_id) > 0)

			var line_col: Color
			var line_width: float = 2.0 * tree_zoom

			if child_unlocked:
				line_col = _get_branch_color(n["branch"])
				line_width = 3.5 * tree_zoom
			elif parent_unlocked:
				line_col = _get_branch_color(n["branch"]).lerp(Color(0.2, 0.3, 0.4), 0.5)
				line_width = 2.0 * tree_zoom
			else:
				line_col = Color(0.18, 0.22, 0.30, 0.4) # Visible tenue para ver el camino
				line_width = 1.5 * tree_zoom

			circuit_drawer.draw_line(start_pt, end_pt, line_col, line_width, true)

	# 3. Dibujar los 28 nodos estelares
	for nid in nodes_data.keys():
		var n = nodes_data[nid]
		var center_pt = tree_offset + (n["pos"] * tree_zoom)
		var lvl = GameManager.get_talent_level(nid)
		var is_unlocked = (lvl > 0)
		var prereq_id = str(n["prereq"])
		var can_unlock = (prereq_id == "" or GameManager.get_talent_level(prereq_id) > 0)
		var is_selected = (selected_node_id == nid)
		var branch_col = _get_branch_color(n["branch"])

		var radius = 22.0 * tree_zoom
		if nid == "core_root": radius = 28.0 * tree_zoom
		elif nid.begins_with("gate_"): radius = 25.0 * tree_zoom

		# Resplandor de selección
		if is_selected:
			circuit_drawer.draw_circle(center_pt, radius + (6.0 * tree_zoom), Color(1, 1, 1, 0.25))
			circuit_drawer.draw_arc(center_pt, radius + (5.0 * tree_zoom), 0, TAU, 32, Color.WHITE, 2.0 * tree_zoom, true)

		# Color de fondo del nodo
		var fill_col: Color
		if is_unlocked:
			fill_col = branch_col.lerp(Color(0.04, 0.06, 0.10), 0.45)
		elif can_unlock:
			fill_col = Color(0.10, 0.14, 0.22, 0.95) # Disponible
		else:
			fill_col = Color(0.06, 0.08, 0.12, 0.85) # Bloqueado tenue

		var border_col: Color
		if is_unlocked:
			border_col = branch_col
		elif can_unlock:
			border_col = branch_col.lerp(Color.WHITE, 0.3) # Brillo listo para comprar
		else:
			border_col = Color(0.25, 0.30, 0.40, 0.5)

		circuit_drawer.draw_circle(center_pt, radius, fill_col)
		circuit_drawer.draw_arc(center_pt, radius, 0, TAU, 32, border_col, (2.5 if can_unlock else 1.5) * tree_zoom, true)

		# Icono del nodo en el centro
		var icon_str = str(n.get("icon", "★"))
		circuit_drawer.draw_string(font, center_pt + Vector2(-8 * tree_zoom, 5 * tree_zoom), icon_str, HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color.WHITE if (is_unlocked or can_unlock) else Color(0.5, 0.55, 0.65))

		# Indicador de nivel debajo del nodo (ej: 0/3)
		var max_lvl = int(n["max_lvl"])
		var lvl_str = "%d/%d" % [lvl, max_lvl]
		if nid == "core_root" or max_lvl == 1:
			lvl_str = "✓" if is_unlocked else ""
		if lvl_str != "":
			circuit_drawer.draw_string(font, center_pt + Vector2(-10 * tree_zoom, 18 * tree_zoom), lvl_str, HORIZONTAL_ALIGNMENT_CENTER, -1, int(9 * tree_zoom), branch_col if is_unlocked else Color(0.6, 0.7, 0.8))

func _get_branch_color(b: String) -> Color:
	match b:
		"core": return Color(0.35, 0.88, 1.0)
		"chatarrero": return Color(1.0, 0.45, 0.15)
		"ingeniero": return Color(0.15, 0.75, 1.0)
		"corredor": return Color(1.0, 0.85, 0.2)
		_: return Color.WHITE

# ====================================================================
# INSPECTOR LATERAL Y COMPRA
# ====================================================================
func _inspect_node(node_id: String) -> void:
	if not nodes_data.has(node_id): return
	selected_node_id = node_id

	var n = nodes_data[node_id]
	var cur_lvl = GameManager.get_talent_level(node_id)
	var max_lvl = int(n["max_lvl"])
	var is_max = (cur_lvl >= max_lvl)
	var prereq_id = str(n["prereq"])

	var prereq_ok = (prereq_id == "" or GameManager.get_talent_level(prereq_id) > 0)
	var cost_pts = int(n["cost_pts"]) * (cur_lvl + 1)
	var cost_w = float(n["cost_watt"]) * (cur_lvl + 1)

	insp_title.text = str(n["name"])
	insp_branch.text = "RAMA: " + str(n["branch"]).to_upper()
	insp_branch.add_theme_color_override("font_color", _get_branch_color(n["branch"]))
	insp_level.text = "Nivel: %d / %d" % [cur_lvl, max_lvl]
	insp_desc.text = str(n["desc"])

	if prereq_id != "":
		var p_name = nodes_data.get(prereq_id, {}).get("name", "Anterior")
		insp_req.text = "✓ Requiere: " + p_name if prereq_ok else "🔒 Requiere: " + p_name
		insp_req.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if prereq_ok else Color(1.0, 0.4, 0.4))
	else:
		insp_req.text = "★ Talento Inicial del Sistema"
		insp_req.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))

	if is_max:
		insp_cost.text = "✓ MÁXIMO NIVEL ALCANZADO"
		insp_cost.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
		insp_buy_btn.text = "✓ APRENDIDO"
		insp_buy_btn.disabled = true
	else:
		var can_afford = (GameManager.talent_points >= cost_pts) and (GameManager.watt >= cost_w) and prereq_ok
		insp_cost.text = "Coste: %d Puntos de Talento | %.3f Watts" % [cost_pts, cost_w]
		insp_cost.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_afford else Color(1.0, 0.45, 0.45))
		
		insp_buy_btn.text = "⚡ APRENDER (NIVEL %d)" % (cur_lvl + 1)
		insp_buy_btn.disabled = not can_afford

	circuit_drawer.queue_redraw()

func _on_upgrade_clicked() -> void:
	if not nodes_data.has(selected_node_id): return
	var n = nodes_data[selected_node_id]
	var cur_lvl = GameManager.get_talent_level(selected_node_id)
	var cost_pts = int(n["cost_pts"]) * (cur_lvl + 1)
	var cost_w = float(n["cost_watt"]) * (cur_lvl + 1)
	var prereq_id = str(n["prereq"])

	insp_buy_btn.disabled = true
	status_lbl.text = "Enviando solicitud a la central..."
	status_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	
	print("[Talentos] Intentando mejorar: ", selected_node_id, " | Coste: ", cost_pts, " pts, ", cost_w, " W")

	var res = await GameManager.upgrade_talent_secure(selected_node_id, str(n["branch"]), cost_pts, cost_w, prereq_id)
	print("[Talentos] Respuesta del servidor: ", res)

	if res.get("success", false):
		status_lbl.text = "✓ ¡Talento desbloqueado con éxito!"
		status_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
		_update_hud_counters()
		_inspect_node(selected_node_id)
		circuit_drawer.queue_redraw()
		talents_updated.emit()
	else:
		# Mostrar el error exacto recibido sin borrarlo
		var err_msg = str(res.get("error", "Error desconocido"))
		status_lbl.text = "⚠️ " + err_msg
		status_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		insp_buy_btn.disabled = false

func _update_hud_counters() -> void:
	if points_label: points_label.text = "🏅 Puntos de Talento: %d" % GameManager.talent_points
	if watt_label: watt_label.text = "⚡ Watts: %.3f" % GameManager.watt