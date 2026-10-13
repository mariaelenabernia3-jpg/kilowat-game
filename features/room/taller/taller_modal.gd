# res://features/room/taller/taller_modal.gd
class_name TallerModal
extends Control

signal workshop_updated()

var current_tab: String = "craft" # "craft", "repair", "upgrade", "inventory"
var selected_tier: int = 1
var modal_zoom: float = 1.0
var min_zoom: float = 0.75
var max_zoom: float = 1.6

var main_panel: PanelContainer
var content_list: VBoxContainer
var tab_craft_btn: Button
var tab_repair_btn: Button
var tab_upgrade_btn: Button
var tab_parts_btn: Button
var status_lbl: Label
var zoom_label: Label
var header_title: Label

# Detección táctil
var modal_touches: Dictionary = {}
var initial_pinch_dist: float = 0.0
var initial_pinch_zoom: float = 1.0

var parts_texture_cache: Dictionary = {}

func _ready() -> void:
	visible = false
	_build_ui_layout()

func open_modal() -> void:
	visible = true
	current_tab = "craft"
	_set_zoom(1.0)
	_refresh_view()
	
	await GameManager.load_player_parts()
	await GameManager.load_player_rpg_state()
	if visible: _refresh_view()

func _input(event: InputEvent) -> void:
	if not visible: return
	
	if event is InputEventScreenTouch:
		if event.pressed:
			modal_touches[event.index] = event.position
			if modal_touches.size() == 2:
				var pts = modal_touches.values()
				initial_pinch_dist = pts[0].distance_to(pts[1])
				initial_pinch_zoom = modal_zoom
				get_viewport().set_input_as_handled()
		else:
			modal_touches.erase(event.index)
			if modal_touches.size() < 2:
				initial_pinch_dist = 0.0

	elif event is InputEventScreenDrag:
		modal_touches[event.index] = event.position
		if modal_touches.size() >= 2 and initial_pinch_dist > 15.0:
			var pts = modal_touches.values()
			var current_dist: float = pts[0].distance_to(pts[1])
			var factor: float = current_dist / initial_pinch_dist
			_set_zoom(clampf(initial_pinch_zoom * factor, min_zoom, max_zoom))
			get_viewport().set_input_as_handled()

func _set_zoom(val: float) -> void:
	modal_zoom = clampf(val, min_zoom, max_zoom)
	if main_panel and is_instance_valid(main_panel):
		main_panel.pivot_offset = Vector2(460, 290)
		main_panel.scale = Vector2(modal_zoom, modal_zoom)
	if zoom_label and is_instance_valid(zoom_label):
		zoom_label.text = "%.0f%%" % (modal_zoom * 100.0)

