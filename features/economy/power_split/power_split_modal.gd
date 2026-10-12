# res://features/economy/power_split/power_split_modal.gd
extends Control

@onready var split_slider: HSlider = $Center/Panel/Margin/VBox/SliderBox/SplitSlider
@onready var split_watt_lbl: Label = $Center/Panel/Margin/VBox/GaugeRow/WattGauge/Margin/VBox/HBox/WattPercent
@onready var split_kilo_lbl: Label = $Center/Panel/Margin/VBox/GaugeRow/KiloGauge/Margin/VBox/HBox/KiloPercent
@onready var split_cooldown_lbl: Label = $Center/Panel/Margin/VBox/CooldownLabel
@onready var save_btn: Button = $Center/Panel/Margin/VBox/Buttons/SaveBtn
@onready var close_btn: Button = $Center/Panel/Margin/VBox/Buttons/CloseBtn

func _ready() -> void:
	close_btn.pressed.connect(func(): visible = false)
	save_btn.pressed.connect(_on_save_pressed)
	split_slider.value_changed.connect(_on_slider_changed)

func open_modal() -> void:
	split_slider.value = GameManager.mining_split_watt
	_update_labels(GameManager.mining_split_watt)
	_refresh_cooldown_ui()
	visible = true

func _on_slider_changed(val: float) -> void:
	_update_labels(val)

func _update_labels(val: float) -> void:
	split_watt_lbl.text = "%d%% WATT (x1,000)" % int(val)
	split_kilo_lbl.text = "%d%% KILOWAT" % int(100.0 - val)

func _refresh_cooldown_ui() -> void:
	var rem: int = GameManager.get_remaining_split_cooldown()
	if rem > 0:
		var h: int = int(float(rem) / 3600.0)
		var m: int = int(float(rem % 3600) / 60.0)
		var s: int = rem % 60
		split_cooldown_lbl.text = "⏳ CIRCUITO BLOQUEADO: Espera %02d:%02d:%02d para volver a calibrar." % [h, m, s]
		split_cooldown_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		split_slider.editable = false
		save_btn.disabled = true
	else:
		split_cooldown_lbl.text = "✓ CIRCUITO DISPONIBLE: Puedes ajustar el flujo ahora (Bloqueo de 6h tras guardar)."
		split_cooldown_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
		split_slider.editable = true
		save_btn.disabled = false

func _on_save_pressed() -> void:
	save_btn.disabled = true
	var res = await GameManager.save_mining_split_secure(split_slider.value)
	if res.get("success", false):
		visible = false
	else:
		_refresh_cooldown_ui()