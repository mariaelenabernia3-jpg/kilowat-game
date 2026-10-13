# res://features/casino/mines/mines_game.gd
extends Control

const TOTAL_TILES: int = 25
const MIN_MINES: int = 2
const MAX_MINES: int = 24

@onready var back_btn: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var chip_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/ChipPill/Margin/HBox/ChipLabel

@onready var bet_input: LineEdit = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/BetInput
@onready var btn_half: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnHalf
@onready var btn_double: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnDouble
@onready var btn_min: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnMin
@onready var btn_max: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnMax

@onready var mines_slider: HSlider = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox/MinesSlider
@onready var mines_count_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox/CountLabel
@onready var gems_left_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/StatsBox/GemsLeftLabel
@onready var next_mult_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/StatsBox/NextMultLabel

@onready var action_btn: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/ActionButton
@onready var grid_container: GridContainer = $CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/Center/BoardPanel/Margin/GridContainer
@onready var status_toast_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/StatusToast

var tex_bomb: Texture2D
var tex_diamond: Texture2D

enum State { IDLE, PLAYING, GAME_OVER }
var current_state: State = State.IDLE

var board_data: Array = []
var revealed_tiles: Array = []
var tile_buttons: Array = []

var selected_mines: int = 3
var current_bet: float = 1.0
var gems_opened: int = 0
var current_multiplier: float = 1.0

func _ready() -> void:
	# Búsqueda defensiva para evitar cualquier error de nodo nulo
	if chip_lbl == null: chip_lbl = find_child("ChipLabel", true, false)
	if bet_input == null: bet_input = find_child("BetInput", true, false)
	if btn_half == null: btn_half = find_child("BtnHalf", true, false)
	if btn_double == null: btn_double = find_child("BtnDouble", true, false)
	if btn_min == null: btn_min = find_child("BtnMin", true, false)
	if btn_max == null: btn_max = find_child("BtnMax", true, false)
	if mines_slider == null: mines_slider = find_child("MinesSlider", true, false)
	if action_btn == null: action_btn = find_child("ActionButton", true, false)
	if grid_container == null: grid_container = find_child("GridContainer", true, false)
	if status_toast_lbl == null: status_toast_lbl = find_child("StatusToast", true, false)
	
	back_btn.pressed.connect(_on_back_pressed)
	action_btn.pressed.connect(_on_action_pressed)
	
	mines_slider.min_value = MIN_MINES
	mines_slider.max_value = MAX_MINES
	mines_slider.value = 3
	mines_slider.value_changed.connect(_on_mines_slider_changed)
	
	bet_input.text = "1"
	bet_input.text_changed.connect(_on_bet_input_changed)
	
	btn_half.pressed.connect(func(): _adjust_bet(0.5))
	btn_double.pressed.connect(func(): _adjust_bet(2.0))
	btn_min.pressed.connect(func(): _set_bet(1.0))
	btn_max.pressed.connect(func(): _set_bet(clampf(GameManager.casino_tokens, 1.0, 5000.0)))
	
	_load_assets()
	_build_board_tiles()
	_update_hud()
	_update_ui_state()

func _load_assets() -> void:
	var path_bomb = "res://assets/sprites/minigames/mines/bomb.png"
	var path_diamond = "res://assets/sprites/minigames/mines/diamond.png"
	if ResourceLoader.exists(path_bomb): tex_bomb = load(path_bomb)
	if ResourceLoader.exists(path_diamond): tex_diamond = load(path_diamond)

func _update_hud() -> void:
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens

func _on_back_pressed() -> void:
	if current_state == State.PLAYING and gems_opened > 0: 
		_cash_out()
	get_tree().change_scene_to_file("res://features/casino/mines/casino_hub.tscn")

func _on_mines_slider_changed(val: float) -> void:
	selected_mines = int(val)
	mines_count_lbl.text = "%d Minas (%d Diamantes)" % [selected_mines, TOTAL_TILES - selected_mines]
	_update_stats_display()

func _on_bet_input_changed(new_text: String) -> void:
	if not new_text.is_valid_float():
		current_bet = 1.0
		return
	var val: float = float(new_text)
	current_bet = clampf(val, 1.0, maxf(1.0, GameManager.casino_tokens))

func _adjust_bet(mult: float) -> void: _set_bet(current_bet * mult)
func _set_bet(val: float) -> void:
	current_bet = maxf(1.0, snappedf(val, 1.0))
	bet_input.text = "%.0f" % current_bet

func _update_stats_display() -> void:
	var total_gems = TOTAL_TILES - selected_mines
	var left = total_gems - gems_opened
	gems_left_lbl.text = "Gemas restantes: %d" % left
	var next_m = _calc_dampened_multiplier(selected_mines, gems_opened + 1)
	next_mult_lbl.text = "Siguiente: %.2fx" % next_m