func _build_ui_layout() -> void:
	for child in get_children(): child.queue_free()

	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.92)
	add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	main_panel = PanelContainer.new()
	main_panel.custom_minimum_size = Vector2(920, 580)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.13, 0.98)
	p_st.border_color = Color(1.0, 0.75, 0.2, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(12)
	p_st.shadow_color = Color(1.0, 0.6, 0.1, 0.3); p_st.shadow_size = 14
	main_panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(main_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 16); margin.add_theme_constant_override("margin_bottom", 16)
	main_panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	# Cabecera
	var header := HBoxContainer.new()
	header_title = Label.new()
	header_title.text = "🔧 TALLER DE INNOVACIÓN"
	header_title.add_theme_font_size_override("font_size", 17)
	header_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	header.add_child(header_title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(sp)

	# Barra de zoom
	var zoom_box := HBoxContainer.new()
	zoom_box.add_theme_constant_override("separation", 4)
	
	var btn_zoom_out := Button.new()
	btn_zoom_out.text = "🔍 -"
	btn_zoom_out.custom_minimum_size = Vector2(36, 30)
	btn_zoom_out.pressed.connect(func(): _set_zoom(modal_zoom - 0.2))
	zoom_box.add_child(btn_zoom_out)

	zoom_label = Label.new()
	zoom_label.text = "100%"
	zoom_label.add_theme_font_size_override("font_size", 11)
	zoom_label.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	zoom_box.add_child(zoom_label)

	var btn_zoom_in := Button.new()
	btn_zoom_in.text = "🔍 +"
	btn_zoom_in.custom_minimum_size = Vector2(36, 30)
	btn_zoom_in.pressed.connect(func(): _set_zoom(modal_zoom + 0.2))
	zoom_box.add_child(btn_zoom_in)

	var btn_reset_zoom := Button.new()
	btn_reset_zoom.text = "100%"
	btn_reset_zoom.custom_minimum_size = Vector2(46, 30)
	btn_reset_zoom.pressed.connect(func(): _set_zoom(1.0))
	zoom_box.add_child(btn_reset_zoom)
	header.add_child(zoom_box)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(32, 30)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): visible = false)
	header.add_child(close_btn)
	vbox.add_child(header)

	# Fila de pestañas
	var tabs_row := HBoxContainer.new()
	tabs_row.add_theme_constant_override("separation", 8)

	tab_craft_btn = Button.new()
	tab_craft_btn.text = "🔨 Fabricar Piezas"
	tab_craft_btn.custom_minimum_size = Vector2(165, 34)
	tab_craft_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_craft_btn.pressed.connect(func(): current_tab = "craft"; _refresh_view())
	tabs_row.add_child(tab_craft_btn)

	tab_repair_btn = Button.new()
	tab_repair_btn.text = "🛠️ Reparar Plantas"
	tab_repair_btn.custom_minimum_size = Vector2(165, 34)
	tab_repair_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_repair_btn.pressed.connect(func(): current_tab = "repair"; _refresh_view())
	tabs_row.add_child(tab_repair_btn)

	tab_upgrade_btn = Button.new()
	tab_upgrade_btn.text = "⚡ Subir Nivel"
	tab_upgrade_btn.custom_minimum_size = Vector2(150, 34)
	tab_upgrade_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_upgrade_btn.pressed.connect(func(): current_tab = "upgrade"; _refresh_view())
	tabs_row.add_child(tab_upgrade_btn)

	tab_parts_btn = Button.new()
	tab_parts_btn.text = "📦 Almacén"
	tab_parts_btn.custom_minimum_size = Vector2(130, 34)
	tab_parts_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_parts_btn.pressed.connect(func(): current_tab = "inventory"; _refresh_view())
	tabs_row.add_child(tab_parts_btn)
	vbox.add_child(tabs_row)

	var hsep := HSeparator.new()
	vbox.add_child(hsep)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	content_list = VBoxContainer.new()
	content_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content_list.add_theme_constant_override("separation", 10)
	scroll.add_child(content_list)

	status_lbl = Label.new()
	status_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_lbl.add_theme_font_size_override("font_size", 12)
	status_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	vbox.add_child(status_lbl)

func _refresh_view() -> void:
	status_lbl.text = ""
	var ing_lvl: int = GameManager.get_profession_level("ingeniero")
	header_title.text = "🔧 TALLER  |  ⚙️ Ingeniero Nv. %d / 25" % ing_lvl

	tab_craft_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "craft" else Color(0.7, 0.75, 0.85))
	tab_repair_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "repair" else Color(0.7, 0.75, 0.85))
	tab_upgrade_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "upgrade" else Color(0.7, 0.75, 0.85))
	tab_parts_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "inventory" else Color(0.7, 0.75, 0.85))

	for child in content_list.get_children(): child.queue_free()

	match current_tab:
		"craft": _build_crafting_tab()
		"repair": _build_repair_tab()
		"upgrade": _build_upgrade_tab()
		"inventory": _build_inventory_tab()

