# res://data/definitions/generator_data.gd
class_name GeneratorData
extends Resource

@export var id: String = "planta_meme"
@export var name: String = "Planta Meme"
@export var level: int = 1
@export var rarity: String = "COMÚN"
@export var item_type: String = "Generador"
@export_multiline var description: String = "No genera electricidad. Bueno... técnicamente genera un poquito."

@export var slots_required: int = 1
@export var is_purchasable: bool = false
@export var cost_watt: float = 0.0
@export var cost_kilowat: float = 0.0

@export var power_kwp: float = 0.000000001
@export var cycle_time_seconds: float = 60.0
@export var reward_kilowat: float = 0.000000001

@export var texture: Texture2D