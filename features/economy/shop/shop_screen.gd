# res://features/economy/shop/shop_screen.gd
extends Control

const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")
const CHIP_ICON: Texture2D = preload("res://assets/sprites/ui/icon_chip.png")
const WHATSAPP_PHONE: String = "5356471292"
const OFFER_FILE: String = "user://cyber_tank_offer.json"

# Cabecera
@onready var back_btn: Button = $CanvasLayer/MainVBox/TopBar/Margin/HBox/BackBtn
@onready var watt_lbl: Label = $CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/WattPill/Margin/HBox/WattLabel
@onready var kilo_lbl: Label = $CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_lbl: Label = $CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/ChipPill/Margin/HBox/ChipLabel

# Selector de Categorías
@onready var tab_generators: Button = $CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox/TabGenerators
@onready var tab_racks: Button = $CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox/TabRacks
@onready var tab_currency: Button = $CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox/TabCurrency
@onready var tab_offers: Button = $CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox/TabOffers

# Catálogo
@onready var items_grid: GridContainer = $CanvasLayer/MainVBox/ContentScroll/Margin/ItemsGrid
@onready var empty_msg: Label = $CanvasLayer/MainVBox/ContentScroll/Margin/EmptyLabel

# Modales
@onready var confirm_modal: Control = $CanvasLayer/ConfirmModal
@onready var modal_title: Label = $CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/Title
@onready var modal_description: Label = $CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/Description
@onready var modal_price_lbl: Label = $CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/PriceBox/HBox/PriceText
@onready var modal_price_icon: TextureRect = $CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/PriceBox/HBox/PriceIcon
@onready var modal_confirm_btn: Button = $CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/Buttons/ConfirmBtn
@onready var modal_cancel_btn: Button = $CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/Buttons/CancelBtn

@onready var desc_modal: Control = $CanvasLayer/DescModal
@onready var desc_title: Label = $CanvasLayer/DescModal/Center/Panel/Margin/VBox/Title
@onready var desc_img: TextureRect = $CanvasLayer/DescModal/Center/Panel/Margin/VBox/ImgBox/Texture
@onready var desc_rarity: Label = $CanvasLayer/DescModal/Center/Panel/Margin/VBox/RarityLabel
@onready var desc_power: Label = $CanvasLayer/DescModal/Center/Panel/Margin/VBox/PowerLabel
@onready var desc_text: Label = $CanvasLayer/DescModal/Center/Panel/Margin/VBox/DescText
@onready var desc_close_btn: Button = $CanvasLayer/DescModal/Center/Panel/Margin/VBox/CloseBtn

var current_category: String = "generators"
var selected_item: Dictionary = {}

const RARITY_COLORS = {
	"Común": Color(0.35, 0.75, 1.0),
	"Raro": Color(0.2, 0.85, 0.45),
	"Épico": Color(0.8, 0.35, 1.0),
	"Legendario": Color(1.0, 0.82, 0.15),
	"Moneda": Color(0.3, 0.95, 0.7),
	"Combo": Color(1.0, 0.5, 0.2),
	"Casino": Color(1.0, 0.45, 0.85)
}

func _ready() -> void:
	if watt_lbl == null: watt_lbl = find_child("WattLabel", true, false)
	if kilo_lbl == null: kilo_lbl = find_child("KiloLabel", true, false)
	if chip_lbl == null: chip_lbl = find_child("ChipLabel", true, false)
	
	back_btn.pressed.connect(_on_back_pressed)
	
	tab_generators.pressed.connect(func(): _switch_tab("generators"))
	tab_racks.pressed.connect(func(): _switch_tab("racks"))
	tab_currency.pressed.connect(func(): _switch_tab("currency"))
	tab_offers.pressed.connect(func(): _switch_tab("offers"))
	
	modal_cancel_btn.pressed.connect(func(): confirm_modal.visible = false)
	modal_confirm_btn.pressed.connect(_execute_purchase)
	desc_close_btn.pressed.connect(func(): desc_modal.visible = false)
	
	_update_hud()
	_switch_tab(GameManager.target_shop_category if GameManager.target_shop_category != "" else "generators")
	GameManager.target_shop_category = "generators"