# ====================================================================
# PESTAÑA 1: FABRICACIÓN DE PIEZAS (CRAFTEO)
# ====================================================================
func _build_crafting_tab() -> void:
	# Selector de Tiers (1 al 5)
	var tier_selector := HBoxContainer.new()
	tier_selector.add_theme_constant_override("separation", 6)
	
	var ing_lvl: int = GameManager.get_profession_level("ingeniero")

	for t in range(1, 6):
		var t_btn := Button.new()
		t_btn.text = "Tier %d" % t
		t_btn.custom_minimum_size = Vector2(80, 30)
		t_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		var req_lvl = 0
		match t:
			2: req_lvl = 6
			3: req_lvl = 12
			4: req_lvl = 18
			5: req_lvl = 25
			
		var is_unlocked = (ing_lvl >= req_lvl)
		if not is_unlocked:
			t_btn.text = "🔒 T%d (Nv%d)" % [t, req_lvl]
			t_btn.add_theme_color_override("font_color", Color(0.5, 0.55, 0.65))
		elif t == selected_tier:
			t_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		else:
			t_btn.add_theme_color_override("font_color", Color(0.8, 0.85, 0.9))
			
		var chosen_t = t
		t_btn.pressed.connect(func():
			if ing_lvl >= req_lvl:
				selected_tier = chosen_t
				_build_crafting_tab()
			else:
				status_lbl.text = "⚠️ Requiere Ingeniero Nivel %d para desbloquear Tier %d." % [req_lvl, chosen_t]
		)
		tier_selector.add_child(t_btn)
	content_list.add_child(tier_selector)

	var hsep := HSeparator.new()
	content_list.add_child(hsep)

	# Catálogo de las 5 piezas crafteables
	var recipes = [
		{"type": "cable", "name": "Cable", "cobre": 4, "plastico": 2, "silicio": 0, "hierro": 0},
		{"type": "ventilador", "name": "Ventilador", "cobre": 0, "plastico": 2, "silicio": 0, "hierro": 4},
		{"type": "panel", "name": "Panel", "cobre": 3, "plastico": 0, "silicio": 3, "hierro": 0},
		{"type": "chip", "name": "Microchip", "cobre": 2, "plastico": 0, "silicio": 4, "hierro": 1},
		{"type": "condensador", "name": "Condensador Plasma", "cobre": 5, "plastico": 0, "silicio": 5, "hierro": 5}
	]

	for r in recipes:
		var ptype = str(r["type"])
		var have_cob = GameManager.get_material_quantity("cobre", selected_tier)
		var have_pla = GameManager.get_material_quantity("plastico", selected_tier)
		var have_sil = GameManager.get_material_quantity("silicio", selected_tier)
		var have_hie = GameManager.get_material_quantity("hierro", selected_tier)

		var can_craft: bool = true
		var cost_texts: Array = []

		if int(r["cobre"]) > 0:
			var ok = have_cob >= int(r["cobre"])
			if not ok: can_craft = false
			cost_texts.append("Cobre T%d: %d/%d %s" % [selected_tier, have_cob, int(r["cobre"]), "✓" if ok else "✕"])

		if int(r["plastico"]) > 0:
			var ok = have_pla >= int(r["plastico"])
			if not ok: can_craft = false
			cost_texts.append("Plástico T%d: %d/%d %s" % [selected_tier, have_pla, int(r["plastico"]), "✓" if ok else "✕"])

		if int(r["silicio"]) > 0:
			var ok = have_sil >= int(r["silicio"])
			if not ok: can_craft = false
			cost_texts.append("Silicio T%d: %d/%d %s" % [selected_tier, have_sil, int(r["silicio"]), "✓" if ok else "✕"])

		if int(r["hierro"]) > 0:
			var ok = have_hie >= int(r["hierro"])
			if not ok: can_craft = false
			cost_texts.append("Hierro T%d: %d/%d %s" % [selected_tier, have_hie, int(r["hierro"]), "✓" if ok else "✕"])

		# Tarjeta visual
		var card := PanelContainer.new()
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
		c_st.border_color = Color(0.25, 0.45, 0.65, 0.8)
		c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)

		var m := MarginContainer.new()
		m.add_theme_constant_override("margin_left", 14); m.add_theme_constant_override("margin_right", 14)
		m.add_theme_constant_override("margin_top", 10); m.add_theme_constant_override("margin_bottom", 10)
		card.add_child(m)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		m.add_child(hbox)

		var info_vbox := VBoxContainer.new()
		info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var name_lbl := Label.new()
		name_lbl.text = "🔩 %s (Tier %d)" % [str(r["name"]), selected_tier]
		name_lbl.add_theme_font_size_override("font_size", 14)
		info_vbox.add_child(name_lbl)

		var cost_lbl := Label.new()
		cost_lbl.text = "Materiales: " + " | ".join(cost_texts)
		cost_lbl.add_theme_font_size_override("font_size", 11)
		cost_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_craft else Color(1.0, 0.45, 0.45))
		info_vbox.add_child(cost_lbl)
		hbox.add_child(info_vbox)

		# Botón Fabricar
		var craft_btn := Button.new()
		craft_btn.text = "⚡ Fabricar"
		craft_btn.custom_minimum_size = Vector2(130, 36)
		craft_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		craft_btn.disabled = not can_craft
		craft_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		craft_btn.pressed.connect(func():
			craft_btn.disabled = true
			var res = await GameManager.craft_piece_secure(ptype, selected_tier, 1)
			if res.get("success", false):
				var d = res.get("data", {})
				var bonus_txt = " (¡Bono Doble!)" if d.get("double_bonus", false) else ""
				status_lbl.text = "✓ ¡Fabricado con éxito! +%d XP Ingeniero%s" % [d.get("xp_gained", 20), bonus_txt]
				workshop_updated.emit()
				_refresh_view()
			else:
				status_lbl.text = "⚠️ " + str(res.get("error", "Error al fabricar"))
				craft_btn.disabled = false
		)
		hbox.add_child(craft_btn)
		content_list.add_child(card)

