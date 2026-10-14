# res://features/progression/battle_pass/battle_pass_screen.gd
extends Control

const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")
const CHIP_ICON: Texture2D = preload("res://assets/sprites/ui/icon_chip.png")

# Cabecera y Recursos
@onready var close_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/CloseButton
@onready var watt_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilo_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel

# Barra de Nivel y Botón Premium
@onready var level_label: Label = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/LevelPill/Margin/HBox/LevelLabel
@onready var xp_progress_bar: ProgressBar = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/XPBox/XPProgressBar
@onready var xp_text_label: Label = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/XPBox/XPTextLabel
@onready var buy_premium_button: Button = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/BuyPremiumButton

# Pestañas
@onready var pass_tab_button: Button = $CanvasLayerUI/MainVBox/TabsBar/Margin/TabsHBox/PassTabButton
@onready var quests_tab_button: Button = $CanvasLayerUI/MainVBox/TabsBar/Margin/TabsHBox/QuestsTabButton
@onready var tracks_scroll: ScrollContainer = $CanvasLayerUI/MainVBox/TracksScroll
@onready var quests_scroll: ScrollContainer = $CanvasLayerUI/MainVBox/QuestsScroll
@onready var tracks_container: HBoxContainer = $CanvasLayerUI/MainVBox/TracksScroll/TracksContainer
@onready var quests_list: VBoxContainer = $CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper/QuestsList
@onready var reset_timer_label: Label = $CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper/ResetHeader/ResetTimerLabel

# Modal de Vista Previa Grande
@onready var reward_preview_modal: Control = $CanvasLayerUI/RewardPreviewModal
@onready var close_preview_btn: Button = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header/ClosePreviewBtn
@onready var preview_title: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header/PreviewTitle
@onready var bg_preview_box: VBoxContainer = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/BgPreviewBox
@onready var bg_large_image: TextureRect = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/BgPreviewBox/BgLargeImage
@onready var gen_preview_box: HBoxContainer = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox
@onready var gen_image: TextureRect = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenImage
@onready var gen_rarity: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenRarity
@onready var gen_name: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenName
@onready var gen_power: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenPower
@onready var gen_income: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenIncome
@onready var gen_desc: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenDesc

var is_premium: bool = false
var current_level: int = 1
var current_xp: int = 0
var xp_needed: int = 500
var clock_timer: float = 0.0

var claimed_free_levels: Array = []
var claimed_premium_levels: Array = []

var is_loading_pass_data: bool = false
var is_loading_quests: bool = false

func _ready() -> void:
	visible = false
	$CanvasLayerUI.visible = true
	if watt_lbl == null: watt_lbl = find_child("WattLabel", true, false)
	if kilo_lbl == null: kilo_lbl = find_child("KiloLabel", true, false)
	if chip_lbl == null: chip_lbl = find_child("ChipLabel", true, false)
	
	close_button.pressed.connect(func(): visible = false)
	if close_preview_btn: close_preview_btn.pressed.connect(func(): reward_preview_modal.visible = false)
	buy_premium_button.pressed.connect(_on_buy_premium_pressed)
	
	pass_tab_button.pressed.connect(_show_tracks)
	quests_tab_button.pressed.connect(_show_quests)
	
	if tracks_scroll:
		tracks_scroll.gui_input.connect(_on_tracks_scroll_gui_input)
	
	_update_hud()
	_show_tracks()
	_load_battle_pass_data()

func _process(delta: float) -> void:
	_update_hud()
	clock_timer += delta
	if clock_timer >= 1.0:
		clock_timer = 0.0
		_update_reset_countdown()

func _input(event: InputEvent) -> void:
	if not visible: return
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_ESCAPE:
			if reward_preview_modal and reward_preview_modal.visible:
				reward_preview_modal.visible = false
				get_viewport().set_input_as_handled()
			else:
				visible = false
				get_viewport().set_input_as_handled()

func _on_tracks_scroll_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and tracks_scroll:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			tracks_scroll.scroll_horizontal = maxi(0, tracks_scroll.scroll_horizontal - 90)
			get_viewport().set_input_as_handled()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			tracks_scroll.scroll_horizontal += 90
			get_viewport().set_input_as_handled()

