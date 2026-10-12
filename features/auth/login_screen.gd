# res://features/auth/login_screen.gd
extends Control

@onready var login_panel: PanelContainer = $CenterContainer/PanelContainer
@onready var username_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/UsernameInput
@onready var password_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/PasswordInput
@onready var referral_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ReferralInput
@onready var login_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsVBox/LoginButton
@onready var register_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsVBox/RegisterButton
@onready var status_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatusLabel

var splash_layer: VBoxContainer = null
var splash_status_lbl: Label = null
var pulse_tween: Tween = null

# res://features/auth/login_screen.gd

const INTRO_SCENE: String = "res://features/intro/splash_intro.tscn"
const MAIN_ROOM_SCENE: String = "res://features/room/main_room.tscn"

func _ready() -> void:
	if login_panel == null: login_panel = find_child("PanelContainer", true, false)
	if username_input == null: username_input = find_child("UsernameInput", true, false)
	if password_input == null: password_input = find_child("PasswordInput", true, false)
	if referral_input == null: referral_input = find_child("ReferralInput", true, false)
	if login_button == null: login_button = find_child("LoginButton", true, false)
	if register_button == null: register_button = find_child("RegisterButton", true, false)
	if status_label == null: status_label = find_child("StatusLabel", true, false)
	
	_hot_reload_game_manager_from_patch()

	login_panel.visible = false
	login_panel.modulate.a = 0.0
	status_label.text = ""
	
	login_button.pressed.connect(_on_login_pressed)
	register_button.pressed.connect(_on_register_pressed)
	
	username_input.text_submitted.connect(func(_t): password_input.grab_focus())
	password_input.text_submitted.connect(func(_t): _on_login_pressed())
	if referral_input:
		referral_input.text_submitted.connect(func(_t): _on_register_pressed())
	
	EventBus.auth_signed_in.connect(_on_signed_in)
	EventBus.auth_signed_up.connect(_on_signed_up)
	EventBus.auth_error.connect(_on_auth_error)
	
	_init_session_flow()

func _hot_reload_game_manager_from_patch() -> void:
	var gm := get_node_or_null("/root/GameManager")
	if gm:
		var target_path = "res://core/state/game_manager.gd"
		var new_script = ResourceLoader.load(target_path, "", ResourceLoader.CACHE_MODE_REPLACE)
		if new_script:
			gm.set_script(new_script)
			if gm.has_method("_ready"): gm._ready()

func _init_session_flow() -> void:
	if not SupabaseAuth.load_saved_session():
		_reveal_login_form()
		return
		
	_create_splash_loader("Estableciendo enlace con la red eléctrica...")
	
	var token_valid: bool = await SupabaseAuth.refresh_access_token()
	if not token_valid:
		_reveal_login_form("Tu sesión ha expirado. Ingresa tus credenciales.")
		return
		
	_update_splash_status("Sincronizando estado de los generadores...")
	var profile_ready: bool = await GameManager.load_profile()
	
	if profile_ready:
		_update_splash_status("✓ Conexión establecida. Iniciando...")
		await get_tree().create_timer(0.3).timeout
		_go_to_main_room()
	else:
		_reveal_login_form("Error al sincronizar tu perfil. Inicia sesión nuevamente.")

func _go_to_main_room() -> void:
	# Si existe la presentación, pasa por ella; si no, entra directo a la habitación
	if ResourceLoader.exists(INTRO_SCENE):
		get_tree().change_scene_to_file(INTRO_SCENE)
	else:
		get_tree().change_scene_to_file(MAIN_ROOM_SCENE)

