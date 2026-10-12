# res://features/economy/shop/offer_inspect_modal.gd
extends Control

signal purchase_completed(success: bool)

@onready var generator_texture: TextureRect = $Center/Panel/Margin/HBox/PedestalArea/GeneratorTexture
@onready var timer_label: Label = $Center/Panel/Margin/HBox/PedestalArea/TimerBadge/Margin/HBox/TimerLabel
@onready var buy_btn: Button = $Center/Panel/Margin/HBox/DetailsArea/BuyButton
@onready var close_btn: Button = $Center/Panel/Margin/HBox/DetailsArea/TopRow/CloseButton
@onready var status_msg: Label = $Center/Panel/Margin/HBox/DetailsArea/StatusMsg

var float_timer: float = 0.0
var base_sprite_y: float = 0.0
var second_accum: float = 0.0

const ITEM_ID: String = "cyber_tank"
const PRICE: float = 1.0
const OFFER_FILE: String = "user://cyber_tank_offer.json"
var offer_end_timestamp: int = 0

func _ready() -> void:
	if close_btn: close_btn.pressed.connect(func(): visible = false)
	if buy_btn: buy_btn.pressed.connect(_on_buy_pressed)
	if generator_texture: base_sprite_y = generator_texture.position.y
	_check_ownership()
	_update_countdown_label()

func open_modal() -> void:
	if _get_remaining_seconds() <= 0 or GameManager.get_owned_generator_count(ITEM_ID) >= 1:
		visible = false
		return
	visible = true
	_check_ownership()
	_update_countdown_label()

func _check_ownership() -> void:
	if GameManager.get_owned_generator_count(ITEM_ID) >= 1:
		buy_btn.disabled = true
		buy_btn.text = "🔒 YA ADQUIRIDO (1/1)"
		status_msg.text = "Ya posees esta unidad en tu inventario."
		status_msg.add_theme_color_override("font_color", Color(0.4, 0.95, 0.55))
	else:
		buy_btn.disabled = false
		buy_btn.text = "⚡ COMPRAR POR 1.0 KILOWAT"
		status_msg.text = ""

func _process(delta: float) -> void:
	if not visible: return
	if generator_texture:
		float_timer += delta * 2.8
		generator_texture.position.y = base_sprite_y + (sin(float_timer) * 7.0)

	second_accum += delta
	if second_accum >= 1.0:
		second_accum = 0.0
		_update_countdown_label()

func _get_remaining_seconds() -> int:
	var now: int = int(Time.get_unix_time_from_system())
	if offer_end_timestamp <= 0 and FileAccess.file_exists(OFFER_FILE):
		var f := FileAccess.open(OFFER_FILE, FileAccess.READ)
		if f:
			var parsed = JSON.parse_string(f.get_as_text())
			if typeof(parsed) == TYPE_DICTIONARY and parsed.has("end_timestamp"):
				offer_end_timestamp = int(parsed["end_timestamp"])
			f.close()
				
	if offer_end_timestamp <= 0:
		offer_end_timestamp = now + 604800
		var f := FileAccess.open(OFFER_FILE, FileAccess.WRITE)
		if f:
			f.store_string(JSON.stringify({"end_timestamp": offer_end_timestamp}))
			f.close()
	return maxi(0, offer_end_timestamp - now)

func _update_countdown_label() -> void:
	if timer_label == null: return
	var rem: int = _get_remaining_seconds()
	var d: int = int(float(rem) / 86400.0)
	var h: int = int(float(rem % 86400) / 3600.0)
	var m: int = int(float(rem % 3600) / 60.0)
	var s: int = rem % 60
	timer_label.text = "TERMINA EN: %02dD %02dH %02dM %02dS" % [d, h, m, s] if rem > 0 else "TERMINA EN: EXPIRADA"

func _on_buy_pressed() -> void:
	if GameManager.get_owned_generator_count(ITEM_ID) >= 1: return
	if GameManager.kilowat < PRICE:
		status_msg.text = "⚠️ Saldo insuficiente. Necesitas 1.0 KILOWAT."
		status_msg.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))
		return
		
	buy_btn.disabled = true
	status_msg.text = "Procesando compra en la central..."
	var res: Dictionary = await GameManager.buy_shop_item_secure(ITEM_ID, "generators", PRICE, "kilowat")
	if res.get("success", false):
		purchase_completed.emit(true)
		visible = false
	else:
		buy_btn.disabled = false
		status_msg.text = "⚠️ " + str(res.get("error", "Error en la compra"))
		status_msg.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))
		purchase_completed.emit(false)
