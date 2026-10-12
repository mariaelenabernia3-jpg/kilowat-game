# res://features/progression/tournament/event_leaderboard.gd
extends Control

var timer_label: Label
var close_btn: Button
var rows_container: VBoxContainer
var user_rank_lbl: Label
var user_power_lbl: Label
var user_diff_lbl: Label
var refresh_btn: Button
var event_remaining_seconds: int = 0
var clock_timer: float = 0.0

func _ready() -> void:
	_build_ui_layout()
	_fetch_leaderboard()

func _build_ui_layout() -> void:
	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.04, 0.05, 0.08, 1.0)
	add_child(overlay)

	var canvas := CanvasLayer.new()
	add_child(canvas)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(center)

	var main_panel := PanelContainer.new()
	main_panel.custom_minimum_size = Vector2(1100, 620)
	center.add_child(main_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_top", 18)
	margin.add_theme_constant_override("margin_right", 20); margin.add_theme_constant_override("margin_bottom", 18)
	main_panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 14)
	margin.add_child(vbox)

	var header := HBoxContainer.new()
	var title := Label.new()
	title.text = "⚡ COMPETENCIA DE POTENCIA"
	title.add_theme_font_size_override("font_size", 22)
	title.add_theme_color_override("font_color", Color(1.0, 0.88, 0.2))
	header.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(sp)

	timer_label = Label.new()
	timer_label.text = "TIEMPO RESTANTE: --"
	header.add_child(timer_label)

	close_btn = Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(36, 36)
	close_btn.pressed.connect(func():
		get_tree().change_scene_to_file("res://features/room/main_room.tscn")
	)
	header.add_child(close_btn)
	vbox.add_child(header)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	rows_container = VBoxContainer.new()
	rows_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(rows_container)

func _process(delta: float) -> void:
	clock_timer += delta
	if clock_timer >= 1.0:
		clock_timer = 0.0
		if event_remaining_seconds > 0:
			event_remaining_seconds -= 1
			_update_timer()

@warning_ignore("integer_division")
func _update_timer() -> void:
	var d = event_remaining_seconds / 86400
	var h = (event_remaining_seconds % 86400) / 3600
	var m = (event_remaining_seconds % 3600) / 60
	var s = event_remaining_seconds % 60
	timer_label.text = "TIEMPO: %dd %02d:%02d:%02d" % [d, h, m, s]

func _fetch_leaderboard() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_power_competition_leaderboard", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res["data"]) == TYPE_DICTIONARY and res["data"].get("success", false):
		var data = res["data"]
		event_remaining_seconds = int(data.get("remaining_seconds", 0))
		_update_timer()
		_build_rows(data.get("leaderboard", []))

func _build_rows(leaderboard: Array) -> void:
	for child in rows_container.get_children(): child.queue_free()
	for item in leaderboard:
		var row := HBoxContainer.new()
		var p_lbl := Label.new()
		p_lbl.text = "#%d %s" % [int(item.get("position", 1)), str(item.get("username", ""))]
		p_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(p_lbl)
		
		var kw_lbl := Label.new()
		kw_lbl.text = "%.9f KWP" % float(item.get("power", 0.0))
		row.add_child(kw_lbl)
		rows_container.add_child(row)
