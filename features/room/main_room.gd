# res://features/room/main_room.gd
extends Node2D

# Componentes Principales de Escena
var room_hud: Node = null
var room_grid: Node = null
var room_background: TextureRect = null

# Modales de la Escena
var power_split_modal: Control = null
var extraction_modal: Control = null
var rack_manage_dialog: Node = null
var referral_modal: Control = null
var battle_pass_screen: Control = null
var bg_selector_modal: Node = null
var taller_modal: Control = null

# Modal de Selección de Estanterías en el Suelo
var rack_select_modal: Control = null
var rack_select_list: VBoxContainer = null
var rack_select_title: Label = null
var current_target_slot: int = -1

# Botón de Evento Semanal
var event_btn: BaseButton = null
var event_btn_container: Control = null

# Menú Lateral Izquierdo Desplegable (Navegación)
var drawer_root: Control = null
var drawer_is_open: bool = false
var drawer_width: float = 210.0
var drawer_tween: Tween = null
var drawer_tab_btn: Button = null
var drawer_bg_btn: Button = null

# Menú Lateral Derecho Desplegable (Almacén)
var inv_root: Control = null
var inv_is_open: bool = false
var inv_width: float = 290.0
var inv_tween: Tween = null
var inv_tab_btn: Button = null
var inv_list_container: VBoxContainer = null
var inv_tab_gens_btn: Button = null
var inv_tab_racks_btn: Button = null
var current_inv_tab: String = "generators"

# Modal Dinámico de Mercado P2P
var market_modal: Control = null
var market_grid: GridContainer = null
var market_status_lbl: Label = null
var market_tab_browse_btn: Button = null
var market_tab_sell_btn: Button = null
var market_tab_my_btn: Button = null
var current_market_view: String = "browse"
var cached_market_listings: Array = []

# Módulo de Chat
var docked_chat_box: PanelContainer = null
var chat_mode_btn: Button = null
var chat_friends_btn: Button = null
var chat_minimize_btn: Button = null
var chat_messages_vbox: VBoxContainer = null
var chat_scroll: ScrollContainer = null
var chat_input: LineEdit = null
var chat_send_btn: Button = null
var chat_body_vbox: VBoxContainer = null

var is_chat_minimized: bool = false
var chat_channel_mode: String = "global"
var active_friend_id: String = ""
var active_friend_name: String = ""
var chat_poll_timer: float = 0.0
var chat_cooldown_left: float = 0.0
var is_fetching_chat: bool = false
var last_chat_hash: String = ""

# Modal de Amigos
var friends_modal: Control = null
var friends_list_vbox: VBoxContainer = null
var friend_req_input: LineEdit = null
var friend_req_status: Label = null

const RACK_VIEW_SCENE: PackedScene = preload("res://features/room/racks/rack_view.tscn")
const GENERATOR_VIEW_SCENE: PackedScene = preload("res://features/room/generators/generator_view.tscn")

const RACK_1_FLOOR_DATA: RackData = preload("res://data/racks/rack_1_floor.tres")
const RACK_2_FLOORS_DATA: RackData = preload("res://data/racks/rack_2_floors.tres")
const RACK_3_FLOORS_DATA: RackData = preload("res://data/racks/rack_3_floors.tres")
const PLANTA_MEME_DATA: GeneratorData = preload("res://data/generators/generator_planta_lvl1.tres")

const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")

var spawned_racks: Dictionary = {}

func _ready() -> void:
	_force_load_patch_zoom_controller() # <-- AÑADIR AQUÍ
	_resolve_nodes()
	_setup_connections()
	_create_sliding_drawer()
	_create_inventory_drawer()
	_create_docked_chat_box()
	_create_friends_modal()
	_create_rack_select_modal()
	_create_market_modal()
	
	# Instanciar el Taller Mecánico de forma segura en memoria para el .pck
	var taller_script = load("res://features/room/taller/taller_modal.gd")
	if taller_script:
		taller_modal = taller_script.new()
		$CanvasLayerUI.add_child(taller_modal)
		taller_modal.workshop_updated.connect(func():
			_render_placed_generators()
			_refresh_inventory_ui()
		)
	
	_apply_equipped_background()
	
	await GameManager.load_player_inventory()
	_render_placed_racks()
	_render_placed_generators()
	_refresh_inventory_ui()
	_check_active_event()

func _process(delta: float) -> void:
	_process_chat(delta)

func _force_load_patch_zoom_controller() -> void:
	var root_viewport = get_tree().root
	
	# Eliminar cualquier controlador viejo que haya quedado en memoria desde el inicio de la APK
	var old_nodes = [
		root_viewport.get_node_or_null("GlobalZoomController"),
		get_node_or_null("/root/GameManager/GlobalZoomController")
	]
	for node in old_nodes:
		if node and is_instance_valid(node):
			node.name = "OldZoom_Disposed"
			node.queue_free()

	# Cargar forzosamente el script nuevo del .pck ignorando la caché
	var z_path := "res://features/room/controls/zoom_controller.gd"
	var z_script = ResourceLoader.load(z_path, "", ResourceLoader.CACHE_MODE_REPLACE)
	if z_script:
		var new_zoom = z_script.new()
		new_zoom.name = "GlobalZoomController"
		root_viewport.add_child(new_zoom)

func _resolve_nodes() -> void:
	room_hud = find_child("RoomHUD", true, false)
	if room_hud == null: room_hud = find_child("HUD", true, false)
	
	room_grid = find_child("RoomGrid", true, false)
	room_background = find_child("RoomBackground", true, false) as TextureRect
	
	event_btn = _find_button(["EventButton", "EventBtn"])
	event_btn_container = find_child("EventButtonContainer", true, false) as Control
	
	if event_btn_container:
		event_btn_container.offset_top = -320.0
		event_btn_container.offset_bottom = -245.0
		event_btn_container.visible = false
	elif event_btn:
		event_btn.visible = false
	
	power_split_modal = find_child("PowerSplitModal", true, false) as Control
	extraction_modal = find_child("ExtractionModal", true, false) as Control
	rack_manage_dialog = find_child("RackManageDialog", true, false)
	referral_modal = find_child("ReferralModal", true, false) as Control
	battle_pass_screen = find_child("BattlePassScreen", true, false) as Control
	bg_selector_modal = find_child("BgSelectorModal", true, false)

func _find_button(names: Array) -> BaseButton:
	for n in names:
		var node = find_child(n, true, false)
		if node is BaseButton: return node
	return null

func _setup_connections() -> void:
	if room_hud:
		if room_hud.has_signal("split_requested") and power_split_modal:
			room_hud.split_requested.connect(func():
				_close_all_drawers()
				if power_split_modal.has_method("open_modal"): power_split_modal.open_modal()
				else: power_split_modal.visible = true
			)
		if room_hud.has_signal("extract_requested") and extraction_modal:
			room_hud.extract_requested.connect(func():
				_close_all_drawers()
				if extraction_modal.has_method("open_modal"): extraction_modal.open_modal()
				else: extraction_modal.visible = true
			)
	
	if bg_selector_modal and bg_selector_modal.has_signal("background_changed"):
		bg_selector_modal.background_changed.connect(func(_id): _apply_equipped_background())
			
	if event_btn:
		event_btn.pressed.connect(func(): get_tree().change_scene_to_file("res://features/progression/tournament/event_leaderboard.tscn"))
	
	if rack_manage_dialog:
		if rack_manage_dialog.has_signal("generator_unmounted"):
			rack_manage_dialog.generator_unmounted.connect(_on_generator_unmounted)
		if rack_manage_dialog.has_signal("generator_mounted"):
			rack_manage_dialog.generator_mounted.connect(_on_generator_mounted)
	
	if room_grid:
		if room_grid.has_signal("slot_selected"): room_grid.slot_selected.connect(_on_slot_clicked)
		if room_grid.has_signal("rack_hold_unmounted"): room_grid.rack_hold_unmounted.connect(_on_rack_hold_unmounted)

func _check_active_event() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_power_competition_leaderboard", HTTPClient.METHOD_POST, {}, true)
	var has_event: bool = false
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		has_event = bool(res["data"].get("success", false))
	if event_btn_container: event_btn_container.visible = has_event
	elif event_btn: event_btn.visible = has_event

func _apply_equipped_background() -> void:
	if room_background == null: return
	var bg_id: String = GameManager.equipped_background
	var path: String = "res://assets/sprites/room/room_background.png"
	if bg_id == "bunker_solar": path = "res://assets/sprites/room/bg_bunker_solar.png"
	elif bg_id == "habitacion_taller": path = "res://assets/sprites/room/bg_habitacion_taller.png"
	if ResourceLoader.exists(path): room_background.texture = load(path)

