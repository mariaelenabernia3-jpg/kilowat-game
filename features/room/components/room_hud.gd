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

var energy_pill: PanelContainer = null
var energy_timer_label: Label = null

func _ready() -> void:
	split_btn.pressed.connect(func(): split_requested.emit())
	extract_btn.pressed.connect(func(): extract_requested.emit())
	logout_btn.pressed.connect(_on_logout_pressed)
	
	_create_energy_timer_pill()
	
	EventBus.power_updated.connect(_update_power)
	EventBus.currencies_updated.connect(func(_w, _k): _update_currencies())
	
	_update_all()

func _create_energy_timer_pill() -> void:
	var stats_box = $Margin/HBox/StatsBox
	if stats_box == null: return
	
	energy_pill = PanelContainer.new()
	energy_pill.name = "EnergyTimerPill"
	energy_pill.custom_minimum_size = Vector2(145, 36)
	energy_pill.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	
	var st := StyleBoxFlat.new()
	st.bg_color = Color(0.1, 0.13, 0.18, 0.95)
	st.border_color = Color(0.2, 0.35, 0.55, 0.7)
	st.set_border_width_all(1)
	st.set_corner_radius_all(16)
	energy_pill.add_theme_stylebox_override("panel", st)
	
	var m := MarginContainer.new()
	m.add_theme_constant_override("margin_left", 8); m.add_theme_constant_override("margin_right", 8)
	energy_pill.add_child(m)
	
	var hbox := HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.add_theme_constant_override("separation", 6)
	m.add_child(hbox)
	
	energy_timer_label = Label.new()
	energy_timer_label.text = "⚡ Energía Temp: 30:00"
	energy_timer_label.add_theme_font_size_override("font_size", 11)
	energy_timer_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	hbox.add_child(energy_timer_label)
	
	stats_box.add_child(energy_pill)
	stats_box.move_child(energy_pill, 1)

func _process(_delta: float) -> void:
	_update_currencies()
	_update_energy_countdown()

func _update_energy_countdown() -> void:
	if energy_pill == null or energy_timer_label == null: return
	
	# Cálculo directo del tiempo restante (1800 segundos = 30 minutos)
	var rem: int = 0
	if GameManager.temporary_kwp > 0.0:
		var now: int = int(Time.get_unix_time_from_system())
		var elapsed: int = now - GameManager.last_minigame_time
		if elapsed < 1800:
			rem = 1800 - elapsed
	
	if GameManager.temporary_kwp <= 0.0 or rem <= 0:
		energy_pill.visible = false
	else:
		energy_pill.visible = true
		var mins: int = int(rem / 60)
		var secs: int = rem % 60
		energy_timer_label.text = "⚡ Energía Temp: %02d:%02d" % [mins, secs]
		
		if rem > 600:
			energy_timer_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
		elif rem > 300:
			energy_timer_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		else:
			energy_timer_label.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))

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