func _update_hud() -> void:
	if watt_lbl and is_instance_valid(watt_lbl):
		watt_lbl.text = "%.4f" % GameManager.watt
	if kilo_lbl and is_instance_valid(kilo_lbl):
		kilo_lbl.text = "%.6f" % GameManager.kilowat
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens

func _update_reset_countdown() -> void:
	var now_utc: Dictionary = Time.get_datetime_dict_from_system(true)
	var seconds_passed_today: int = (now_utc.hour * 3600) + (now_utc.minute * 60) + now_utc.second
	var seconds_until_midnight: int = 86400 - seconds_passed_today
	var h: int = int(float(seconds_until_midnight) / 3600.0)
	var m: int = int(float(seconds_until_midnight % 3600) / 60.0)
	var s: int = seconds_until_midnight % 60
	if reset_timer_label and is_instance_valid(reset_timer_label):
		reset_timer_label.text = "⏳ Reinicio de misiones en: %02d:%02d:%02d" % [h, m, s]

func _show_tracks() -> void:
	tracks_scroll.visible = true
	quests_scroll.visible = false
	_switch_tab_visual(pass_tab_button, quests_tab_button)

func _show_quests() -> void:
	tracks_scroll.visible = false
	quests_scroll.visible = true
	_switch_tab_visual(quests_tab_button, pass_tab_button)
	_build_quests_ui()

func _switch_tab_visual(active_btn: Button, inactive_btn: Button) -> void:
	active_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	inactive_btn.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))

func _on_buy_premium_pressed() -> void:
	if is_premium: return
	if GameManager.kilowat < 2.0:
		visible = false
		if ResourceLoader.exists("res://features/economy/shop/shop_screen.tscn"):
			get_tree().change_scene_to_file("res://features/economy/shop/shop_screen.tscn")
		return
		
	buy_premium_button.disabled = true
	var res: Dictionary = await GameManager.buy_shop_item_secure("premium_pass_s1", "pass", 2.0, "kilowat")
	if res.get("success", false):
		is_premium = true
		_update_ui()
		_load_battle_pass_data()
	else:
		buy_premium_button.disabled = false

func _load_battle_pass_data() -> void:
	if is_loading_pass_data: return
	is_loading_pass_data = true
	
	var uid = SupabaseClient.current_user_id
	if uid == "": 
		is_loading_pass_data = false
		return
		
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_or_create_battle_pass", HTTPClient.METHOD_POST, {}, true)
	is_loading_pass_data = false
	
	if res.get("success", false) and typeof(res["data"]) == TYPE_DICTIONARY and res["data"].get("success", false):
		var bp = res["data"]
		current_level = int(bp.get("current_level", 1))
		current_xp = int(bp.get("current_xp", 0))
		xp_needed = int(bp.get("xp_to_next_level", 500))
		is_premium = bool(bp.get("is_premium", false))
		claimed_free_levels = _parse_claimed(bp.get("claimed_free_levels", []))
		claimed_premium_levels = _parse_claimed(bp.get("claimed_premium_levels", []))
		_update_ui()
		_build_tracks_ui()
		if quests_scroll.visible:
			_build_quests_ui()

func _update_ui() -> void:
	level_label.text = "NIVEL %d / 20" % current_level
	xp_progress_bar.max_value = xp_needed
	xp_progress_bar.value = current_xp
	var pct: int = int((float(current_xp) / float(max(1, xp_needed))) * 100.0)
	xp_text_label.text = "%d / %d XP (%d%%)" % [current_xp, xp_needed, pct]
	
	if is_premium:
		buy_premium_button.text = "✓ PREMIUM ACTIVO"
		buy_premium_button.disabled = true
		buy_premium_button.add_theme_color_override("font_color", Color(0.4, 1.0, 0.4))
	else:
		buy_premium_button.text = "⚡ ACTIVAR PREMIUM (2 KILOWAT)"
		buy_premium_button.disabled = false
		buy_premium_button.add_theme_color_override("font_color", Color(0.08, 0.06, 0.01))