func _close_all_drawers() -> void:
	if drawer_is_open: _close_drawer()
	if inv_is_open: _close_inventory_drawer()
	if market_modal and market_modal.visible: market_modal.visible = false
	if friends_modal and friends_modal.visible: friends_modal.visible = false
	if taller_modal and taller_modal.visible: taller_modal.visible = false

# ====================================================================
# MENÚ LATERAL IZQUIERDO DESPLEGABLE
# ====================================================================

func _create_sliding_drawer() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	var old_sidebar = find_child("LeftSidebar", true, false)
	if old_sidebar: old_sidebar.visible = false

	drawer_root = Control.new()
	drawer_root.name = "SlidingSideDrawer"
	drawer_root.position = Vector2(-drawer_width, 95.0)
	drawer_root.size = Vector2(drawer_width, 430.0)

	var panel := PanelContainer.new()
	panel.name = "MenuPanel"
	panel.size = Vector2(drawer_width, 430.0)
	panel.custom_minimum_size = Vector2(drawer_width, 430.0)

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	p_st.border_color = Color(0.25, 0.55, 0.85, 0.9)
	p_st.border_width_right = 2
	p_st.border_width_top = 2
	p_st.border_width_bottom = 2
	p_st.corner_radius_top_right = 10
	p_st.corner_radius_bottom_right = 10
	p_st.shadow_color = Color(0.1, 0.45, 0.8, 0.3)
	p_st.shadow_size = 12
	panel.add_theme_stylebox_override("panel", p_st)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 14); margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 12); margin.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	margin.add_child(vbox)

	var title_lbl := Label.new()
	title_lbl.text = "MENÚ"
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_lbl.add_theme_font_size_override("font_size", 13)
	title_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	vbox.add_child(title_lbl)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	var btn_normal := StyleBoxFlat.new()
	btn_normal.bg_color = Color(0.10, 0.13, 0.19, 0.9)
	btn_normal.border_color = Color(0.25, 0.38, 0.55, 0.7)
	btn_normal.set_border_width_all(1)
	btn_normal.set_corner_radius_all(6)

	var btn_hover := StyleBoxFlat.new()
	btn_hover.bg_color = Color(0.14, 0.20, 0.30, 1.0)
	btn_hover.border_color = Color(0.35, 0.88, 1.0, 1.0)
	btn_hover.set_border_width_all(1)
	btn_hover.set_corner_radius_all(6)

	var options = [
		{"id": "taller", "text": "🔧 Taller Mecánico", "color": Color(1.0, 0.85, 0.25)},
		{"id": "market", "text": "🛒 Mercado P2P", "color": Color(0.3, 0.95, 0.75)},
		{"id": "shop", "text": "Tienda Oficial", "color": Color(0.95, 0.98, 1.0)},
		{"id": "minigames", "text": "Minijuegos", "color": Color(0.95, 0.98, 1.0)},
		{"id": "casino", "text": "Casino", "color": Color(1.0, 0.55, 0.9)},
		{"id": "pass", "text": "Pase de Batalla", "color": Color(1.0, 0.85, 0.2)},
		{"id": "ref", "text": "Referidos", "color": Color(0.4, 0.95, 0.6)},
		{"id": "bg", "text": "Cambiar Fondo", "color": Color(0.85, 0.9, 1.0)}
	]

	for opt in options:
		var b := Button.new()
		b.text = opt["text"]
		b.custom_minimum_size = Vector2(0, 34)
		b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		b.add_theme_stylebox_override("normal", btn_normal)
		b.add_theme_stylebox_override("hover", btn_hover)
		b.add_theme_stylebox_override("pressed", btn_hover)
		b.add_theme_color_override("font_color", opt["color"])
		b.add_theme_font_size_override("font_size", 12)

		var opt_id: String = opt["id"]
		b.pressed.connect(func(): _on_drawer_option_pressed(opt_id))

		if opt_id == "bg":
			drawer_bg_btn = b
			drawer_bg_btn.visible = (GameManager.unlocked_backgrounds.size() > 1)

		vbox.add_child(b)

	drawer_root.add_child(panel)

	drawer_tab_btn = Button.new()
	drawer_tab_btn.name = "DrawerTabButton"
	drawer_tab_btn.text = "▶"
	drawer_tab_btn.position = Vector2(drawer_width, 130.0)
	drawer_tab_btn.custom_minimum_size = Vector2(34, 60)
	drawer_tab_btn.size = Vector2(34, 60)
	drawer_tab_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	var tab_st := StyleBoxFlat.new()
	tab_st.bg_color = Color(0.08, 0.12, 0.18, 0.96)
	tab_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	tab_st.border_width_right = 2
	tab_st.border_width_top = 2
	tab_st.border_width_bottom = 2
	tab_st.corner_radius_top_right = 8
	tab_st.corner_radius_bottom_right = 8
	tab_st.shadow_color = Color(0.15, 0.6, 0.9, 0.4)
	tab_st.shadow_size = 8
	drawer_tab_btn.add_theme_stylebox_override("normal", tab_st)
	drawer_tab_btn.add_theme_stylebox_override("hover", tab_st)
	drawer_tab_btn.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	drawer_tab_btn.add_theme_font_size_override("font_size", 15)
	drawer_tab_btn.pressed.connect(_toggle_drawer)

	drawer_root.add_child(drawer_tab_btn)
	canvas_ui.add_child(drawer_root)

func _toggle_drawer() -> void:
	if drawer_is_open: _close_drawer()
	else: _open_drawer()

func _open_drawer() -> void:
	if inv_is_open: _close_inventory_drawer()
	drawer_is_open = true
	drawer_tab_btn.text = "◀"
	if drawer_bg_btn: drawer_bg_btn.visible = (GameManager.unlocked_backgrounds.size() > 1)
	if drawer_tween and drawer_tween.is_running(): drawer_tween.kill()
	drawer_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	drawer_tween.tween_property(drawer_root, "position:x", 0.0, 0.25)

func _close_drawer() -> void:
	drawer_is_open = false
	drawer_tab_btn.text = "▶"
	if drawer_tween and drawer_tween.is_running(): drawer_tween.kill()
	drawer_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	drawer_tween.tween_property(drawer_root, "position:x", -drawer_width, 0.25)

func _on_drawer_option_pressed(opt_id: String) -> void:
	match opt_id:
		"taller":
			_close_drawer()
			if taller_modal: taller_modal.open_modal()
		"market":
			_close_drawer()
			_open_market_modal()
		"shop":
			get_tree().change_scene_to_file("res://features/economy/shop/shop_screen.tscn")
		"minigames":
			get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")
		"casino":
			get_tree().change_scene_to_file("res://features/casino/mines/casino_hub.tscn")
		"pass":
			_close_drawer()
			if battle_pass_screen: battle_pass_screen.visible = not battle_pass_screen.visible
		"ref":
			_close_drawer()
			if referral_modal:
				if referral_modal.has_method("open_modal"): referral_modal.open_modal()
				else: referral_modal.visible = true
		"bg":
			_close_drawer()
			if bg_selector_modal:
				if bg_selector_modal.has_method("open_modal"): bg_selector_modal.open_modal()
				else: bg_selector_modal.visible = true

# ====================================================================
# MODAL DE SELECCIÓN DE ESTANTERÍA (CREACIÓN Y APERTURA)
# ====================================================================