func _calc_dampened_multiplier(mines: int, opened: int) -> float:
	if opened <= 0: return 1.0
	var safe_mines = clampi(mines, MIN_MINES, MAX_MINES)
	var fair: float = 1.0
	
	for i in range(opened):
		var remaining_tiles: float = float(TOTAL_TILES - i)
		var remaining_safe_tiles: float = float(TOTAL_TILES - safe_mines - i)
		
		# Protección estricta contra división por cero
		if remaining_safe_tiles <= 0.0 or remaining_tiles <= 0.0:
			break
			
		fair *= remaining_tiles / remaining_safe_tiles
		
	var dampened: float = 1.0 + (fair - 1.0) * 0.60
	return maxf(1.02, snappedf(dampened, 0.01))

func _build_board_tiles() -> void:
	for child in grid_container.get_children(): child.queue_free()
	tile_buttons.clear()
	
	for i in range(TOTAL_TILES):
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(76, 76)
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.clip_contents = true
		
		var style_normal := StyleBoxFlat.new()
		style_normal.bg_color = Color(0.12, 0.15, 0.22, 0.95)
		style_normal.border_color = Color(0.2, 0.35, 0.55, 0.8)
		style_normal.set_border_width_all(2)
		style_normal.set_corner_radius_all(8)
		btn.add_theme_stylebox_override("normal", style_normal)
		
		var icon_rect := TextureRect.new()
		icon_rect.name = "Icon"
		icon_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		btn.add_child(icon_rect)
		
		var idx = i
		btn.pressed.connect(func(): _on_tile_clicked(idx))
		grid_container.add_child(btn)
		tile_buttons.append(btn)

func _update_ui_state() -> void:
	match current_state:
		State.IDLE, State.GAME_OVER:
			bet_input.editable = true; mines_slider.editable = true
			btn_half.disabled = false; btn_double.disabled = false; btn_min.disabled = false; btn_max.disabled = false
			action_btn.disabled = false; action_btn.text = "⚡ APOSTAR FICHAS"
			var st_green := StyleBoxFlat.new()
			st_green.bg_color = Color(0.15, 0.75, 0.45, 1.0); st_green.border_color = Color(0.4, 1.0, 0.6)
			st_green.set_border_width_all(2); st_green.set_corner_radius_all(8)
			action_btn.add_theme_stylebox_override("normal", st_green)
			action_btn.add_theme_stylebox_override("hover", st_green)
			action_btn.add_theme_color_override("font_color", Color(0.04, 0.12, 0.04))
		State.PLAYING:
			bet_input.editable = false; mines_slider.editable = false
			btn_half.disabled = true; btn_double.disabled = true; btn_min.disabled = true; btn_max.disabled = true
			if gems_opened == 0:
				action_btn.text = "ELIGE UNA CASILLA..."; action_btn.disabled = true
			else:
				action_btn.disabled = false
				var win_amount: float = current_bet * current_multiplier
				action_btn.text = "💰 RETIRAR %.0f CHIPS (%.2fx)" % [win_amount, current_multiplier]
				var st_gold := StyleBoxFlat.new()
				st_gold.bg_color = Color(1.0, 0.82, 0.15, 1.0); st_gold.border_color = Color(1.0, 0.95, 0.6)
				st_gold.set_border_width_all(2); st_gold.set_corner_radius_all(8)
				action_btn.add_theme_stylebox_override("normal", st_gold)
				action_btn.add_theme_stylebox_override("hover", st_gold)
				action_btn.add_theme_color_override("font_color", Color(0.12, 0.08, 0.01))

func _on_action_pressed() -> void:
	if current_state in [State.IDLE, State.GAME_OVER]: _start_game()
	elif current_state == State.PLAYING and gems_opened > 0: _cash_out()

func _start_game() -> void:
	if GameManager.casino_tokens < current_bet:
		_show_toast("⚠️ Saldo insuficiente en Fichas de casino.")
		_update_ui_state()
		return
		
	GameManager.casino_tokens -= current_bet
	_update_hud()
	_sync_chips_to_supabase()
	
	gems_opened = 0
	current_multiplier = 1.0
	current_state = State.PLAYING
	
	_generate_mines()
	_reset_tile_views()
	_update_stats_display()
	_update_ui_state()

func _generate_mines() -> void:
	board_data.clear(); revealed_tiles.clear()
	for i in range(TOTAL_TILES):
		board_data.append(false); revealed_tiles.append(false)
		
	var placed = 0
	while placed < selected_mines:
		var r: int = randi() % TOTAL_TILES
		if not board_data[r]:
			board_data[r] = true
			placed += 1

