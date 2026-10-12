# res://core/state/event_bus.gd
@warning_ignore("unused_signal")
extends Node

# --- Autenticación ---
signal auth_signed_in(user_data: Dictionary)
signal auth_signed_up(user_data: Dictionary)
signal auth_signed_out()
signal auth_error(message: String)

# --- Perfil y Estado ---
signal profile_loaded(profile_data: Dictionary)
signal profile_error(message: String)

# --- Economía y Potencia ---
signal power_updated(new_power_kwp: float)
signal currencies_updated(new_watt: float, new_kilowat: float)

# --- Tarjeta de Información de Equipos ---
signal show_plant_info(info: Dictionary, screen_pos: Vector2)
signal hide_plant_info()
