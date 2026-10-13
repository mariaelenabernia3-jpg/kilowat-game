# res://data/definitions/material_data.gd
class_name MaterialData
extends Resource

@export var id: String = "cobre_t1"
@export var name: String = "Cobre Bruto"
@export var material_type: String = "cobre" # "cobre", "plastico", "silicio", "hierro"
@export_range(1, 5) var tier: int = 1
@export var rarity_name: String = "Común"
@export var texture: Texture2D

static func get_tier_color(t: int) -> Color:
	match t:
		1: return Color(0.4, 0.75, 1.0)   # Común (Azul claro)
		2: return Color(0.2, 0.85, 0.45)  # Poco Común (Verde)
		3: return Color(0.85, 0.4, 1.0)   # Especial (Púrpura)
		4: return Color(1.0, 0.45, 0.2)   # Épico (Naranja)
		5: return Color(1.0, 0.82, 0.15)  # Legendario (Dorado)
		_: return Color.WHITE