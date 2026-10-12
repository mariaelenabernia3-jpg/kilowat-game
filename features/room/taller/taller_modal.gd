# res://features/room/taller/taller_modal.gd
class_name TallerModal
extends Control

signal workshop_updated()

var current_tab: String = "repair"
var modal_zoom: float = 1.0
var min_zoom: float = 0.75
var max_zoom: float = 1.6

var main_panel: PanelContainer
var content_list: VBoxContainer
var tab_repair_btn: Button
var tab_upgrade_btn: Button
var tab_parts_btn: Button
var status_lbl: Label
var zoom_label: Label

# Detección táctil dentro del modal
var modal_touches: Dictionary = {}
var initial_pinch_dist: float = 0.0
var initial_pinch_zoom: float = 1.0

func _ready() -> void:
	visible = false
	_build_ui_layout()

func open_modal() -> void:
	visible = true
	current_tab = "repair"
	_set_zoom(1.0)
	_refresh_view()
	
	# Sincronizar en segundo plano con el servidor y redibujar si llegaron piezas nuevas
	await GameManager.load_player_parts()
	if visible:
		_refresh_view()

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
		# Fijar pivote al centro exacto de la tarjeta (440, 280)
		main_panel.pivot_offset = Vector2(440, 280)
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
	main_panel.custom_minimum_size = Vector2(880, 560)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.13, 0.98)
	p_st.border_color = Color(1.0, 0.75, 0.2, 1.0)
	p_st.set_border_width_all(2)
	p_st.set_corner_radius_all(12)
	p_st.shadow_color = Color(1.0, 0.6, 0.1, 0.3)
	p_st.shadow_size = 14
	main_panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(main_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 18); margin.add_theme_constant_override("margin_bottom", 18)
	main_panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	# Cabecera con Controles de Zoom
	var header := HBoxContainer.new()
	var title := Label.new()
	title.text = "🔧 TALLER DE INNOVACIÓN & MANTENIMIENTO"
	title.add_theme_font_size_override("font_size", 18)
	title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	header.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(sp)

	# Barra de zoom en cabecera
	var zoom_box := HBoxContainer.new()
	zoom_box.add_theme_constant_override("separation", 4)
	
	var btn_zoom_out := Button.new()
	btn_zoom_out.text = "🔍 -"
	btn_zoom_out.custom_minimum_size = Vector2(36, 32)
	btn_zoom_out.pressed.connect(func(): _set_zoom(modal_zoom - 0.2))
	zoom_box.add_child(btn_zoom_out)

	zoom_label = Label.new()
	zoom_label.text = "100%"
	zoom_label.add_theme_font_size_override("font_size", 11)
	zoom_label.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	zoom_box.add_child(zoom_label)

	var btn_zoom_in := Button.new()
	btn_zoom_in.text = "🔍 +"
	btn_zoom_in.custom_minimum_size = Vector2(36, 32)
	btn_zoom_in.pressed.connect(func(): _set_zoom(modal_zoom + 0.2))
	zoom_box.add_child(btn_zoom_in)

	var btn_reset_zoom := Button.new()
	btn_reset_zoom.text = "100%"
	btn_reset_zoom.custom_minimum_size = Vector2(46, 32)
	btn_reset_zoom.pressed.connect(func(): _set_zoom(1.0))
	zoom_box.add_child(btn_reset_zoom)
	header.add_child(zoom_box)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(32, 32)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): visible = false)
	header.add_child(close_btn)
	vbox.add_child(header)

	# Pestañas
	var tabs_row := HBoxContainer.new()
	tabs_row.add_theme_constant_override("separation", 10)

	tab_repair_btn = Button.new()
	tab_repair_btn.text = "🔨 Reparar Durabilidad"
	tab_repair_btn.custom_minimum_size = Vector2(180, 36)
	tab_repair_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_repair_btn.pressed.connect(func(): current_tab = "repair"; _refresh_view())
	tabs_row.add_child(tab_repair_btn)

	tab_upgrade_btn = Button.new()
	tab_upgrade_btn.text = "⚡ Subir Nivel (+25% kW)"
	tab_upgrade_btn.custom_minimum_size = Vector2(180, 36)
	tab_upgrade_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_upgrade_btn.pressed.connect(func(): current_tab = "upgrade"; _refresh_view())
	tabs_row.add_child(tab_upgrade_btn)

	tab_parts_btn = Button.new()
	tab_parts_btn.text = "📦 Repuestos Disponibles"
	tab_parts_btn.custom_minimum_size = Vector2(180, 36)
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
	tab_repair_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "repair" else Color(0.7, 0.75, 0.85))
	tab_upgrade_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "upgrade" else Color(0.7, 0.75, 0.85))
	tab_parts_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "inventory" else Color(0.7, 0.75, 0.85))

	for child in content_list.get_children(): child.queue_free()

	match current_tab:
		"repair": _build_repair_tab()
		"upgrade": _build_upgrade_tab()
		"inventory": _build_inventory_tab()

