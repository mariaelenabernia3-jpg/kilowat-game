# res://features/room/racks/rack_view.gd
extends Node2D

var instance_id: String = ""
var rack_data: RackData = null
var current_floor_slot: int = -1

@onready var sprite: Sprite2D = $Sprite
@onready var plant_slots_container: Node2D = $PlantSlots

func _ready() -> void:
	# Garantizar visibilidad frente al fondo en Android
	z_index = 2
	z_as_relative = false

func setup_rack(data: RackData, db_id: String = "", floor_idx: int = -1) -> void:
	rack_data = data
	instance_id = db_id
	current_floor_slot = floor_idx
	
	z_index = 2
	z_as_relative = false
	
	if sprite == null:
		sprite = get_node_or_null("Sprite")
		
	if rack_data != null and rack_data.texture != null and sprite != null:
		sprite.texture = rack_data.texture
		sprite.visible = true
		sprite.centered = true
		sprite.offset = Vector2(0, -rack_data.texture.get_height() / 2.0)
	elif sprite != null:
		sprite.visible = false

func get_slot_marker(slot_index: int) -> Marker2D:
	if plant_slots_container == null:
		plant_slots_container = get_node_or_null("PlantSlots")
	if plant_slots_container != null:
		var markers = plant_slots_container.get_children()
		if slot_index >= 0 and slot_index < markers.size():
			return markers[slot_index]
	return null
