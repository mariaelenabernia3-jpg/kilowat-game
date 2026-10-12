# res://features/intro/splash_intro.gd
extends Control

const NEXT_SCENE_PATH: String = "res://features/room/main_room.tscn"

# =========================================================================
# ⏱️ TIEMPOS EXACTOS DE LECTURA (En segundos reales)
# =========================================================================
const SEGUNDOS_LECTURA_DZM: float = 2.0        # Tiempo en pantalla para DZM Studio
const SEGUNDOS_LECTURA_CLAN: float = 2.0       # Tiempo en pantalla para ClanHater
const SEGUNDOS_LECTURA_KILOWAT: float = 2.3    # Tiempo en pantalla para KILOWAT

# Nodos
@onready var background_rect: ColorRect = $Background
@onready var particles: CPUParticles2D = $Particles
@onready var skip_label: Label = $SkipLabel
@onready var flash_overlay: ColorRect = $FlashOverlay

# Cartel 1: DZM Studio
@onready var card_dzm: VBoxContainer = $Center/CardDZM
@onready var title_dzm: Label = $Center/CardDZM/TitleDZM
@onready var sub_dzm: Label = $Center/CardDZM/SubDZM

# Cartel 2: ClanHater Project
@onready var card_clanhater: VBoxContainer = $Center/CardClanHater
@onready var badge_clanhater: Label = $Center/CardClanHater/BadgeClanHater
@onready var title_clanhater: Label = $Center/CardClanHater/TitleClanHater

# Cartel 3: KILOWAT
@onready var card_kilowat: VBoxContainer = $Center/CardKilowat
@onready var logo_kilowat: Label = $Center/CardKilowat/LogoKilowat
@onready var sub_kilowat: Label = $Center/CardKilowat/SubKilowat

var has_skipped: bool = false

func _ready() -> void:
	# Inicializar todos los carteles ocultos
	card_dzm.modulate.a = 0.0
	card_dzm.scale = Vector2(0.75, 0.75)
	card_dzm.visible = true
	
	card_clanhater.modulate.a = 0.0
	card_clanhater.scale = Vector2(0.75, 0.75)
	card_clanhater.visible = true
	
	card_kilowat.modulate.a = 0.0
	card_kilowat.scale = Vector2(0.75, 0.75)
	card_kilowat.visible = true
	
	flash_overlay.modulate.a = 0.0
	skip_label.modulate.a = 0.0
	particles.emitting = false

	# Indicador sutil de salto tras 1 segundo
	var skip_tween := create_tween()
	skip_tween.tween_property(skip_label, "modulate:a", 0.45, 0.8).set_delay(1.0)

	# Iniciar la secuencia paso a paso
	_run_cinematic()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_skip_to_updater()
	elif event is InputEventMouseButton and event.pressed:
		_skip_to_updater()
	elif event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode in [KEY_SPACE, KEY_ENTER, KEY_ESCAPE]:
			_skip_to_updater()

func _run_cinematic() -> void:
	# Pausa inicial en negro
	await get_tree().create_timer(0.2).timeout
	if has_skipped: return

	# =========================================================================
	# 1. DZM STUDIO
	# =========================================================================
	var t1 := create_tween().set_parallel(true)
	t1.tween_property(card_dzm, "modulate:a", 1.0, 0.4)
	t1.tween_property(card_dzm, "scale", Vector2.ONE, 0.45)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await t1.finished
	if has_skipped: return

	# ⏳ TIEMPO GARANTIZADO DE LECTURA (2.0 segundos sin desaparecer)
	await get_tree().create_timer(SEGUNDOS_LECTURA_DZM).timeout
	if has_skipped: return

	# Salida suave
	var t1_out := create_tween().set_parallel(true)
	t1_out.tween_property(card_dzm, "modulate:a", 0.0, 0.3)
	t1_out.tween_property(card_dzm, "scale", Vector2(1.08, 1.08), 0.3)
	await t1_out.finished
	if has_skipped: return

	# Pausa de transición entre carteles
	await get_tree().create_timer(0.35).timeout
	if has_skipped: return

	# =========================================================================
	# 2. CLANHATER PROJECT
	# =========================================================================
	var t2 := create_tween().set_parallel(true)
	t2.tween_property(card_clanhater, "modulate:a", 1.0, 0.4)
	t2.tween_property(card_clanhater, "scale", Vector2.ONE, 0.45)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await t2.finished
	if has_skipped: return

	# Efecto de brillo neón en el badge
	var pulse := create_tween().set_loops(2)
	pulse.tween_property(badge_clanhater, "modulate:a", 0.4, 0.35)
	pulse.tween_property(badge_clanhater, "modulate:a", 1.0, 0.35)

	# ⏳ TIEMPO GARANTIZADO DE LECTURA (2.0 segundos sin desaparecer)
	await get_tree().create_timer(SEGUNDOS_LECTURA_CLAN).timeout
	if has_skipped: return

	# Salida suave
	var t2_out := create_tween().set_parallel(true)
	t2_out.tween_property(card_clanhater, "modulate:a", 0.0, 0.3)
	t2_out.tween_property(card_clanhater, "scale", Vector2(0.92, 0.92), 0.3)
	await t2_out.finished
	if has_skipped: return

	# Pausa previa al logotipo principal
	await get_tree().create_timer(0.4).timeout
	if has_skipped: return

	# =========================================================================
	# 3. KILOWAT (Impacto Eléctrico)
	# =========================================================================
	# Disparo de partículas y temblor
	particles.amount = 45
	particles.emitting = true
	particles.restart()
	_shake_camera()

	# Flash de alto voltaje
	var flash := create_tween()
	flash.tween_property(flash_overlay, "modulate:a", 0.85, 0.07)
	flash.tween_property(flash_overlay, "modulate:a", 0.0, 0.28)

	# Golpe de entrada de KILOWAT
	var t3 := create_tween().set_parallel(true)
	t3.tween_property(card_kilowat, "modulate:a", 1.0, 0.3)
	t3.tween_property(card_kilowat, "scale", Vector2.ONE, 0.45)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await t3.finished
	if has_skipped: return

	# ⏳ TIEMPO GARANTIZADO DE LECTURA (2.3 segundos para apreciar el juego)
	await get_tree().create_timer(SEGUNDOS_LECTURA_KILOWAT).timeout
	if has_skipped: return

	# Transición limpia hacia el actualizador OTA
	var t_final := create_tween().set_parallel(true)
	t_final.tween_property(card_kilowat, "modulate:a", 0.0, 0.45)
	t_final.tween_property(skip_label, "modulate:a", 0.0, 0.25)
	t_final.tween_property(particles, "modulate:a", 0.0, 0.45)
	await t_final.finished
	if has_skipped: return

	_go_to_updater()

func _shake_camera() -> void:
	var original_pos := position
	var shake_tween := create_tween()
	for i in range(6):
		var offset := Vector2(randf_range(-10.0, 10.0), randf_range(-7.0, 7.0))
		shake_tween.tween_property(self, "position", original_pos + offset, 0.025)
	shake_tween.tween_property(self, "position", original_pos, 0.025)

func _skip_to_updater() -> void:
	if has_skipped: return
	has_skipped = true
	
	var fade_fast := create_tween()
	fade_fast.tween_property(self, "modulate:a", 0.0, 0.15)
	fade_fast.tween_callback(_go_to_updater)

func _go_to_updater() -> void:
	get_tree().change_scene_to_file.call_deferred(NEXT_SCENE_PATH)