func _process(_delta: float) -> void:
	_update_hud()

func _update_hud() -> void:
	if watt_lbl and is_instance_valid(watt_lbl):
		watt_lbl.text = "%.4f" % GameManager.watt
	if kilo_lbl and is_instance_valid(kilo_lbl):
		kilo_lbl.text = "%.6f" % GameManager.kilowat
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://features/room/main_room.tscn")

func _switch_tab(cat_name: String) -> void:
	current_category = cat_name
	
	var tabs = {
		"generators": tab_generators,
		"racks": tab_racks,
		"currency": tab_currency,
		"offers": tab_offers
	}
	for key in tabs.keys():
		var btn: Button = tabs[key]
		var is_active = (key == current_category)
		btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if is_active else Color(0.7, 0.75, 0.85))
		
		var st := StyleBoxFlat.new()
		st.bg_color = Color(0.12, 0.16, 0.24, 0.95) if is_active else Color(0.06, 0.08, 0.12, 0.7)
		st.border_color = Color(0.3, 0.85, 1.0) if is_active else Color(0.18, 0.22, 0.3)
		st.border_width_bottom = 3 if is_active else 0
		st.set_corner_radius_all(6)
		btn.add_theme_stylebox_override("normal", st)
		btn.add_theme_stylebox_override("hover", st)
		
	_populate_grid()

func _populate_grid() -> void:
	for child in items_grid.get_children(): child.queue_free()
	var catalog = _get_catalog(current_category)
	
	if catalog.is_empty():
		empty_msg.visible = true
		if current_category == "offers":
			empty_msg.text = "¡Ya has adquirido la oferta especial o ha expirado!"
		else:
			empty_msg.text = "Próximamente nuevos suministros en esta sección."
	else:
		empty_msg.visible = false
		for item in catalog:
			items_grid.add_child(_build_item_card(item))

