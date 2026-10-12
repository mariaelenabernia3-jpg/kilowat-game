# res://features/room/grid/room_grid.gd
extends Node2D

signal slot_selected(slot_index: int)
signal rack_hold_unmounted(slot_index: int)

@export_group("Dimensiones de Estantería")
@export var slot_width: float = 140.0
@export var slot_height: float = 220.0
@export var show_guides: bool = true

@export_group("Posicionamiento Manual por Coordenadas")
@export var custom_slot_positions: Array[Vector2] = []

const FLOOR_SLOT_SCENE: PackedScene = preload("res://features/room/grid/floor_slot.tscn")

@onready var slots_container: Node2D = $SlotsContainer
@onready var custom_markers: Node2D = $CustomMarkers

var slots_list: Array = []

func _ready() -> void:
	build_grid()

func build_grid() -> void:
	for child in slots_container.get_children():
		child.queue_free()
	slots_list.clear()

	# Coordenadas exactas para los 6 estantes en 2 filas de 3
	var final_positions: Array[Vector2] = [
		Vector2(480, 360), Vector2(680, 360), Vector2(890, 360), # Fila 1 (Superior)
		Vector2(480, 600), Vector2(680, 600), Vector2(890, 600)  # Fila 2 (Inferior)
	]

	for i in range(final_positions.size()):
		var slot_instance = FLOOR_SLOT_SCENE.instantiate()
		slot_instance.custom_minimum_size = Vector2(slot_width, slot_height)
		slot_instance.size = Vector2(slot_width, slot_height)
		
		var base_pos: Vector2 = final_positions[i]
		var top_left_x: float = base_pos.x - (slot_width / 2.0)
		var top_left_y: float = base_pos.y - slot_height
		slot_instance.position = Vector2(top_left_x, top_left_y)
		
		slots_container.add_child(slot_instance)
		slot_instance.set_slot_index(i)
		slot_instance.set_border_visible(show_guides)
		
		if not slot_instance.slot_clicked.is_connected(_on_slot_clicked):
			slot_instance.slot_clicked.connect(_on_slot_clicked)
			
		var slot_idx_val: int = i
		slot_instance.slot_hold_completed.connect(func(_idx): rack_hold_unmounted.emit(slot_idx_val))
		slots_list.append(slot_instance)
		
func set_slot_occupied(index: int, occupied: bool) -> void:
	if index >= 0 and index < slots_list.size():
		slots_list[index].is_occupied = occupied

func _on_slot_clicked(index: int) -> void:
	slot_selected.emit(index)

func get_slot_container(index: int) -> Marker2D:
	if index >= 0 and index < slots_list.size():
		return slots_list[index].rack_container
	return null