# ====================================================================
# CONSTRUCCIÓN DE LAS 20 COLUMNAS DE NIVELES (FREE & PREMIUM)
# ====================================================================

func _build_tracks_ui() -> void:
	for child in tracks_container.get_children(): child.queue_free()
	
	for lvl in range(1, 21):
		var col := VBoxContainer.new()
		col.custom_minimum_size = Vector2(140, 360)
		col.add_theme_constant_override("separation", 8)
		
		# 1. PISTA PREMIUM
		var prem_card := PanelContainer.new()
		prem_card.custom_minimum_size = Vector2(140, 150)
		var p_st := StyleBoxFlat.new()
		p_st.bg_color = Color(0.12, 0.10, 0.07, 0.95)
		p_st.border_color = Color(1.0, 0.82, 0.15, 1.0)
		p_st.set_border_width_all(1)
		p_st.set_corner_radius_all(8)
		prem_card.add_theme_stylebox_override("panel", p_st)
		
		var pvbox := VBoxContainer.new()
		pvbox.alignment = BoxContainer.ALIGNMENT_BEGIN
		pvbox.add_theme_constant_override("separation", 4)
		var pm := MarginContainer.new()
		pm.add_theme_constant_override("margin_left", 8); pm.add_theme_constant_override("margin_right", 8)
		pm.add_theme_constant_override("margin_top", 6); pm.add_theme_constant_override("margin_bottom", 8)
		pm.add_child(pvbox)
		prem_card.add_child(pm)
		
		var prem_tag := Label.new()
		prem_tag.text = "★ PREMIUM"
		prem_tag.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		prem_tag.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		prem_tag.add_theme_font_size_override("font_size", 9)
		pvbox.add_child(prem_tag)
		
		var is_prem_claimed = (lvl in claimed_premium_levels) or (str(lvl) in claimed_premium_levels)
		var can_claim_prem = is_premium and (lvl <= current_level) and (not is_prem_claimed)
		_populate_reward_box(pvbox, _get_premium_reward_info(lvl), not is_premium, lvl, true, is_prem_claimed, can_claim_prem)
		col.add_child(prem_card)
		
		# 2. INSIGNIA CENTRAL
		var lvl_pill := PanelContainer.new()
		lvl_pill.custom_minimum_size = Vector2(0, 24)
		var lp_st := StyleBoxFlat.new()
		var reached = (lvl <= current_level)
		lp_st.bg_color = Color(0.15, 0.22, 0.32, 0.95) if reached else Color(0.08, 0.10, 0.14, 0.8)
		lp_st.border_color = Color(0.35, 0.88, 1.0) if reached else Color(0.2, 0.25, 0.35)
		lp_st.set_border_width_all(1)
		lp_st.set_corner_radius_all(12)
		lvl_pill.add_theme_stylebox_override("panel", lp_st)
		
		var lvl_lbl := Label.new()
		lvl_lbl.text = "NV %d" % lvl
		lvl_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lvl_lbl.add_theme_color_override("font_color", Color(0.9, 0.98, 1.0) if reached else Color(0.6, 0.65, 0.75))
		lvl_lbl.add_theme_font_size_override("font_size", 10)
		lvl_pill.add_child(lvl_lbl)
		col.add_child(lvl_pill)
		
		# 3. PISTA GRATIS
		var free_card := PanelContainer.new()
		free_card.custom_minimum_size = Vector2(140, 150)
		var f_st := StyleBoxFlat.new()
		f_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
		f_st.border_color = Color(0.25, 0.45, 0.75, 0.8)
		f_st.set_border_width_all(1)
		f_st.set_corner_radius_all(8)
		free_card.add_theme_stylebox_override("panel", f_st)
		
		var fvbox := VBoxContainer.new()
		fvbox.alignment = BoxContainer.ALIGNMENT_BEGIN
		fvbox.add_theme_constant_override("separation", 4)
		var fm := MarginContainer.new()
		fm.add_theme_constant_override("margin_left", 8); fm.add_theme_constant_override("margin_top", 6)
		fm.add_theme_constant_override("margin_right", 8); fm.add_theme_constant_override("margin_bottom", 8)
		fm.add_child(fvbox)
		free_card.add_child(fm)
		
		var free_tag := Label.new()
		free_tag.text = "GRATIS"
		free_tag.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		free_tag.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
		free_tag.add_theme_font_size_override("font_size", 9)
		fvbox.add_child(free_tag)
		
		if lvl % 2 == 0:
			var is_free_claimed = (lvl in claimed_free_levels) or (str(lvl) in claimed_free_levels)
			var can_claim_free = (lvl <= current_level) and (not is_free_claimed)
			_populate_reward_box(fvbox, _get_free_reward_info(lvl), false, lvl, false, is_free_claimed, can_claim_free)
		else:
			var empty_space := Control.new()
			empty_space.custom_minimum_size = Vector2(0, 75)
			fvbox.add_child(empty_space)
			var dash := Label.new()
			dash.text = "—"
			dash.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			dash.add_theme_color_override("font_color", Color(0.35, 0.4, 0.5))
			fvbox.add_child(dash)
			
		col.add_child(free_card)
		tracks_container.add_child(col)

