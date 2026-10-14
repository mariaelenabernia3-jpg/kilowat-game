# res://features/room/racks/rack_manage_dialog.gd
extends PanelContainer

signal generator_unmounted(gen_id: String)
signal generator_mounted(gen_id: String, slot_idx: int)

@onready var dialog_title: Label = $Margin/VBox/DialogTitle
@onready var dialog_status: Label = $Margin/VBox/DialogStatus
@onready var slots_list: VBoxContainer = $Margin/VBox/SlotsScroll/SlotsList
@onready var close_btn: Button = $Margin/VBox/CloseBtn

var current_rack: Dictionary = {}
var current_rack_data: RackData = null

func _ready() -> void:
	close_btn.pressed.connect(func(): visible = false)

func open_dialog(rack: Dictionary, rack_data: RackData) -> void:
	current_rack = rack
	current_rack_data = rack_data
	dialog_title.text = "GESTIÓN: %s" % rack_data.name.to_upper()
	
	for child in slots_list.get_children():
		child.queue_free()
		
	var rack_id: String = str(rack.get("id", rack.get("rack_id", "")))
	var placed_count: int = 0
	
	for slot_idx in range(rack_data.total_slots):
		var slot_card := PanelContainer.new()
		var slot_hbox := HBoxContainer.new()
		slot_hbox.add_theme_constant_override("separation", 12)
		
		var slot_num_lbl := Label.new()
		slot_num_lbl.text = "Espacio %d:" % (slot_idx + 1)
		slot_num_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		slot_hbox.add_child(slot_num_lbl)
		
		var installed_gen: Dictionary = {}
		for gen in GameManager.player_generators:
			if str(gen.get("rack_id", "")) == rack_id and int(gen.get("slot_in_rack", -1)) == slot_idx:
				installed_gen = gen
				break
				
		if not installed_gen.is_empty():
			placed_count += 1
			var g_type = str(installed_gen.get("generator_type", ""))
			var tier = _get_generator_tier(g_type)
			var tier_name = ["Común", "Poco Común", "Especial", "Épico", "Legendario"][tier - 1]
			
			var name_lbl := Label.new()
			name_lbl.text = "%s [%s]" % [_format_gen_name(g_type), tier_name]
			name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			slot_hbox.add_child(name_lbl)
			
			var unmount_btn := Button.new()
			unmount_btn.text = "❌ Quitar"
			unmount_btn.custom_minimum_size = Vector2(90, 32)
			unmount_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			unmount_btn.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))
			
			var gid = str(installed_gen.get("id", ""))
			unmount_btn.pressed.connect(func():
				visible = false
				generator_unmounted.emit(gid)
			)
			slot_hbox.add_child(unmount_btn)
		else:
			var empty_lbl := Label.new()
			empty_lbl.text = "(Vacío)"
			empty_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			empty_lbl.add_theme_color_override("font_color", Color(0.5, 0.55, 0.65))
			slot_hbox.add_child(empty_lbl)
			
			var mount_btn := MenuButton.new()
			mount_btn.text = "➕ Colocar..."
			mount_btn.custom_minimum_size = Vector2(110, 32)
			mount_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			mount_btn.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
			
			var popup: PopupMenu = mount_btn.get_popup()
			popup.clear()
			
			var unplaced_gens: Array = []
			for gen in GameManager.player_generators:
				var is_unmounted = (gen.get("rack_id") == null or str(gen.get("rack_id")) == "" or str(gen.get("rack_id")) == "null")
				if is_unmounted:
					unplaced_gens.append(gen)
					
			if unplaced_gens.is_empty():
				popup.add_item("Sin equipos en almacén")
				popup.set_item_disabled(0, true)
			else:
				for i in range(unplaced_gens.size()):
					var g_type = str(unplaced_gens[i].get("generator_type", ""))
					var limit = _get_room_limit_for_type(g_type)
					var active_count = _get_active_count_for_type(g_type)
					
					if active_count >= limit:
						popup.add_item("%s (Límite %d/%d en sala)" % [_format_gen_name(g_type), active_count, limit], i)
						popup.set_item_disabled(i, true)
					else:
						popup.add_item("%s (%d/%d en sala)" % [_format_gen_name(g_type), active_count, limit], i)
					
				var s_idx = slot_idx
				var list_copy = unplaced_gens.duplicate()
				popup.id_pressed.connect(func(clicked_idx: int):
					if clicked_idx >= 0 and clicked_idx < list_copy.size():
						visible = false
						generator_mounted.emit(str(list_copy[clicked_idx]["id"]), s_idx)
				)
			slot_hbox.add_child(mount_btn)
			
		slot_card.add_child(slot_hbox)
		slots_list.add_child(slot_card)
		
	dialog_status.text = "Espacios en uso: %d / %d" % [placed_count, rack_data.total_slots]
	visible = true

# ====================================================================
# CONTROL DE LIMITES Y TIERS
# ====================================================================

func _get_generator_tier(g_type: String) -> int:
	if GameManager.has_method("get_generator_tier"):
		return GameManager.get_generator_tier(g_type)
	match g_type:
		"planta_meme", "dinamo_manual", "ecoflow_spark", "bateria_plomo": return 1
		"ecoflow_spark_plus", "panel_solar", "molino_eolico": return 2
		"delta_mini", "inverter_silencioso": return 3
		"ecoflow_thunder_pro", "pro_electrico", "turbina_hidro": return 4
		"ecoflow_ultra", "cyber_tank", "reactor_magnetico": return 5
		_: return 1

func _get_room_limit_for_type(g_type: String) -> int:
	var tier = _get_generator_tier(g_type)
	match tier:
		1: return 4 # 4 de cada modelo común
		2: return 3 # 3 de cada modelo poco común
		3: return 2 # 2 de cada modelo especial
		4: return 1 # 1 de cada modelo épico
		5: return 1 # 1 de cada modelo legendario
		_: return 1

func _get_active_count_for_type(g_type: String) -> int:
	var count: int = 0
	for gen in GameManager.player_generators:
		var is_mounted = (gen.get("rack_id") != null and str(gen.get("rack_id")) != "" and str(gen.get("rack_id")) != "null")
		if is_mounted and str(gen.get("generator_type", "")) == g_type:
			count += 1
	return count

func _format_gen_name(g_type: String) -> String:
	match g_type:
		"planta_meme": return "Planta Meme"
		"dinamo_manual": return "Generador Manual"
		"ecoflow_spark": return "EcoFlow Spark"
		"bateria_plomo": return "Batería de Plomo"
		"ecoflow_spark_plus": return "EcoFlow Spark Plus"
		"panel_solar": return "Panel Solar"
		"molino_eolico": return "Mini Molino Eólico"
		"delta_mini": return "EcoFlow DELTA Mini"
		"inverter_silencioso": return "Inverter Silencioso"
		"ecoflow_thunder_pro": return "EcoFlow Thunder Pro"
		"pro_electrico": return "EcoFlow Pro Eléctrico"
		"turbina_hidro": return "Turbina Hidroeléctrica"
		"ecoflow_ultra": return "EcoFlow Ultra"
		"cyber_tank": return "Cyber Tank 100%"
		"reactor_magnetico": return "Reactor Magnético"
		_: return "Generador"
