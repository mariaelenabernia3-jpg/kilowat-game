# res://features/room/components/bg_selector_modal.gd
extends PanelContainer

signal background_changed(bg_id: String)

@onready var bg_list: VBoxContainer = $Margin/VBox/BgScroll/BgList
@onready var close_btn: Button = $Margin/VBox/CloseBgButton

func _ready() -> void:
	close_btn.pressed.connect(func(): visible = false)

func open_modal() -> void:
	for child in bg_list.get_children():
		child.queue_free()
		
	var bg_catalog = [
		{"id": "default", "name": "Habitación Inicial", "desc": "El cuarto oscuro tradicional.", "texture": "res://assets/sprites/room/room_background.png"},
		{"id": "bunker_solar", "name": "Búnker Solar", "desc": "Refugio industrial del Pase de Temporada.", "texture": "res://assets/sprites/room/bg_bunker_solar.png"},
		{"id": "habitacion_taller", "name": "Habitación Taller", "desc": "Banco de trabajo con herramientas.", "texture": "res://assets/sprites/room/bg_habitacion_taller.png"}
	]
	
	for bg in bg_catalog:
		var bg_id: String = bg["id"]
		var is_unlocked: bool = (bg_id in GameManager.unlocked_backgrounds)
		var is_equipped: bool = (GameManager.equipped_background == bg_id)
		
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 84)
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
		c_st.border_color = Color(0.35, 0.88, 1.0) if is_equipped else Color(0.2, 0.25, 0.35)
		c_st.set_border_width_all(2 if is_equipped else 1)
		c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)
		
		var cm := MarginContainer.new()
		cm.add_theme_constant_override("margin_left", 12)
		cm.add_theme_constant_override("margin_right", 12)
		cm.add_theme_constant_override("margin_top", 8)
		cm.add_theme_constant_override("margin_bottom", 8)
		card.add_child(cm)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		cm.add_child(hbox)
		
		var thumb := TextureRect.new()
		thumb.custom_minimum_size = Vector2(100, 60)
		thumb.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		var t_path = str(bg["texture"])
		if ResourceLoader.exists(t_path): thumb.texture = load(t_path)
		hbox.add_child(thumb)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.add_theme_constant_override("separation", 2)
		
		var name_lbl := Label.new()
		name_lbl.text = str(bg["name"])
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0) if is_unlocked else Color(0.5, 0.55, 0.65))
		vbox.add_child(name_lbl)
		
		var desc_lbl := Label.new()
		desc_lbl.text = str(bg["desc"])
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.65, 0.70, 0.80) if is_unlocked else Color(0.4, 0.45, 0.55))
		vbox.add_child(desc_lbl)
		hbox.add_child(vbox)
		
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(110, 36)
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		if is_equipped:
			btn.text = "✓ Puesto"
			btn.disabled = true
		elif is_unlocked:
			btn.text = "⚡ Equipar"
			btn.pressed.connect(func():
				await GameManager.equip_background(bg_id)
				background_changed.emit(bg_id)
				open_modal()
			)
		else:
			btn.text = "🔒 Bloqueado"
			btn.disabled = true
			
		hbox.add_child(btn)
		bg_list.add_child(card)
		
	visible = true