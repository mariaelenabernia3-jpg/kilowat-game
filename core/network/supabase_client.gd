# res://core/network/supabase_client.gd
extends Node

# Configuración del proyecto Supabase
const SUPABASE_URL: String = "https://uncrcxoaerxsqqbumxtv.supabase.co"
const SUPABASE_ANON_KEY: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVuY3JjeG9hZXJ4c3FxYnVteHR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAwMTEzMTEsImV4cCI6MjEwNTU4NzMxMX0.AGtx7A1PGvFjXT-ZaCcsZXpUxrKPds3vFKTh5yLjRio"

# Tiempo máximo de espera en segundos (Vital para conexiones inestables)
const REQUEST_TIMEOUT_SECONDS: float = 12.0

# Variables de sesión en memoria
var access_token: String = ""
var refresh_token: String = ""
var current_user_id: String = ""

func get_headers(use_auth: bool = true) -> PackedStringArray:
	var clean_anon: String = SUPABASE_ANON_KEY.strip_edges()
	var bearer_token: String = access_token.strip_edges() if (use_auth and access_token != "") else clean_anon
	
	return PackedStringArray([
		"Content-Type: application/json",
		"apikey: " + clean_anon,
		"Authorization: Bearer " + bearer_token
	])

## Envía peticiones HTTP asíncronas con timeout controlado y manejo robusto de errores
func send_request(endpoint: String, method: HTTPClient.Method, body_dict: Dictionary = {}, use_auth: bool = true) -> Dictionary:
	var http_request := HTTPRequest.new()
	http_request.timeout = REQUEST_TIMEOUT_SECONDS
	add_child(http_request)
	
	var url: String = SUPABASE_URL + endpoint
	var headers: PackedStringArray = get_headers(use_auth)
	var body_string: String = ""
	
	if method != HTTPClient.METHOD_GET and not body_dict.is_empty():
		body_string = JSON.stringify(body_dict)
		
	var err: Error = http_request.request(url, headers, method, body_string)
	if err != OK:
		http_request.queue_free()
		return {"success": false, "status": 0, "data": {}, "error": "Error interno al iniciar petición HTTP (%d)" % err}
		
	var response: Array = await http_request.request_completed
	http_request.queue_free()
	
	var result: int = response[0]
	var response_code: int = response[1]
	var response_body: PackedByteArray = response[3]
	
	if result != HTTPRequest.RESULT_SUCCESS:
		var network_msg = "Error de conexión o tiempo de espera agotado."
		if result == HTTPRequest.RESULT_TIMEOUT:
			network_msg = "Tiempo de conexión agotado. Revisa tu señal de red."
		return {"success": false, "status": response_code, "data": {}, "error": network_msg}
		
	var json_str: String = response_body.get_string_from_utf8()
	var json_parser := JSON.new()
	var parse_err: Error = json_parser.parse(json_str)
	var response_data = json_parser.data if parse_err == OK else {}
	
	if response_code >= 200 and response_code < 300:
		return {"success": true, "status": response_code, "data": response_data, "error": ""}
	else:
		var err_msg: String = "Error en el servidor (%d)" % response_code
		if typeof(response_data) == TYPE_DICTIONARY:
			if response_data.has("msg"):
				err_msg = str(response_data["msg"])
			elif response_data.has("message"):
				err_msg = str(response_data["message"])
			elif response_data.has("error_description"):
				err_msg = str(response_data["error_description"])
			elif response_data.has("error"):
				err_msg = str(response_data["error"])
		elif typeof(response_data) == TYPE_STRING and response_data != "":
			err_msg = response_data
		return {"success": false, "status": response_code, "data": response_data, "error": err_msg}