func _create_rack_select_modal() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	rack_select_modal = Control.new()
	rack_select_modal.name = "RackSelectModal"
	rack_select_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	rack_select_modal.visible = false

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.88)
	rack_select_modal.add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	rack_select_modal.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(540, 420)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.08, 0.10, 0.15, 0.98)
	p_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(12)
	panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 18); margin.add_theme_constant_override("margin_bottom", 18)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 12)
	margin.add_child(vbox)

	var hrow := HBoxContainer.new()
	rack_select_title = Label.new()
	rack_select_title.text = "🗄️ INSTALAR ESTANTERÍA"
	rack_select_title.add_theme_font_size_override("font_size", 17)
	rack_select_title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	hrow.add_child(rack_select_title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hrow.add_child(sp)

	var close_x := Button.new()
	close_x.text = "✕"
	close_x.custom_minimum_size = Vector2(32, 32)
	close_x.pressed.connect(func(): rack_select_modal.visible = false)
	hrow.add_child(close_x)
	vbox.add_child(hrow)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	rack_select_list = VBoxContainer.new()
	rack_select_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rack_select_list.add_theme_constant_override("separation", 10)
	scroll.add_child(rack_select_list)

	canvas_ui.add_child(rack_select_modal)

func _open_rack_select_modal(slot_index: int) -> void:
	_close_all_drawers()
	if rack_select_modal == null: _create_rack_select_modal()
	if rack_select_modal == null: return

	current_target_slot = slot_index
	if rack_select_title: rack_select_title.text = "🗄️ INSTALAR EN ESPACIO #%d" % (slot_index + 1)
	for child in rack_select_list.get_children(): child.queue_free()

	var available_racks: Array = []
	for r in GameManager.player_racks:
		if int(r.get("slot_index", -1)) == -1: available_racks.append(r)

	if available_racks.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No tienes estanterías en tu inventario."
		rack_select_list.add_child(empty_lbl)
	else:
		for r in available_racks:
			var r_data: RackData = _get_rack_data(r)
			var row_panel := PanelContainer.new()
			var rm := MarginContainer.new()
			rm.add_theme_constant_override("margin_left", 12); rm.add_theme_constant_override("margin_right", 12)
			rm.add_theme_constant_override("margin_top", 8); rm.add_theme_constant_override("margin_bottom", 8)
			row_panel.add_child(rm)

			var hbox := HBoxContainer.new()
			hbox.add_theme_constant_override("separation", 14)
			rm.add_child(hbox)

			var name_lbl := Label.new()
			name_lbl.text = r_data.name if r_data else "Estantería"
			name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			hbox.add_child(name_lbl)

			var place_btn := Button.new()
			place_btn.text = "⚡ Colocar aquí"
			place_btn.pressed.connect(_on_rack_selected_from_modal.bind(r, slot_index))
			hbox.add_child(place_btn)

			rack_select_list.add_child(row_panel)

	rack_select_modal.visible = true

func _on_rack_selected_from_modal(chosen_rack: Dictionary, target_slot: int) -> void:
	if rack_select_modal: rack_select_modal.visible = false
	_place_chosen_rack(chosen_rack, target_slot)

func _place_chosen_rack(rack: Dictionary, slot_index: int) -> void:
	for other_rack in GameManager.player_racks:
		if int(other_rack.get("slot_index", -1)) == slot_index and other_rack != rack:
			other_rack["slot_index"] = -1

	rack["slot_index"] = slot_index
	if room_grid: room_grid.set_slot_occupied(slot_index, true)
	_instantiate_rack(rack, slot_index)
	_refresh_inventory_ui()
	
	var r_id = str(rack.get("id", rack.get("rack_id", "")))
	await GameManager.place_rack_in_slot(r_id, slot_index)

# ====================================================================
# MODAL DEL MERCADO P2P (COMPLETO CON ARTÍCULOS Y REPUESTOS)
# ====================================================================

func _create_market_modal() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	market_modal = Control.new()
	market_modal.name = "MarketModal"
	market_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	market_modal.visible = false

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.94)
	market_modal.add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	market_modal.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(980, 600)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.13, 0.98)
	p_st.border_color = Color(0.3, 0.95, 0.75, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(12)
	p_st.shadow_color = Color(0.1, 0.6, 0.45, 0.3)
	p_st.shadow_size = 14
	panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 22); margin.add_theme_constant_override("margin_right", 22)
	margin.add_theme_constant_override("margin_top", 18); margin.add_theme_constant_override("margin_bottom", 18)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 12)
	margin.add_child(vbox)

	var hrow := HBoxContainer.new()
	var title_lbl := Label.new()
	title_lbl.text = "🛒 MERCADO DE JUGADORES (P2P)"
	title_lbl.add_theme_font_size_override("font_size", 18)
	title_lbl.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75))
	hrow.add_child(title_lbl)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hrow.add_child(sp)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(34, 34)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): market_modal.visible = false)
	hrow.add_child(close_btn)
	vbox.add_child(hrow)

	var nav_tabs := HBoxContainer.new()
	nav_tabs.add_theme_constant_override("separation", 10)

	market_tab_browse_btn = Button.new()
	market_tab_browse_btn.text = "🔍 Explorar Ofertas"
	market_tab_browse_btn.custom_minimum_size = Vector2(170, 38)
	market_tab_browse_btn.pressed.connect(func(): current_market_view = "browse"; _refresh_market_view())
	nav_tabs.add_child(market_tab_browse_btn)

	market_tab_sell_btn = Button.new()
	market_tab_sell_btn.text = "📦 Vender mi Inventario"
	market_tab_sell_btn.custom_minimum_size = Vector2(210, 38)
	market_tab_sell_btn.pressed.connect(func(): current_market_view = "sell"; _refresh_market_view())
	nav_tabs.add_child(market_tab_sell_btn)

	market_tab_my_btn = Button.new()
	market_tab_my_btn.text = "📋 Mis Publicaciones"
	market_tab_my_btn.custom_minimum_size = Vector2(170, 38)
	market_tab_my_btn.pressed.connect(func(): current_market_view = "my_sales"; _refresh_market_view())
	nav_tabs.add_child(market_tab_my_btn)
	vbox.add_child(nav_tabs)

	var hsep := HSeparator.new()
	vbox.add_child(hsep)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	market_grid = GridContainer.new()
	market_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	market_grid.columns = 3
	market_grid.add_theme_constant_override("h_separation", 14)
	market_grid.add_theme_constant_override("v_separation", 14)
	scroll.add_child(market_grid)

	market_status_lbl = Label.new()
	market_status_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	market_status_lbl.add_theme_font_size_override("font_size", 12)
	market_status_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	vbox.add_child(market_status_lbl)

	canvas_ui.add_child(market_modal)

func _open_market_modal() -> void:
	_close_all_drawers()
	if market_modal == null: _create_market_modal()
	if market_modal == null: return
	market_modal.visible = true
	current_market_view = "browse"
	_refresh_market_view()

func _refresh_market_view() -> void:
	if market_modal == null: return
	market_status_lbl.text = ""
	market_tab_browse_btn.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75) if current_market_view == "browse" else Color(0.7, 0.75, 0.85))
	market_tab_sell_btn.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75) if current_market_view == "sell" else Color(0.7, 0.75, 0.85))
	market_tab_my_btn.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75) if current_market_view == "my_sales" else Color(0.7, 0.75, 0.85))

	for child in market_grid.get_children(): child.queue_free()

	match current_market_view:
		"browse": _fetch_and_show_browse_listings()
		"sell": _show_sellable_inventory()
		"my_sales": _show_my_listings()

func _fetch_and_show_browse_listings() -> void:
	market_status_lbl.text = "Cargando ofertas activas..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_market_listings", HTTPClient.METHOD_POST, {}, true)
	market_status_lbl.text = ""

	for child in market_grid.get_children(): child.queue_free()

	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		cached_market_listings = res["data"].get("listings", [])
		if cached_market_listings.is_empty():
			var no_lbl := Label.new()
			no_lbl.text = "No hay ofertas de jugadores en el mercado en este momento."
			no_lbl.add_theme_font_size_override("font_size", 13)
			no_lbl.add_theme_color_override("font_color", Color(0.65, 0.7, 0.8))
			market_grid.add_child(no_lbl)
			return

		for l in cached_market_listings:
			var card := PanelContainer.new()
			card.custom_minimum_size = Vector2(285, 180)
			
			var i_type = str(l.get("item_type", ""))
			var sub_type = str(l.get("item_sub_type", ""))
			var p_val = float(l.get("price", 0))
			var cur = str(l.get("currency", "watt"))
			var lid = str(l.get("id", ""))
			var qty = int(l.get("quantity", 1))
			var seller = str(l.get("seller_username", "Jugador"))
			var is_mine = (seller.to_lower() == GameManager.username.to_lower())

			var c_st := StyleBoxFlat.new()
			c_st.bg_color = Color(0.09, 0.12, 0.18, 0.95)
			c_st.border_color = Color(0.3, 0.85, 1.0) if i_type == "generator" else (Color(0.5, 0.6, 1.0) if i_type == "rack" else Color(0.3, 0.95, 0.7))
			c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
			card.add_theme_stylebox_override("panel", c_st)

			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
			cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
			card.add_child(cm)

			var vb := VBoxContainer.new()
			vb.add_theme_constant_override("separation", 5)
			cm.add_child(vb)

			var name_str = ""
			if i_type == "generator": name_str = "⚡ " + _format_gen_name(sub_type)
			elif i_type == "rack": name_str = "🗄️ " + _format_rack_name(sub_type)
			else: name_str = "🔩 %s Nv.%d (Lote x%d)" % [sub_type.capitalize(), int(l.get("part_level", 1)), qty]

			var lbl := Label.new()
			lbl.text = name_str
			lbl.add_theme_font_size_override("font_size", 13)
			lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0))
			vb.add_child(lbl)

			var slbl := Label.new()
			slbl.text = "Vendedor: %s%s" % [seller, " (Tú)" if is_mine else ""]
			slbl.add_theme_font_size_override("font_size", 10)
			slbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.85))
			vb.add_child(slbl)

			var plbl := Label.new()
			plbl.text = "Total: %.4f %s (+10%% comisión)" % [p_val * 1.10, "W" if cur == "watt" else "KW"]
			plbl.add_theme_font_size_override("font_size", 11)
			plbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			vb.add_child(plbl)

			vb.add_spacer(false)

			var buy_b := Button.new()
			buy_b.text = "✕ Eres el vendedor" if is_mine else "⚡ Comprar Artículo"
			buy_b.custom_minimum_size = Vector2(0, 34)
			buy_b.disabled = is_mine
			buy_b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			buy_b.pressed.connect(func():
				buy_b.disabled = true
				var b_res = await SupabaseClient.send_request("/rest/v1/rpc/buy_market_item", HTTPClient.METHOD_POST, {"p_listing_id": lid}, true)
				if b_res.get("success", false) and b_res.get("data", {}).get("success", false):
					market_status_lbl.text = "✓ ¡Compra realizada con éxito!"
					await GameManager.load_profile()
					await GameManager.load_player_inventory()
					_refresh_market_view()
				else:
					market_status_lbl.text = "⚠️ " + str(b_res.get("data", {}).get("error", "Saldo insuficiente o artículo agotado"))
					buy_b.disabled = false
			)
			vb.add_child(buy_b)
			market_grid.add_child(card)