func _populate_reward_box(container: VBoxContainer, info: Dictionary, show_lock: bool, lvl: int, is_prem_track: bool, is_claimed: bool, can_claim: bool) -> void:
	var rtype = str(info.get("type", ""))
	
	var visual_box := CenterContainer.new()
	visual_box.custom_minimum_size = Vector2(0, 68)
	
	if rtype == "watt":
		var vb := VBoxContainer.new()
		vb.alignment = BoxContainer.ALIGNMENT_CENTER
		vb.add_theme_constant_override("separation", 2)
		var ico := TextureRect.new()
		ico.texture = WATT_ICON
		ico.custom_minimum_size = Vector2(30, 30)
		ico.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		ico.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		vb.add_child(ico)
		
		var amt := Label.new()
		amt.text = str(info.get("amount_text", ""))
		amt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		amt.add_theme_color_override("font_color", Color(0.4, 0.95, 0.55))
		amt.add_theme_font_size_override("font_size", 10)
		vb.add_child(amt)
		visual_box.add_child(vb)
		
	elif rtype in ["room_bg", "generator"]:
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(110, 64)
		btn.flat = true
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.pressed.connect(func(): _open_preview_modal(info))
		
		var vb := VBoxContainer.new()
		vb.alignment = BoxContainer.ALIGNMENT_CENTER
		vb.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		vb.mouse_filter = Control.MOUSE_FILTER_IGNORE
		vb.add_theme_constant_override("separation", 2)
		
		var thumb := TextureRect.new()
		thumb.custom_minimum_size = Vector2(50, 32) if rtype == "room_bg" else Vector2(36, 36)
		thumb.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		thumb.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var path = str(info.get("texture_path", ""))
		if ResourceLoader.exists(path): thumb.texture = load(path)
		vb.add_child(thumb)
		
		var n_lbl := Label.new()
		n_lbl.text = str(info.get("name", ""))
		n_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		n_lbl.add_theme_font_size_override("font_size", 9)
		n_lbl.add_theme_color_override("font_color", Color(0.35, 0.85, 1.0))
		n_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		vb.add_child(n_lbl)
		
		btn.add_child(vb)
		visual_box.add_child(btn)
		
	container.add_child(visual_box)

	var footer := CenterContainer.new()
	footer.custom_minimum_size = Vector2(0, 30)
	
	if is_claimed:
		var c_btn := Button.new()
		c_btn.text = "✓ Reclamado"
		c_btn.custom_minimum_size = Vector2(115, 26)
		c_btn.disabled = true
		c_btn.add_theme_font_size_override("font_size", 9)
		var dis_st := StyleBoxFlat.new()
		dis_st.bg_color = Color(0.1, 0.15, 0.12, 0.8)
		dis_st.border_color = Color(0.2, 0.5, 0.3, 0.6)
		dis_st.set_border_width_all(1); dis_st.set_corner_radius_all(5)
		c_btn.add_theme_stylebox_override("disabled", dis_st)
		c_btn.add_theme_color_override("font_disabled_color", Color(0.4, 0.85, 0.5, 0.7))
		footer.add_child(c_btn)
	elif can_claim:
		var claim_btn := Button.new()
		claim_btn.text = "⚡ Reclamar"
		claim_btn.custom_minimum_size = Vector2(115, 26)
		claim_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		claim_btn.add_theme_font_size_override("font_size", 10)
		
		var act_st := StyleBoxFlat.new()
		act_st.bg_color = Color(1.0, 0.82, 0.15, 1.0) if is_prem_track else Color(0.15, 0.75, 0.45, 1.0)
		act_st.border_color = Color(1.0, 0.95, 0.6) if is_prem_track else Color(0.4, 1.0, 0.6)
		act_st.set_border_width_all(1); act_st.set_corner_radius_all(5)
		claim_btn.add_theme_stylebox_override("normal", act_st)
		claim_btn.add_theme_stylebox_override("hover", act_st)
		claim_btn.add_theme_color_override("font_color", Color(0.08, 0.06, 0.01) if is_prem_track else Color(0.04, 0.12, 0.04))
		
		claim_btn.pressed.connect(func(): _claim_level_reward(lvl, is_prem_track, claim_btn))
		footer.add_child(claim_btn)
	elif show_lock:
		var l_lbl := Label.new()
		l_lbl.text = "🔒 Bloqueado"
		l_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		l_lbl.add_theme_font_size_override("font_size", 9)
		footer.add_child(l_lbl)
	else:
		var w_lbl := Label.new()
		w_lbl.text = "NV %d Requerido" % lvl
		w_lbl.add_theme_color_override("font_color", Color(0.55, 0.6, 0.7))
		w_lbl.add_theme_font_size_override("font_size", 9)
		footer.add_child(w_lbl)
		
	container.add_child(footer)

