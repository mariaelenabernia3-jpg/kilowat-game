# res://features/minigames/_shared/fuse_puzzle.gd
extends Control

signal puzzle_completed(success: bool)

@onready var svg_texture_rect: TextureRect = $Panel/Margin/VBox/SvgTextureRect
@onready var timer_label: Label = $Panel/Margin/VBox/TimerLabel
@onready var wire_blue: Button = $Panel/Margin/VBox/WiresContainer/WireBlue
@onready var wire_red: Button = $Panel/Margin/VBox/WiresContainer/WireRed
@onready var wire_yellow: Button = $Panel/Margin/VBox/WiresContainer/WireYellow

var current_challenge_id: String = ""
var time_left: float = 10.0
var is_active: bool = false

func _ready() -> void:
	wire_blue.pressed.connect(func(): _choose_wire(0))
	wire_red.pressed.connect(func(): _choose_wire(1))
	wire_yellow.pressed.connect(func(): _choose_wire(2))

func _process(delta: float) -> void:
	if not is_active: return
	time_left -= delta
	timer_label.text = "⏳ Tiempo restante: %ds" % max(0, int(ceil(time_left)))
	if time_left <= 0.0:
		is_active = false
		_fail_puzzle("Tiempo agotado.")

func open_challenge() -> void:
	visible = true
	is_active = false
	timer_label.text = "Conectando con el circuito..."
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/request_bot_challenge", HTTPClient.METHOD_POST, {}, true)
	if not res.get("success", false) or not res.get("data", {}).get("success", false):
		puzzle_completed.emit(false)
		visible = false
		return
		
	var data = res["data"]
	current_challenge_id = str(data.get("challenge_id", ""))
	var raw_svg: String = str(data.get("svg_data", ""))
	time_left = float(data.get("expires_in_seconds", 10))
	
	var img := Image.new()
	var err := img.load_svg_from_string(raw_svg)
	if err == OK:
		svg_texture_rect.texture = ImageTexture.create_from_image(img)
		
	is_active = true

func _choose_wire(wire_index: int) -> void:
	if not is_active: return
	is_active = false
	
	wire_blue.disabled = true
	wire_red.disabled = true
	wire_yellow.disabled = true
	
	var body = {
		"p_challenge_id": current_challenge_id,
		"p_selected_wire": wire_index
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/verify_bot_challenge", HTTPClient.METHOD_POST, body, true)
	
	wire_blue.disabled = false
	wire_red.disabled = false
	wire_yellow.disabled = false
	visible = false
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false) == true:
		puzzle_completed.emit(true)
	else:
		puzzle_completed.emit(false)

func _fail_puzzle(_reason: String) -> void:
	visible = false
	puzzle_completed.emit(false)