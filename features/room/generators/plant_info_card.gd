# res://features/room/generators/plant_info_card.gd
extends PanelContainer

@onready var card_rarity: Label = $Margin/VBox/HeaderBox/RarityBadge
@onready var card_level: Label = $Margin/VBox/HeaderBox/LevelBadge
@onready var card_name: Label = $Margin/VBox/PlantNameLabel
@onready var card_power: Label = $Margin/VBox/PowerRow/PowerVal
@onready var card_income: Label = $Margin/VBox/IncomeRow/IncomeVal
@onready var card_status: Label = $Margin/VBox/StatusRow/StatusVal
@onready var card_desc: Label = $Margin/VBox/DescriptionLabel

func _ready() -> void:
	visible = false
	EventBus.show_plant_info.connect(_on_show_info)
	EventBus.hide_plant_info.connect(_on_hide_info)

func _on_show_info(info: Dictionary, plant_global_pos: Vector2) -> void:
	card_name.text = str(info.get("name", "Generador"))
	card_level.text = "NIVEL %d" % int(info.get("level", 1))
	card_rarity.text = "★ " + str(info.get("rarity", "COMÚN"))
	card_power.text = str(info.get("power", "0.000000050 KWP"))
	card_income.text = str(info.get("income", "+0.000000050 kW / min"))
	
	var dur: float = float(info.get("durability", 100.0))
	var is_act: bool = bool(info.get("is_active", false))
	
	if dur <= 0.0:
		card_status.text = "💥 AVERIADA (0% Durabilidad - Ir al Taller)"
		card_status.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	elif is_act:
		card_status.text = "ACTIVA (%.0f%% Dur.) [%s]" % [dur, str(info.get("time_left", ""))]
		card_status.add_theme_color_override("font_color", Color(0.4, 1.0, 0.4))
	else:
		card_status.text = "APAGADA (%.0f%% Durabilidad)" % dur
		card_status.add_theme_color_override("font_color", Color(1.0, 0.75, 0.2))
		
	card_desc.text = str(info.get("description", ""))
	
	var target_x: float = plant_global_pos.x + 35.0
	var target_y: float = plant_global_pos.y - 120.0
	if target_x + 280.0 > 1260.0: target_x = plant_global_pos.x - 295.0
		
	position = Vector2(target_x, maxf(70.0, target_y))
	visible = true

func _on_hide_info() -> void:
	visible = false