func _show_sellable_inventory() -> void:
	for child in market_grid.get_children(): child.queue_free()
	market_status_lbl.text = "Cargando tus artículos..."
	await GameManager.load_player_inventory()
	market_status_lbl.text = ""

	var unmounted_gens: Array = []
	var mounted_gens: Array = []
	for g in GameManager.player_generators:
		if g.get("rack_id") == null or str(g.get("rack_id")) == "" or str(g.get("rack_id")) == "null":
			unmounted_gens.append(g)
		else:
			mounted_gens.append(g)

	var sellable_racks: Array = []
	for r in GameManager.player_racks:
		if int(r.get("slot_index", -1)) == -1:
			sellable_racks.append(r)

	var sellable_parts: Array = []
	for p in GameManager.player_parts:
		if int(p.get("quantity", 0)) > 0:
			sellable_parts.append(p)

	if unmounted_gens.is_empty() and mounted_gens.is_empty() and sellable_racks.is_empty() and sellable_parts.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "Tu almacén está vacío. Gana repuestos en minijuegos o desmonta plantas para venderlas aquí."
		empty_lbl.add_theme_font_size_override("font_size", 13)
		market_grid.add_child(empty_lbl)
		return

	# 1. Repuestos de taller disponibles
	for p in sellable_parts:
		var ptype = str(p.get("part_type", ""))
		var plvl = int(p.get("part_level", 1))
		var pqty = int(p.get("quantity", 1))
		market_grid.add_child(_build_sell_part_card(ptype, plvl, pqty))

	# 2. Generadores en almacén (listos para publicar)
	for g in unmounted_gens:
		var gid = str(g.get("id", ""))
		var gtype = str(g.get("generator_type", ""))
		market_grid.add_child(_build_sell_item_card("generator", gid, "⚡ " + _format_gen_name(gtype)))

	# 3. Generadores instalados en la habitación (con opción para desmontar)
	for g in mounted_gens:
		var gid = str(g.get("id", ""))
		var gtype = str(g.get("generator_type", ""))
		market_grid.add_child(_build_mounted_gen_card(gid, _format_gen_name(gtype)))

	# 4. Estanterías en almacén
	for r in sellable_racks:
		var rid = str(r.get("id", ""))
		var rtype = str(r.get("rack_type", ""))
		market_grid.add_child(_build_sell_item_card("rack", rid, "🗄️ " + _format_rack_name(rtype)))

func _build_mounted_gen_card(gen_id: String, gen_name: String) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 175)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.12, 0.10, 0.08, 0.95)
	c_st.border_color = Color(1.0, 0.6, 0.2, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 6)
	cm.add_child(vb)

	var title := Label.new()
	title.text = "⚡ " + gen_name
	title.add_theme_font_size_override("font_size", 13)
	vb.add_child(title)

	var desc := Label.new()
	desc.text = "Esta planta está activa en tu estantería. Desmóntala para poder venderla."
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.add_theme_font_size_override("font_size", 10)
	desc.add_theme_color_override("font_color", Color(1.0, 0.75, 0.3))
	vb.add_child(desc)

	vb.add_spacer(false)

	var unmount_btn := Button.new()
	unmount_btn.text = "📦 Desmontar al Almacén"
	unmount_btn.custom_minimum_size = Vector2(0, 34)
	unmount_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	unmount_btn.pressed.connect(func():
		unmount_btn.disabled = true
		await GameManager.unmount_generator(gen_id)
		await GameManager.load_player_inventory()
		_render_placed_generators()
		_show_sellable_inventory()
	)
	vb.add_child(unmount_btn)
	return card

func _build_sell_item_card(item_type: String, item_id: String, display_name: String) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 185)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
	c_st.border_color = Color(0.35, 0.88, 1.0, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 6)
	cm.add_child(vb)

	var title := Label.new()
	title.text = display_name
	title.add_theme_font_size_override("font_size", 13)
	vb.add_child(title)

	var input_row := HBoxContainer.new()
	input_row.add_theme_constant_override("separation", 6)

	var price_in := LineEdit.new()
	price_in.placeholder_text = "Precio"
	price_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input_row.add_child(price_in)

	var cur_opt := OptionButton.new()
	cur_opt.add_item("WATT", 0)
	cur_opt.add_item("KILOWAT", 1)
	input_row.add_child(cur_opt)
	vb.add_child(input_row)

	var fee_lbl := Label.new()
	fee_lbl.text = "Tasa (10%): 0.00"
	fee_lbl.add_theme_font_size_override("font_size", 10)
	fee_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	vb.add_child(fee_lbl)

	price_in.text_changed.connect(func(t):
		var p = float(t)
		var c = "WATT" if cur_opt.selected == 0 else "KILOWAT"
		fee_lbl.text = "Tasa (10%%): %.4f %s" % [p * 0.10, c]
	)

	var btn_pub := Button.new()
	btn_pub.text = "🚀 Publicar Venta"
	btn_pub.custom_minimum_size = Vector2(0, 34)
	btn_pub.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_pub.pressed.connect(func():
		var p_val = float(price_in.text)
		if p_val <= 0.0:
			market_status_lbl.text = "⚠️ El precio debe ser mayor a 0."
			return
		btn_pub.disabled = true
		var cur_str = "watt" if cur_opt.selected == 0 else "kilowat"
		var body = {"p_item_type": item_type, "p_item_id": item_id, "p_price": p_val, "p_currency": cur_str}
		var pub_res = await SupabaseClient.send_request("/rest/v1/rpc/publish_market_item", HTTPClient.METHOD_POST, body, true)
		if pub_res.get("success", false) and pub_res.get("data", {}).get("success", false):
			market_status_lbl.text = "✓ ¡Artículo publicado en el mercado!"
			await GameManager.load_player_inventory()
			_show_sellable_inventory()
		else:
			market_status_lbl.text = "⚠️ " + str(pub_res.get("data", {}).get("error", "Error al publicar"))
			btn_pub.disabled = false
	)
	vb.add_child(btn_pub)
	return card

