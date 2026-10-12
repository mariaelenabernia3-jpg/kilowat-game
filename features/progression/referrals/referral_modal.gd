# res://features/progression/referrals/referral_modal.gd
extends Control

@onready var code_label: Label = $Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox/CodeLabel
@onready var copy_btn: Button = $Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox/CopyBtn
@onready var total_refs_lbl: Label = $Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox/TotalRefsVal
@onready var refs_progress_bar: ProgressBar = $Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox/ProgressBar
@onready var power_earned_lbl: Label = $Center/Panel/Margin/VBox/StatsGrid/PowerCard/Margin/VBox/PowerEarnedVal
@onready var friends_list: VBoxContainer = $Center/Panel/Margin/VBox/FriendsScroll/Margin/FriendsList
@onready var close_btn: Button = $Center/Panel/Margin/VBox/TopRow/CloseBtn

var my_referral_code: String = ""

func _ready() -> void:
	visible = false
	close_btn.pressed.connect(func(): visible = false)
	copy_btn.pressed.connect(_on_copy_pressed)

func open_modal() -> void:
	visible = true
	_fetch_referral_data()

func _fetch_referral_data() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_referral_stats", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var d = res["data"]
		my_referral_code = str(d.get("referral_code", GameManager.username))
		code_label.text = my_referral_code
		
		var refs_count: int = int(d.get("total_referrals", 0))
		total_refs_lbl.text = "%d / 20 Amigos" % refs_count
		if refs_progress_bar:
			refs_progress_bar.value = refs_count
			
		var p_kwp: float = float(d.get("referral_power_kwp", 0.0))
		power_earned_lbl.text = "+%.9f KWP" % p_kwp
		
		for child in friends_list.get_children():
			child.queue_free()
			
		var friends = d.get("friends", [])
		if friends.is_empty():
			var empty_panel := PanelContainer.new()
			var ep_st := StyleBoxFlat.new()
			ep_st.bg_color = Color(0.08, 0.10, 0.14, 0.7)
			ep_st.set_corner_radius_all(6)
			empty_panel.add_theme_stylebox_override("panel", ep_st)
			
			var ep_m := MarginContainer.new()
			ep_m.add_theme_constant_override("margin_top", 16)
			ep_m.add_theme_constant_override("margin_bottom", 16)
			empty_panel.add_child(ep_m)
			
			var empty_lbl := Label.new()
			empty_lbl.text = "Aún no tienes amigos en tu red.\nComparte tu código para recibir potencia permanente de por vida."
			empty_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			empty_lbl.add_theme_color_override("font_color", Color(0.65, 0.70, 0.80))
			empty_lbl.add_theme_font_size_override("font_size", 12)
			ep_m.add_child(empty_lbl)
			friends_list.add_child(empty_panel)
		else:
			for f in friends:
				var row_panel := PanelContainer.new()
				var rp_st := StyleBoxFlat.new()
				var is_done = bool(f.get("completed", false))
				rp_st.bg_color = Color(0.10, 0.14, 0.20, 0.85) if is_done else Color(0.08, 0.10, 0.14, 0.85)
				rp_st.border_color = Color(0.3, 0.85, 0.5) if is_done else Color(0.25, 0.35, 0.5, 0.6)
				rp_st.set_border_width_all(1)
				rp_st.set_corner_radius_all(6)
				row_panel.add_theme_stylebox_override("panel", rp_st)
				
				var rm := MarginContainer.new()
				rm.add_theme_constant_override("margin_left", 12); rm.add_theme_constant_override("margin_right", 12)
				rm.add_theme_constant_override("margin_top", 8); rm.add_theme_constant_override("margin_bottom", 8)
				row_panel.add_child(rm)
				
				var row := HBoxContainer.new()
				rm.add_child(row)
				
				var u_lbl := Label.new()
				u_lbl.text = str(f.get("username", "Jugador")).to_upper()
				u_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				u_lbl.add_theme_font_size_override("font_size", 12)
				row.add_child(u_lbl)
				
				var status_lbl := Label.new()
				if is_done:
					status_lbl.text = "✓ VERIFICADO (+0.000000050 KWP)"
					status_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
				else:
					status_lbl.text = "⏳ En progreso (Nivel 4 de Pase o 30 victorias)"
					status_lbl.add_theme_color_override("font_color", Color(1.0, 0.82, 0.2))
				status_lbl.add_theme_font_size_override("font_size", 11)
				row.add_child(status_lbl)
				
				friends_list.add_child(row_panel)

func _on_copy_pressed() -> void:
	DisplayServer.clipboard_set(my_referral_code)
	copy_btn.text = "✓ ¡CÓDIGO COPIADO!"
	await get_tree().create_timer(1.8).timeout
	copy_btn.text = "📋 COPIAR CÓDIGO"