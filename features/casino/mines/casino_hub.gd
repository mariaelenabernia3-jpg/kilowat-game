# res://features/casino/mines/casino_hub.gd
extends Control

@onready var back_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var chip_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel
@onready var watt_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilowat_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel

@onready var btn_play_mines: Button = $CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox/BtnPlayMines

var btn_play_roulette: Button = null

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	btn_play_mines.pressed.connect(_on_play_mines_pressed)
	
	# Habilitar la tarjeta de la Ruleta
	var upcoming_card = find_child("UpcomingCard", true, false)
	if upcoming_card:
		var badge = upcoming_card.find_child("Badge", true, false)
		if badge: badge.text = "★ JUEGO DISPONIBLE"
		badge.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		
		var desc = upcoming_card.find_child("Desc", true, false)
		if desc: desc.text = "1 Giro gratis cada 24 horas. ¡Gana Watts, Fichas de Casino, XP para tu Pase y hasta un generador EcoFlow Spark!"
		
		# Crear el botón para entrar a la ruleta
		var vbox = upcoming_card.find_child("VBox", true, false)
		if vbox:
			btn_play_roulette = Button.new()
			btn_play_roulette.text = "🎡 ENTRAR A LA RULETA"
			btn_play_roulette.custom_minimum_size = Vector2(240, 48)
			btn_play_roulette.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			btn_play_roulette.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			
			var st_btn := StyleBoxFlat.new()
			st_btn.bg_color = Color(1.0, 0.82, 0.15)
			st_btn.set_corner_radius_all(6)
			btn_play_roulette.add_theme_stylebox_override("normal", st_btn)
			btn_play_roulette.add_theme_color_override("font_color", Color(0.08, 0.06, 0.01))
			btn_play_roulette.pressed.connect(_on_play_roulette_pressed)
			vbox.add_child(btn_play_roulette)
			
	_update_hud()

func _process(_delta: float) -> void:
	_update_hud()

func _update_hud() -> void:
	if chip_label and is_instance_valid(chip_label):
		chip_label.text = "%.0f" % GameManager.casino_tokens
	if watt_label and is_instance_valid(watt_label):
		watt_label.text = "%.4f" % GameManager.watt
	if kilowat_label and is_instance_valid(kilowat_label):
		kilowat_label.text = "%.6f" % GameManager.kilowat

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://features/room/main_room.tscn")

func _on_play_mines_pressed() -> void:
	get_tree().change_scene_to_file("res://features/casino/mines/mines_game.tscn")

func _on_play_roulette_pressed() -> void:
	get_tree().change_scene_to_file("res://features/casino/roulette_game.tscn")