func _build_sell_part_card(part_type: String, part_lvl: int, max_stock: int) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 205)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
	c_st.border_color = Color(0.3, 0.95, 0.75, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 5)
	cm.add_child(vb)

	var title := Label.new()
	title.text = "🔩 %s Nv.%d (Tienes: %d)" % [part_type.capitalize(), part_lvl, max_stock]
	title.add_theme_font_size_override("font_size", 13)
	title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	vb.add_child(title)

	var qty_row := HBoxContainer.new()
	var qty_lbl := Label.new()
	qty_lbl.text = "Cantidad a vender:"
	qty_lbl.add_theme_font_size_override("font_size", 11)
	qty_row.add_child(qty_lbl)

	var qty_spin := SpinBox.new()
	qty_spin.min_value = 1
	qty_spin.max_value = max_stock
	qty_spin.value = 1
	qty_row.add_child(qty_spin)
	vb.add_child(qty_row)

	var input_row := HBoxContainer.new()
	var price_in := LineEdit.new()
	price_in.placeholder_text = "Precio lote"
	price_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input_row.add_child(price_in)

	var cur_opt := OptionButton.new()
	cur_opt.add_item("WATT", 0)
	cur_opt.add_item("KILOWAT", 1)
	input_row.add_child(cur_opt)
	vb.add_child(input_row)

	var fee_lbl := Label.new()
	fee_lbl.text = "Tasa (10%): 0.00"
	fee_lbl.add_theme_font_size_override("font_size", 10)
	fee_lbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.85))
	vb.add_child(fee_lbl)

	price_in.text_changed.connect(func(t):
		var p = float(t)
		var c = "WATT" if cur_opt.selected == 0 else "KILOWAT"
		fee_lbl.text = "Tasa (10%%): %.4f %s" % [p * 0.10, c]
	)

	var btn_pub := Button.new()
	btn_pub.text = "🚀 Publicar Lote"
	btn_pub.custom_minimum_size = Vector2(0, 34)
	btn_pub.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_pub.pressed.connect(func():
		var p_val = float(price_in.text)
		var q_val = int(qty_spin.value)
		if p_val <= 0.0:
			market_status_lbl.text = "⚠️ El precio debe ser mayor a 0."
			return
		btn_pub.disabled = true
		var cur_str = "watt" if cur_opt.selected == 0 else "kilowat"
		var body = {
			"p_part_type": part_type, 
			"p_part_level": part_lvl, 
			"p_quantity": q_val, 
			"p_price": p_val, 
			"p_currency": cur_str
		}
		var pub_res = await SupabaseClient.send_request("/rest/v1/rpc/publish_market_part", HTTPClient.METHOD_POST, body, true)
		if pub_res.get("success", false) and pub_res.get("data", {}).get("success", false):
			market_status_lbl.text = "✓ ¡Lote de repuestos publicado en el mercado!"
			await GameManager.load_player_inventory()
			_show_sellable_inventory()
		else:
			market_status_lbl.text = "⚠️ " + str(pub_res.get("data", {}).get("error", "Error al publicar lote"))
			btn_pub.disabled = false
	)
	vb.add_child(btn_pub)
	return card

