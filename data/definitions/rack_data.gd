# res://data/definitions/rack_data.gd
class_name RackData
extends Resource

@export var id: String = "rack_1_floor"
@export var name: String = "Estantería de 1 Piso"
@export_range(1, 3) var floors: int = 1
@export var total_slots: int = 2
@export var price_watt: float = 0.0
@export var price_kilowat: float = 0.0
@export var texture: Texture2D