# res://features/room/generators/generator_view.gd
extends Node2D

var instance_id: String = ""
var generator_data: GeneratorData = null
var is_active: bool = false
var is_pinned: bool = false
var target_death_ticks: int = 0
var current_durability: float = 100.0
var current_level: int = 1

@onready var plant_texture: TextureRect = $PlantTexture
@onready var status_indicator: ColorRect = $StatusIndicator
@onready var time_label: Label = $TimeBadge/TimeLabel
@onready var click_area: Button = $ClickArea

func _ready() -> void:
	click_area.pressed.connect(_on_clicked)
	click_area.mouse_entered.connect(_on_mouse_entered)
	click_area.mouse_exited.connect(_on_mouse_exited)

func setup_from_server(data: GeneratorData, db_id: String, remaining_seconds: int, durability: float = 100.0, level: int = 1) -> void:
	generator_data = data
	instance_id = db_id
	current_durability = durability
	current_level = level
	
	if generator_data != null and generator_data.texture != null:
		plant_texture.texture = generator_data.texture
		
	var base_power: float = generator_data.power_kwp if generator_data else 0.000000001
	var base_rate: float = generator_data.reward_kilowat if generator_data else 0.000000001
	
	# Aplicar el bono por nivel permanente (+25% por cada nivel arriba de 1)
	var level_multiplier: float = 1.0 + (max(1, current_level) - 1) * 0.25
	var power_val: float = base_power * level_multiplier
	var rate_val: float = base_rate * level_multiplier
		
	if remaining_seconds > 0 and current_durability > 0.0:
		is_active = true
		target_death_ticks = Time.get_ticks_msec() + (remaining_seconds * 1000)
		status_indicator.color = Color(0.2, 0.9, 0.2, 1) # Verde óptimo
		GameManager.set_generator_power(instance_id, true, power_val, rate_val)
	else:
		is_active = false
		target_death_ticks = 0
		status_indicator.color = Color(0.9, 0.2, 0.2, 1) # Rojo averiado o apagado
		time_label.text = "EN PANNE" if current_durability <= 0.0 else "OFF"
		GameManager.set_generator_power(instance_id, false, power_val, rate_val)

func _process(_delta: float) -> void:
	if not is_active: return
	var current_ticks = Time.get_ticks_msec()
	
	if current_ticks < target_death_ticks:
		var remaining_seconds: int = int((target_death_ticks - current_ticks) / 1000.0)
		var hours: int = int(float(remaining_seconds) / 3600.0)
		var minutes: int = int(float(remaining_seconds % 3600) / 60.0)
		var seconds: int = remaining_seconds % 60
		time_label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
	else:
		is_active = false
		status_indicator.color = Color(0.9, 0.2, 0.2, 1)
		time_label.text = "OFF"
		GameManager.set_generator_power(instance_id, false, 0.0)

func _get_info_payload() -> Dictionary:
	var base_power = generator_data.power_kwp if generator_data else 0.000000001
	var base_rate = generator_data.reward_kilowat if generator_data else 0.000000001
	var mult = 1.0 + (max(1, current_level) - 1) * 0.25
	
	return {
		"name": generator_data.name if generator_data else "Generador",
		"level": current_level,
		"durability": current_durability,
		"rarity": generator_data.rarity if generator_data else "COMÚN",
		"power": "%.9f KWP" % (base_power * mult),
		"income": "+%.9f kW / min" % (base_rate * mult),
		"is_active": is_active,
		"time_left": time_label.text,
		"description": generator_data.description if generator_data else ""
	}
	
func _on_mouse_entered() -> void:
	EventBus.show_plant_info.emit(_get_info_payload(), global_position)

func _on_mouse_exited() -> void:
	if not is_pinned: EventBus.hide_plant_info.emit()

func _on_clicked() -> void:
	if not is_active and instance_id != "" and current_durability > 0.0:
		reactivate_in_supabase()
	else:
		is_pinned = not is_pinned
		if is_pinned: EventBus.show_plant_info.emit(_get_info_payload(), global_position)
		else: EventBus.hide_plant_info.emit()

func reactivate_in_supabase() -> void:
	time_label.text = "..."
	var body = {"p_generator_id": instance_id}
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/activate_generator", HTTPClient.METHOD_POST, body, true)
	
	if res.get("success", false) and typeof(res["data"]) == TYPE_DICTIONARY and res["data"].get("success", false):
		var new_sec: int = int(res["data"].get("remaining_active_seconds", 21600))
		setup_from_server(generator_data, instance_id, new_sec, current_durability, current_level)
		
		for g in GameManager.player_generators:
			if str(g.get("id", "")) == instance_id:
				g["remaining_active_seconds"] = new_sec
				break