func _show_my_listings() -> void:
	for child in market_grid.get_children(): child.queue_free()
	var res = await SupabaseClient.send_request("/rest/v1/market_listings?seller_id=eq." + SupabaseClient.current_user_id + "&status=eq.active&select=*", HTTPClient.METHOD_GET, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_ARRAY:
		var items: Array = res["data"]
		if items.is_empty():
			var no_lbl := Label.new()
			no_lbl.text = "No tienes ningún artículo publicado en venta actualmente."
			no_lbl.add_theme_font_size_override("font_size", 13)
			market_grid.add_child(no_lbl)
			return

		for it in items:
			var card := PanelContainer.new()
			card.custom_minimum_size = Vector2(285, 150)
			var c_st := StyleBoxFlat.new()
			c_st.bg_color = Color(0.09, 0.12, 0.18, 0.95)
			c_st.border_color = Color(1.0, 0.85, 0.2, 0.8)
			c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
			card.add_theme_stylebox_override("panel", c_st)

			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
			cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
			card.add_child(cm)

			var vb := VBoxContainer.new()
			cm.add_child(vb)

			var lid = str(it.get("id", ""))
			var itype = str(it.get("item_type", ""))
			var isub = str(it.get("item_sub_type", ""))
			var iqty = int(it.get("quantity", 1))

			var display = ""
			if itype == "part": display = "🔩 %s Nv.%d (Lote x%d)" % [isub.capitalize(), int(it.get("part_level", 1)), iqty]
			elif itype == "generator": display = "⚡ " + _format_gen_name(isub)
			else: display = "🗄️ " + _format_rack_name(isub)

			var lbl := Label.new()
			lbl.text = display
			lbl.add_theme_font_size_override("font_size", 13)
			vb.add_child(lbl)

			var plbl := Label.new()
			plbl.text = "Precio: %.4f %s" % [float(it.get("price", 0)), str(it.get("currency", "watt")).to_upper()]
			plbl.add_theme_font_size_override("font_size", 11)
			plbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			vb.add_child(plbl)

			vb.add_spacer(false)

			var cb := Button.new()
			cb.text = "✕ Cancelar y Recuperar"
			cb.custom_minimum_size = Vector2(0, 32)
			cb.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			cb.pressed.connect(func():
				cb.disabled = true
				await SupabaseClient.send_request("/rest/v1/rpc/cancel_market_listing", HTTPClient.METHOD_POST, {"p_listing_id": lid}, true)
				await GameManager.load_player_inventory()
				_show_my_listings()
			)
			vb.add_child(cb)
			market_grid.add_child(card)

# ====================================================================
# AUXILIARES
# ====================================================================
func _format_rack_name(r_type: String) -> String:
	match r_type:
		"rack_2_floors": return "Estantería de 2 Pisos"
		"rack_3_floors": return "Estantería de 3 Pisos"
		_: return "Estantería de 1 Piso"

func _format_gen_name(g_type: String) -> String:
	match g_type:
		"ecoflow_spark": return "EcoFlow Spark"
		"ecoflow_spark_plus": return "EcoFlow Spark Plus"
		"ecoflow_thunder_pro": return "EcoFlow Thunder Pro"
		"ecoflow_ultra": return "EcoFlow Ultra"
		"cyber_tank": return "Cyber Tank 100%"
		"dinamo_manual": return "Generador Manual"
		"delta_mini": return "EcoFlow DELTA Mini"
		"panel_solar": return "Panel Solar"
		"pro_electrico": return "EcoFlow Pro Eléctrico"
		_: return "Planta Meme"

# ====================================================================
# GESTIÓN DE ESPACIOS Y GENERADORES EN LA SALA
# ====================================================================
func _on_slot_clicked(slot_index: int) -> void:
	_close_all_drawers()
	for rack in GameManager.player_racks:
		if int(rack.get("slot_index", -1)) == slot_index:
			if rack_manage_dialog and rack_manage_dialog.has_method("open_dialog"):
				rack_manage_dialog.open_dialog(rack, _get_rack_data(rack))
			return
	_open_rack_select_modal(slot_index)

func _on_rack_hold_unmounted(slot_index: int) -> void:
	var target_rack: Dictionary = {}
	for rack in GameManager.player_racks:
		if int(rack.get("slot_index", -1)) == slot_index:
			target_rack = rack
			break
	if target_rack.is_empty(): return
	
	var r_id: String = str(target_rack.get("id", target_rack.get("rack_id", "")))
	target_rack["slot_index"] = -1
	if room_grid: room_grid.set_slot_occupied(slot_index, false)
	
	for gen in GameManager.player_generators:
		if str(gen.get("rack_id", "")) == r_id:
			var gid: String = str(gen.get("id", ""))
			gen["rack_id"] = null
			gen["slot_in_rack"] = -1
			GameManager.set_generator_power(gid, false, 0.0)
			await GameManager.unmount_generator(gid)
			
	if spawned_racks.has(slot_index):
		if is_instance_valid(spawned_racks[slot_index]):
			spawned_racks[slot_index].queue_free()
		spawned_racks.erase(slot_index)
		
	_render_placed_generators()
	_refresh_inventory_ui()
	await GameManager.unmount_rack_complete(r_id)

func _on_generator_unmounted(gen_id: String) -> void:
	for g in GameManager.player_generators:
		if str(g.get("id", "")) == gen_id:
			g["rack_id"] = null; g["slot_in_rack"] = -1; break
	GameManager.set_generator_power(gen_id, false, 0.0)
	_render_placed_generators()
	_refresh_inventory_ui()
	await GameManager.unmount_generator(gen_id)

func _on_generator_mounted(gen_id: String, slot_idx: int) -> void:
	if rack_manage_dialog and "current_rack" in rack_manage_dialog:
		var r_id: String = str(rack_manage_dialog.current_rack.get("id", rack_manage_dialog.current_rack.get("rack_id", "")))
		var ok = await GameManager.place_generator_in_rack(gen_id, r_id, slot_idx)
		if not ok:
			await GameManager.load_player_inventory()
			_render_placed_generators()
			_refresh_inventory_ui()
			return
		
		for g in GameManager.player_generators:
			var is_same_rack = str(g.get("rack_id", "")) == r_id
			var is_same_slot = int(g.get("slot_in_rack", -1)) == slot_idx
			var is_different = str(g.get("id", "")) != gen_id
			if is_same_rack and is_same_slot and is_different:
				g["rack_id"] = null
				g["slot_in_rack"] = -1
		
		for g in GameManager.player_generators:
			if str(g.get("id", "")) == gen_id:
				g["rack_id"] = r_id
				g["slot_in_rack"] = slot_idx
				break
				
		_render_placed_generators()
		_refresh_inventory_ui()

func _render_placed_racks() -> void:
	if room_grid == null: return
	for i in range(6): room_grid.set_slot_occupied(i, false)

	for s_idx in spawned_racks.keys():
		if is_instance_valid(spawned_racks[s_idx]):
			spawned_racks[s_idx].queue_free()
	spawned_racks.clear()

	var occupied_slots: Dictionary = {}
	for rack in GameManager.player_racks:
		var slot_idx: int = int(rack.get("slot_index", -1))
		if slot_idx >= 0 and slot_idx < 6:
			if occupied_slots.has(slot_idx):
				rack["slot_index"] = -1
				continue
			occupied_slots[slot_idx] = true
			room_grid.set_slot_occupied(slot_idx, true)
			_instantiate_rack(rack, slot_idx)

func _instantiate_rack(rack_info: Dictionary, slot_idx: int) -> void:
	if room_grid == null: return
	var anchor = room_grid.get_slot_container(slot_idx)
	if anchor == null: return
	for child in anchor.get_children(): child.queue_free()
	var r_instance = RACK_VIEW_SCENE.instantiate()
	anchor.add_child(r_instance)
	r_instance.setup_rack(_get_rack_data(rack_info), str(rack_info.get("id", "")), slot_idx)
	spawned_racks[slot_idx] = r_instance

func _render_placed_generators() -> void:
	for r_view in spawned_racks.values():
		if is_instance_valid(r_view) and r_view.plant_slots_container != null:
			for marker in r_view.plant_slots_container.get_children():
				for child in marker.get_children():
					child.queue_free()

	var occupied_slots: Dictionary = {}

	for gen in GameManager.player_generators:
		var r_id: String = str(gen.get("rack_id", ""))
		var s_in_rack: int = int(gen.get("slot_in_rack", -1))
		var gid: String = str(gen.get("id", ""))
		
		if r_id != "" and r_id != "null" and s_in_rack >= 0:
			var slot_key = "%s_%d" % [r_id, s_in_rack]
			if occupied_slots.has(slot_key):
				GameManager.set_generator_power(gid, false, 0.0)
				continue
				
			var rack_mounted = false
			var target_slot_idx = -1
			for rack in GameManager.player_racks:
				if str(rack.get("id", rack.get("rack_id", ""))) == r_id:
					target_slot_idx = int(rack.get("slot_index", -1))
					rack_mounted = (target_slot_idx >= 0)
					break
			
			if not rack_mounted:
				GameManager.set_generator_power(gid, false, 0.0)
				continue
				
			if spawned_racks.has(target_slot_idx):
				var marker = spawned_racks[target_slot_idx].get_slot_marker(s_in_rack)
				if marker:
					occupied_slots[slot_key] = true
					var gen_view = GENERATOR_VIEW_SCENE.instantiate()
					marker.add_child(gen_view)
					var res = _get_gen_data(str(gen.get("generator_type", "")))
					var rem_sec = int(gen.get("remaining_active_seconds", 21600))
					var dur = float(gen.get("durability", 100.0))
					var lvl = int(gen.get("level", 1))
					gen_view.setup_from_server(res, gid, rem_sec, dur, lvl)

func _get_rack_data(r: Dictionary) -> RackData:
	match str(r.get("rack_type", "")):
		"rack_2_floors": return RACK_2_FLOORS_DATA
		"rack_3_floors": return RACK_3_FLOORS_DATA
		_: return RACK_1_FLOOR_DATA

func _get_gen_data(t: String) -> GeneratorData:
	var path: String = "res://data/generators/generator_%s.tres" % t
	if ResourceLoader.exists(path): return load(path)
	var fallback_path: String = "res://data/generators/generator_planta_lvl1.tres"
	if ResourceLoader.exists(fallback_path): return load(fallback_path)
	return null

# ====================================================================
# MENÚ DERECHO (INVENTARIO ALMACÉN)
# ====================================================================
func _create_inventory_drawer() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	var screen_w = 1280.0
	inv_root = Control.new()
	inv_root.name = "SlidingInventoryDrawer"
	inv_root.position = Vector2(screen_w, 95.0)
	inv_root.size = Vector2(inv_width, 450.0)

	var panel := PanelContainer.new()
	panel.name = "InvPanel"
	panel.size = Vector2(inv_width, 450.0)
	panel.custom_minimum_size = Vector2(inv_width, 450.0)

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	p_st.border_color = Color(0.25, 0.55, 0.85, 0.9)
	p_st.border_width_left = 2; p_st.border_width_top = 2; p_st.border_width_bottom = 2
	p_st.corner_radius_top_left = 10; p_st.corner_radius_bottom_left = 10
	p_st.shadow_color = Color(0.1, 0.45, 0.8, 0.3)
	p_st.shadow_size = 12
	panel.add_theme_stylebox_override("panel", p_st)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 14); margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 14); margin.add_theme_constant_override("margin_bottom", 14)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	var title_lbl := Label.new()
	title_lbl.text = "📦 INVENTARIO (ALMACÉN)"
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_lbl.add_theme_font_size_override("font_size", 13)
	title_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	vbox.add_child(title_lbl)

	var tabs_hbox := HBoxContainer.new()
	tabs_hbox.add_theme_constant_override("separation", 8)

	inv_tab_gens_btn = Button.new()
	inv_tab_gens_btn.text = "⚡ Generadores"
	inv_tab_gens_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inv_tab_gens_btn.custom_minimum_size = Vector2(0, 32)
	inv_tab_gens_btn.pressed.connect(func(): current_inv_tab = "generators"; _refresh_inventory_ui())
	tabs_hbox.add_child(inv_tab_gens_btn)

	inv_tab_racks_btn = Button.new()
	inv_tab_racks_btn.text = "🗄️ Estanterías"
	inv_tab_racks_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inv_tab_racks_btn.custom_minimum_size = Vector2(0, 32)
	inv_tab_racks_btn.pressed.connect(func(): current_inv_tab = "racks"; _refresh_inventory_ui())
	tabs_hbox.add_child(inv_tab_racks_btn)
	vbox.add_child(tabs_hbox)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	inv_list_container = VBoxContainer.new()
	inv_list_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inv_list_container.add_theme_constant_override("separation", 8)
	scroll.add_child(inv_list_container)

	inv_root.add_child(panel)

	inv_tab_btn = Button.new()
	inv_tab_btn.name = "InvTabButton"
	inv_tab_btn.text = "◀"
	inv_tab_btn.position = Vector2(-34.0, 130.0)
	inv_tab_btn.custom_minimum_size = Vector2(34, 60)
	inv_tab_btn.size = Vector2(34, 60)
	inv_tab_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	var tab_st := StyleBoxFlat.new()
	tab_st.bg_color = Color(0.08, 0.12, 0.18, 0.96)
	tab_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	tab_st.border_width_left = 2; tab_st.border_width_top = 2; tab_st.border_width_bottom = 2
	tab_st.corner_radius_top_left = 8; tab_st.corner_radius_bottom_left = 8
	tab_st.shadow_color = Color(0.15, 0.6, 0.9, 0.4); tab_st.shadow_size = 8
	inv_tab_btn.add_theme_stylebox_override("normal", tab_st)
	inv_tab_btn.add_theme_stylebox_override("hover", tab_st)
	inv_tab_btn.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	inv_tab_btn.add_theme_font_size_override("font_size", 15)
	inv_tab_btn.pressed.connect(_toggle_inventory_drawer)

	inv_root.add_child(inv_tab_btn)
	canvas_ui.add_child(inv_root)

func _toggle_inventory_drawer() -> void:
	if inv_is_open: _close_inventory_drawer()
	else: _open_inventory_drawer()

func _open_inventory_drawer() -> void:
	if drawer_is_open: _close_drawer()
	inv_is_open = true
	inv_tab_btn.text = "▶"
	_refresh_inventory_ui()
	
	var screen_w = 1280.0
	if inv_tween and inv_tween.is_running(): inv_tween.kill()
	inv_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	inv_tween.tween_property(inv_root, "position:x", screen_w - inv_width, 0.25)

func _close_inventory_drawer() -> void:
	inv_is_open = false
	inv_tab_btn.text = "◀"
	var screen_w = 1280.0
	if inv_tween and inv_tween.is_running(): inv_tween.kill()
	inv_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	inv_tween.tween_property(inv_root, "position:x", screen_w, 0.25)