# ====================================================================
# PESTAÑA 1: REPARACIÓN (Con checklist estricto de piezas)
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
		name_lbl.text = "%s (Nivel %d)" % [_format_name(gtype), lvl]
		name_lbl.add_theme_font_size_override("font_size", 14)
		info_vbox.add_child(name_lbl)

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

		# Requisitos de reparación según modelo
		var req_cable_lvl = 1; var req_cable_qty = 6
		var req_vent_lvl = 1; var req_vent_qty = 4

		if gtype in ["ecoflow_ultra", "cyber_tank"]:
			req_cable_lvl = 4; req_cable_qty = 12; req_vent_lvl = 4; req_vent_qty = 8
		elif gtype in ["ecoflow_thunder_pro", "pro_electrico"]:
			req_cable_lvl = 3; req_cable_qty = 10; req_vent_lvl = 3; req_vent_qty = 6
		elif gtype in ["ecoflow_spark_plus", "delta_mini", "panel_solar"]:
			req_cable_lvl = 2; req_cable_qty = 8; req_vent_lvl = 2; req_vent_qty = 5

		var have_c = GameManager.get_part_quantity("cable", req_cable_lvl)
		var have_v = GameManager.get_part_quantity("ventilador", req_vent_lvl)
		var can_repair = (have_c >= req_cable_qty) and (have_v >= req_vent_qty)

		var req_lbl := Label.new()
		req_lbl.text = "Piezas: Cable Nv%d (%d/%d %s) | Ventilador Nv%d (%d/%d %s)" % [
			req_cable_lvl, have_c, req_cable_qty, "✓" if have_c >= req_cable_qty else "✕",
			req_vent_lvl, have_v, req_vent_qty, "✓" if have_v >= req_vent_qty else "✕"
		]
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_repair else Color(1.0, 0.45, 0.45))
		info_vbox.add_child(req_lbl)

		hbox.add_child(info_vbox)

		# Botón Reparar
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
# PESTAÑA 2: SUBIR DE NIVEL (Validación estricta de piezas)
# ====================================================================
func _build_upgrade_tab() -> void:
	for gen in GameManager.player_generators:
		var gid = str(gen.get("id", ""))
		var gtype = str(gen.get("generator_type", ""))
		var lvl = int(gen.get("level", 1))

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
		name_lbl.text = "%s — Nivel %d %s" % [_format_name(gtype), lvl, "★ MÁXIMO" if lvl >= 4 else "➔ Nivel %d" % (lvl + 1)]
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		info_vbox.add_child(name_lbl)

		var bonus_lbl := Label.new()
		bonus_lbl.text = "⚡ Bono: +%d%% kW/min | Próximo: +%d%% kW/min" % [(lvl - 1) * 25, lvl * 25] if lvl < 4 else "⚡ Potencia máxima (+75% permanente)"
		bonus_lbl.add_theme_font_size_override("font_size", 11)
		bonus_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		info_vbox.add_child(bonus_lbl)

		# Comprobación rigurosa de piezas requeridas
		var can_upgrade: bool = false
		var req_desc: String = ""

		if lvl < 4:
			var target_lvl = lvl + 1
			var req_part_lvl = lvl
			var req_c = 20 if target_lvl == 2 else 15
			var req_v = 15
			var req_p = 10 if target_lvl < 4 else 12

			var have_c = GameManager.get_part_quantity("cable", req_part_lvl)
			var have_v = GameManager.get_part_quantity("ventilador", req_part_lvl)
			var have_p = GameManager.get_part_quantity("panel", req_part_lvl)

			can_upgrade = (have_c >= req_c) and (have_v >= req_v) and (have_p >= req_p)

			req_desc = "Requisitos: Cable Nv%d (%d/%d %s) | Vent Nv%d (%d/%d %s) | Panel Nv%d (%d/%d %s)" % [
				req_part_lvl, have_c, req_c, "✓" if have_c >= req_c else "✕",
				req_part_lvl, have_v, req_v, "✓" if have_v >= req_v else "✕",
				req_part_lvl, have_p, req_p, "✓" if have_p >= req_p else "✕"
			]
		else:
			req_desc = "Generador mejorado al límite máximo permitido."

		var req_lbl := Label.new()
		req_lbl.text = req_desc
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_upgrade else (Color(0.7, 0.75, 0.85) if lvl >= 4 else Color(1.0, 0.45, 0.45)))
		info_vbox.add_child(req_lbl)
		hbox.add_child(info_vbox)

		# Botón Subir Nivel (Bloqueado si falta 1 sola pieza)
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
# PESTAÑA 3: INVENTARIO DE REPUESTOS
# ====================================================================
func _build_inventory_tab() -> void:
	var grid := GridContainer.new()
	grid.columns = 5
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 12)
	grid.add_theme_constant_override("v_separation", 12)

	var categories = [
		{"type": "cable", "name": "Cable", "prefix": "pieza cable "},
		{"type": "ventilador", "name": "Ventilador", "prefix": "pieza ventilador "},
		{"type": "panel", "name": "Panel", "prefix": "pieza panel "}
	]

	for cat in categories:
		for lvl in range(1, 6):
			var count = GameManager.get_part_quantity(cat["type"], lvl)
			var path = "res://assets/sprites/piezas/%s%d.png" % [cat["prefix"], lvl]

			var p_card := PanelContainer.new()
			p_card.custom_minimum_size = Vector2(150, 95)
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
			pvbox.alignment = BoxContainer.ALIGNMENT_CENTER
			pvbox.add_theme_constant_override("separation", 4)
			pm.add_child(pvbox)

			var tex := TextureRect.new()
			tex.custom_minimum_size = Vector2(36, 36)
			tex.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			tex.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			if ResourceLoader.exists(path): tex.texture = load(path)
			pvbox.add_child(tex)

			var l_name := Label.new()
			l_name.text = "%s Nv. %d" % [cat["name"], lvl]
			l_name.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			l_name.add_theme_font_size_override("font_size", 10)
			pvbox.add_child(l_name)

			var l_qty := Label.new()
			l_qty.text = "Posees: %d" % count
			l_qty.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			l_qty.add_theme_font_size_override("font_size", 11)
			l_qty.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if count > 0 else Color(0.6, 0.65, 0.75))
			pvbox.add_child(l_qty)

			grid.add_child(p_card)

	content_list.add_child(grid)

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
