# res://features/room/grid/floor_slot.gd
extends Control

signal slot_clicked(slot_index: int)
signal slot_hold_completed(slot_index: int)

@export var slot_index: int = 0
@export var hold_duration: float = 1.2

@onready var slot_border: ReferenceRect = $SlotBorder
@onready var click_button: Button = $ClickButton
@onready var rack_container: Marker2D = $RackContainer

var is_occupied: bool = false
var is_pressing: bool = false
var was_hold_completed: bool = false
var hold_progress: float = 0.0
var hold_timer: float = 0.0

func _ready() -> void:
	click_button.button_down.connect(_on_button_down)
	click_button.button_up.connect(_on_button_up)
	click_button.mouse_entered.connect(_on_mouse_entered)
	click_button.mouse_exited.connect(_on_mouse_exited)

func set_slot_index(idx: int) -> void:
	slot_index = idx

func set_border_visible(show_border: bool) -> void:
	slot_border.visible = show_border

func _process(delta: float) -> void:
	if is_pressing and is_occupied:
		hold_timer += delta
		hold_progress = clampf(hold_timer / hold_duration, 0.0, 1.0)
		queue_redraw()
		
		if hold_timer >= hold_duration:
			is_pressing = false
			was_hold_completed = true
			hold_progress = 0.0
			queue_redraw()
			slot_hold_completed.emit(slot_index)

func _draw() -> void:
	if is_occupied and hold_progress > 0.0:
		var center := Vector2(size.x / 2.0, size.y / 2.0)
		var radius: float = 34.0
		var bg_color := Color(0.08, 0.1, 0.15, 0.85)
		var arc_color := Color(0.18, 0.92, 0.82, 1.0)
		var width: float = 6.0
		
		draw_arc(center, radius, 0, TAU, 36, bg_color, width + 2.0, true)
		var start_angle := -PI / 2.0
		var end_angle := start_angle + (hold_progress * TAU)
		draw_arc(center, radius, start_angle, end_angle, 36, arc_color, width, true)

func _on_button_down() -> void:
	was_hold_completed = false
	if is_occupied:
		is_pressing = true
		hold_timer = 0.0
		hold_progress = 0.0
		queue_redraw()

func _on_button_up() -> void:
	if was_hold_completed:
		was_hold_completed = false
		is_pressing = false
		hold_progress = 0.0
		queue_redraw()
		return
		
	is_pressing = false
	hold_progress = 0.0
	queue_redraw()
	
	# Si soltó el clic antes de 1.2s, siempre se considera un clic válido
	slot_clicked.emit(slot_index)

func _on_mouse_entered() -> void:
	if not is_occupied: slot_border.border_color = Color(0.4, 1.0, 0.4, 0.7)

func _on_mouse_exited() -> void:
	if is_pressing:
		is_pressing = false
		hold_progress = 0.0
		queue_redraw()
	if not is_occupied: slot_border.border_color = Color(0.3, 0.7, 0.3, 0.25)