func _refresh_inventory_ui() -> void:
	if inv_list_container == null: return
	for child in inv_list_container.get_children(): child.queue_free()

	var stored_gens: Array = []
	for gen in GameManager.player_generators:
		var is_mounted = (gen.get("rack_id") != null and str(gen.get("rack_id")) != "" and str(gen.get("rack_id")) != "null")
		if not is_mounted: stored_gens.append(gen)

	var stored_racks: Array = []
	for r in GameManager.player_racks:
		if int(r.get("slot_index", -1)) == -1: stored_racks.append(r)

	var is_gens = (current_inv_tab == "generators")
	inv_tab_gens_btn.text = "⚡ Generadores (%d)" % stored_gens.size()
	inv_tab_racks_btn.text = "🗄️ Estanterías (%d)" % stored_racks.size()

	var card_bg := StyleBoxFlat.new()
	card_bg.bg_color = Color(0.09, 0.12, 0.18, 0.9)
	card_bg.border_color = Color(0.2, 0.35, 0.55, 0.7)
	card_bg.set_border_width_all(1); card_bg.set_corner_radius_all(6)

	if is_gens:
		if stored_gens.is_empty():
			var empty_lbl := Label.new()
			empty_lbl.text = "No tienes generadores en almacén."
			empty_lbl.add_theme_font_size_override("font_size", 11)
			inv_list_container.add_child(empty_lbl)
			return

		for gen in stored_gens:
			var g_type = str(gen.get("generator_type", ""))
			var dur = float(gen.get("durability", 100.0))
			var lvl = int(gen.get("level", 1))

			var card := PanelContainer.new()
			card.add_theme_stylebox_override("panel", card_bg)
			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 10); cm.add_theme_constant_override("margin_right", 10)
			cm.add_theme_constant_override("margin_top", 8); cm.add_theme_constant_override("margin_bottom", 8)
			card.add_child(cm)
			
			var row := VBoxContainer.new()
			cm.add_child(row)
			
			var top_row := HBoxContainer.new()
			var name_lbl := Label.new()
			name_lbl.text = "%s (Nv %d)" % [_format_gen_name(g_type), lvl]
			name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			name_lbl.add_theme_font_size_override("font_size", 12)
			top_row.add_child(name_lbl)
			
			var status_lbl := Label.new()
			status_lbl.text = "Dur: %.0f%%" % dur
			status_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if dur >= 50 else Color(1.0, 0.4, 0.4))
			status_lbl.add_theme_font_size_override("font_size", 10)
			top_row.add_child(status_lbl)
			row.add_child(top_row)
			inv_list_container.add_child(card)

	else:
		if stored_racks.is_empty():
			var empty_lbl := Label.new()
			empty_lbl.text = "No tienes estanterías en almacén."
			empty_lbl.add_theme_font_size_override("font_size", 11)
			inv_list_container.add_child(empty_lbl)
			return

		for r in stored_racks:
			var r_data: RackData = _get_rack_data(r)
			var card := PanelContainer.new()
			card.add_theme_stylebox_override("panel", card_bg)
			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 10); cm.add_theme_constant_override("margin_right", 10)
			cm.add_theme_constant_override("margin_top", 8); cm.add_theme_constant_override("margin_bottom", 8)
			card.add_child(cm)
			
			var row := VBoxContainer.new()
			cm.add_child(row)
			
			var name_lbl := Label.new()
			name_lbl.text = r_data.name if r_data else "Estantería"
			name_lbl.add_theme_font_size_override("font_size", 12)
			row.add_child(name_lbl)
			inv_list_container.add_child(card)

# ====================================================================
# CHAT Y AMIGOS
# ====================================================================
func _create_docked_chat_box() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	if "saved_chat_channel_mode" in GameManager:
		chat_channel_mode = GameManager.saved_chat_channel_mode
		active_friend_id = GameManager.saved_active_friend_id
		active_friend_name = GameManager.saved_active_friend_name
		is_chat_minimized = GameManager.saved_is_chat_minimized

	docked_chat_box = PanelContainer.new()
	docked_chat_box.name = "DockedChatBox"
	docked_chat_box.custom_minimum_size = Vector2(340, 220)
	docked_chat_box.position = Vector2(20.0, 485.0 if not is_chat_minimized else 665.0)

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.06, 0.08, 0.12, 0.88)
	p_st.border_color = Color(0.25, 0.55, 0.85, 0.85)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(8)
	docked_chat_box.add_theme_stylebox_override("panel", p_st)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 8); margin.add_theme_constant_override("margin_right", 8)
	margin.add_theme_constant_override("margin_top", 6); margin.add_theme_constant_override("margin_bottom", 6)
	docked_chat_box.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	margin.add_child(vbox)

	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 6)

	chat_mode_btn = Button.new()
	chat_mode_btn.custom_minimum_size = Vector2(80, 26)
	chat_mode_btn.add_theme_font_size_override("font_size", 10)
	chat_mode_btn.pressed.connect(_toggle_chat_mode)
	top_bar.add_child(chat_mode_btn)

	chat_friends_btn = Button.new()
	chat_friends_btn.text = "👥 Amigos"
	chat_friends_btn.custom_minimum_size = Vector2(80, 26)
	chat_friends_btn.add_theme_font_size_override("font_size", 10)
	chat_friends_btn.pressed.connect(_open_friends_modal)
	top_bar.add_child(chat_friends_btn)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top_bar.add_child(sp)

	chat_minimize_btn = Button.new()
	chat_minimize_btn.text = "▲" if is_chat_minimized else "—"
	chat_minimize_btn.custom_minimum_size = Vector2(26, 26)
	chat_minimize_btn.pressed.connect(_toggle_chat_minimize)
	top_bar.add_child(chat_minimize_btn)
	vbox.add_child(top_bar)

	chat_body_vbox = VBoxContainer.new()
	chat_body_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	chat_body_vbox.visible = not is_chat_minimized
	vbox.add_child(chat_body_vbox)

	chat_scroll = ScrollContainer.new()
	chat_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	chat_scroll.follow_focus = true
	chat_body_vbox.add_child(chat_scroll)

	chat_messages_vbox = VBoxContainer.new()
	chat_messages_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	chat_messages_vbox.add_theme_constant_override("separation", 4)
	chat_scroll.add_child(chat_messages_vbox)

	var input_row := HBoxContainer.new()
	input_row.add_theme_constant_override("separation", 4)

	chat_input = LineEdit.new()
	chat_input.placeholder_text = "Escribe aquí..."
	chat_input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	chat_input.custom_minimum_size = Vector2(0, 30)
	chat_input.max_length = 150
	chat_input.text_submitted.connect(func(_t): _send_chat_message(); chat_input.call_deferred("grab_focus"))
	input_row.add_child(chat_input)

	chat_send_btn = Button.new()
	chat_send_btn.text = "⚡"
	chat_send_btn.custom_minimum_size = Vector2(36, 30)
	chat_send_btn.pressed.connect(func(): _send_chat_message(); chat_input.call_deferred("grab_focus"))
	input_row.add_child(chat_send_btn)
	chat_body_vbox.add_child(input_row)

	canvas_ui.add_child(docked_chat_box)
	_update_chat_header_ui()
	_fetch_chat_data()

func _toggle_chat_minimize() -> void:
	is_chat_minimized = not is_chat_minimized
	if "saved_is_chat_minimized" in GameManager:
		GameManager.saved_is_chat_minimized = is_chat_minimized
	chat_body_vbox.visible = not is_chat_minimized
	chat_minimize_btn.text = "▲" if is_chat_minimized else "—"
	docked_chat_box.custom_minimum_size.y = 40.0 if is_chat_minimized else 220.0
	docked_chat_box.position.y = 665.0 if is_chat_minimized else 485.0

func _toggle_chat_mode() -> void:
	if chat_channel_mode == "global":
		if active_friend_id == "":
			_open_friends_modal()
			return
		chat_channel_mode = "private"
	else:
		chat_channel_mode = "global"
	
	if "saved_chat_channel_mode" in GameManager:
		GameManager.saved_chat_channel_mode = chat_channel_mode
	_update_chat_header_ui()
	last_chat_hash = ""
	_fetch_chat_data()

func _update_chat_header_ui() -> void:
	if chat_mode_btn == null: return
	if chat_channel_mode == "global":
		chat_mode_btn.text = "🌍 Global"
		chat_mode_btn.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		chat_input.placeholder_text = "Chat Global..."
	else:
		chat_mode_btn.text = "🔒 " + (active_friend_name if active_friend_name != "" else "Privado")
		chat_mode_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		chat_input.placeholder_text = "Privado a " + active_friend_name + "..."