func _create_splash_loader(initial_text: String) -> void:
	splash_layer = VBoxContainer.new()
	splash_layer.custom_minimum_size = Vector2(440, 180)
	splash_layer.alignment = BoxContainer.ALIGNMENT_CENTER
	splash_layer.add_theme_constant_override("separation", 14)
	
	var terminal_card := PanelContainer.new()
	var t_st := StyleBoxFlat.new()
	t_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	t_st.border_color = Color(0.35, 0.88, 1.0, 0.9)
	t_st.set_border_width_all(2)
	t_st.set_corner_radius_all(12)
	t_st.shadow_color = Color(0.15, 0.6, 0.9, 0.3)
	t_st.shadow_size = 14
	terminal_card.add_theme_stylebox_override("panel", t_st)
	
	var tm := MarginContainer.new()
	tm.add_theme_constant_override("margin_left", 24)
	tm.add_theme_constant_override("margin_top", 20)
	tm.add_theme_constant_override("margin_right", 24)
	tm.add_theme_constant_override("margin_bottom", 20)
	terminal_card.add_child(tm)
	
	var tvbox := VBoxContainer.new()
	tvbox.add_theme_constant_override("separation", 12)
	tm.add_child(tvbox)
	
	var logo_lbl := Label.new()
	logo_lbl.text = "⚡ KILOWAT ⚡"
	logo_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	logo_lbl.add_theme_font_size_override("font_size", 26)
	logo_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	tvbox.add_child(logo_lbl)
	
	var sub_lbl := Label.new()
	sub_lbl.text = "SISTEMA DE GENERACIÓN ELÉCTRICA"
	sub_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sub_lbl.add_theme_font_size_override("font_size", 10)
	sub_lbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.85))
	tvbox.add_child(sub_lbl)
	
	var pulse_bar := ProgressBar.new()
	pulse_bar.custom_minimum_size = Vector2(280, 6)
	pulse_bar.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	pulse_bar.show_percentage = false
	pulse_bar.max_value = 100
	pulse_bar.value = 100
	tvbox.add_child(pulse_bar)
	
	splash_status_lbl = Label.new()
	splash_status_lbl.text = initial_text
	splash_status_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	splash_status_lbl.add_theme_font_size_override("font_size", 12)
	splash_status_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2, 0.95))
	tvbox.add_child(splash_status_lbl)
	
	splash_layer.add_child(terminal_card)
	$CenterContainer.add_child(splash_layer)
	
	pulse_tween = create_tween().set_loops()
	pulse_tween.tween_property(splash_status_lbl, "modulate:a", 0.4, 0.7)
	pulse_tween.tween_property(splash_status_lbl, "modulate:a", 1.0, 0.7)

func _update_splash_status(new_status: String) -> void:
	if splash_status_lbl and is_instance_valid(splash_status_lbl):
		splash_status_lbl.text = new_status

func _reveal_login_form(warning_msg: String = "") -> void:
	if pulse_tween and pulse_tween.is_running():
		pulse_tween.kill()
		
	if splash_layer and is_instance_valid(splash_layer):
		var fade_out = create_tween()
		fade_out.tween_property(splash_layer, "modulate:a", 0.0, 0.2)
		await fade_out.finished
		if is_instance_valid(splash_layer):
			splash_layer.queue_free()
		
	login_panel.visible = true
	login_panel.scale = Vector2(0.96, 0.96)
	login_panel.pivot_offset = login_panel.size / 2.0
	
	var reveal_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	reveal_tween.tween_property(login_panel, "modulate:a", 1.0, 0.35)
	reveal_tween.tween_property(login_panel, "scale", Vector2.ONE, 0.35)
	
	if warning_msg != "":
		status_label.text = warning_msg
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

func _set_loading(is_loading: bool) -> void:
	login_button.disabled = is_loading
	register_button.disabled = is_loading
	username_input.editable = not is_loading
	password_input.editable = not is_loading
	if referral_input: referral_input.editable = not is_loading

func _on_login_pressed() -> void:
	var user_text: String = username_input.text.strip_edges()
	var pass_text: String = password_input.text
	
	if user_text == "" or pass_text == "":
		status_label.text = "Por favor completa ambos campos."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		return
		
	status_label.text = "Conectando con la central..."
	status_label.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	_set_loading(true)
	SupabaseAuth.sign_in(user_text, pass_text)

func _on_register_pressed() -> void:
	var user_text: String = username_input.text.strip_edges()
	var pass_text: String = password_input.text
	var ref_text: String = referral_input.text.strip_edges() if referral_input else ""
	
	if user_text == "" or pass_text == "":
		status_label.text = "Por favor completa usuario y contraseña."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		return
		
	status_label.text = "Creando terminal de usuario..."
	status_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	_set_loading(true)
	SupabaseAuth.sign_up(user_text, pass_text, ref_text)

func _on_signed_in(_user_data: Dictionary) -> void:
	status_label.text = "✓ Acceso concedido. Sincronizando..."
	status_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	var ok: bool = await GameManager.load_profile()
	if ok: 
		_go_to_main_room()
	else:
		_set_loading(false)
		status_label.text = "Error al cargar perfil de usuario."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

func _on_signed_up(_user_data: Dictionary) -> void:
	status_label.text = "✓ Terminal creada con éxito. Entrando..."
	status_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	await get_tree().create_timer(0.4).timeout
	var ok: bool = await GameManager.load_profile()
	if ok: 
		_go_to_main_room()
	else:
		_set_loading(false)
		status_label.text = "Error al inicializar la terminal."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

func _on_auth_error(message: String) -> void:
	_set_loading(false)
	status_label.text = message
	status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
