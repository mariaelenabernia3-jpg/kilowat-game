# res://core/network/http_downloader.gd
class_name HttpDownloader
extends Node

signal progress_changed(downloaded_bytes: int, total_bytes: int, speed_bytes_sec: float)
signal download_finished(success: bool, error_msg: String)

var http_client: HTTPClient
var file_handle: FileAccess

var is_downloading: bool = false
var is_paused: bool = false

var current_url: String = ""
var destination_file: String = ""
var temp_file_path: String = ""

var expected_file_size: int = 0
var current_downloaded_bytes: int = 0
var initial_offset_bytes: int = 0

var speed_timer: float = 0.0
var bytes_received_tick: int = 0
var current_speed: float = 0.0

func _init() -> void:
	http_client = HTTPClient.new()

## Inicia la descarga con soporte de reanudación si se cayó la conexión
func start_download(url: String, dest_path: String, total_size: int = 0) -> void:
	current_url = url
	destination_file = dest_path
	temp_file_path = dest_path + ".download"
	expected_file_size = total_size
	is_paused = false
	is_downloading = true
	bytes_received_tick = 0
	current_speed = 0.0
	speed_timer = 0.0
	_connect_and_request()

func pause() -> void:
	if not is_downloading: return
	is_paused = true
	is_downloading = false
	_close_file()
	http_client.close()
	download_finished.emit(false, "Descarga pausada por el usuario.")

func resume() -> void:
	if is_downloading: return
	is_paused = false
	is_downloading = true
	_connect_and_request()

func cancel() -> void:
	is_downloading = false
	is_paused = false
	_close_file()
	http_client.close()
	if FileAccess.file_exists(temp_file_path):
		DirAccess.remove_absolute(temp_file_path)
	download_finished.emit(false, "Descarga cancelada.")

func _connect_and_request() -> void:
	current_downloaded_bytes = 0
	initial_offset_bytes = 0
	
	if FileAccess.file_exists(temp_file_path):
		var tf := FileAccess.open(temp_file_path, FileAccess.READ)
		if tf:
			current_downloaded_bytes = tf.get_length()
			initial_offset_bytes = current_downloaded_bytes
			tf.close()

	if expected_file_size > 0 and current_downloaded_bytes >= expected_file_size:
		_complete_download()
		return

	var regex := RegEx.new()
	regex.compile("^(https?)://([^/:]+)(?::(\\d+))?(.*)$")
	var match_res := regex.search(current_url)
	if not match_res:
		_abort("URL de descarga no válida: " + current_url)
		return
		
	var scheme := match_res.get_string(1)
	var host := match_res.get_string(2)
	var port_str := match_res.get_string(3)
	var path_str := match_res.get_string(4)
	if path_str == "": path_str = "/"
	var port := 443 if scheme == "https" else 80
	if port_str != "": port = port_str.to_int()

	var tls_opts: TLSOptions = TLSOptions.client() if scheme == "https" else null
	var err := http_client.connect_to_host(host, port, tls_opts)
	if err != OK:
		_abort("No se pudo conectar con el host: " + host)
		return

	while http_client.get_status() == HTTPClient.STATUS_CONNECTING or http_client.get_status() == HTTPClient.STATUS_RESOLVING:
		http_client.poll()
		await get_tree().process_frame

	if http_client.get_status() != HTTPClient.STATUS_CONNECTED:
		_abort("Error al conectar (Estado: %d)" % http_client.get_status())
		return

	var headers := PackedStringArray(["User-Agent: Kilowat-Downloader/1.0", "Accept: */*"])
	if current_downloaded_bytes > 0:
		headers.append("Range: bytes=%d-" % current_downloaded_bytes)
		file_handle = FileAccess.open(temp_file_path, FileAccess.READ_WRITE)
		if file_handle: file_handle.seek_end()
	else:
		file_handle = FileAccess.open(temp_file_path, FileAccess.WRITE)

	if not file_handle:
		_abort("No se pudo abrir el archivo temporal: " + temp_file_path)
		return

	var req_err := http_client.request(HTTPClient.METHOD_GET, path_str, headers)
	if req_err != OK:
		_abort("Error al enviar la petición HTTP GET.")

func _process(delta: float) -> void:
	if not is_downloading or is_paused: return
	http_client.poll()
	var status := http_client.get_status()
	
	speed_timer += delta
	if speed_timer >= 1.0:
		current_speed = float(bytes_received_tick) / speed_timer
		bytes_received_tick = 0
		speed_timer = 0.0

	match status:
		HTTPClient.STATUS_DISCONNECTED, HTTPClient.STATUS_CONNECTION_ERROR:
			_abort("Conexión perdida durante la descarga.")
		HTTPClient.STATUS_BODY:
			var resp_code := http_client.get_response_code()
			if resp_code != 200 and resp_code != 206:
				_abort("El servidor rechazó la descarga (Código: %d)" % resp_code)
				return

			if expected_file_size <= 0:
				var resp_headers := http_client.get_response_headers_as_dictionary()
				if resp_headers.has("content-length"):
					expected_file_size = current_downloaded_bytes + int(resp_headers["content-length"])

			while http_client.get_status() == HTTPClient.STATUS_BODY:
				var chunk := http_client.read_response_body_chunk()
				if chunk.size() == 0: break
				file_handle.store_buffer(chunk)
				current_downloaded_bytes += chunk.size()
				bytes_received_tick += chunk.size()
				progress_changed.emit(current_downloaded_bytes, expected_file_size, current_speed)
				http_client.poll()
				
		HTTPClient.STATUS_CONNECTED:
			_complete_download()

func _complete_download() -> void:
	is_downloading = false
	_close_file()
	http_client.close()
	if FileAccess.file_exists(destination_file):
		DirAccess.remove_absolute(destination_file)
	var err := DirAccess.rename_absolute(temp_file_path, destination_file)
	if err != OK:
		_abort("Error al renombrar el archivo temporal.")
		return
	download_finished.emit(true, "")

func _abort(msg: String) -> void:
	is_downloading = false
	_close_file()
	http_client.close()
	download_finished.emit(false, msg)

func _close_file() -> void:
	if file_handle:
		file_handle.flush()
		file_handle.close()
		file_handle = null