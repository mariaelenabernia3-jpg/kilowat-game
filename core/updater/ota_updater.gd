# res://core/updater/ota_updater.gd
extends Control

const GITHUB_USER: String = "mariaelenabernia3-jpg"
const GITHUB_REPO: String = "kilowat-game"

const BASE_VERSION: String = "1.0.0"
const UPDATES_DIR: String = "user://updates/"
const VERSION_FILE: String = "user://installed_version.txt"

const MAIN_GAME_SCENE: String = "res://features/auth/login_screen.tscn"

@onready var status_lbl: Label = $Center/Panel/Margin/VBox/StatusLabel
@onready var progress_bar: ProgressBar = $Center/Panel/Margin/VBox/ProgressBar
@onready var action_btn: Button = $Center/Panel/Margin/VBox/ActionButton
@onready var logo_lbl: Label = $Center/Panel/Margin/VBox/Logo

var dl_request: HTTPRequest
var is_downloading: bool = false
var is_pck_patch: bool = false
var target_download_url: String = ""
var downloaded_local_path: String = ""
var download_total_bytes: int = 0
var remote_detected_version: String = ""
var pulse_tween: Tween = null

func _ready() -> void:
	action_btn.visible = false
	progress_bar.value = 0
	progress_bar.visible = false
	
	pulse_tween = create_tween().set_loops()
	pulse_tween.tween_property(logo_lbl, "modulate:a", 0.6, 0.7)
	pulse_tween.tween_property(logo_lbl, "modulate:a", 1.0, 0.7)
	
	if not DirAccess.dir_exists_absolute(UPDATES_DIR):
		DirAccess.make_dir_recursive_absolute(UPDATES_DIR)

	# Montar parche previo en disco si existe
	_mount_existing_patch()

	if OS.has_feature("editor"):
		print("[OTA] Modo editor. Saltando comprobación.")
		_proceed_to_game()
		return

	# Comprobar actualizaciones remotas
	_check_github_updates()

func _mount_existing_patch() -> bool:
	var saved_pck: String = UPDATES_DIR + "patch.pck"
	if not FileAccess.file_exists(saved_pck):
		return false
		
	var check_file := FileAccess.open(saved_pck, FileAccess.READ)
	if check_file == null or check_file.get_length() < 1024:
		if check_file: check_file.close()
		return false
	check_file.close()

	var global_pck: String = ProjectSettings.globalize_path(saved_pck)
	var mounted: bool = ProjectSettings.load_resource_pack(global_pck, true)
	if not mounted:
		mounted = ProjectSettings.load_resource_pack(saved_pck, true)
		
	if mounted:
		print("[OTA] Parche .pck montado con éxito en res://")
	return mounted

func _get_current_installed_version() -> String:
	if FileAccess.file_exists(VERSION_FILE):
		var f := FileAccess.open(VERSION_FILE, FileAccess.READ)
		if f:
			var v := f.get_as_text().strip_edges()
			f.close()
			if v != "":
				if _is_newer_version(BASE_VERSION, v):
					return BASE_VERSION
				return v
	return BASE_VERSION

func _save_installed_version(new_version: String) -> void:
	var f := FileAccess.open(VERSION_FILE, FileAccess.WRITE)
	if f:
		f.store_string(new_version.strip_edges())
		f.flush()
		f.close()

func _process(_delta: float) -> void:
	if is_downloading and is_instance_valid(dl_request):
		var dl_bytes := dl_request.get_downloaded_bytes()
		var body_size := dl_request.get_body_size()
		
		if body_size > 0:
			var pct := (float(dl_bytes) / float(body_size)) * 100.0
			progress_bar.value = pct
			var mb_done := float(dl_bytes) / (1024.0 * 1024.0)
			var mb_total := float(body_size) / (1024.0 * 1024.0)
			status_lbl.text = "Descargando actualización: %.1f / %.1f MB (%.0f%%)" % [mb_done, mb_total, pct]

func _check_github_updates() -> void:
	status_lbl.text = "Comprobando actualizaciones..."
	
	var http := HTTPRequest.new()
	http.timeout = 10.0
	add_child(http)
	
	var api_url := "https://api.github.com/repos/%s/%s/releases/latest" % [GITHUB_USER, GITHUB_REPO]
	var headers := PackedStringArray([
		"User-Agent: Godot-Kilowat-OTA-Updater",
		"Accept: application/vnd.github.v3+json"
	])
	
	http.request(api_url, headers, HTTPClient.METHOD_GET)
	var res: Array = await http.request_completed
	http.queue_free()
	
	if res[1] != 200:
		_proceed_to_game()
		return
		
	var json := JSON.new()
	if json.parse(res[3].get_string_from_utf8()) != OK or typeof(json.data) != TYPE_DICTIONARY:
		_proceed_to_game()
		return
		
	var release_data: Dictionary = json.data
	var tag_name: String = str(release_data.get("tag_name", "")).strip_edges()
	remote_detected_version = tag_name.replace("v", "").replace("V", "").strip_edges()
	
	var local_v: String = _get_current_installed_version()
	
	if _is_newer_version(remote_detected_version, local_v):
		_handle_detected_update(release_data, tag_name)
	else:
		status_lbl.text = "¡Juego al día!"
		await get_tree().create_timer(0.3).timeout
		_proceed_to_game()