func _build_item_card(item: Dictionary) -> PanelContainer:
	var rarity = str(item.get("rarity", "Común"))
	var border_color: Color = RARITY_COLORS.get(rarity, Color(0.4, 0.5, 0.6))
	var is_fiat: bool = bool(item.get("is_fiat", false))
	var cur: String = str(item.get("currency", "watt"))
	var item_id: String = str(item.get("id", ""))
	var is_chip: bool = "chip" in item_id
	
	# Solo el Cyber Tank tiene límite de compra única en la tienda
	var is_limit_reached: bool = false
	if item_id == "cyber_tank" and GameManager.get_owned_generator_count("cyber_tank") >= 1:
		is_limit_reached = true
	
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(230, 320)
	
	var card_style := StyleBoxFlat.new()
	card_style.bg_color = Color(0.08, 0.10, 0.14, 0.95)
	card_style.border_color = border_color
	card_style.set_border_width_all(2)
	card_style.set_corner_radius_all(10)
	card_style.shadow_color = Color(border_color.r, border_color.g, border_color.b, 0.25)
	card_style.shadow_size = 8
	card.add_theme_stylebox_override("panel", card_style)
	
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 12)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 12)
	margin.add_theme_constant_override("margin_bottom", 12)
	card.add_child(margin)
	
	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	margin.add_child(vbox)
	
	# Encabezado: Rareza y Nombre
	var tag_lbl := Label.new()
	tag_lbl.text = "★ " + rarity.to_upper()
	tag_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	tag_lbl.add_theme_font_size_override("font_size", 10)
	tag_lbl.add_theme_color_override("font_color", border_color)
	vbox.add_child(tag_lbl)
	
	var title_lbl := Label.new()
	title_lbl.text = str(item.get("name", "Artículo"))
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_lbl.add_theme_font_size_override("font_size", 13)
	title_lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0))
	vbox.add_child(title_lbl)
	
	# Vista previa de la imagen
	var img_btn := Button.new()
	img_btn.custom_minimum_size = Vector2(0, 100)
	img_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var img_st := StyleBoxFlat.new()
	img_st.bg_color = Color(0.05, 0.06, 0.09, 0.9)
	img_st.border_color = Color(0.18, 0.25, 0.35, 0.6)
	img_st.set_border_width_all(1)
	img_st.set_corner_radius_all(8)
	img_btn.add_theme_stylebox_override("normal", img_st)
	img_btn.add_theme_stylebox_override("hover", img_st)
	
	var tex_rect := TextureRect.new()
	tex_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	tex_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	tex_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	tex_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var t_path = str(item.get("texture_path", ""))
	if ResourceLoader.exists(t_path): tex_rect.texture = load(t_path)
	img_btn.add_child(tex_rect)
	img_btn.pressed.connect(func(): _open_desc(item))
	vbox.add_child(img_btn)
	
	# Estadística / Descripción Corta
	var stat_pill := PanelContainer.new()
	var sp_st := StyleBoxFlat.new()
	sp_st.bg_color = Color(0.12, 0.15, 0.22, 0.8)
	sp_st.set_corner_radius_all(6)
	stat_pill.add_theme_stylebox_override("panel", sp_st)
	
	var stat_lbl := Label.new()
	stat_lbl.text = str(item.get("stat_desc", ""))
	stat_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	stat_lbl.add_theme_font_size_override("font_size", 10)
	stat_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	stat_pill.add_child(stat_lbl)
	vbox.add_child(stat_pill)
	
	vbox.add_spacer(false)
	
	# Botón de Compra
	var buy_btn := Button.new()
	buy_btn.custom_minimum_size = Vector2(0, 42)
	buy_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	var btn_st := StyleBoxFlat.new()
	var font_c: Color = Color(0.06, 0.08, 0.12)
	
	if is_limit_reached:
		btn_st.bg_color = Color(0.15, 0.18, 0.24, 0.9)
		btn_st.border_color = Color(0.3, 0.35, 0.45)
		font_c = Color(0.65, 0.7, 0.8)
		buy_btn.disabled = true
	elif is_fiat:
		btn_st.bg_color = Color(0.12, 0.75, 0.45, 1.0)
		btn_st.border_color = Color(0.4, 1.0, 0.6, 1.0)
		font_c = Color(0.02, 0.15, 0.06)
	elif rarity == "Casino" or is_chip:
		btn_st.bg_color = Color(0.85, 0.15, 0.55, 1.0)
		btn_st.border_color = Color(1.0, 0.5, 0.85, 1.0)
		font_c = Color(1.0, 0.95, 1.0)
	elif cur == "kilowat":
		btn_st.bg_color = Color(1.0, 0.82, 0.15, 1.0)
		btn_st.border_color = Color(1.0, 0.95, 0.6, 1.0)
		font_c = Color(0.12, 0.08, 0.01)
	else:
		btn_st.bg_color = Color(0.15, 0.70, 0.95, 1.0)
		btn_st.border_color = Color(0.5, 0.9, 1.0, 1.0)
		font_c = Color(0.02, 0.10, 0.18)
		
	btn_st.set_border_width_all(2)
	btn_st.set_corner_radius_all(6)
	buy_btn.add_theme_stylebox_override("normal", btn_st)
	buy_btn.add_theme_stylebox_override("hover", btn_st)
	buy_btn.add_theme_stylebox_override("disabled", btn_st)
	
	var btn_hbox := HBoxContainer.new()
	btn_hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	btn_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	btn_hbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	btn_hbox.add_theme_constant_override("separation", 8)
	
	if not is_limit_reached:
		var btn_ico := TextureRect.new()
		btn_ico.custom_minimum_size = Vector2(22, 22)
		btn_ico.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		btn_ico.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		btn_ico.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		if is_chip or rarity == "Casino":
			btn_ico.texture = CHIP_ICON
		elif cur == "kilowat" or ("kilo" in item_id):
			btn_ico.texture = KILOWAT_ICON
		else:
			btn_ico.texture = WATT_ICON
			
		btn_hbox.add_child(btn_ico)
	
	var btn_text_lbl := Label.new()
	if is_limit_reached:
		btn_text_lbl.text = "🔒 YA ADQUIRIDO (1/1)"
	elif is_fiat:
		btn_text_lbl.text = "%s • COMPRAR" % str(item.get("fiat_price"))
	else:
		var c_name = "W" if cur == "watt" else "KW"
		btn_text_lbl.text = "%s %s • COMPRAR" % [str(item.get("price")), c_name]
		
	btn_text_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
	btn_text_lbl.add_theme_font_size_override("font_size", 12)
	btn_text_lbl.add_theme_color_override("font_color", font_c)
	btn_hbox.add_child(btn_text_lbl)
	
	buy_btn.add_child(btn_hbox)
	if not is_limit_reached:
		buy_btn.pressed.connect(func(): _open_confirm(item))
	vbox.add_child(buy_btn)
	
	return card

