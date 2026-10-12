# res://features/room/racks/rack_view.gd
extends Node2D

var instance_id: String = ""
var rack_data: RackData = null
var current_floor_slot: int = -1

@onready var sprite: Sprite2D = $Sprite
@onready var plant_slots_container: Node2D = $PlantSlots

func setup_rack(data: RackData, db_id: String = "", floor_idx: int = -1) -> void:
	rack_data = data
	instance_id = db_id
	current_floor_slot = floor_idx
	
	if rack_data != null and rack_data.texture != null:
		sprite.texture = rack_data.texture
		sprite.visible = true
		sprite.centered = true
		sprite.offset = Vector2(0, -rack_data.texture.get_height() / 2.0)
	else:
		sprite.visible = false

func get_slot_marker(slot_index: int) -> Marker2D:
	var markers = plant_slots_container.get_children()
	if slot_index >= 0 and slot_index < markers.size():
		return markers[slot_index]
	return null