func _claim_level_reward(lvl: int, is_prem_track: bool, btn: Button) -> void:
	btn.disabled = true; btn.text = "..."
	var payload = {"p_level": lvl, "p_is_premium": is_prem_track}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/claim_battle_pass_reward", HTTPClient.METHOD_POST, payload, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		btn.text = "✓ Reclamado"; btn.disabled = true
		await GameManager.load_profile()
		_load_battle_pass_data()
	else:
		btn.disabled = false
		btn.text = "Reintentar"

func _open_preview_modal(info: Dictionary) -> void:
	var rtype = str(info.get("type", ""))
	preview_title.text = "VISTA PREVIA: " + str(info.get("name", "")).to_upper()
	
	if rtype == "room_bg":
		bg_preview_box.visible = true
		gen_preview_box.visible = false
		var path = str(info.get("texture_path", ""))
		if ResourceLoader.exists(path): bg_large_image.texture = load(path)
	elif rtype == "generator":
		bg_preview_box.visible = false
		gen_preview_box.visible = true
		var path = str(info.get("texture_path", ""))
		if ResourceLoader.exists(path): gen_image.texture = load(path)
		gen_rarity.text = "★ " + str(info.get("rarity", "EXCLUSIVA"))
		gen_name.text = str(info.get("name", ""))
		gen_power.text = "⚡ Potencia: " + str(info.get("power", ""))
		gen_income.text = "🪙 Generación: " + str(info.get("income", ""))
		gen_desc.text = str(info.get("description", ""))
		
	reward_preview_modal.visible = true

func _get_free_reward_info(level: int) -> Dictionary:
	match level:
		2: return {"type": "watt", "amount_text": "+0.05 W"}
		4: return {"type": "watt", "amount_text": "+0.10 W"}
		6: return {"type": "generator", "name": "Generador Manual", "texture_path": "res://assets/sprites/generators/dinamo_manual.png", "rarity": "PASE TEMPORADA 1", "power": "0.000000025 KWP", "income": "+0.000000025 kW/min", "description": "«Hay que darle a la manivela: 0.000000025 kW/min.»"}
		8: return {"type": "watt", "amount_text": "+0.25 W"}
		10: return {"type": "room_bg", "name": "Hab. Taller", "texture_path": "res://assets/sprites/room/bg_habitacion_taller.png"}
		12: return {"type": "watt", "amount_text": "+0.50 W"}
		14: return {"type": "watt", "amount_text": "+0.75 W"}
		16: return {"type": "watt", "amount_text": "+1.00 W"}
		18: return {"type": "watt", "amount_text": "+1.25 W"}
		20: return {"type": "generator", "name": "Panel Solar", "texture_path": "res://assets/sprites/generators/panel_solar.png", "rarity": "PASE TEMPORADA 1", "power": "0.000000200 KWP", "income": "+0.000000200 kW/min", "description": "«Fotoceldas recicladas: 0.000000200 kW/min.»"}
		_: return {"type": "watt", "amount_text": "+0.01 W"}