# ====================================================================
# PESTAÑA 2: REPARACIÓN DE PLANTAS (ACTUALIZADA A LAS 5 RAREZAS)
# ====================================================================
func _build_repair_tab() -> void:
	if GameManager.player_generators.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No tienes generadores para reparar."
		empty_lbl.add_theme_font_size_override("font_size", 12)
		content_list.add_child(empty_lbl)
		return

	for gen in GameManager.player_generators:
		var gid = str(gen.get("id", ""))
		var gtype = str(gen.get("generator_type", ""))
		var dur = float(gen.get("durability", 100.0))
		var lvl = int(gen.get("level", 1))

		var card := PanelContainer.new()
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.09, 0.12, 0.18, 0.95)
		c_st.border_color = Color(0.25, 0.45, 0.65, 0.8)
		c_st.set_border_width_all(1)
		c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)

		var m := MarginContainer.new()
		m.add_theme_constant_override("margin_left", 14)
		m.add_theme_constant_override("margin_right", 14)
		m.add_theme_constant_override("margin_top", 10)
		m.add_theme_constant_override("margin_bottom", 10)
		card.add_child(m)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 16)
		m.add_child(hbox)

		var info_vbox := VBoxContainer.new()
		info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		# Nombre y Rareza
		var tier = GameManager.get_generator_tier(gtype)
		var tier_name = ["Común", "Poco Común", "Especial", "Épico", "Legendario"][tier - 1]

		var name_lbl := Label.new()
		name_lbl.text = "%s [%s] (Nivel %d)" % [_format_name(gtype), tier_name, lvl]
		name_lbl.add_theme_font_size_override("font_size", 14)
		info_vbox.add_child(name_lbl)

		# Barra de Durabilidad
		var dur_bar := ProgressBar.new()
		dur_bar.custom_minimum_size = Vector2(0, 8)
		dur_bar.max_value = 100.0
		dur_bar.value = dur
		dur_bar.show_percentage = false
		info_vbox.add_child(dur_bar)

		var status_text := Label.new()
		status_text.text = "Durabilidad: %.1f%% %s" % [dur, "✓ Óptima" if dur >= 50 else ("⚠️ Desgastada" if dur > 0 else "💥 AVERIADA")]
		status_text.add_theme_font_size_override("font_size", 11)
		status_text.add_theme_color_override("font_color", Color(0.4, 1.0, 0.5) if dur >= 50 else (Color(1.0, 0.7, 0.2) if dur > 0 else Color(1.0, 0.35, 0.35)))
		info_vbox.add_child(status_text)

		# Cálculo de Requisitos según la Rareza (Tier 1 a 5)
		var req_c = 0; var req_v = 0; var req_p = 0; var req_chip = 0; var req_cond = 0
		match tier:
			1: req_c = 6; req_v = 4
			2: req_c = 8; req_v = 5
			3: req_c = 10; req_v = 6; req_p = 4
			4: req_c = 12; req_v = 8; req_chip = 4
			5: req_c = 15; req_v = 10; req_chip = 6; req_cond = 4

		var have_c = GameManager.get_part_quantity("cable", tier)
		var have_v = GameManager.get_part_quantity("ventilador", tier)
		var have_p = GameManager.get_part_quantity("panel", tier)
		var have_chip = GameManager.get_part_quantity("chip", tier)
		var have_cond = GameManager.get_part_quantity("condensador", tier)

		var can_repair: bool = true
		var cost_strs: Array = []
		
		if req_c > 0:
			var ok = have_c >= req_c; if not ok: can_repair = false
			cost_strs.append("Cable Nv%d (%d/%d %s)" % [tier, have_c, req_c, "✓" if ok else "✕"])
		if req_v > 0:
			var ok = have_v >= req_v; if not ok: can_repair = false
			cost_strs.append("Vent Nv%d (%d/%d %s)" % [tier, have_v, req_v, "✓" if ok else "✕"])
		if req_p > 0:
			var ok = have_p >= req_p; if not ok: can_repair = false
			cost_strs.append("Panel Nv%d (%d/%d %s)" % [tier, have_p, req_p, "✓" if ok else "✕"])
		if req_chip > 0:
			var ok = have_chip >= req_chip; if not ok: can_repair = false
			cost_strs.append("Chip Nv%d (%d/%d %s)" % [tier, have_chip, req_chip, "✓" if ok else "✕"])
		if req_cond > 0:
			var ok = have_cond >= req_cond; if not ok: can_repair = false
			cost_strs.append("Cond Nv%d (%d/%d %s)" % [tier, have_cond, req_cond, "✓" if ok else "✕"])

		var req_lbl := Label.new()
		req_lbl.text = "Piezas: " + " | ".join(cost_strs)
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_repair else Color(1.0, 0.45, 0.45))
		info_vbox.add_child(req_lbl)

		hbox.add_child(info_vbox)

		# Botón de Reparación
		var rep_btn := Button.new()
		rep_btn.custom_minimum_size = Vector2(170, 38)
		rep_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		rep_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

		if dur >= 100.0:
			rep_btn.text = "✓ Al 100%"
			rep_btn.disabled = true
		elif not can_repair:
			rep_btn.text = "🔒 Faltan Piezas"
			rep_btn.disabled = true
		else:
			rep_btn.text = "🔨 Reparar al 100%"
			rep_btn.disabled = false
			rep_btn.pressed.connect(func():
				rep_btn.disabled = true
				var res = await GameManager.repair_generator_secure(gid)
				if res.get("success", false):
					status_lbl.text = "✓ ¡Generador reparado al 100%!"
					workshop_updated.emit()
					_refresh_view()
				else:
					status_lbl.text = "⚠️ " + str(res.get("error", "Error"))
					rep_btn.disabled = false
			)
		hbox.add_child(rep_btn)
		content_list.add_child(card)

