# res://features/room/components/room_hud.gd
extends PanelContainer

signal split_requested()
signal extract_requested()

@onready var player_label: Label = $Margin/HBox/PlayerLabel
@onready var power_label: Label = $Margin/HBox/StatsBox/PowerPill/Margin/HBox/PowerLabel
@onready var watt_label: Label = $Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilowat_label: Label = $Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_label: Label = $Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel

@onready var split_btn: Button = $Margin/HBox/ActionsBox/SplitPowerBtn
@onready var extract_btn: Button = $Margin/HBox/ActionsBox/ExtractBtn
@onready var logout_btn: Button = $Margin/HBox/ActionsBox/LogoutButton

func _ready() -> void:
	split_btn.pressed.connect(func(): split_requested.emit())
	extract_btn.pressed.connect(func(): extract_requested.emit())
	logout_btn.pressed.connect(_on_logout_pressed)
	
	EventBus.power_updated.connect(_update_power)
	EventBus.currencies_updated.connect(func(_w, _k): _update_currencies())
	
	_update_all()

func _process(_delta: float) -> void:
	_update_currencies()

func _update_all() -> void:
	player_label.text = "Operador: " + GameManager.username
	_update_power(GameManager.total_kwp)
	_update_currencies()

func _update_power(kwp: float) -> void:
	if power_label and is_instance_valid(power_label):
		power_label.text = _format_power(kwp)

func _update_currencies() -> void:
	if watt_label and is_instance_valid(watt_label):
		watt_label.text = "%.4f" % GameManager.watt
	if kilowat_label and is_instance_valid(kilowat_label):
		kilowat_label.text = "%.6f" % GameManager.kilowat
	if chip_label and is_instance_valid(chip_label):
		chip_label.text = "%.0f" % GameManager.casino_tokens

func _format_power(kwp: float) -> String:
	if kwp <= 0.0: return "0.000000000 KWP"
	elif kwp >= 1000000.0: return "%.3f GWP" % (kwp / 1000000.0)
	elif kwp >= 1000.0: return "%.3f MWP" % (kwp / 1000.0)
	elif kwp >= 1.0: return "%.4f KWP" % kwp
	else: return "%.9f KWP" % kwp

func _on_logout_pressed() -> void:
	logout_btn.disabled = true
	logout_btn.text = "..."
	await SupabaseAuth.sign_out()
	get_tree().change_scene_to_file("res://features/auth/login_screen.tscn")