func _reset_tile_views() -> void:
	for i in range(TOTAL_TILES):
		var btn: Button = tile_buttons[i]
		btn.disabled = false; btn.text = ""; btn.modulate = Color.WHITE; btn.scale = Vector2.ONE
		var icon: TextureRect = btn.get_node("Icon")
		icon.texture = null
		
		var st := StyleBoxFlat.new()
		st.bg_color = Color(0.12, 0.15, 0.22, 0.95)
		st.border_color = Color(0.2, 0.35, 0.55, 0.85)
		st.set_border_width_all(2); st.set_corner_radius_all(8)
		btn.add_theme_stylebox_override("normal", st)
		btn.add_theme_stylebox_override("disabled", st)

func _on_tile_clicked(idx: int) -> void:
	if current_state != State.PLAYING or revealed_tiles[idx]: return
	revealed_tiles[idx] = true
	var btn: Button = tile_buttons[idx]
	btn.disabled = true
	
	if board_data[idx]: _hit_mine(idx)
	else: _reveal_gem(idx)

func _reveal_gem(idx: int) -> void:
	var btn: Button = tile_buttons[idx]
	var icon: TextureRect = btn.get_node("Icon")
	if tex_diamond: icon.texture = tex_diamond
	else: btn.text = "💎"; btn.add_theme_font_size_override("font_size", 26)
		
	var st_gem := StyleBoxFlat.new()
	st_gem.bg_color = Color(0.2, 0.08, 0.3, 0.95); st_gem.border_color = Color(0.75, 0.3, 1.0, 1.0)
	st_gem.set_border_width_all(2); st_gem.set_corner_radius_all(8)
	btn.add_theme_stylebox_override("disabled", st_gem)
	
	btn.scale = Vector2(0.8, 0.8)
	var tw := create_tween()
	tw.tween_property(btn, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BACK)
	
	gems_opened += 1
	current_multiplier = _calc_dampened_multiplier(selected_mines, gems_opened)
	_update_stats_display()
	_update_ui_state()
	
	if gems_opened >= (TOTAL_TILES - selected_mines): _cash_out()

func _hit_mine(idx: int) -> void:
	current_state = State.GAME_OVER
	var btn: Button = tile_buttons[idx]
	var icon: TextureRect = btn.get_node("Icon")
	if tex_bomb: icon.texture = tex_bomb
	else: btn.text = "💣"; btn.add_theme_font_size_override("font_size", 26)
		
	var st_bomb := StyleBoxFlat.new()
	st_bomb.bg_color = Color(0.35, 0.08, 0.08, 0.95); st_bomb.border_color = Color(1.0, 0.25, 0.25, 1.0)
	st_bomb.set_border_width_all(2); st_bomb.set_corner_radius_all(8)
	btn.add_theme_stylebox_override("disabled", st_bomb)
	
	_show_toast("💥 ¡BOOM! Pisaste una mina. Apuesta perdida.")
	_reveal_full_board(idx)
	_sync_chips_to_supabase()
	_update_ui_state()

func _cash_out() -> void:
	if current_state != State.PLAYING: return
	current_state = State.GAME_OVER
	var total_won: float = current_bet * current_multiplier
	GameManager.casino_tokens += total_won
	_update_hud()
	_sync_chips_to_supabase()
	_show_toast("🏆 ¡Retiro con éxito! Ganaste %.0f FICHAS (%.2fx)" % [total_won, current_multiplier])
	_reveal_full_board(-1)
	_update_ui_state()

func _reveal_full_board(_exploded_idx: int) -> void:
	for i in range(TOTAL_TILES):
		var btn: Button = tile_buttons[i]
		var icon: TextureRect = btn.get_node("Icon")
		btn.disabled = true
		if not revealed_tiles[i]:
			btn.modulate = Color(0.65, 0.65, 0.65, 0.8)
			if board_data[i]:
				if tex_bomb: icon.texture = tex_bomb
				else: btn.text = "💣"
			else:
				if tex_diamond: icon.texture = tex_diamond
				else: btn.text = "💎"

func _sync_chips_to_supabase() -> void:
	SupabaseClient.send_request("/rest/v1/rpc/save_casino_chips", HTTPClient.METHOD_POST, {"p_chips": GameManager.casino_tokens}, true)

func _show_toast(msg: String) -> void:
	status_toast_lbl.text = msg
	status_toast_lbl.modulate.a = 1.0
	var tw := create_tween()
	tw.tween_property(status_toast_lbl, "modulate:a", 0.0, 0.6).set_delay(2.5)
