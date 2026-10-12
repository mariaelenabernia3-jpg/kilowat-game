# res://core/security/integrity_verifier.gd
class_name IntegrityVerifier
extends RefCounted

## Calcula el hash SHA-256 de un archivo en disco leyendo por fragmentos de 1 MB
## Esto evita sobrecargar la memoria RAM en teléfonos modestos
static func compute_file_sha256(file_path: String) -> String:
	if not FileAccess.file_exists(file_path):
		push_warning("[IntegrityVerifier] El archivo no existe: " + file_path)
		return ""
		
	var ctx := HashingContext.new()
	var err := ctx.start(HashingContext.HASH_SHA256)
	if err != OK:
		push_error("[IntegrityVerifier] Error al iniciar el contexto SHA-256.")
		return ""
		
	var file := FileAccess.open(file_path, FileAccess.READ)
	if not file:
		push_error("[IntegrityVerifier] No se pudo abrir el archivo para lectura: " + file_path)
		return ""
		
	var chunk_size := 1024 * 1024 # 1 MB por bloque
	while file.get_position() < file.get_length():
		var remaining := file.get_length() - file.get_position()
		var bytes_to_read := mini(chunk_size, remaining)
		var buffer := file.get_buffer(bytes_to_read)
		ctx.update(buffer)
		
	var hash_bytes := ctx.finish()
	file.close()
	return hash_bytes.hex_encode().to_lower()

## Compara si el hash real del archivo en disco coincide con el hash esperado del manifiesto
static func verify_file(file_path: String, expected_hash: String) -> bool:
	if expected_hash.strip_edges() == "":
		return false
	var actual_hash := compute_file_sha256(file_path)
	if actual_hash == "":
		return false
	return actual_hash == expected_hash.strip_edges().to_lower()

## Valida la firma digital RSA-SHA256 del manifiesto
static func verify_signature(data_bytes: PackedByteArray, signature_base64: String, public_key_pem: String) -> bool:
	if signature_base64.strip_edges() == "" or public_key_pem.strip_edges() == "":
		push_warning("[IntegrityVerifier] Firma digital omitida (Modo desarrollo).")
		return true
		
	var crypto := Crypto.new()
	var pub_key := CryptoKey.new()
	var err := pub_key.load_from_string(public_key_pem, true)
	if err != OK:
		push_error("[IntegrityVerifier] La clave pública RSA no tiene formato PEM válido.")
		return false
		
	var signature_bytes := Marshalls.base64_to_raw(signature_base64)
	if signature_bytes.is_empty():
		push_error("[IntegrityVerifier] La firma Base64 está corrupta.")
		return false
		
	var ctx := HashingContext.new()
	var start_err := ctx.start(HashingContext.HASH_SHA256)
	if start_err != OK:
		push_error("[IntegrityVerifier] Error al iniciar contexto de hash.")
		return false
		
	ctx.update(data_bytes)
	var hash_bytes: PackedByteArray = ctx.finish()
	return crypto.verify(HashingContext.HASH_SHA256, hash_bytes, signature_bytes, pub_key)