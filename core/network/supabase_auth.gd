# res://core/network/supabase_auth.gd
extends Node

const SESSION_FILE: String = "user://session.json"
const EMAIL_DOMAIN: String = "@kilowat.local"
const ENCRYPTION_KEY: String = "K1L0W@T_S3CUR3_S3SS10N_2026_AES"

func _format_email(username: String) -> String:
	var clean: String = username.strip_edges().to_lower()
	clean = clean.replace(" ", ".")
	clean = clean.replace("á", "a").replace("é", "e").replace("í", "i").replace("ó", "o").replace("ú", "u").replace("ñ", "n")
	var regex := RegEx.new()
	regex.compile("[^a-z0-9._-]")
	clean = regex.sub(clean, "", true)
	return clean + EMAIL_DOMAIN

## Registro con código de referido opcional y device_id único
func sign_up(username: String, password: String, referrer_code: String = "") -> void:
	username = username.strip_edges()
	if username.length() < 3 or username.length() > 20:
		EventBus.auth_error.emit("El usuario debe tener entre 3 y 20 caracteres.")
		return
		
	if password.length() < 6:
		EventBus.auth_error.emit("La contraseña debe tener mínimo 6 caracteres.")
		return

	var device_unique_id: String = OS.get_unique_id()
	if device_unique_id == "":
		device_unique_id = "generic_dev_" + str(Time.get_unix_time_from_system())

	var email: String = _format_email(username)
	var body: Dictionary = {
		"email": email,
		"password": password,
		"data": {
			"username": username,
			"device_id": device_unique_id,
			"referrer_code": referrer_code.strip_edges()
		}
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/auth/v1/signup", HTTPClient.METHOD_POST, body, false)
	
	if not res["success"]:
		EventBus.auth_error.emit(res["error"])
		return
		
	var data: Dictionary = res["data"]
	if data.has("access_token"):
		_save_session(data)
		EventBus.auth_signed_up.emit(data)
	else:
		# En algunos flujos de Supabase Auth sin confirmación de email, pasa a sign_in directo
		await sign_in(username, password)

func sign_in(username: String, password: String) -> void:
	username = username.strip_edges()
	var email: String = _format_email(username)
	var body: Dictionary = {
		"email": email,
		"password": password
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/auth/v1/token?grant_type=password", HTTPClient.METHOD_POST, body, false)
	
	if not res["success"]:
		EventBus.auth_error.emit("Usuario o contraseña incorrectos.")
		return
		
	var data: Dictionary = res["data"]
	_save_session(data)
	EventBus.auth_signed_in.emit(data)

func sign_out() -> void:
	if SupabaseClient.access_token != "":
		await SupabaseClient.send_request("/auth/v1/logout", HTTPClient.METHOD_POST, {}, true)
	
	SupabaseClient.access_token = ""
	SupabaseClient.refresh_token = ""
	SupabaseClient.current_user_id = ""
	
	if FileAccess.file_exists(SESSION_FILE):
		DirAccess.remove_absolute(SESSION_FILE)
		
	EventBus.auth_signed_out.emit()

func _save_session(auth_data: Dictionary) -> void:
	SupabaseClient.access_token = str(auth_data.get("access_token", ""))
	SupabaseClient.refresh_token = str(auth_data.get("refresh_token", ""))
	if auth_data.has("user") and typeof(auth_data["user"]) == TYPE_DICTIONARY:
		SupabaseClient.current_user_id = str(auth_data["user"].get("id", ""))
		
	var file := FileAccess.open_encrypted_with_pass(SESSION_FILE, FileAccess.WRITE, ENCRYPTION_KEY)
	if file:
		var save_data := {
			"refresh_token": SupabaseClient.refresh_token,
			"user_id": SupabaseClient.current_user_id
		}
		file.store_string(JSON.stringify(save_data))
		file.close()

func load_saved_session() -> bool:
	if not FileAccess.file_exists(SESSION_FILE):
		return false
		
	var file := FileAccess.open_encrypted_with_pass(SESSION_FILE, FileAccess.READ, ENCRYPTION_KEY)
	if file:
		var content: String = file.get_as_text()
		file.close()
		var json := JSON.new()
		if json.parse(content) == OK and typeof(json.data) == TYPE_DICTIONARY:
			SupabaseClient.refresh_token = str(json.data.get("refresh_token", ""))
			SupabaseClient.current_user_id = str(json.data.get("user_id", ""))
			return SupabaseClient.refresh_token != ""
	return false

func refresh_access_token() -> bool:
	if SupabaseClient.refresh_token == "":
		return false
		
	var body: Dictionary = {
		"refresh_token": SupabaseClient.refresh_token
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/auth/v1/token?grant_type=refresh_token", HTTPClient.METHOD_POST, body, false)
	if res["success"] and typeof(res["data"]) == TYPE_DICTIONARY:
		var data: Dictionary = res["data"]
		_save_session(data)
		return true
	return false