func _process_chat(delta: float) -> void:
	if chat_cooldown_left > 0.0:
		chat_cooldown_left = maxf(0.0, chat_cooldown_left - delta)
		if chat_send_btn: chat_send_btn.disabled = (chat_cooldown_left > 0.0)

	chat_poll_timer += delta
	if chat_poll_timer >= 3.5:
		chat_poll_timer = 0.0
		_fetch_chat_data()

func _fetch_chat_data() -> void:
	if is_fetching_chat or is_chat_minimized: return
	is_fetching_chat = true

	var endpoint = "/rest/v1/rpc/get_recent_chat_messages"
	var body: Dictionary = {}

	if chat_channel_mode == "private" and active_friend_id != "":
		endpoint = "/rest/v1/rpc/get_private_chat_messages"
		body = {"p_friend_id": active_friend_id}

	var res = await SupabaseClient.send_request(endpoint, HTTPClient.METHOD_POST, body, true)
	is_fetching_chat = false

	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var msgs: Array = res["data"].get("messages", [])
		_render_chat_messages(msgs)

func _render_chat_messages(msgs: Array) -> void:
	if chat_messages_vbox == null: return

	var new_hash := str(msgs.size()) + "_" + (str(msgs[-1]["unix_time"]) if msgs.size() > 0 else "")
	if new_hash == last_chat_hash and chat_messages_vbox.get_child_count() > 0: return
	last_chat_hash = new_hash

	for child in chat_messages_vbox.get_children(): child.queue_free()

	if msgs.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "Sin mensajes aún."
		empty_lbl.add_theme_font_size_override("font_size", 9)
		chat_messages_vbox.add_child(empty_lbl)
		return

	for m in msgs:
		var author = str(m.get("sender_username", m.get("username", "Jugador")))
		var text_content = str(m.get("message", ""))
		var is_me = (author.to_lower() == GameManager.username.to_lower())

		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 4)

		var name_lbl := Label.new()
		name_lbl.text = author + ":"
		name_lbl.add_theme_font_size_override("font_size", 10)
		name_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if is_me else Color(0.35, 0.88, 1.0))
		row.add_child(name_lbl)

		var msg_lbl := Label.new()
		msg_lbl.text = text_content
		msg_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		msg_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		msg_lbl.add_theme_font_size_override("font_size", 10)
		msg_lbl.add_theme_color_override("font_color", Color(0.9, 0.95, 1.0))
		row.add_child(msg_lbl)

		chat_messages_vbox.add_child(row)

	await get_tree().process_frame
	if chat_scroll and is_instance_valid(chat_scroll):
		chat_scroll.scroll_vertical = int(chat_scroll.get_v_scroll_bar().max_value)

func _send_chat_message() -> void:
	if chat_input == null or chat_cooldown_left > 0.0: return
	var txt = chat_input.text.strip_edges()
	if txt == "": return

	chat_input.text = ""
	chat_input.call_deferred("grab_focus")

	var endpoint = "/rest/v1/rpc/send_chat_message"
	var body: Dictionary = {"p_message": txt}

	if chat_channel_mode == "private":
		if active_friend_id == "": return
		endpoint = "/rest/v1/rpc/send_private_message"
		body = {"p_friend_id": active_friend_id, "p_message": txt}

	chat_send_btn.disabled = true
	var res = await SupabaseClient.send_request(endpoint, HTTPClient.METHOD_POST, body, true)

	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		chat_cooldown_left = 3.0
		_fetch_chat_data()
	else:
		chat_send_btn.disabled = false

func _create_friends_modal() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	friends_modal = Control.new()
	friends_modal.name = "FriendsModal"
	friends_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	friends_modal.visible = false

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.88)
	friends_modal.add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	friends_modal.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(520, 460)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.08, 0.10, 0.15, 0.98)
	p_st.border_color = Color(1.0, 0.85, 0.2, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(10)
	panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16); margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_top", 14); margin.add_theme_constant_override("margin_bottom", 14)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	var hrow := HBoxContainer.new()
	var title := Label.new()
	title.text = "👥 AMIGOS & SOLICITUDES"
	title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	title.add_theme_font_size_override("font_size", 16)
	hrow.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hrow.add_child(sp)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(30, 30)
	close_btn.pressed.connect(func(): friends_modal.visible = false)
	hrow.add_child(close_btn)
	vbox.add_child(hrow)

	var add_row := HBoxContainer.new()
	friend_req_input = LineEdit.new()
	friend_req_input.placeholder_text = "Nombre del jugador a invitar..."
	friend_req_input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_row.add_child(friend_req_input)

	var send_req_btn := Button.new()
	send_req_btn.text = "➕ Enviar Solicitud"
	send_req_btn.pressed.connect(_send_friend_request)
	add_row.add_child(send_req_btn)
	vbox.add_child(add_row)

	friend_req_status = Label.new()
	friend_req_status.add_theme_font_size_override("font_size", 11)
	vbox.add_child(friend_req_status)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	friends_list_vbox = VBoxContainer.new()
	friends_list_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(friends_list_vbox)

	canvas_ui.add_child(friends_modal)

func _open_friends_modal() -> void:
	_close_all_drawers()
	if friends_modal == null: _create_friends_modal()
	if friends_modal == null: return
	friends_modal.visible = true
	friend_req_status.text = ""
	_fetch_friends_data()

func _send_friend_request() -> void:
	if friend_req_input == null or friend_req_input.text.strip_edges() == "": return
	friend_req_status.text = "Enviando solicitud..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/send_friend_request", HTTPClient.METHOD_POST, {"p_target_username": friend_req_input.text.strip_edges()}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		friend_req_status.text = "✓ Solicitud enviada"
		friend_req_input.text = ""
		_fetch_friends_data()
	else:
		friend_req_status.text = "⚠️ " + str(res.get("data", {}).get("error", "Error"))

func _fetch_friends_data() -> void:
	for child in friends_list_vbox.get_children(): child.queue_free()
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_friends_list", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var friends: Array = res["data"].get("friends", [])
		var reqs: Array = res["data"].get("pending_requests", [])

		if not reqs.is_empty():
			var r_title := Label.new()
			r_title.text = "📩 SOLICITUDES RECIBIDAS:"
			r_title.add_theme_font_size_override("font_size", 11)
			r_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			friends_list_vbox.add_child(r_title)

			for rq in reqs:
				var r_id = str(rq.get("request_id", ""))
				var sender = str(rq.get("sender_username", ""))
				var row := HBoxContainer.new()
				var u_lbl := Label.new()
				u_lbl.text = "• " + sender
				u_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				row.add_child(u_lbl)

				var acc_btn := Button.new()
				acc_btn.text = "✓ Aceptar"
				acc_btn.pressed.connect(func(): _respond_friend_req(r_id, true))
				row.add_child(acc_btn)
				friends_list_vbox.add_child(row)

		var f_title := Label.new()
		f_title.text = "👥 TUS AMIGOS:"
		f_title.add_theme_font_size_override("font_size", 11)
		f_title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		friends_list_vbox.add_child(f_title)

		if friends.is_empty():
			var empty_lbl := Label.new()
			empty_lbl.text = "No tienes amigos agregados aún."
			empty_lbl.add_theme_font_size_override("font_size", 10)
			friends_list_vbox.add_child(empty_lbl)
		else:
			for fr in friends:
				var fid = str(fr.get("friend_id", ""))
				var fname = str(fr.get("username", ""))
				var online = bool(fr.get("is_online", false))

				var row := HBoxContainer.new()
				var name_lbl := Label.new()
				name_lbl.text = ("🟢 " if online else "⚪ ") + fname
				name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				name_lbl.add_theme_font_size_override("font_size", 12)
				row.add_child(name_lbl)

				var chat_btn := Button.new()
				chat_btn.text = "💬 Chatear"
				chat_btn.pressed.connect(func():
					active_friend_id = fid
					active_friend_name = fname
					chat_channel_mode = "private"
					friends_modal.visible = false
					_update_chat_header_ui()
					last_chat_hash = ""
					_fetch_chat_data()
				)
				row.add_child(chat_btn)
				friends_list_vbox.add_child(row)

func _respond_friend_req(request_id: String, accept: bool) -> void:
	await SupabaseClient.send_request("/rest/v1/rpc/respond_friend_request", HTTPClient.METHOD_POST, {"p_request_id": request_id, "p_accept": accept}, true)
	_fetch_friends_data()