func _get_premium_reward_info(level: int) -> Dictionary:
	match level:
		1: return {"type": "watt", "amount_text": "+1.0 W"}
		2: return {"type": "watt", "amount_text": "+1.5 W"}
		3: return {"type": "watt", "amount_text": "+2.0 W"}
		4: return {"type": "watt", "amount_text": "+1.0 W"}
		5: return {"type": "room_bg", "name": "Búnker Solar", "texture_path": "res://assets/sprites/room/bg_bunker_solar.png"}
		6: return {"type": "watt", "amount_text": "+2.0 W"}
		7: return {"type": "watt", "amount_text": "+2.5 W"}
		8: return {"type": "watt", "amount_text": "+3.0 W"}
		9: return {"type": "watt", "amount_text": "+2.0 W"}
		10: return {"type": "generator", "name": "DELTA Mini", "texture_path": "res://assets/sprites/generators/delta_mini.png", "rarity": "PREMIUM TEMPORADA 1", "power": "0.000000300 KWP", "income": "+0.000000300 kW/min", "description": "«Batería portátil de gama alta: 0.000000300 kW/min.»"}
		11: return {"type": "watt", "amount_text": "+2.5 W"}
		12: return {"type": "watt", "amount_text": "+3.0 W"}
		13: return {"type": "watt", "amount_text": "+3.5 W"}
		14: return {"type": "watt", "amount_text": "+2.0 W"}
		15: return {"type": "watt", "amount_text": "+4.0 W"}
		16: return {"type": "watt", "amount_text": "+3.0 W"}
		17: return {"type": "watt", "amount_text": "+3.5 W"}
		18: return {"type": "watt", "amount_text": "+4.0 W"}
		19: return {"type": "watt", "amount_text": "+4.0 W"}
		20: return {"type": "generator", "name": "Pro Eléctrico", "texture_path": "res://assets/sprites/generators/pro_electrico.png", "rarity": "LEGENDARIO TEMPORADA 1", "power": "0.000000800 KWP", "income": "+0.000000800 kW/min", "description": "«Cúspide tecnológica del pase de batalla: 0.000000800 kW/min.»"}
		_: return {"type": "watt", "amount_text": "+1.0 W"}