func _open_desc(item: Dictionary) -> void:
	desc_title.text = str(item.get("name", "")).to_upper()
	var t_path = str(item.get("texture_path", ""))
	if ResourceLoader.exists(t_path): desc_img.texture = load(t_path)
	
	var r = str(item.get("rarity", "Común"))
	desc_rarity.text = "★ RAREZA: " + r.to_upper()
	desc_rarity.add_theme_color_override("font_color", RARITY_COLORS.get(r, Color.WHITE))
	desc_power.text = "⚡ " + str(item.get("stat_desc", ""))
	desc_text.text = str(item.get("description", "Equipo de alta eficiencia para tu habitación."))
	desc_modal.visible = true

func _open_confirm(item: Dictionary) -> void:
	selected_item = item
	var item_id = str(item.get("id", ""))
	var is_chip = "chip" in item_id
	
	if bool(item.get("is_fiat", false)):
		modal_title.text = "⚡ COMPRA POR TRANSFERENCIA"
		modal_description.text = "Solicita %s mediante transferencia bancaria (EnZona o Transfermóvil):\n\n• Precio exacto sin comisiones: %s" % [
			str(item.get("name")), str(item.get("fiat_price"))
		]
		modal_price_lbl.text = str(item.get("fiat_price"))
		modal_price_icon.texture = CHIP_ICON if is_chip else (KILOWAT_ICON if "kilo" in item_id else WATT_ICON)
		modal_confirm_btn.text = "📲 Contactar por WhatsApp"
	else:
		var cur_name = "WATT" if item.get("currency") == "watt" else "KILOWAT"
		modal_title.text = "⚡ CONFIRMAR COMPRA"
		modal_description.text = "¿Deseas adquirir %s con tu saldo disponible?\n\n• Precio: %s %s" % [
			str(item.get("name")), str(item.get("price")), cur_name
		]
		modal_price_lbl.text = "%s %s" % [str(item.get("price")), cur_name]
		modal_price_icon.texture = CHIP_ICON if is_chip else (WATT_ICON if item.get("currency") == "watt" else KILOWAT_ICON)
		modal_confirm_btn.text = "✓ Confirmar y Pagar"
		
	confirm_modal.visible = true

func _execute_purchase() -> void:
	confirm_modal.visible = false
	if bool(selected_item.get("is_fiat", false)):
		var raw_msg = "Hola, solicito comprar el paquete %s para la cuenta %s por %s." % [
			str(selected_item.get("name")), GameManager.username, str(selected_item.get("fiat_price"))
		]
		var wa_url = "https://wa.me/" + WHATSAPP_PHONE + "?text=" + raw_msg.uri_encode()
		if OS.has_feature("web"): JavaScriptBridge.eval("window.open('" + wa_url + "', '_blank');")
		else: OS.shell_open(wa_url)
		return

	var price: float = float(selected_item.get("price", 0.0))
	var cur: String = str(selected_item.get("currency", "watt"))
	var item_id: String = str(selected_item.get("id", ""))
	
	var res = await GameManager.buy_shop_item_secure(item_id, current_category, price, cur)
	if res.get("success", false):
		_populate_grid()
		_update_hud()

func _get_offer_remaining_seconds() -> int:
	var now: int = int(Time.get_unix_time_from_system())
	var offer_end: int = 0
	if FileAccess.file_exists(OFFER_FILE):
		var f := FileAccess.open(OFFER_FILE, FileAccess.READ)
		if f:
			var parsed = JSON.parse_string(f.get_as_text())
			if typeof(parsed) == TYPE_DICTIONARY and parsed.has("end_timestamp"):
				offer_end = int(parsed["end_timestamp"])
			f.close()
	return maxi(0, offer_end - now) if offer_end > 0 else 604800

