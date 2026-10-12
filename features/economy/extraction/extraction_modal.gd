# res://features/economy/extraction/extraction_modal.gd
extends Control

const WHATSAPP_PHONE: String = "5356471292"

@onready var balance_lbl: Label = $Center/Panel/Margin/VBox/BalanceRow/BalanceVal
@onready var invoice_details_lbl: Label = $Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox/InvoiceDetailsLabel
@onready var payout_amount_lbl: Label = $Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox/PayoutRow/PayoutAmountLabel
@onready var status_msg: Label = $Center/Panel/Margin/VBox/StatusMsg
@onready var close_btn: Button = $Center/Panel/Margin/VBox/Buttons/CloseBtn
@onready var action_btn: Button = $Center/Panel/Margin/VBox/Buttons/ActionBtn

func _ready() -> void:
	close_btn.pressed.connect(func(): visible = false)
	action_btn.pressed.connect(_process_extraction)

func open_modal() -> void:
	var raw_kilo: float = GameManager.kilowat
	var fee_kilo: float = raw_kilo * 0.10
	var net_kilo: float = maxf(0.0, raw_kilo - fee_kilo)
	var cup_total: int = int(net_kilo * 500.0)
	
	balance_lbl.text = "%.6f KW  ➔  %d CUP" % [raw_kilo, cup_total]
	invoice_details_lbl.text = "• Saldo Bruto: %.6f KW\n• Tarifa de Mantenimiento (10%%): -%.6f KW\n• Saldo Neto a Liquidar: %.6f KW" % [raw_kilo, fee_kilo, net_kilo]
	payout_amount_lbl.text = "$ %d CUP" % cup_total
	
	if raw_kilo >= 5.0:
		status_msg.text = "✓ Fondos suficientes para retiro inmediato (Mínimo: 5 KW)."
		status_msg.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
		action_btn.disabled = false
	else:
		status_msg.text = "⚠️ Mínimo de retiro: 5 KILOWAT (Te faltan %.4f KW)." % (5.0 - raw_kilo)
		status_msg.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		action_btn.disabled = true
		
	visible = true

func _process_extraction() -> void:
	action_btn.disabled = true
	status_msg.text = "Verificando saldo en la central..."
	
	var ok: bool = await GameManager.load_profile()
	if not ok or GameManager.kilowat < 5.0:
		status_msg.text = "⚠️ Saldo insuficiente en el servidor. Mínimo 5 KILOWAT."
		status_msg.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		action_btn.disabled = true
		return
		
	visible = false
	var raw_kilo: float = GameManager.kilowat
	var fee_kilo: float = raw_kilo * 0.10
	var net_kilo: float = maxf(0.0, raw_kilo - fee_kilo)
	var cup_total: int = int(net_kilo * 500.0)
	
	var raw_msg: String = "Hola, solicito la extracción de mis fondos en KILOWAT.\n" \
		+ "• Usuario: %s\n" % GameManager.username \
		+ "• Saldo Bruto: %.6f KILOWAT\n" % raw_kilo \
		+ "• Tarifa de Red (10%%): -%.6f KILOWAT\n" % fee_kilo \
		+ "• Total Neto: %.6f KILOWAT\n" % net_kilo \
		+ "• Total a recibir en transferencia: %d CUP." % cup_total

	var wa_url: String = "https://wa.me/" + WHATSAPP_PHONE + "?text=" + raw_msg.uri_encode()
	if OS.has_feature("web"): JavaScriptBridge.eval("window.open('" + wa_url + "', '_blank');")
	else: OS.shell_open(wa_url)