# ====================================================================
# PESTAÑA: MISIONES DEL PASE Y CONTRATOS (SEGURO Y BLINDADO)
# ====================================================================
func _build_quests_ui() -> void:
	if is_loading_quests: return
	is_loading_quests = true

	for child in quests_list.get_children():
		child.queue_free()

	var loading_lbl := Label.new()
	loading_lbl.text = "Cargando misiones y contratos..."
	loading_lbl.add_theme_font_size_override("font_size", 12)
	loading_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	quests_list.add_child(loading_lbl)

	# 1. Obtener Misiones diarias clásicas
	var res_bp = await SupabaseClient.send_request("/rest/v1/rpc/get_daily_quests_status", HTTPClient.METHOD_POST, {}, true)
	
	# 2. Obtener Contratos Industriales (Llamada segura)
	var contracts: Array = []
	if GameManager.has_method("get_daily_contracts_secure"):
		contracts = await GameManager.get_daily_contracts_secure()

	is_loading_quests = false

	# Limpiar el aviso de carga
	if is_instance_valid(loading_lbl):
		loading_lbl.queue_free()

	# SECCIÓN 1: MISIONES DE JUEGO (XP PARA EL PASE)
	var sec1_header := Label.new()
	sec1_header.text = "🎮 MISIONES DE JUEGO (XP DEL PASE)"
	sec1_header.add_theme_font_size_override("font_size", 13)
	sec1_header.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	quests_list.add_child(sec1_header)

	var has_bp_quests: bool = false
	if res_bp.get("success", false) and typeof(res_bp["data"]) == TYPE_DICTIONARY:
		var q_array = res_bp["data"].get("quests", [])
		if q_array.size() > 0:
			has_bp_quests = true
			for q in q_array:
				var panel := PanelContainer.new()
				var p_st := StyleBoxFlat.new()
				p_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
				p_st.border_color = Color(0.2, 0.35, 0.55, 0.7)
				p_st.set_border_width_all(1); p_st.set_corner_radius_all(8)
				panel.add_theme_stylebox_override("panel", p_st)

				var pm := MarginContainer.new()
				pm.add_theme_constant_override("margin_left", 14); pm.add_theme_constant_override("margin_top", 10)
				pm.add_theme_constant_override("margin_right", 14); pm.add_theme_constant_override("margin_bottom", 10)
				panel.add_child(pm)

				var hbox := HBoxContainer.new()
				hbox.add_theme_constant_override("separation", 14)
				pm.add_child(hbox)

				var vbox := VBoxContainer.new()
				vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				vbox.add_theme_constant_override("separation", 3)

				var q_title := Label.new()
				q_title.text = "%s (+%d XP)" % [str(q.get("title", "")), int(q.get("reward_xp", 0))]
				q_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
				q_title.add_theme_font_size_override("font_size", 13)
				vbox.add_child(q_title)

				var q_desc := Label.new()
				q_desc.text = str(q.get("description", ""))
				q_desc.add_theme_font_size_override("font_size", 11)
				q_desc.add_theme_color_override("font_color", Color(0.75, 0.8, 0.9))
				vbox.add_child(q_desc)

				var prog_lbl := Label.new()
				prog_lbl.text = "Progreso: %d / %d" % [int(q.get("current_progress", 0)), int(q.get("target_count", 1))]
				prog_lbl.add_theme_font_size_override("font_size", 10)
				prog_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
				vbox.add_child(prog_lbl)
				hbox.add_child(vbox)

				var q_btn := Button.new()
				q_btn.custom_minimum_size = Vector2(125, 34)
				q_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
				var is_comp = bool(q.get("is_completed", false))
				var is_clm = bool(q.get("is_claimed", false))

				if is_clm:
					q_btn.text = "✓ Reclamada"
					q_btn.disabled = true
				elif is_comp:
					q_btn.text = "⚡ Reclamar XP"
					q_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
					var q_id = str(q.get("quest_id", ""))
					q_btn.pressed.connect(func(): _claim_quest(q_id, q_btn))
				else:
					q_btn.text = "En curso"
					q_btn.disabled = true
				hbox.add_child(q_btn)

				quests_list.add_child(panel)

	if not has_bp_quests:
		var no_q_lbl := Label.new()
		no_q_lbl.text = "No hay misiones activas por el momento."
		no_q_lbl.add_theme_font_size_override("font_size", 11)
		quests_list.add_child(no_q_lbl)

	var hsep := HSeparator.new()
	quests_list.add_child(hsep)

	# SECCIÓN 2: CONTRATOS DE LA RED ELÉCTRICA
	var sec2_header := Label.new()
	sec2_header.text = "📜 CONTRATOS DE LA RED ELÉCTRICA (TALENTOS & FICHAS)"
	sec2_header.add_theme_font_size_override("font_size", 13)
	sec2_header.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	quests_list.add_child(sec2_header)

	if contracts.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No hay contratos industriales disponibles hoy."
		empty_lbl.add_theme_font_size_override("font_size", 11)
		quests_list.add_child(empty_lbl)
		return

	for c in contracts:
		var panel := PanelContainer.new()
		var p_st := StyleBoxFlat.new()
		p_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
		p_st.border_color = Color(1.0, 0.75, 0.2, 0.7)
		p_st.set_border_width_all(1); p_st.set_corner_radius_all(8)
		panel.add_theme_stylebox_override("panel", p_st)

		var pm := MarginContainer.new()
		pm.add_theme_constant_override("margin_left", 14); pm.add_theme_constant_override("margin_top", 10)
		pm.add_theme_constant_override("margin_right", 14); pm.add_theme_constant_override("margin_bottom", 10)
		panel.add_child(pm)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		pm.add_child(hbox)

		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.add_theme_constant_override("separation", 3)

		var c_title := Label.new()
		c_title.text = "📋 " + str(c.get("title", "Contrato"))
		c_title.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
		c_title.add_theme_font_size_override("font_size", 13)
		vbox.add_child(c_title)

		var c_desc := Label.new()
		c_desc.text = str(c.get("description", ""))
		c_desc.add_theme_font_size_override("font_size", 11)
		c_desc.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
		vbox.add_child(c_desc)

		var p_type = str(c.get("req_piece_type", ""))
		var p_tier = int(c.get("req_piece_tier", 1))
		var p_qty = int(c.get("req_piece_qty", 1))
		var req_w = float(c.get("req_watt", 0.0))

		var have_p = GameManager.get_part_quantity(p_type, p_tier) if GameManager.has_method("get_part_quantity") else 0
		var have_w = GameManager.watt
		var can_deliver = (have_p >= p_qty) and (have_w >= req_w)

		var req_lbl := Label.new()
		var p_names = {"cable": "Cables", "ventilador": "Ventiladores", "panel": "Paneles", "chip": "Microchips", "condensador": "Condensadores"}
		var p_display = p_names.get(p_type, p_type.capitalize())
		req_lbl.text = "Requiere: %s Nv.%d (%d/%d %s) | Watts (%.3f/%.3f %s)" % [
			p_display, p_tier, have_p, p_qty, "✓" if have_p >= p_qty else "✕",
			have_w, req_w, "✓" if have_w >= req_w else "✕"
		]
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_deliver else Color(1.0, 0.45, 0.45))
		vbox.add_child(req_lbl)

		var rew_lbl := Label.new()
		rew_lbl.text = "Recompensa: +%d Ptos. Talento 🏅 | +%d Fichas Casino 🪙 | +%d XP ⭐" % [
			int(c.get("reward_talent_points", 1)),
			int(c.get("reward_casino_tokens", 1)),
			int(c.get("reward_xp", 100))
		]
		rew_lbl.add_theme_font_size_override("font_size", 10)
		rew_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		vbox.add_child(rew_lbl)

		hbox.add_child(vbox)

		var q_btn := Button.new()
		q_btn.custom_minimum_size = Vector2(135, 36)
		q_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		var is_delivered = bool(c.get("is_delivered", false))

		if is_delivered:
			q_btn.text = "✓ Entregado"
			q_btn.disabled = true
		elif can_deliver:
			q_btn.text = "⚡ Entregar"
			q_btn.disabled = false
			q_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			var c_copy = c.duplicate()
			q_btn.pressed.connect(func():
				q_btn.disabled = true; q_btn.text = "..."
				if GameManager.has_method("deliver_contract_secure"):
					var res = await GameManager.deliver_contract_secure(c_copy)
					if res.get("success", false):
						_build_quests_ui()
					else:
						q_btn.disabled = false; q_btn.text = "Reintentar"
			)
		else:
			q_btn.text = "🔒 Faltan Piezas"
			q_btn.disabled = true

		hbox.add_child(q_btn)
		quests_list.add_child(panel)

func _claim_quest(quest_id: String, btn: Button) -> void:
	btn.disabled = true
	btn.text = "..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/claim_quest_reward", HTTPClient.METHOD_POST, {"p_quest_id": quest_id}, true)
	if res.get("success", false):
		await GameManager.load_profile()
		_load_battle_pass_data()
	else:
		btn.disabled = false
		btn.text = "Reintentar"

func _parse_claimed(raw) -> Array:
	var res: Array = []
	if typeof(raw) == TYPE_ARRAY:
		for x in raw: res.append(int(x))
	elif typeof(raw) == TYPE_STRING:
		var c = raw.replace("{","").replace("}","").replace("[","").replace("]","").strip_edges()
		if c != "":
			for p in c.split(","): 
				if p.strip_edges() != "": 
					res.append(int(p.strip_edges()))
	return res