func _get_catalog(cat: String) -> Array:
	match cat:
		"generators":
			return [
				{"id": "ecoflow_spark", "name": "EcoFlow Spark", "rarity": "Común", "stat_desc": "0.000000050 kW/min (Máx 4 en sala)", "description": "Batería portátil de inicio (Máximo 4 activas en la habitación).", "price": 0.50, "currency": "watt", "texture_path": "res://assets/sprites/generators/ecoflow_spark.png"},
				{"id": "ecoflow_spark_plus", "name": "EcoFlow Spark Plus", "rarity": "Común", "stat_desc": "0.000000100 kW/min (Máx 4 en sala)", "description": "Versión con litio (Máximo 4 activas en la habitación).", "price": 0.80, "currency": "watt", "texture_path": "res://assets/sprites/generators/ecoflow_spark_plus.png"},
				{"id": "ecoflow_thunder_pro", "name": "EcoFlow Thunder Pro", "rarity": "Épico", "stat_desc": "0.000000400 kW/min (Máx 1 en sala)", "description": "Estación pesada de titanio (Máximo 1 activa en la habitación).", "price": 0.50, "currency": "kilowat", "texture_path": "res://assets/sprites/generators/ecoflow_thunder_pro.png"},
				{"id": "ecoflow_ultra", "name": "EcoFlow Ultra", "rarity": "Legendario", "stat_desc": "0.000000600 kW/min (Máx 1 en sala)", "description": "Almacenamiento masivo industrial (Máximo 1 activa en la habitación).", "price": 0.80, "currency": "kilowat", "texture_path": "res://assets/sprites/generators/ecoflow_ultra.png"}
			]
		"racks":
			return [
				{"id": "rack_1_floor", "name": "Estantería de 1 Piso", "rarity": "Común", "stat_desc": "Capacidad: 2 Espacios", "description": "Estantería básica para tus primeras plantas.", "price": 0.6, "currency": "watt", "texture_path": "res://assets/sprites/racks/racks1.png"},
				{"id": "rack_2_floors", "name": "Estantería de 2 Pisos", "rarity": "Raro", "stat_desc": "Capacidad: 4 Espacios", "description": "Doble nivel reforzado con metal.", "price": 1.0, "currency": "watt", "texture_path": "res://assets/sprites/racks/racks2.png"},
				{"id": "rack_3_floors", "name": "Estantería de 3 Pisos", "rarity": "Épico", "stat_desc": "Capacidad: 6 Espacios", "description": "Estructura de 3 pisos para alta carga.", "price": 2.8, "currency": "watt", "texture_path": "res://assets/sprites/racks/racks3.png"}
			]
		"currency":
			return [
				# FICHAS DE CASINO (CHIPS)
				{"id": "pack_1_chip_cup", "name": "1 Ficha de Casino", "rarity": "Casino", "stat_desc": "1 Ficha (Sin comisión)", "description": "1 Ficha para apostar en Minas.", "is_fiat": true, "fiat_price": "150 CUP", "texture_path": "res://assets/sprites/ui/icon_chip.png"},
				{"id": "pack_1_chip_kilo", "name": "1 Ficha (Con Saldo)", "rarity": "Casino", "stat_desc": "1 Ficha de Casino", "description": "Usa 0.20 KILOWAT de tu saldo.", "price": 0.20, "currency": "kilowat", "texture_path": "res://assets/sprites/ui/icon_chip.png"},
				{"id": "pack_3_chips_cup", "name": "3 Fichas de Casino", "rarity": "Casino", "stat_desc": "3 Fichas (Sin comisión)", "description": "3 Fichas para apostar en Minas.", "is_fiat": true, "fiat_price": "400 CUP", "texture_path": "res://assets/sprites/ui/icon_chip.png"},
				{"id": "pack_3_chips_kilo", "name": "3 Fichas (Con Saldo)", "rarity": "Casino", "stat_desc": "3 Fichas de Casino", "description": "Usa 0.80 KILOWAT de tu saldo.", "price": 0.80, "currency": "kilowat", "texture_path": "res://assets/sprites/ui/icon_chip.png"},
				{"id": "pack_5_chips_cup", "name": "5 Fichas de Casino", "rarity": "Casino", "stat_desc": "5 Fichas (Sin comisión)", "description": "5 Fichas para apostar en Minas.", "is_fiat": true, "fiat_price": "700 CUP", "texture_path": "res://assets/sprites/ui/icon_chip.png"},
				{"id": "pack_5_chips_kilo", "name": "5 Fichas (Con Saldo)", "rarity": "Casino", "stat_desc": "5 Fichas de Casino", "description": "Usa 1.40 KILOWAT de tu saldo.", "price": 1.40, "currency": "kilowat", "texture_path": "res://assets/sprites/ui/icon_chip.png"},

				# PAQUETES KILOWAT
				{"id": "pack_1_kilo", "name": "1 KILOWAT", "rarity": "Moneda", "stat_desc": "1.0 kW Saldo Oficial", "description": "Paquete de 1.0 KILOWAT directo a tu cuenta.", "is_fiat": true, "fiat_price": "500 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},
				{"id": "pack_2_kilo", "name": "2 KILOWAT (Pase)", "rarity": "Moneda", "stat_desc": "2.0 kW (Pase Premium)", "description": "Saldo exacto para activar el Pase de Batalla.", "is_fiat": true, "fiat_price": "1000 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},
				{"id": "pack_3_kilo", "name": "3 KILOWAT", "rarity": "Moneda", "stat_desc": "3.0 kW Alta Potencia", "description": "Paquete de 3.0 KILOWAT directo a tu cuenta.", "is_fiat": true, "fiat_price": "1500 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},
				{"id": "pack_4_kilo", "name": "4 KILOWAT", "rarity": "Moneda", "stat_desc": "4.0 kW Con Ahorro", "description": "Paquete de 4.0 KILOWAT directo a tu cuenta.", "is_fiat": true, "fiat_price": "2000 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},

				# COMBOS ESPECIALES
				{"id": "combo_2k_2w", "name": "Combo 2 Kilo + 2 Watt", "rarity": "Combo", "stat_desc": "2.0 KW + 2.0 W Saldo", "description": "Recibe 2.0 KILOWAT y 2.0 WATT en tu cuenta.", "is_fiat": true, "fiat_price": "1100 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},
				{"id": "combo_3k_4w", "name": "Combo 3 Kilo + 4 Watt", "rarity": "Combo", "stat_desc": "3.0 KW + 4.0 W Saldo", "description": "Recibe 3.0 KILOWAT y 4.0 WATT en tu cuenta.", "is_fiat": true, "fiat_price": "1800 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},

				# PAQUETES WATT
				{"id": "pack_25_watt", "name": "2.5 WATT", "rarity": "Moneda", "stat_desc": "2.50 WATT Saldo", "description": "Paquete básico para adquirir plantas.", "is_fiat": true, "fiat_price": "250 CUP", "texture_path": "res://assets/sprites/ui/icon_watt.png"},
				{"id": "pack_3_watt", "name": "3 WATT", "rarity": "Moneda", "stat_desc": "3.00 WATT Saldo", "description": "Saldo rápido para generadores.", "is_fiat": true, "fiat_price": "300 CUP", "texture_path": "res://assets/sprites/ui/icon_watt.png"},
				{"id": "pack_5_watt", "name": "5 WATT", "rarity": "Moneda", "stat_desc": "5.00 WATT (Ahorro)", "description": "Paquete completo con descuento en CUP.", "is_fiat": true, "fiat_price": "480 CUP", "texture_path": "res://assets/sprites/ui/icon_watt.png"}
			]
		"offers":
			var already_owned = GameManager.get_owned_generator_count("cyber_tank") >= 1
			var rem_time = _get_offer_remaining_seconds()
			if not already_owned and rem_time > 0:
				return [
					{"id": "cyber_tank", "name": "Cyber Tank 100%", "rarity": "Legendario", "stat_desc": "0.000000900 kW/min", "description": "Generador de plasma blindado exclusivo de edición limitada (Límite 1 por cuenta / 1 en sala).", "price": 1.0, "currency": "kilowat", "texture_path": "res://assets/sprites/generators/cyber_tank.png"}
				]
			else:
				return []
		_: return []