func _is_newer_version(remote_v: String, local_v: String) -> bool:
	var r_parts := remote_v.split(".")
	var l_parts := local_v.split(".")
	var max_len := maxi(r_parts.size(), l_parts.size())
	for i in range(max_len):
		var r_num := int(r_parts[i]) if i < r_parts.size() else 0
		var l_num := int(l_parts[i]) if i < l_parts.size() else 0
		if r_num > l_num: return true
		elif r_num < l_num: return false
	return false

func _handle_detected_update(release: Dictionary, tag: String) -> void:
	var assets: Array = release.get("assets", [])
	target_download_url = ""
	is_pck_patch = false
	var download_name := ""
	
	for asset in assets:
		var name_str := str(asset.get("name", "")).to_lower()
		if name_str.ends_with(".pck"):
			target_download_url = str(asset.get("browser_download_url", ""))
			download_name = "patch.pck"
			download_total_bytes = int(asset.get("size", 0))
			is_pck_patch = true
			break
			
	if target_download_url == "":
		for asset in assets:
			var name_str := str(asset.get("name", "")).to_lower()
			if name_str.ends_with(".apk"):
				target_download_url = str(asset.get("browser_download_url", ""))
				download_name = "Kilowat_Update.apk"
				download_total_bytes = int(asset.get("size", 0))
				is_pck_patch = false
				break
				
	if target_download_url == "":
		_proceed_to_game()
		return
		
	downloaded_local_path = UPDATES_DIR + download_name
	progress_bar.visible = true
	progress_bar.value = 0
	
	if is_pck_patch:
		var mb_size := float(download_total_bytes) / (1024.0 * 1024.0)
		status_lbl.text = "⚡ Nueva versión %s disponible (~%.1f MB). Descargando..." % [tag, mb_size]
		await get_tree().create_timer(0.3).timeout
		_start_download_from_github()
	else:
		var mb_size := float(download_total_bytes) / (1024.0 * 1024.0)
		status_lbl.text = "Nueva APK %s disponible (~%.1f MB)" % [tag, mb_size]
		action_btn.text = "Descargar e Instalar APK"
		action_btn.visible = true
		action_btn.pressed.connect(_start_download_from_github)

func _start_download_from_github() -> void:
	action_btn.visible = false
	is_downloading = true
	
	if FileAccess.file_exists(downloaded_local_path):
		var global_clean: String = ProjectSettings.globalize_path(downloaded_local_path)
		DirAccess.remove_absolute(global_clean)
		
	dl_request = HTTPRequest.new()
	dl_request.download_file = downloaded_local_path
	dl_request.use_threads = true
	dl_request.max_redirects = 8
	add_child(dl_request)
	
	var headers := PackedStringArray(["User-Agent: Godot-Kilowat-OTA-Updater"])
	dl_request.request(target_download_url, headers, HTTPClient.METHOD_GET)
	var res: Array = await dl_request.request_completed
	is_downloading = false
	dl_request.queue_free()
	
	if res[1] == 200:
		var final_file := FileAccess.open(downloaded_local_path, FileAccess.READ)
		var actual_len: int = final_file.get_length() if final_file else 0
		if final_file: final_file.close()
		
		if download_total_bytes > 0 and actual_len < (download_total_bytes * 0.95):
			status_lbl.text = "Descarga incompleta. Entrando al juego..."
			await get_tree().create_timer(0.8).timeout
			_proceed_to_game()
			return
			
		progress_bar.value = 100
		
		if is_pck_patch:
			_save_installed_version(remote_detected_version)
			_mount_existing_patch()
			status_lbl.text = "✓ ¡Actualización aplicada! Entrando..."
			await get_tree().create_timer(0.4).timeout
			_proceed_to_game()
		else:
			status_lbl.text = "¡Descarga completa! Abriendo instalador..."
			_launch_apk_installer()
	else:
		status_lbl.text = "Error de red al actualizar. Entrando..."
		await get_tree().create_timer(0.8).timeout
		_proceed_to_game()

func _launch_apk_installer() -> void:
	if OS.get_name() == "Android":
		OS.shell_open(target_download_url)
	else:
		var global_path: String = ProjectSettings.globalize_path(downloaded_local_path)
		var err := OS.shell_open(global_path)
		if err != OK: OS.shell_open(target_download_url)

func _proceed_to_game() -> void:
	if pulse_tween: pulse_tween.kill()
	get_tree().change_scene_to_file.call_deferred(MAIN_GAME_SCENE)