# ====================================================================
# PESTAÑA 3: SUBIR NIVEL DE PLANTAS (ADAPTADA A LAS 5 RAREZAS)
# ====================================================================
func _build_upgrade_tab() -> void:
	if GameManager.player_generators.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No tienes generadores para mejorar."
		empty_lbl.add_theme_font_size_override("font_size", 12)
		content_list.add_child(empty_lbl)
		return

	for gen in GameManager.player_generators:
		var gid = str(gen.get("id", ""))
		var gtype = str(gen.get("generator_type", ""))
		var lvl = int(gen.get("level", 1))
		var tier = GameManager.get_generator_tier(gtype)
		var tier_name = ["Común", "Poco Común", "Especial", "Épico", "Legendario"][tier - 1]

		var card := PanelContainer.new()
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
		c_st.border_color = Color(1.0, 0.8, 0.2, 0.8) if lvl < 4 else Color(0.3, 0.5, 0.7, 0.5)
		c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)

		var m := MarginContainer.new()
		m.add_theme_constant_override("margin_left", 14); m.add_theme_constant_override("margin_right", 14)
		m.add_theme_constant_override("margin_top", 10); m.add_theme_constant_override("margin_bottom", 10)
		card.add_child(m)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 16)
		m.add_child(hbox)

		var info_vbox := VBoxContainer.new()
		info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var name_lbl := Label.new()
		name_lbl.text = "%s [%s] — Nivel %d %s" % [_format_name(gtype), tier_name, lvl, "★ MÁXIMO" if lvl >= 4 else "➔ Nivel %d" % (lvl + 1)]
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		info_vbox.add_child(name_lbl)

		var bonus_lbl := Label.new()
		bonus_lbl.text = "⚡ Bono actual: +%d%% kW/min | Próximo nivel: +%d%% kW/min" % [(lvl - 1) * 25, lvl * 25] if lvl < 4 else "⚡ Potencia máxima alcanzada (+75% permanente)"
		bonus_lbl.add_theme_font_size_override("font_size", 11)
		bonus_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		info_vbox.add_child(bonus_lbl)

		# Comprobación rigurosa de piezas según el Tier de la planta y nivel objetivo
		var can_upgrade: bool = false
		var req_desc: String = ""

		if lvl < 4:
			var target_lvl = lvl + 1
			var req_c = 10 if target_lvl == 2 else (16 if target_lvl == 3 else 24)
			var req_v = 8 if target_lvl == 2 else (12 if target_lvl == 3 else 18)
			var req_p = 6 if target_lvl == 2 else (10 if target_lvl == 3 else 14)
			var req_chip = 4 if target_lvl == 2 else (6 if target_lvl == 3 else 8)
			var req_cond = 2 if target_lvl == 2 else (3 if target_lvl == 3 else 4)

			if tier == 1: req_p = 0
			if tier <= 2: req_chip = 0; req_cond = 0
			if tier <= 4: req_cond = 0

			var have_c = GameManager.get_part_quantity("cable", tier)
			var have_v = GameManager.get_part_quantity("ventilador", tier)
			var have_p = GameManager.get_part_quantity("panel", tier)
			var have_chip = GameManager.get_part_quantity("chip", tier)
			var have_cond = GameManager.get_part_quantity("condensador", tier)

			can_upgrade = true
			var cost_strs: Array = []

			if req_c > 0:
				var ok = have_c >= req_c; if not ok: can_upgrade = false
				cost_strs.append("Cable Nv%d (%d/%d %s)" % [tier, have_c, req_c, "✓" if ok else "✕"])
			if req_v > 0:
				var ok = have_v >= req_v; if not ok: can_upgrade = false
				cost_strs.append("Vent Nv%d (%d/%d %s)" % [tier, have_v, req_v, "✓" if ok else "✕"])
			if req_p > 0:
				var ok = have_p >= req_p; if not ok: can_upgrade = false
				cost_strs.append("Panel Nv%d (%d/%d %s)" % [tier, have_p, req_p, "✓" if ok else "✕"])
			if req_chip > 0:
				var ok = have_chip >= req_chip; if not ok: can_upgrade = false
				cost_strs.append("Chip Nv%d (%d/%d %s)" % [tier, have_chip, req_chip, "✓" if ok else "✕"])
			if req_cond > 0:
				var ok = have_cond >= req_cond; if not ok: can_upgrade = false
				cost_strs.append("Cond Nv%d (%d/%d %s)" % [tier, have_cond, req_cond, "✓" if ok else "✕"])

			req_desc = "Requisitos Nv.%d: " % target_lvl + " | ".join(cost_strs)
		else:
			req_desc = "Generador mejorado al límite máximo permitido."

		var req_lbl := Label.new()
		req_lbl.text = req_desc
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_upgrade else (Color(0.7, 0.75, 0.85) if lvl >= 4 else Color(1.0, 0.45, 0.45)))
		info_vbox.add_child(req_lbl)
		hbox.add_child(info_vbox)

		# Botón Subir Nivel
		var up_btn := Button.new()
		up_btn.custom_minimum_size = Vector2(180, 38)
		up_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		up_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

		if lvl >= 4:
			up_btn.text = "✓ Nivel Máximo"
			up_btn.disabled = true
		elif not can_upgrade:
			up_btn.text = "🔒 Faltan Repuestos"
			up_btn.disabled = true
		else:
			up_btn.text = "⚡ Subir a Nivel %d" % (lvl + 1)
			up_btn.disabled = false
			up_btn.pressed.connect(func():
				up_btn.disabled = true
				var res = await GameManager.upgrade_generator_secure(gid)
				if res.get("success", false):
					status_lbl.text = "🎉 ¡Generador subido de nivel con éxito!"
					workshop_updated.emit()
					_refresh_view()
				else:
					status_lbl.text = "⚠️ " + str(res.get("error", "Error"))
					up_btn.disabled = false
			)
		hbox.add_child(up_btn)
		content_list.add_child(card)

# ====================================================================
# PESTAÑA 4: ALMACÉN (MATERIALES Y PIEZAS)
# ====================================================================
func _build_inventory_tab() -> void:
	var section_mat := Label.new()
	section_mat.text = "📦 MATERIALES BRUTOS (FARMEO DE MINIJUEGOS)"
	section_mat.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	section_mat.add_theme_font_size_override("font_size", 12)
	content_list.add_child(section_mat)

	var grid_mat := GridContainer.new()
	grid_mat.columns = 4
	grid_mat.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid_mat.add_theme_constant_override("h_separation", 10)
	grid_mat.add_theme_constant_override("v_separation", 10)

	var mat_types = [
		{"type": "cobre", "name": "Cobre Bruto"},
		{"type": "plastico", "name": "Plástico Rec."},
		{"type": "silicio", "name": "Silicio/Cuarzo"},
		{"type": "hierro", "name": "Chatarra Hierro"}
	]

	for m in mat_types:
		for t in range(1, 6):
			var count = GameManager.get_material_quantity(m["type"], t)
			if count > 0:
				var p_card := PanelContainer.new()
				p_card.custom_minimum_size = Vector2(160, 60)
				var st := StyleBoxFlat.new()
				st.bg_color = Color(0.08, 0.10, 0.15, 0.9)
				st.border_color = Color(0.2, 0.45, 0.65, 0.7)
				st.set_border_width_all(1); st.set_corner_radius_all(6)
				p_card.add_theme_stylebox_override("panel", st)

				var pm := MarginContainer.new()
				pm.add_theme_constant_override("margin_left", 8); pm.add_theme_constant_override("margin_right", 8)
				pm.add_theme_constant_override("margin_top", 6); pm.add_theme_constant_override("margin_bottom", 6)
				p_card.add_child(pm)

				var pvbox := VBoxContainer.new()
				pm.add_child(pvbox)

				var l_name := Label.new()
				l_name.text = "%s (T%d)" % [m["name"], t]
				l_name.add_theme_font_size_override("font_size", 11)
				pvbox.add_child(l_name)

				var l_qty := Label.new()
				l_qty.text = "Cantidad: %d" % count
				l_qty.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
				l_qty.add_theme_font_size_override("font_size", 11)
				pvbox.add_child(l_qty)

				grid_mat.add_child(p_card)
	content_list.add_child(grid_mat)

	var hsep := HSeparator.new()
	content_list.add_child(hsep)

	var section_parts := Label.new()
	section_parts.text = "🔩 PIEZAS MANUFACTURADAS (LISTAS PARA USAR)"
	section_parts.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	section_parts.add_theme_font_size_override("font_size", 12)
	content_list.add_child(section_parts)

	var grid_parts := GridContainer.new()
	grid_parts.columns = 5
	grid_parts.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid_parts.add_theme_constant_override("h_separation", 10)
	grid_parts.add_theme_constant_override("v_separation", 10)

	var piece_categories = [
		{"type": "cable", "name": "Cable"},
		{"type": "ventilador", "name": "Ventilador"},
		{"type": "panel", "name": "Panel"},
		{"type": "chip", "name": "Microchip"},
		{"type": "condensador", "name": "Condensador"}
	]

	for cat in piece_categories:
		for lvl in range(1, 6):
			var count = GameManager.get_part_quantity(cat["type"], lvl)
			var p_card := PanelContainer.new()
			p_card.custom_minimum_size = Vector2(150, 75)
			var st := StyleBoxFlat.new()
			st.bg_color = Color(0.08, 0.10, 0.15, 0.9)
			st.border_color = Color(0.2, 0.35, 0.55, 0.7)
			st.set_border_width_all(1); st.set_corner_radius_all(6)
			p_card.add_theme_stylebox_override("panel", st)

			var pm := MarginContainer.new()
			pm.add_theme_constant_override("margin_left", 8); pm.add_theme_constant_override("margin_right", 8)
			pm.add_theme_constant_override("margin_top", 6); pm.add_theme_constant_override("margin_bottom", 6)
			p_card.add_child(pm)

			var pvbox := VBoxContainer.new()
			pm.add_child(pvbox)

			var l_name := Label.new()
			l_name.text = "%s Nv. %d" % [cat["name"], lvl]
			l_name.add_theme_font_size_override("font_size", 11)
			pvbox.add_child(l_name)

			var l_qty := Label.new()
			l_qty.text = "Posees: %d" % count
			l_qty.add_theme_font_size_override("font_size", 11)
			l_qty.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if count > 0 else Color(0.6, 0.65, 0.75))
			pvbox.add_child(l_qty)

			grid_parts.add_child(p_card)

	content_list.add_child(grid_parts)

func _format_name(gtype: String) -> String:
	match gtype:
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