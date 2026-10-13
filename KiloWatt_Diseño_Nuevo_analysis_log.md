# Análisis del Proyecto: KiloWatt_Diseño_Nuevo

## Resumen del Proyecto
- **Total de Carpetas:** 63
- **Total de Archivos:** 307

### Desglose por Extensión
- `.import`: 70 archivo(s)
- `.png`: 66 archivo(s)
- `[Sin extensión]`: 40 archivo(s)
- `.gd`: 40 archivo(s)
- `.uid`: 40 archivo(s)
- `.tscn`: 28 archivo(s)
- `.tres`: 13 archivo(s)
- `.bat`: 3 archivo(s)
- `.webp`: 3 archivo(s)
- `.cfg`: 1 archivo(s)
- `.godot`: 1 archivo(s)
- `.md`: 1 archivo(s)
- `.jpg`: 1 archivo(s)

---

### 📁 Carpeta: `.//`

- 📄 `.gitattributes` *(recurso no leído)*

- 📄 `.gitignore` *(recurso no leído)*

- 📄 `KiloWatt_Diseño_Nuevo_analysis_log.md` *(recurso no leído)*

#### 📄 Archivo: `README.md`

```
# KILOWAT - Guía de Colaboración en Equipo

## 📌 Reglas de Oro para evitar conflictos en Git:
1. **Nunca trabajen sobre la misma escena (`.tscn`) al mismo tiempo:**
   - Si Developer A está modificando la habitación (`features/room/`), Developer B debe trabajar en un minijuego (`features/minigames/`) o en la tienda (`features/economy/`).
2. **Usa ramas (Branches):**
   - No programes directo en `main`. Crea ramas: `git checkout -b feature/nuevo-minijuego`.
3. **Todo cambio global se hace en `core/`:**
   - Si necesitas una nueva señal, agrégala en `core/state/event_bus.gd`.

```

---

- 📄 `actualizar_amigo.bat` *(recurso no leído)*

#### 📄 Archivo: `export_presets.cfg`

```
[preset.0]

name="Windows Desktop"
platform="Windows Desktop"
runnable=false
dedicated_server=false
custom_features=""
export_filter="all_resources"
include_filter=""
exclude_filter=""
export_path="../../../../KILOWAT_SISTEMA/deploy_tools/builds/windows/kilowat.exe"
patches=PackedStringArray()
patch_delta_encoding=false
patch_delta_compression_level_zstd=19
patch_delta_min_reduction=0.1
patch_delta_include_filters="*"
patch_delta_exclude_filters=""
encryption_include_filters=""
encryption_exclude_filters=""
seed=0
encrypt_pck=false
encrypt_directory=false
script_export_mode=2

[preset.0.options]

custom_template/debug=""
custom_template/release=""
debug/export_console_wrapper=1
binary_format/embed_pck=true
texture_format/s3tc_bptc=true
texture_format/etc2_astc=false
shader_baker/enabled=false
binary_format/architecture="x86_64"
codesign/enable=false
codesign/timestamp=true
codesign/timestamp_server_url=""
codesign/digest_algorithm=1
codesign/description=""
codesign/custom_options=PackedStringArray()
application/modify_resources=true
application/icon=""
application/console_wrapper_icon=""
application/icon_interpolation=4
application/file_version=""
application/product_version=""
application/company_name=""
application/product_name=""
application/file_description=""
application/copyright=""
application/trademarks=""
application/export_angle=0
application/export_d3d12=0
application/d3d12_agility_sdk_multiarch=true
ssh_remote_deploy/enabled=false
ssh_remote_deploy/host="user@host_ip"
ssh_remote_deploy/port="22"
ssh_remote_deploy/extra_args_ssh=""
ssh_remote_deploy/extra_args_scp=""
ssh_remote_deploy/run_script="Expand-Archive -LiteralPath '{temp_dir}\\{archive_name}' -DestinationPath '{temp_dir}'
$action = New-ScheduledTaskAction -Execute '{temp_dir}\\{exe_name}' -Argument '{cmd_args}'
$trigger = New-ScheduledTaskTrigger -Once -At 00:00
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings
Register-ScheduledTask godot_remote_debug -InputObject $task -Force:$true
Start-ScheduledTask -TaskName godot_remote_debug
while (Get-ScheduledTask -TaskName godot_remote_debug | ? State -eq running) { Start-Sleep -Milliseconds 100 }
Unregister-ScheduledTask -TaskName godot_remote_debug -Confirm:$false -ErrorAction:SilentlyContinue"
ssh_remote_deploy/cleanup_script="Stop-ScheduledTask -TaskName godot_remote_debug -ErrorAction:SilentlyContinue
Unregister-ScheduledTask -TaskName godot_remote_debug -Confirm:$false -ErrorAction:SilentlyContinue
Remove-Item -Recurse -Force '{temp_dir}'"

[preset.1]

name="Android"
platform="Android"
runnable=false
dedicated_server=false
custom_features=""
export_filter="all_resources"
include_filter=""
exclude_filter=""
export_path="../../../../KILOWAT_SISTEMA/deploy_tools/builds/android/game.apk"
patches=PackedStringArray()
patch_delta_encoding=false
patch_delta_compression_level_zstd=19
patch_delta_min_reduction=0.1
patch_delta_include_filters="*"
patch_delta_exclude_filters=""
encryption_include_filters=""
encryption_exclude_filters=""
seed=0
encrypt_pck=false
encrypt_directory=false
script_export_mode=2

[preset.1.options]

custom_template/debug=""
custom_template/release=""
gradle_build/use_gradle_build=false
gradle_build/gradle_build_directory="res://apk"
gradle_build/android_source_template=""
gradle_build/compress_native_libraries=false
gradle_build/export_format=0
gradle_build/min_sdk=""
gradle_build/target_sdk=""
gradle_build/custom_theme_attributes={}
architectures/armeabi-v7a=false
architectures/arm64-v8a=true
architectures/x86=false
architectures/x86_64=false
version/code=1
version/name="1.0.0"
package/unique_name="com.kilowat.game"
package/name="KILOWAT"
package/signed=true
package/app_category=2
package/retain_data_on_uninstall=false
package/exclude_from_recents=false
package/show_in_android_tv=false
package/show_in_app_library=true
package/show_as_launcher_app=false
launcher_icons/main_192x192=""
launcher_icons/adaptive_foreground_432x432=""
launcher_icons/adaptive_background_432x432=""
launcher_icons/adaptive_monochrome_432x432=""
graphics/opengl_debug=false
shader_baker/enabled=false
xr_features/xr_mode=0
gesture/swipe_to_dismiss=false
screen/immersive_mode=true
screen/edge_to_edge=false
screen/support_small=true
screen/support_normal=true
screen/support_large=true
screen/support_xlarge=true
screen/background_color=Color(0, 0, 0, 1)
user_data_backup/allow=false
command_line/extra_args=""
apk_expansion/enable=false
apk_expansion/SALT=""
apk_expansion/public_key=""
permissions/custom_permissions=PackedStringArray()
permissions/access_checkin_properties=false
permissions/access_coarse_location=false
permissions/access_fine_location=false
permissions/access_location_extra_commands=false
permissions/access_media_location=false
permissions/access_mock_location=false
permissions/access_network_state=true
permissions/access_surface_flinger=false
permissions/access_wifi_state=false
permissions/account_manager=false
permissions/add_voicemail=false
permissions/authenticate_accounts=false
permissions/battery_stats=false
permissions/bind_accessibility_service=false
permissions/bind_appwidget=false
permissions/bind_device_admin=false
permissions/bind_input_method=false
permissions/bind_nfc_service=false
permissions/bind_notification_listener_service=false
permissions/bind_print_service=false
permissions/bind_remoteviews=false
permissions/bind_text_service=false
permissions/bind_vpn_service=false
permissions/bind_wallpaper=false
permissions/bluetooth=false
permissions/bluetooth_admin=false
permissions/bluetooth_privileged=false
permissions/brick=false
permissions/broadcast_package_removed=false
permissions/broadcast_sms=false
permissions/broadcast_sticky=false
permissions/broadcast_wap_push=false
permissions/call_phone=false
permissions/call_privileged=false
permissions/camera=false
permissions/capture_audio_output=false
permissions/capture_secure_video_output=false
permissions/capture_video_output=false
permissions/change_component_enabled_state=false
permissions/change_configuration=false
permissions/change_network_state=false
permissions/change_wifi_multicast_state=false
permissions/change_wifi_state=false
permissions/clear_app_cache=false
permissions/clear_app_user_data=false
permissions/control_location_updates=false
permissions/delete_cache_files=false
permissions/delete_packages=false
permissions/device_power=false
permissions/diagnostic=false
permissions/disable_keyguard=false
permissions/dump=false
permissions/expand_status_bar=false
permissions/factory_test=false
permissions/flashlight=false
permissions/force_back=false
permissions/get_accounts=false
permissions/get_package_size=false
permissions/get_tasks=false
permissions/get_top_activity_info=false
permissions/global_search=false
permissions/hardware_test=false
permissions/inject_events=false
permissions/install_location_provider=false
permissions/install_packages=true
permissions/install_shortcut=false
permissions/internal_system_window=false
permissions/internet=true
permissions/kill_background_processes=false
permissions/location_hardware=false
permissions/manage_accounts=false
permissions/manage_app_tokens=false
permissions/manage_documents=false
permissions/manage_external_storage=false
permissions/manage_media=false
permissions/master_clear=false
permissions/media_content_control=false
permissions/modify_audio_settings=false
permissions/modify_phone_state=false
permissions/mount_format_filesystems=false
permissions/mount_unmount_filesystems=false
permissions/nfc=false
permissions/persistent_activity=false
permissions/post_notifications=false
permissions/process_outgoing_calls=false
permissions/read_calendar=false
permissions/read_call_log=false
permissions/read_contacts=false
permissions/read_external_storage=false
permissions/read_frame_buffer=false
permissions/read_history_bookmarks=false
permissions/read_input_state=false
permissions/read_logs=false
permissions/read_media_audio=false
permissions/read_media_images=false
permissions/read_media_video=false
permissions/read_media_visual_user_selected=false
permissions/read_phone_state=false
permissions/read_profile=false
permissions/read_sms=false
permissions/read_social_stream=false
permissions/read_sync_settings=false
permissions/read_sync_stats=false
permissions/read_user_dictionary=false
permissions/reboot=false
permissions/receive_boot_completed=false
permissions/receive_mms=false
permissions/receive_sms=false
permissions/receive_wap_push=false
permissions/record_audio=false
permissions/reorder_tasks=false
permissions/restart_packages=false
permissions/send_respond_via_message=false
permissions/send_sms=false
permissions/set_activity_watcher=false
permissions/set_alarm=false
permissions/set_always_finish=false
permissions/set_animation_scale=false
permissions/set_debug_app=false
permissions/set_orientation=false
permissions/set_pointer_speed=false
permissions/set_preferred_applications=false
permissions/set_process_limit=false
permissions/set_time=false
permissions/set_time_zone=false
permissions/set_wallpaper=false
permissions/set_wallpaper_hints=false
permissions/signal_persistent_processes=false
permissions/status_bar=false
permissions/subscribed_feeds_read=false
permissions/subscribed_feeds_write=false
permissions/system_alert_window=false
permissions/transmit_ir=false
permissions/uninstall_shortcut=false
permissions/update_device_stats=false
permissions/use_credentials=false
permissions/use_sip=false
permissions/vibrate=false
permissions/wake_lock=false
permissions/write_apn_settings=false
permissions/write_calendar=false
permissions/write_call_log=false
permissions/write_contacts=false
permissions/write_external_storage=false
permissions/write_gservices=false
permissions/write_history_bookmarks=false
permissions/write_profile=false
permissions/write_secure_settings=false
permissions/write_settings=false
permissions/write_sms=false
permissions/write_social_stream=false
permissions/write_sync_settings=false
permissions/write_user_dictionary=false
splash_screen/disable_godot_boot_splash=false
splash_screen/icon=""
splash_screen/branding_image=""
splash_screen/background_color=Color(0, 0, 0, 1)

```

---

- 📄 `generar_parche.bat` *(recurso no leído)*

- 📄 `icon.png` *(recurso no leído)*

#### 📄 Archivo: `icon.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://e22ja3oafbki"
path="res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=["res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `project.godot` *(recurso no leído)*

- 📄 `publicar_github.bat` *(recurso no leído)*

#### 📁 Carpeta: `./assets/`

##### 📁 Carpeta: `./assets\audio/`

###### 📁 Carpeta: `./assets\audio\music/`

####### 📄 Archivo: `.gitkeep`

```

```

---

###### 📁 Carpeta: `./assets\audio\sfx/`

####### 📄 Archivo: `.gitkeep`

```

```

---

##### 📁 Carpeta: `./assets\fonts/`

###### 📄 Archivo: `.gitkeep`

```

```

---

##### 📁 Carpeta: `./assets\sprites/`

###### 📁 Carpeta: `./assets\sprites\generators/`

####### 📄 Archivo: `.gitkeep`

```

```

---

- 📄 `cyber_tank.png` *(recurso no leído)*

####### 📄 Archivo: `cyber_tank.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ctum585omkbol"
path="res://.godot/imported/cyber_tank.png-344e4d6bde1810b009f4b10d9ffb39be.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/cyber_tank.png"
dest_files=["res://.godot/imported/cyber_tank.png-344e4d6bde1810b009f4b10d9ffb39be.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `delta_mini.png` *(recurso no leído)*

####### 📄 Archivo: `delta_mini.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cthb3fukjxgp4"
path="res://.godot/imported/delta_mini.png-62afb46ee9c0104cb5bcc5b2f65fa7fa.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/delta_mini.png"
dest_files=["res://.godot/imported/delta_mini.png-62afb46ee9c0104cb5bcc5b2f65fa7fa.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `dinamo_manual.png` *(recurso no leído)*

####### 📄 Archivo: `dinamo_manual.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b0t42lcfj4t5v"
path="res://.godot/imported/dinamo_manual.png-8337398e96d0f9641bb9adb041f6b430.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/dinamo_manual.png"
dest_files=["res://.godot/imported/dinamo_manual.png-8337398e96d0f9641bb9adb041f6b430.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `ecoflow_spark.png` *(recurso no leído)*

####### 📄 Archivo: `ecoflow_spark.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://csun77nkn0f2m"
path="res://.godot/imported/ecoflow_spark.png-b5edd31dff68f368f802c1f9bb5ab097.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/ecoflow_spark.png"
dest_files=["res://.godot/imported/ecoflow_spark.png-b5edd31dff68f368f802c1f9bb5ab097.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `ecoflow_spark_plus.png` *(recurso no leído)*

####### 📄 Archivo: `ecoflow_spark_plus.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c2rc2upawhqo7"
path="res://.godot/imported/ecoflow_spark_plus.png-49072e97cb5b2376af78587f3d72795b.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/ecoflow_spark_plus.png"
dest_files=["res://.godot/imported/ecoflow_spark_plus.png-49072e97cb5b2376af78587f3d72795b.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `ecoflow_thunder_pro.png` *(recurso no leído)*

####### 📄 Archivo: `ecoflow_thunder_pro.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d4fe17y8l62tr"
path="res://.godot/imported/ecoflow_thunder_pro.png-fb7aa79ef521f357272d7f793e962e0c.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/ecoflow_thunder_pro.png"
dest_files=["res://.godot/imported/ecoflow_thunder_pro.png-fb7aa79ef521f357272d7f793e962e0c.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `ecoflow_ultra.png` *(recurso no leído)*

####### 📄 Archivo: `ecoflow_ultra.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cvg0a2uv4wst1"
path="res://.godot/imported/ecoflow_ultra.png-65daa9ea4b947169349f822bc6e2e376.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/ecoflow_ultra.png"
dest_files=["res://.godot/imported/ecoflow_ultra.png-65daa9ea4b947169349f822bc6e2e376.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `panel_solar.png` *(recurso no leído)*

####### 📄 Archivo: `panel_solar.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://h2necnhls70b"
path="res://.godot/imported/panel_solar.png-073977dc9db8efc2df9ca75b476421ae.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/panel_solar.png"
dest_files=["res://.godot/imported/panel_solar.png-073977dc9db8efc2df9ca75b476421ae.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `plantalevel1.png` *(recurso no leído)*

####### 📄 Archivo: `plantalevel1.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dkcldsddo83ca"
path="res://.godot/imported/plantalevel1.png-1872060813236eb5f94eab1a4c518b7c.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/plantalevel1.png"
dest_files=["res://.godot/imported/plantalevel1.png-1872060813236eb5f94eab1a4c518b7c.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pro_electrico.png` *(recurso no leído)*

####### 📄 Archivo: `pro_electrico.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cmqjq0lcv0w0f"
path="res://.godot/imported/pro_electrico.png-f59c4aa75d7f0915b6f3acf74001b36f.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/generators/pro_electrico.png"
dest_files=["res://.godot/imported/pro_electrico.png-f59c4aa75d7f0915b6f3acf74001b36f.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

###### 📁 Carpeta: `./assets\sprites\minigames/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📁 Carpeta: `./assets\sprites\minigames\coinclick/`

- 📄 `bg.png` *(recurso no leído)*

######## 📄 Archivo: `bg.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bbhlrpld4w0gu"
path="res://.godot/imported/bg.png-705544e0c7e391d66fa7dee93fce59bd.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coinclick/bg.png"
dest_files=["res://.godot/imported/bg.png-705544e0c7e391d66fa7dee93fce59bd.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `bomb.png` *(recurso no leído)*

######## 📄 Archivo: `bomb.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b5cjfebvxh5nh"
path="res://.godot/imported/bomb.png-308ad5616a4a009f03bae1b5dfe98fe6.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coinclick/bomb.png"
dest_files=["res://.godot/imported/bomb.png-308ad5616a4a009f03bae1b5dfe98fe6.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `coin.png` *(recurso no leído)*

######## 📄 Archivo: `coin.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cojt0clp4jo0q"
path="res://.godot/imported/coin.png-23ee397641b18c28f74a849e8b6797ce.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coinclick/coin.png"
dest_files=["res://.godot/imported/coin.png-23ee397641b18c28f74a849e8b6797ce.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `thumb.jpg` *(recurso no leído)*

######## 📄 Archivo: `thumb.jpg.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://oiqwr130wtku"
path="res://.godot/imported/thumb.jpg-98e65fdac8ed8004cc95d2ef4e6f1ec1.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coinclick/thumb.jpg"
dest_files=["res://.godot/imported/thumb.jpg-98e65fdac8ed8004cc95d2ef4e6f1ec1.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `wizard.png` *(recurso no leído)*

######## 📄 Archivo: `wizard.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bwctmwkrhw2au"
path="res://.godot/imported/wizard.png-b59a198880dfe3b075f5bad1fad50721.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coinclick/wizard.png"
dest_files=["res://.godot/imported/wizard.png-b59a198880dfe3b075f5bad1fad50721.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

####### 📁 Carpeta: `./assets\sprites\minigames\coin_match/`

- 📄 `bg.png` *(recurso no leído)*

######## 📄 Archivo: `bg.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ciqajjnikqfxi"
path="res://.godot/imported/bg.png-0ae8a6353e03511fc649deb6c308c072.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coin_match/bg.png"
dest_files=["res://.godot/imported/bg.png-0ae8a6353e03511fc649deb6c308c072.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `coins.png` *(recurso no leído)*

######## 📄 Archivo: `coins.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dq7euud2sigfe"
path="res://.godot/imported/coins.png-9e5b52c24b98d3f9d91a3ca89a8656a3.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coin_match/coins.png"
dest_files=["res://.godot/imported/coins.png-9e5b52c24b98d3f9d91a3ca89a8656a3.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `thumb.webp` *(recurso no leído)*

######## 📄 Archivo: `thumb.webp.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cypwxudxhvtsv"
path="res://.godot/imported/thumb.webp-ae4cb8bd60ae50ef1362e84a52601ef6.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/coin_match/thumb.webp"
dest_files=["res://.godot/imported/thumb.webp-ae4cb8bd60ae50ef1362e84a52601ef6.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

####### 📁 Carpeta: `./assets\sprites\minigames\crypto_memory/`

- 📄 `card_bnb.png` *(recurso no leído)*

######## 📄 Archivo: `card_bnb.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dtsxdsc28e4gg"
path="res://.godot/imported/card_bnb.png-cbbe81bf1cda50da226bd72e1098acbd.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_bnb.png"
dest_files=["res://.godot/imported/card_bnb.png-cbbe81bf1cda50da226bd72e1098acbd.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_btc.png` *(recurso no leído)*

######## 📄 Archivo: `card_btc.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cpnqdflxxw2xg"
path="res://.godot/imported/card_btc.png-413ebfe1d8adbba8318d972cf44646f9.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_btc.png"
dest_files=["res://.godot/imported/card_btc.png-413ebfe1d8adbba8318d972cf44646f9.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_eos.png` *(recurso no leído)*

######## 📄 Archivo: `card_eos.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dbtxoqa4ls4ob"
path="res://.godot/imported/card_eos.png-34f5ea2418a63f1e2304bc2f06f95014.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_eos.png"
dest_files=["res://.godot/imported/card_eos.png-34f5ea2418a63f1e2304bc2f06f95014.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_eth.png` *(recurso no leído)*

######## 📄 Archivo: `card_eth.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d2xejtlsuxorw"
path="res://.godot/imported/card_eth.png-df877f27bcff13a24922d8d79a8ffffe.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_eth.png"
dest_files=["res://.godot/imported/card_eth.png-df877f27bcff13a24922d8d79a8ffffe.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_ltc.png` *(recurso no leído)*

######## 📄 Archivo: `card_ltc.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://7p1qjnk640gg"
path="res://.godot/imported/card_ltc.png-d4ca6a5ea7731802a8fb37bbbc0618ea.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_ltc.png"
dest_files=["res://.godot/imported/card_ltc.png-d4ca6a5ea7731802a8fb37bbbc0618ea.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_rlt.png` *(recurso no leído)*

######## 📄 Archivo: `card_rlt.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ccew38logo6kq"
path="res://.godot/imported/card_rlt.png-9ffcbf2bb0c11e27eab183a2ac4f40c9.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_rlt.png"
dest_files=["res://.godot/imported/card_rlt.png-9ffcbf2bb0c11e27eab183a2ac4f40c9.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_rocket.png` *(recurso no leído)*

######## 📄 Archivo: `card_rocket.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bimmt7kb2x40c"
path="res://.godot/imported/card_rocket.png-90e9654332faa00ddff8f8cf84c5d18e.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_rocket.png"
dest_files=["res://.godot/imported/card_rocket.png-90e9654332faa00ddff8f8cf84c5d18e.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_usdt.png` *(recurso no leído)*

######## 📄 Archivo: `card_usdt.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ceemfp3nk3s57"
path="res://.godot/imported/card_usdt.png-fcbb686eb214d8c7ba4743b9fed42f26.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_usdt.png"
dest_files=["res://.godot/imported/card_usdt.png-fcbb686eb214d8c7ba4743b9fed42f26.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_xmr.png` *(recurso no leído)*

######## 📄 Archivo: `card_xmr.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bmft673wlf2yh"
path="res://.godot/imported/card_xmr.png-3534d09653fc574f3826c435122322f9.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_xmr.png"
dest_files=["res://.godot/imported/card_xmr.png-3534d09653fc574f3826c435122322f9.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `card_xrp.png` *(recurso no leído)*

######## 📄 Archivo: `card_xrp.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://fg4n3a6p088f"
path="res://.godot/imported/card_xrp.png-bba6f713e6a2283f3fca7563c396f767.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/card_xrp.png"
dest_files=["res://.godot/imported/card_xrp.png-bba6f713e6a2283f3fca7563c396f767.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `thumb.webp` *(recurso no leído)*

######## 📄 Archivo: `thumb.webp.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dtaav0kt5c3tu"
path="res://.godot/imported/thumb.webp-07f52463472eada4ce0dd342b5264038.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/crypto_memory/thumb.webp"
dest_files=["res://.godot/imported/thumb.webp-07f52463472eada4ce0dd342b5264038.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

####### 📁 Carpeta: `./assets\sprites\minigames\flappy_rocket/`

- 📄 `bar_green.png` *(recurso no leído)*

######## 📄 Archivo: `bar_green.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://3e5tnm6sx42c"
path="res://.godot/imported/bar_green.png-4f858d63943b38f139de2ebff247e45d.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/flappy_rocket/bar_green.png"
dest_files=["res://.godot/imported/bar_green.png-4f858d63943b38f139de2ebff247e45d.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `bg.png` *(recurso no leído)*

######## 📄 Archivo: `bg.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c2n5s58jbx63j"
path="res://.godot/imported/bg.png-0c5dae1895f92abf7e5e002b53bf248c.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/flappy_rocket/bg.png"
dest_files=["res://.godot/imported/bg.png-0c5dae1895f92abf7e5e002b53bf248c.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `explosion.png` *(recurso no leído)*

######## 📄 Archivo: `explosion.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cvx3o8xf6emps"
path="res://.godot/imported/explosion.png-8044974c4561d426b1ca46518f544323.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/flappy_rocket/explosion.png"
dest_files=["res://.godot/imported/explosion.png-8044974c4561d426b1ca46518f544323.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `ship.png` *(recurso no leído)*

######## 📄 Archivo: `ship.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dm05mdqhqfijp"
path="res://.godot/imported/ship.png-941a8d004c96a1c7ef2d7d0a631b519d.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/flappy_rocket/ship.png"
dest_files=["res://.godot/imported/ship.png-941a8d004c96a1c7ef2d7d0a631b519d.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `thumb.webp` *(recurso no leído)*

######## 📄 Archivo: `thumb.webp.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dkcr15tyarj1b"
path="res://.godot/imported/thumb.webp-605e79155cafc1c5ff8a19ef85328960.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/flappy_rocket/thumb.webp"
dest_files=["res://.godot/imported/thumb.webp-605e79155cafc1c5ff8a19ef85328960.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

####### 📁 Carpeta: `./assets\sprites\minigames\mines/`

- 📄 `bg.png` *(recurso no leído)*

######## 📄 Archivo: `bg.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b5annkceek5mm"
path="res://.godot/imported/bg.png-f5edb62b0d0b097d32ddd33351edd7ad.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/mines/bg.png"
dest_files=["res://.godot/imported/bg.png-f5edb62b0d0b097d32ddd33351edd7ad.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `bomb.png` *(recurso no leído)*

######## 📄 Archivo: `bomb.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://t32888vqdnaw"
path="res://.godot/imported/bomb.png-447c50e80bb381e32738bcc1b8e6b055.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/mines/bomb.png"
dest_files=["res://.godot/imported/bomb.png-447c50e80bb381e32738bcc1b8e6b055.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `diamond.png` *(recurso no leído)*

######## 📄 Archivo: `diamond.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d2nd6mvuuby3m"
path="res://.godot/imported/diamond.png-e3d3d2a7d78298db68af8f1bc1455f05.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/minigames/mines/diamond.png"
dest_files=["res://.godot/imported/diamond.png-e3d3d2a7d78298db68af8f1bc1455f05.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

###### 📁 Carpeta: `./assets\sprites\pet/`

- 📄 `mascot.png` *(recurso no leído)*

####### 📄 Archivo: `mascot.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://tx256pca3bf6"
path="res://.godot/imported/mascot.png-b35fc9fc1df08d198a16c4f90a07a3a0.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/pet/mascot.png"
dest_files=["res://.godot/imported/mascot.png-b35fc9fc1df08d198a16c4f90a07a3a0.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

###### 📁 Carpeta: `./assets\sprites\piezas/`

- 📄 `pieza cable 1.png` *(recurso no leído)*

####### 📄 Archivo: `pieza cable 1.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://creic83k4ts4s"
path="res://.godot/imported/pieza cable 1.png-83133006d6355ea6f9352bde6aac2a54.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza cable 1.png"
dest_files=["res://.godot/imported/pieza cable 1.png-83133006d6355ea6f9352bde6aac2a54.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza cable 2.png` *(recurso no leído)*

####### 📄 Archivo: `pieza cable 2.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b530xmbxn313b"
path="res://.godot/imported/pieza cable 2.png-fdd27fb402bbb13711584d83183ef358.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza cable 2.png"
dest_files=["res://.godot/imported/pieza cable 2.png-fdd27fb402bbb13711584d83183ef358.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza cable 3.png` *(recurso no leído)*

####### 📄 Archivo: `pieza cable 3.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dutwot845s7m"
path="res://.godot/imported/pieza cable 3.png-bf9d8a54f70ddfeac0c297f70aadd21b.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza cable 3.png"
dest_files=["res://.godot/imported/pieza cable 3.png-bf9d8a54f70ddfeac0c297f70aadd21b.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza cable 4.png` *(recurso no leído)*

####### 📄 Archivo: `pieza cable 4.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://5ok3yjmepsku"
path="res://.godot/imported/pieza cable 4.png-43216ffec5cc761b9030b60ee90f8b67.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza cable 4.png"
dest_files=["res://.godot/imported/pieza cable 4.png-43216ffec5cc761b9030b60ee90f8b67.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza cable 5.png` *(recurso no leído)*

####### 📄 Archivo: `pieza cable 5.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://642pq4jymaku"
path="res://.godot/imported/pieza cable 5.png-4ac0ae24c928331358aba2466c61c345.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza cable 5.png"
dest_files=["res://.godot/imported/pieza cable 5.png-4ac0ae24c928331358aba2466c61c345.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza panel 1.png` *(recurso no leído)*

####### 📄 Archivo: `pieza panel 1.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b2tgsbm6phpno"
path="res://.godot/imported/pieza panel 1.png-d31a8caa5bc1a4588cf52955b848b4e6.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza panel 1.png"
dest_files=["res://.godot/imported/pieza panel 1.png-d31a8caa5bc1a4588cf52955b848b4e6.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza panel 2.png` *(recurso no leído)*

####### 📄 Archivo: `pieza panel 2.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://djjbiv1q6qqnk"
path="res://.godot/imported/pieza panel 2.png-2103e6291dee7c9e2adc65aa12dd9b00.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza panel 2.png"
dest_files=["res://.godot/imported/pieza panel 2.png-2103e6291dee7c9e2adc65aa12dd9b00.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza panel 3.png` *(recurso no leído)*

####### 📄 Archivo: `pieza panel 3.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bki2ygqxjabvs"
path="res://.godot/imported/pieza panel 3.png-2c7711db56ce06c3b2f0631fb8ddf933.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza panel 3.png"
dest_files=["res://.godot/imported/pieza panel 3.png-2c7711db56ce06c3b2f0631fb8ddf933.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza panel 4.png` *(recurso no leído)*

####### 📄 Archivo: `pieza panel 4.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bjxjytb5hf6dy"
path="res://.godot/imported/pieza panel 4.png-7c099d617bbfeaad09d827ebfe22c686.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza panel 4.png"
dest_files=["res://.godot/imported/pieza panel 4.png-7c099d617bbfeaad09d827ebfe22c686.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza panel 5.png` *(recurso no leído)*

####### 📄 Archivo: `pieza panel 5.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://big4sqdentsgt"
path="res://.godot/imported/pieza panel 5.png-43d4553c8312126ae60ec06b56094109.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza panel 5.png"
dest_files=["res://.godot/imported/pieza panel 5.png-43d4553c8312126ae60ec06b56094109.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza ventilador 1.png` *(recurso no leído)*

####### 📄 Archivo: `pieza ventilador 1.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dixtc645nxdmg"
path="res://.godot/imported/pieza ventilador 1.png-488042687b1f519b6ee07abdc0b5bbea.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza ventilador 1.png"
dest_files=["res://.godot/imported/pieza ventilador 1.png-488042687b1f519b6ee07abdc0b5bbea.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza ventilador 2.png` *(recurso no leído)*

####### 📄 Archivo: `pieza ventilador 2.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://g1hcvofkm6lt"
path="res://.godot/imported/pieza ventilador 2.png-8416a9a5a7b0f54ce3409b9197007f25.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza ventilador 2.png"
dest_files=["res://.godot/imported/pieza ventilador 2.png-8416a9a5a7b0f54ce3409b9197007f25.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza ventilador 3.png` *(recurso no leído)*

####### 📄 Archivo: `pieza ventilador 3.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cejklqs5deldr"
path="res://.godot/imported/pieza ventilador 3.png-bbf50758bf4812bb1cfdd0ceacfce7cb.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza ventilador 3.png"
dest_files=["res://.godot/imported/pieza ventilador 3.png-bbf50758bf4812bb1cfdd0ceacfce7cb.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza ventilador 4.png` *(recurso no leído)*

####### 📄 Archivo: `pieza ventilador 4.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://keckc62rj22h"
path="res://.godot/imported/pieza ventilador 4.png-c04b7e1a551915018e96f6e96349375a.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza ventilador 4.png"
dest_files=["res://.godot/imported/pieza ventilador 4.png-c04b7e1a551915018e96f6e96349375a.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `pieza ventilador 5.png` *(recurso no leído)*

####### 📄 Archivo: `pieza ventilador 5.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cy0e8slx1lk7x"
path="res://.godot/imported/pieza ventilador 5.png-78086d9749fe8fabe627f8a66d32ba5e.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/piezas/pieza ventilador 5.png"
dest_files=["res://.godot/imported/pieza ventilador 5.png-78086d9749fe8fabe627f8a66d32ba5e.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

###### 📁 Carpeta: `./assets\sprites\racks/`

####### 📄 Archivo: `.gitkeep`

```

```

---

- 📄 `racks1.png` *(recurso no leído)*

####### 📄 Archivo: `racks1.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://f5cs323vvdor"
path="res://.godot/imported/racks1.png-5f03eb6822046116a40db0fe43487be3.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/racks/racks1.png"
dest_files=["res://.godot/imported/racks1.png-5f03eb6822046116a40db0fe43487be3.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `racks2.png` *(recurso no leído)*

####### 📄 Archivo: `racks2.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://db0fexuwv1dxf"
path="res://.godot/imported/racks2.png-84d0ec5099c6fb86d854c427d4ad56ab.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/racks/racks2.png"
dest_files=["res://.godot/imported/racks2.png-84d0ec5099c6fb86d854c427d4ad56ab.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `racks3.png` *(recurso no leído)*

####### 📄 Archivo: `racks3.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bb4qjra0nh1lj"
path="res://.godot/imported/racks3.png-eceff7b860dd89e1a32aaec0a00524e7.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/racks/racks3.png"
dest_files=["res://.godot/imported/racks3.png-eceff7b860dd89e1a32aaec0a00524e7.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

###### 📁 Carpeta: `./assets\sprites\room/`

####### 📄 Archivo: `.gitkeep`

```

```

---

- 📄 `bg_bunker_solar.png` *(recurso no leído)*

####### 📄 Archivo: `bg_bunker_solar.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ba8w281yjntfh"
path="res://.godot/imported/bg_bunker_solar.png-6544d8af50cc6131322cfcac44f179dc.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/room/bg_bunker_solar.png"
dest_files=["res://.godot/imported/bg_bunker_solar.png-6544d8af50cc6131322cfcac44f179dc.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `bg_habitacion_taller.png` *(recurso no leído)*

####### 📄 Archivo: `bg_habitacion_taller.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d3t0p0i7ga013"
path="res://.godot/imported/bg_habitacion_taller.png-6a60ba3de781b0afa38a89786caf851c.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/room/bg_habitacion_taller.png"
dest_files=["res://.godot/imported/bg_habitacion_taller.png-6a60ba3de781b0afa38a89786caf851c.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `room_background.png` *(recurso no leído)*

####### 📄 Archivo: `room_background.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bckxlbs6i5sln"
path="res://.godot/imported/room_background.png-945b901c5e62d38b0fe2d0c66272533d.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/room/room_background.png"
dest_files=["res://.godot/imported/room_background.png-945b901c5e62d38b0fe2d0c66272533d.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

###### 📁 Carpeta: `./assets\sprites\ui/`

- 📄 `bg_battlepass.png` *(recurso no leído)*

####### 📄 Archivo: `bg_battlepass.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c0rdxbifotwc4"
path="res://.godot/imported/bg_battlepass.png-a4b8594de6f0f5c7b04f483f12a3e302.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/bg_battlepass.png"
dest_files=["res://.godot/imported/bg_battlepass.png-a4b8594de6f0f5c7b04f483f12a3e302.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `bg_login.png` *(recurso no leído)*

####### 📄 Archivo: `bg_login.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bo6rvxxg81rbu"
path="res://.godot/imported/bg_login.png-a1fe011de4cebcababb95559768a04c0.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/bg_login.png"
dest_files=["res://.godot/imported/bg_login.png-a1fe011de4cebcababb95559768a04c0.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `btn_cyber_tank_banner.png` *(recurso no leído)*

####### 📄 Archivo: `btn_cyber_tank_banner.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://vy82l4b5hqtr"
path="res://.godot/imported/btn_cyber_tank_banner.png-f8367e8af6902e028ed2059d74ac6714.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/btn_cyber_tank_banner.png"
dest_files=["res://.godot/imported/btn_cyber_tank_banner.png-f8367e8af6902e028ed2059d74ac6714.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `btn_evento_potencia.png` *(recurso no leído)*

####### 📄 Archivo: `btn_evento_potencia.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dngorub66msn5"
path="res://.godot/imported/btn_evento_potencia.png-3c8f37ab4a67c4212a31f2f4296140ee.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/btn_evento_potencia.png"
dest_files=["res://.godot/imported/btn_evento_potencia.png-3c8f37ab4a67c4212a31f2f4296140ee.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `btn_minijuegos.png` *(recurso no leído)*

####### 📄 Archivo: `btn_minijuegos.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cavgsqbpa83lj"
path="res://.godot/imported/btn_minijuegos.png-3ba4e1977ce95abbcb8cd91269c8b413.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/btn_minijuegos.png"
dest_files=["res://.godot/imported/btn_minijuegos.png-3ba4e1977ce95abbcb8cd91269c8b413.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `btn_tienda.png` *(recurso no leído)*

####### 📄 Archivo: `btn_tienda.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://exevh5ptqh1b"
path="res://.godot/imported/btn_tienda.png-69a4c58d475a8336c1a0fcd4593330b1.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/btn_tienda.png"
dest_files=["res://.godot/imported/btn_tienda.png-69a4c58d475a8336c1a0fcd4593330b1.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `icon_battlepass.png` *(recurso no leído)*

####### 📄 Archivo: `icon_battlepass.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dn33aijj78qdg"
path="res://.godot/imported/icon_battlepass.png-d09616cd618b5716e263cf70fcf38294.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/icon_battlepass.png"
dest_files=["res://.godot/imported/icon_battlepass.png-d09616cd618b5716e263cf70fcf38294.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `icon_chip.png` *(recurso no leído)*

####### 📄 Archivo: `icon_chip.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c7pvtqts3faj8"
path="res://.godot/imported/icon_chip.png-224d114001882258899e6f0834a0df89.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/icon_chip.png"
dest_files=["res://.godot/imported/icon_chip.png-224d114001882258899e6f0834a0df89.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `icon_kilowat.png` *(recurso no leído)*

####### 📄 Archivo: `icon_kilowat.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ccmry72o5nhug"
path="res://.godot/imported/icon_kilowat.png-f9583f937dd1b68daa0506edfe2d69a0.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/icon_kilowat.png"
dest_files=["res://.godot/imported/icon_kilowat.png-f9583f937dd1b68daa0506edfe2d69a0.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

- 📄 `icon_watt.png` *(recurso no leído)*

####### 📄 Archivo: `icon_watt.png.import`

```
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://qsj8sh8c1wq1"
path="res://.godot/imported/icon_watt.png-cce009be39cabaddd0b3c3e4cf3f9a0e.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/sprites/ui/icon_watt.png"
dest_files=["res://.godot/imported/icon_watt.png-cce009be39cabaddd0b3c3e4cf3f9a0e.ctex"]

[params]

compress/mode=1
compress/high_quality=false
compress/lossy_quality=0.85
compress/uastc_level=0
compress/rdo_quality_loss=0.0
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/channel_remap/red=0
process/channel_remap/green=1
process/channel_remap/blue=2
process/channel_remap/alpha=3
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1

```

---

####### 📁 Carpeta: `./assets\sprites\ui\banners/`

######## 📄 Archivo: `.gitkeep`

```

```

---

####### 📁 Carpeta: `./assets\sprites\ui\icons/`

######## 📄 Archivo: `.gitkeep`

```

```

---

#### 📁 Carpeta: `./core/`

##### 📁 Carpeta: `./core\network/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `http_downloader.gd`

```
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
```

---

###### 📄 Archivo: `http_downloader.gd.uid`

```
uid://cn17u5spd0ij5

```

---

###### 📄 Archivo: `supabase_auth.gd`

```
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
```

---

###### 📄 Archivo: `supabase_auth.gd.uid`

```
uid://cr1xpxpdds7kw

```

---

###### 📄 Archivo: `supabase_client.gd`

```
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
```

---

###### 📄 Archivo: `supabase_client.gd.uid`

```
uid://d01c8hol666cv

```

---

##### 📁 Carpeta: `./core\security/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `integrity_verifier.gd`

```
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
```

---

###### 📄 Archivo: `integrity_verifier.gd.uid`

```
uid://dd42nuq4uuyid

```

---

##### 📁 Carpeta: `./core\state/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `event_bus.gd`

```
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

```

---

###### 📄 Archivo: `event_bus.gd.uid`

```
uid://dqe2c601ndhxx

```

---

###### 📄 Archivo: `game_manager.gd`

```
# res://core/state/game_manager.gd
extends Node

# --- Perfil del Jugador en Memoria ---
var username: String = ""
var watt: float = 0.0
var kilowat: float = 0.0
var casino_tokens: float = 0.0

# --- Potencia en KWP ---
var total_kwp: float = 0.0
var temporary_kwp: float = 0.0
var referral_power_kwp: float = 0.0

# --- Reparto de Minería (% Watts vs % kW) ---
var mining_split_watt: float = 50.0
var last_split_change_time: int = 0

var active_kw_rates: Dictionary = {}
var total_kw_per_minute: float = 0.0

var has_claimed_welcome_gift: bool = false
var open_battle_pass_on_room: bool = false
var target_shop_category: String = "generators"

# --- Fondos de Habitación ---
var unlocked_backgrounds: Array = ["default"]
var equipped_background: String = "default"

# --- Registro de Cooldowns y Timers ---
var minigame_cooldown_ticks: Dictionary = {}
var active_generator_powers: Dictionary = {}
var has_active_generator: bool = false

var last_minigame_time: int = 0
var decay_timer: float = 0.0
var online_quest_timer: float = 0.0
var cycle_60s_timer: float = 0.0

# --- Caché del Inventario y Repuestos ---
var player_racks: Array = []
var player_generators: Array = []
var player_parts: Array = [] # [{part_type: "cable", part_level: 1, quantity: 10}]

# --- Estado Persistente del Chat y Amigos ---
var saved_chat_channel_mode: String = "global"
var saved_active_friend_id: String = ""
var saved_active_friend_name: String = ""
var saved_is_chat_minimized: bool = false
var pending_friend_requests_count: int = 0

# --- Estado RPG del Jugador (Fase 1) ---
var player_materials: Array = [] # [{ "material_type": "cobre", "tier": 1, "quantity": 10 }]
var player_professions: Dictionary = {
	"chatarrero_level": 0, "chatarrero_xp": 0,
	"ingeniero_level": 0, "ingeniero_xp": 0,
	"corredor_level": 0, "corredor_xp": 0
}
var player_talents: Array = []
var talent_points: int = 0

var global_zoom: Node = null

func _ready() -> void:
	if not EventBus.auth_signed_out.is_connected(_on_signed_out):
		EventBus.auth_signed_out.connect(_on_signed_out)
	_setup_global_zoom()

func _setup_global_zoom() -> void:
	# Eliminar cualquier controlador huérfano en el viewport raíz
	var root_node = get_tree().root
	for child in root_node.get_children():
		if child.name.begins_with("GlobalZoomController") or child.name.begins_with("OldZoom"):
			child.queue_free()

func _process(delta: float) -> void:
	_process_online_power_decay(delta)
	_process_online_quest_timer(delta)
	_process_continuous_mining(delta)

# ====================================================================
# MINADO CONTINUO Y ECONOMÍA
# ====================================================================

func _process_continuous_mining(delta: float) -> void:
	if not has_active_generator or total_kw_per_minute <= 0.0:
		return
		
	cycle_60s_timer += delta
	if cycle_60s_timer >= 60.0:
		cycle_60s_timer -= 60.0
		
		var watt_share: float = mining_split_watt / 100.0
		var kilo_share: float = (100.0 - mining_split_watt) / 100.0
		
		var effective_min_rate: float = total_kw_per_minute * 0.90
		var earned_kilo: float = effective_min_rate * kilo_share
		var earned_watt: float = (effective_min_rate * watt_share) * 1000.0
		
		kilowat += earned_kilo
		watt += earned_watt
		
		EventBus.currencies_updated.emit(watt, kilowat)
		sync_passive_income()

func _process_online_power_decay(delta: float) -> void:
	if temporary_kwp <= 0.0:
		return
		
	decay_timer += delta
	if decay_timer >= 10.0:
		decay_timer = 0.0
		var now: int = int(Time.get_unix_time_from_system())
		var elapsed: int = now - last_minigame_time
		
		if elapsed > 1800:
			var chunk_size: float = 0.000000001
			temporary_kwp = maxf(0.0, temporary_kwp - (chunk_size * (delta / 600.0)))
			_recalc_total_power()

func _process_online_quest_timer(delta: float) -> void:
	online_quest_timer += delta
	if online_quest_timer >= 60.0:
		online_quest_timer = 0.0
		SupabaseClient.send_request("/rest/v1/rpc/track_quest_action", HTTPClient.METHOD_POST, {"p_action_type": "online_minute", "p_amount": 1}, true)

# ====================================================================
# POTENCIA Y GENERADORES
# ====================================================================

func add_temporary_power(amount: float) -> void:
	temporary_kwp += amount
	last_minigame_time = int(Time.get_unix_time_from_system())
	_recalc_total_power()

func set_generator_power(gen_id: String, is_active: bool, kwp_amount: float, kw_rate: float = 0.000000001) -> void:
	if gen_id == "": gen_id = "default_plant"
	if kwp_amount <= 0.0: kwp_amount = 0.000000001
		
	if is_active:
		active_generator_powers[gen_id] = kwp_amount
		active_kw_rates[gen_id] = kw_rate
	else:
		active_generator_powers.erase(gen_id)
		active_kw_rates.erase(gen_id)
		
	_recalc_total_power()

func _recalc_total_power() -> void:
	var gen_sum: float = 0.0
	for p in active_generator_powers.values():
		gen_sum += float(p)
		
	total_kwp = gen_sum + temporary_kwp + referral_power_kwp
	
	var gen_rates_sum: float = 0.0
	for r in active_kw_rates.values():
		gen_rates_sum += float(r)
	total_kw_per_minute = gen_rates_sum + referral_power_kwp
	
	has_active_generator = (active_generator_powers.size() > 0 or referral_power_kwp > 0.0)
	EventBus.power_updated.emit(total_kwp)

# ====================================================================
# SINCRONIZACIÓN CON SUPABASE
# ====================================================================

func load_profile() -> bool:
	if SupabaseClient.current_user_id == "":
		EventBus.profile_error.emit("No hay sesión activa.")
		return false
		
	await SupabaseClient.send_request("/rest/v1/rpc/apply_offline_power_decay", HTTPClient.METHOD_POST, {}, true)
	
	var endpoint: String = "/rest/v1/profiles?id=eq." + SupabaseClient.current_user_id + "&select=*"
	var res: Dictionary = await SupabaseClient.send_request(endpoint, HTTPClient.METHOD_GET, {}, true)
	
	if not res.get("success", false):
		EventBus.profile_error.emit("Error al obtener perfil: " + str(res.get("error", "")))
		return false
		
	var data = res.get("data")
	if typeof(data) == TYPE_ARRAY and data.size() > 0:
		var profile: Dictionary = data[0]
		username = str(profile.get("username", ""))
		watt = float(profile.get("watt", 0.0))
		kilowat = float(profile.get("kilowat", 0.0))
		casino_tokens = float(profile.get("casino_tokens", 0.0))
		temporary_kwp = float(profile.get("temporary_kwp", 0.0))
		referral_power_kwp = float(profile.get("referral_power_kwp", 0.0))
		mining_split_watt = float(profile.get("mining_split_watt", 50.0))
		
		last_split_change_time = _parse_iso_datetime(str(profile.get("last_split_change_at", "")))
		has_claimed_welcome_gift = bool(profile.get("has_claimed_welcome_gift", false))
		
		if not has_claimed_welcome_gift:
			await claim_welcome_gift()

		var raw_bgs = profile.get("unlocked_backgrounds", ["default"])
		if typeof(raw_bgs) == TYPE_ARRAY:
			unlocked_backgrounds = raw_bgs
		elif typeof(raw_bgs) == TYPE_STRING:
			var clean_str = raw_bgs.replace("{", "").replace("}", "").replace('"', "").strip_edges()
			unlocked_backgrounds = clean_str.split(",") if clean_str != "" else ["default"]
		else:
			unlocked_backgrounds = ["default"]
			
		equipped_background = str(profile.get("equipped_background", "default"))
		
		var parsed_mg_time = _parse_iso_datetime(str(profile.get("last_minigame_at", "")))
		last_minigame_time = parsed_mg_time if parsed_mg_time > 0 else int(Time.get_unix_time_from_system())
			
		await load_player_inventory()
		await load_player_rpg_state()
		await sync_passive_income()
		
		_recalc_total_power()
		EventBus.profile_loaded.emit(profile)
		EventBus.currencies_updated.emit(watt, kilowat)
		return true
	return false

func load_player_inventory() -> void:
	var uid: String = SupabaseClient.current_user_id
	if uid == "": return
	
	var res_racks: Dictionary = await SupabaseClient.send_request("/rest/v1/player_racks?user_id=eq." + uid + "&select=*", HTTPClient.METHOD_GET, {}, true)
	if res_racks.get("success", false) and typeof(res_racks.get("data")) == TYPE_ARRAY:
		player_racks = res_racks["data"]
		
	var res_gens: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_player_generators_secure", HTTPClient.METHOD_POST, {}, true)
	if res_gens.get("success", false) and typeof(res_gens.get("data")) == TYPE_DICTIONARY:
		var fetched_gens = res_gens["data"].get("generators", [])
		if typeof(fetched_gens) == TYPE_ARRAY:
			player_generators = fetched_gens

	# Cargar inventario de repuestos
	var res_parts: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_player_parts", HTTPClient.METHOD_POST, {}, true)
	if res_parts.get("success", false) and typeof(res_parts.get("data")) == TYPE_DICTIONARY:
		player_parts = res_parts["data"].get("parts", [])

func sync_passive_income() -> void:
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/sync_generator_income", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var res_prof: Dictionary = await SupabaseClient.send_request("/rest/v1/profiles?id=eq." + SupabaseClient.current_user_id + "&select=watt,kilowat,referral_power_kwp", HTTPClient.METHOD_GET, {}, true)
		if res_prof.get("success", false) and typeof(res_prof.get("data")) == TYPE_ARRAY and res_prof["data"].size() > 0:
			watt = float(res_prof["data"][0].get("watt", watt))
			kilowat = float(res_prof["data"][0].get("kilowat", kilowat))
			referral_power_kwp = float(res_prof["data"][0].get("referral_power_kwp", referral_power_kwp))
			_recalc_total_power()
			EventBus.currencies_updated.emit(watt, kilowat)

# ====================================================================
# TALLER MECÁNICO Y PIEZAS (BLINDADO PARA PARCHE .PCK)
# ====================================================================

## Suma las piezas ganadas en memoria inmediatamente
func add_part_locally(part_type: String, part_level: int, qty: int) -> void:
	var clean_type = part_type.strip_edges().to_lower()
	var found = false
	for p in player_parts:
		var p_t = str(p.get("part_type", "")).strip_edges().to_lower()
		var p_l = int(p.get("part_level", p.get("level", 0)))
		if p_t == clean_type and p_l == part_level:
			p["quantity"] = int(p.get("quantity", 0)) + qty
			found = true
			break
	if not found:
		player_parts.append({
			"part_type": clean_type,
			"part_level": part_level,
			"quantity": qty
		})

## Descuenta piezas en memoria al reparar o mejorar
func deduct_part_locally(part_type: String, part_level: int, qty: int) -> void:
	var clean_type = part_type.strip_edges().to_lower()
	for p in player_parts:
		var p_t = str(p.get("part_type", "")).strip_edges().to_lower()
		var p_l = int(p.get("part_level", p.get("level", 0)))
		if p_t == clean_type and p_l == part_level:
			p["quantity"] = maxi(0, int(p.get("quantity", 0)) - qty)
			break

## Búsqueda flexible insensible a mayúsculas
func get_part_quantity(part_type: String, part_level: int) -> int:
	var target_type = part_type.strip_edges().to_lower()
	for p in player_parts:
		var p_t = str(p.get("part_type", "")).strip_edges().to_lower()
		var p_l = int(p.get("part_level", p.get("level", 0)))
		if p_t == target_type and p_l == part_level:
			return int(p.get("quantity", 0))
	return 0

## Carga directa desde la tabla player_parts de Supabase con fallback a RPC
func load_player_parts() -> void:
	var uid = SupabaseClient.current_user_id
	if uid == "": return

	# 1. Consulta REST directa (rápida y estándar)
	var res = await SupabaseClient.send_request("/rest/v1/player_parts?user_id=eq." + uid + "&select=*&quantity=gt.0", HTTPClient.METHOD_GET, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_ARRAY:
		player_parts = res["data"]
		return

	# 2. Fallback por RPC
	var res_rpc = await SupabaseClient.send_request("/rest/v1/rpc/get_player_parts", HTTPClient.METHOD_POST, {}, true)
	if res_rpc.get("success", false) and typeof(res_rpc.get("data")) == TYPE_DICTIONARY:
		player_parts = res_rpc["data"].get("parts", [])

func repair_generator_secure(gen_db_id: String) -> Dictionary:
	var gen: Dictionary = {}
	for g in player_generators:
		if str(g.get("id", "")) == gen_db_id:
			gen = g
			break

	if gen.is_empty():
		return {"success": false, "error": "Generador no encontrado"}

	var gtype = str(gen.get("generator_type", ""))
	var tier = get_generator_tier(gtype)
	
	# Matriz de requisitos por Tier
	var req_c = 0; var req_v = 0; var req_p = 0; var req_chip = 0; var req_cond = 0
	match tier:
		1: req_c = 6; req_v = 4
		2: req_c = 8; req_v = 5
		3: req_c = 10; req_v = 6; req_p = 4
		4: req_c = 12; req_v = 8; req_chip = 4
		5: req_c = 15; req_v = 10; req_chip = 6; req_cond = 4

	if req_c > 0 and get_part_quantity("cable", tier) < req_c:
		return {"success": false, "error": "Faltan Cables Nv.%d (%d requeridos)" % [tier, req_c]}
	if req_v > 0 and get_part_quantity("ventilador", tier) < req_v:
		return {"success": false, "error": "Faltan Ventiladores Nv.%d (%d requeridos)" % [tier, req_v]}
	if req_p > 0 and get_part_quantity("panel", tier) < req_p:
		return {"success": false, "error": "Faltan Paneles Nv.%d (%d requeridos)" % [tier, req_p]}
	if req_chip > 0 and get_part_quantity("chip", tier) < req_chip:
		return {"success": false, "error": "Faltan Microchips Nv.%d (%d requeridos)" % [tier, req_chip]}
	if req_cond > 0 and get_part_quantity("condensador", tier) < req_cond:
		return {"success": false, "error": "Faltan Condensadores Nv.%d (%d requeridos)" % [tier, req_cond]}

	var res = await SupabaseClient.send_request("/rest/v1/rpc/repair_generator", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	if res.get("success", false) and res.get("data", {}).get("success", false):
		if req_c > 0: deduct_part_locally("cable", tier, req_c)
		if req_v > 0: deduct_part_locally("ventilador", tier, req_v)
		if req_p > 0: deduct_part_locally("panel", tier, req_p)
		if req_chip > 0: deduct_part_locally("chip", tier, req_chip)
		if req_cond > 0: deduct_part_locally("condensador", tier, req_cond)
		
		# Restaurar durabilidad local
		gen["durability"] = 100.0
		await load_player_inventory()
		return {"success": true}
		
	var err = res.get("data", {}).get("error", "Error al reparar generador")
	return {"success": false, "error": err}

## Helper para obtener el Tier de cualquier generador
func get_generator_tier(gtype: String) -> int:
	match gtype:
		"planta_meme", "dinamo_manual", "ecoflow_spark", "bateria_plomo": return 1
		"ecoflow_spark_plus", "panel_solar", "molino_eolico": return 2
		"delta_mini", "inverter_silencioso": return 3
		"ecoflow_thunder_pro", "pro_electrico", "turbina_hidro": return 4
		"ecoflow_ultra", "cyber_tank", "reactor_magnetico": return 5
		_: return 1

func upgrade_generator_secure(gen_db_id: String) -> Dictionary:
	var gen: Dictionary = {}
	for g in player_generators:
		if str(g.get("id", "")) == gen_db_id:
			gen = g
			break

	if gen.is_empty():
		return {"success": false, "error": "Generador no encontrado"}

	var lvl = int(gen.get("level", 1))
	if lvl >= 4:
		return {"success": false, "error": "Ya se encuentra en el nivel máximo (Nivel 4)."}

	var target_lvl = lvl + 1
	var gtype = str(gen.get("generator_type", ""))
	var tier = get_generator_tier(gtype)

	# Escala de piezas según el nivel objetivo
	var req_c = 10 if target_lvl == 2 else (16 if target_lvl == 3 else 24)
	var req_v = 8 if target_lvl == 2 else (12 if target_lvl == 3 else 18)
	var req_p = 6 if target_lvl == 2 else (10 if target_lvl == 3 else 14)
	var req_chip = 4 if target_lvl == 2 else (6 if target_lvl == 3 else 8)
	var req_cond = 2 if target_lvl == 2 else (3 if target_lvl == 3 else 4)

	# Ajustar según el Tier del generador
	if tier == 1: req_p = 0
	if tier <= 2: req_chip = 0; req_cond = 0
	if tier <= 4: req_cond = 0

	# Comprobar existencias locales
	if req_c > 0 and get_part_quantity("cable", tier) < req_c:
		return {"success": false, "error": "Faltan Cables Nv.%d (%d requeridos)" % [tier, req_c]}
	if req_v > 0 and get_part_quantity("ventilador", tier) < req_v:
		return {"success": false, "error": "Faltan Ventiladores Nv.%d (%d requeridos)" % [tier, req_v]}
	if req_p > 0 and get_part_quantity("panel", tier) < req_p:
		return {"success": false, "error": "Faltan Paneles Nv.%d (%d requeridos)" % [tier, req_p]}
	if req_chip > 0 and get_part_quantity("chip", tier) < req_chip:
		return {"success": false, "error": "Faltan Microchips Nv.%d (%d requeridos)" % [tier, req_chip]}
	if req_cond > 0 and get_part_quantity("condensador", tier) < req_cond:
		return {"success": false, "error": "Faltan Condensadores Nv.%d (%d requeridos)" % [tier, req_cond]}

	var res = await SupabaseClient.send_request("/rest/v1/rpc/upgrade_generator_level", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	if res.get("success", false) and res.get("data", {}).get("success", false):
		if req_c > 0: deduct_part_locally("cable", tier, req_c)
		if req_v > 0: deduct_part_locally("ventilador", tier, req_v)
		if req_p > 0: deduct_part_locally("panel", tier, req_p)
		if req_chip > 0: deduct_part_locally("chip", tier, req_chip)
		if req_cond > 0: deduct_part_locally("condensador", tier, req_cond)
		
		gen["level"] = target_lvl
		await load_player_inventory()
		return {"success": true, "new_level": target_lvl}
		
	var err = res.get("data", {}).get("error", "Error al subir de nivel") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red"
	return {"success": false, "error": err}

# ====================================================================
# ACCIONES DE JUEGO (RPCS)
# ====================================================================

func get_owned_generator_count(gen_type: String) -> int:
	var count: int = 0
	for g in player_generators:
		if str(g.get("generator_type", "")) == gen_type:
			count += 1
	return count

func get_remaining_split_cooldown() -> int:
	var now: int = int(Time.get_unix_time_from_system())
	var elapsed: int = now - last_split_change_time
	if elapsed < 21600:
		return 21600 - elapsed
	return 0

func save_mining_split_secure(new_split_watt: float) -> Dictionary:
	var body = {"p_split_watt": new_split_watt}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/set_mining_split_secure", HTTPClient.METHOD_POST, body, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		mining_split_watt = new_split_watt
		last_split_change_time = int(Time.get_unix_time_from_system())
		return {"success": true}
	else:
		var err = res["data"].get("error", "Error al guardar reparto.") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red."
		return {"success": false, "error": err}

func buy_shop_item_secure(item_id: String, category: String, price: float, currency: String) -> Dictionary:
	var body = {
		"p_item_id": item_id,
		"p_category": category,
		"p_price": price,
		"p_currency": currency
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/purchase_shop_item", HTTPClient.METHOD_POST, body, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		watt = float(res["data"].get("new_watt", watt))
		kilowat = float(res["data"].get("new_kilowat", kilowat))
		EventBus.currencies_updated.emit(watt, kilowat)
		await load_player_inventory()
		return {"success": true}
	else:
		var err = res["data"].get("error", "Error en la compra.") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de conexión."
		return {"success": false, "error": err}

func claim_welcome_gift() -> Dictionary:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/claim_welcome_gift_popup", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false) == true:
		has_claimed_welcome_gift = true
		await load_player_inventory()
		return {"success": true}
	var err_msg = res["data"].get("error", "Error al reclamar kit.") if typeof(res.get("data")) == TYPE_DICTIONARY else "Error de red."
	return {"success": false, "error": err_msg}

func place_rack_in_slot(rack_db_id: String, slot_index: int) -> bool:
	for r in player_racks:
		var r_id = str(r.get("id", r.get("rack_id", "")))
		if r_id == rack_db_id:
			r["slot_index"] = slot_index
		elif int(r.get("slot_index", -1)) == slot_index:
			r["slot_index"] = -1

	var body = {"p_rack_id": rack_db_id, "p_slot_index": slot_index}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/place_rack_secure", HTTPClient.METHOD_POST, body, true)
	return res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)

func place_generator_in_rack(gen_db_id: String, rack_db_id: String, slot_in_rack: int) -> Dictionary:
	var body = {
		"p_gen_id": str(gen_db_id).strip_edges(),
		"p_rack_id": str(rack_db_id).strip_edges(),
		"p_slot_in_rack": slot_in_rack
	}
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/place_generator_secure", HTTPClient.METHOD_POST, body, true)
	var is_ok: bool = res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)
	
	if is_ok:
		for g in player_generators:
			var g_id = str(g.get("id", g.get("gen_id", "")))
			if g_id == gen_db_id:
				g["rack_id"] = rack_db_id
				g["slot_in_rack"] = slot_in_rack
				break
		return {"success": true}
	else:
		var err_msg = "Error desconocido al colocar generador"
		if typeof(res.get("data")) == TYPE_DICTIONARY:
			var d = res["data"]
			if d.has("error"): err_msg = str(d["error"])
			elif d.has("message"): err_msg = str(d["message"])
		elif res.has("error") and res["error"] != "":
			err_msg = str(res["error"])
			
		return {"success": false, "error": err_msg}

func unmount_generator(gen_db_id: String) -> bool:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/unmount_generator_secure", HTTPClient.METHOD_POST, {"p_gen_id": gen_db_id}, true)
	for g in player_generators:
		if str(g.get("id", g.get("gen_id", ""))) == gen_db_id:
			g["rack_id"] = null
			g["slot_in_rack"] = -1
			break
	return res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)

func unmount_rack_complete(rack_db_id: String) -> bool:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/unmount_rack_complete", HTTPClient.METHOD_POST, {"p_rack_id": rack_db_id}, true)
	for r in player_racks:
		if str(r.get("id", r.get("rack_id", ""))) == rack_db_id:
			r["slot_index"] = -1
			break
	for g in player_generators:
		if str(g.get("rack_id", "")) == rack_db_id:
			g["rack_id"] = null
			g["slot_in_rack"] = -1
	return res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false)

func equip_background(bg_id: String) -> bool:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/equip_room_background", HTTPClient.METHOD_POST, {"p_bg_id": bg_id}, true)
	if res.get("success", false) and res["data"].get("success", false):
		equipped_background = bg_id
		return true
	return false

func set_cooldown_seconds(game_id: String, seconds: int) -> void:
	if seconds > 0:
		minigame_cooldown_ticks[game_id] = Time.get_ticks_msec() + (seconds * 1000)
	else:
		minigame_cooldown_ticks.erase(game_id)

func get_remaining_cooldown_seconds(game_id: String) -> int:
	if not minigame_cooldown_ticks.has(game_id):
		return 0
	var target_ticks: int = minigame_cooldown_ticks[game_id]
	var current_ticks: int = Time.get_ticks_msec()
	if current_ticks < target_ticks:
		return int(ceil(float(target_ticks - current_ticks) / 1000.0))
	minigame_cooldown_ticks.erase(game_id)
	return 0

func _on_signed_out() -> void:
	username = ""
	watt = 0.0
	kilowat = 0.0
	casino_tokens = 0.0
	total_kwp = 0.0
	temporary_kwp = 0.0
	referral_power_kwp = 0.0
	mining_split_watt = 50.0
	last_split_change_time = 0
	target_shop_category = "generators"
	unlocked_backgrounds = ["default"]
	equipped_background = "default"
	active_generator_powers.clear()
	minigame_cooldown_ticks.clear()
	has_active_generator = false
	cycle_60s_timer = 0.0
	online_quest_timer = 0.0
	player_racks.clear()
	player_generators.clear()
	player_parts.clear()
	has_claimed_welcome_gift = false
	open_battle_pass_on_room = false
	saved_chat_channel_mode = "global"
	saved_active_friend_id = ""
	saved_active_friend_name = ""
	saved_is_chat_minimized = false
	pending_friend_requests_count = 0
	player_materials.clear()
	player_talents.clear()
	talent_points = 0
	player_professions = {
		"chatarrero_level": 0, "chatarrero_xp": 0,
		"ingeniero_level": 0, "ingeniero_xp": 0,
		"corredor_level": 0, "corredor_xp": 0
	}

func _parse_iso_datetime(dt_str: String) -> int:
	if dt_str == "" or dt_str == "null":
		return 0
	var clean: String = dt_str.replace("Z", "")
	if "+" in clean: clean = clean.split("+")[0]
	if "." in clean: clean = clean.split(".")[0]
	return int(Time.get_unix_time_from_datetime_string(clean))
	
## Envía la solicitud de fabricación al servidor y sincroniza inventarios de inmediato
func craft_piece_secure(piece_type: String, tier: int, qty: int = 1) -> Dictionary:
	var body = {
		"p_piece_type": piece_type.strip_edges().to_lower(),
		"p_tier": tier,
		"p_quantity": qty
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/craft_workshop_piece", HTTPClient.METHOD_POST, body, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		var crafted_qty = int(d.get("quantity_crafted", qty))
		var clean_type = piece_type.strip_edges().to_lower()
		
		# 1. Sumar pieza localmente
		add_part_locally(clean_type, tier, crafted_qty)
		
		# 2. Descontar materiales de memoria local
		match clean_type:
			"cable":
				deduct_material_locally("cobre", tier, 4 * qty)
				deduct_material_locally("plastico", tier, 2 * qty)
			"ventilador":
				deduct_material_locally("hierro", tier, 4 * qty)
				deduct_material_locally("plastico", tier, 2 * qty)
			"panel":
				deduct_material_locally("silicio", tier, 3 * qty)
				deduct_material_locally("cobre", tier, 3 * qty)
			"chip":
				deduct_material_locally("silicio", tier, 4 * qty)
				deduct_material_locally("cobre", tier, 2 * qty)
				deduct_material_locally("hierro", tier, 1 * qty)
			"condensador":
				deduct_material_locally("cobre", tier, 5 * qty)
				deduct_material_locally("silicio", tier, 5 * qty)
				deduct_material_locally("hierro", tier, 5 * qty)
				
		# 3. Actualizar datos de Ingeniero
		if d.has("new_level"):
			player_professions["ingeniero_level"] = int(d["new_level"])
			
		return {"success": true, "data": d}
	else:
		var err = res.get("data", {}).get("error", "Error al fabricar") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red"
		return {"success": false, "error": err}

# ====================================================================
# SISTEMA RPG: GESTIÓN DE MATERIALES Y PROFESIONES
# ====================================================================

## Carga el estado RPG unificado desde Supabase
func load_player_rpg_state() -> void:
	if SupabaseClient.current_user_id == "": return
	
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_player_rpg_state", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		talent_points = int(d.get("talent_points", 0))
		player_materials = d.get("materials", [])
		player_professions = d.get("professions", player_professions)
		player_talents = d.get("talents", [])

## Consulta la cantidad de un material específico
func get_material_quantity(mat_type: String, tier: int) -> int:
	var clean_type = mat_type.strip_edges().to_lower()
	for m in player_materials:
		if str(m.get("material_type", "")).strip_edges().to_lower() == clean_type and int(m.get("tier", 1)) == tier:
			return int(m.get("quantity", 0))
	return 0

## Agrega materiales inmediatamente en memoria local (ej: drop de minijuegos)
func add_material_locally(mat_type: String, tier: int, qty: int) -> void:
	var clean_type = mat_type.strip_edges().to_lower()
	var found = false
	for m in player_materials:
		if str(m.get("material_type", "")).strip_edges().to_lower() == clean_type and int(m.get("tier", 1)) == tier:
			m["quantity"] = int(m.get("quantity", 0)) + qty
			found = true
			break
	if not found:
		player_materials.append({
			"material_type": clean_type,
			"tier": tier,
			"quantity": qty
		})

## Descuenta materiales en memoria local (ej: crafteo en taller)
func deduct_material_locally(mat_type: String, tier: int, qty: int) -> void:
	var clean_type = mat_type.strip_edges().to_lower()
	for m in player_materials:
		if str(m.get("material_type", "")).strip_edges().to_lower() == clean_type and int(m.get("tier", 1)) == tier:
			m["quantity"] = maxi(0, int(m.get("quantity", 0)) - qty)
			break

## Devuelve el nivel actual de una profesión (0 a 25)
func get_profession_level(prof_name: String) -> int:
	var key = prof_name.to_lower() + "_level"
	return int(player_professions.get(key, 0))

## Devuelve la XP acumulada en una profesión
func get_profession_xp(prof_name: String) -> int:
	var key = prof_name.to_lower() + "_xp"
	return int(player_professions.get(key, 0))
	
## Procesa las recompensas RPG de minijuegos y genera el texto para el mensaje de victoria
func process_minigame_rpg_rewards(data: Dictionary) -> String:
	var msg: String = ""
	
	# 1. Procesar Material obtenido
	if bool(data.get("has_dropped_material", false)):
		var mat_type: String = str(data.get("material_type", "cobre")).strip_edges().to_lower()
		var tier: int = int(data.get("material_tier", 1))
		var qty: int = int(data.get("material_qty", 1))
		
		# Sumar de inmediato a la memoria local
		add_material_locally(mat_type, tier, qty)
		
		var mat_names = {
			"cobre": "Cobre Bruto",
			"plastico": "Plástico Reciclado",
			"silicio": "Silicio / Cuarzo",
			"hierro": "Chatarra de Hierro"
		}
		var display_name = mat_names.get(mat_type, mat_type.capitalize())
		msg += "\n📦 Botín: +%d %s (Tier %d)" % [qty, display_name, tier]
		
	# 2. Procesar XP y Nivel de Chatarrero
	var xp_gained: int = int(data.get("chatarrero_xp_gained", 0))
	if xp_gained > 0:
		msg += "\n⭐ +%d XP de Chatarrero" % xp_gained
		
	if bool(data.get("chatarrero_leveled_up", false)):
		var new_lvl: int = int(data.get("new_chatarrero_level", 1))
		player_professions["chatarrero_level"] = new_lvl
		msg += "\n🎉 ¡SUBISTE A NIVEL %d DE CHATARRERO!" % new_lvl
		
	return msg
	
## Obtiene la lista de contratos diarios del servidor
func get_daily_contracts_secure() -> Array:
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/get_or_create_daily_contracts", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		return res["data"].get("contracts", [])
	return []

## Entrega el contrato, descuenta los recursos y actualiza monedas en memoria local
func deliver_contract_secure(contract_dict: Dictionary) -> Dictionary:
	var c_id = str(contract_dict.get("id", ""))
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/deliver_daily_contract", HTTPClient.METHOD_POST, {"p_contract_id": c_id}, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		
		# 1. Deducir recursos localmente
		var p_type = str(contract_dict.get("req_piece_type", ""))
		var p_tier = int(contract_dict.get("req_piece_tier", 1))
		var p_qty = int(contract_dict.get("req_piece_qty", 1))
		var req_w = float(contract_dict.get("req_watt", 0.0))
		
		deduct_part_locally(p_type, p_tier, p_qty)
		watt = maxf(0.0, watt - req_w)
		
		# 2. Sumar recompensas
		talent_points += int(d.get("reward_talent_points", 1))
		casino_tokens += int(d.get("reward_casino_tokens", 1))
		
		EventBus.currencies_updated.emit(watt, kilowat)
		return {"success": true, "data": d}
	else:
		var err = res.get("data", {}).get("error", "Error al entregar") if typeof(res.get("data")) == TYPE_DICTIONARY else "Fallo de red"
		return {"success": false, "error": err}
		
## Devuelve el nivel desbloqueado de un talento específico (0 si no lo tiene, max 3)
func get_talent_level(talent_id: String) -> int:
	for t in player_talents:
		if str(t.get("talent_id", "")) == talent_id:
			return int(t.get("level", 1))
	return 0

## Envía la mejora al servidor y extrae el error real si algo falla
func upgrade_talent_secure(talent_id: String, branch: String, cost_points: int, cost_watt: float, prereq_id: String = "") -> Dictionary:
	var body = {
		"p_talent_id": talent_id,
		"p_branch": branch,
		"p_cost_points": cost_points,
		"p_cost_watt": cost_watt,
		"p_prereq_id": prereq_id
	}
	
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/upgrade_player_talent", HTTPClient.METHOD_POST, body, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var d = res["data"]
		var new_lvl = int(d.get("new_level", 1))
		
		# Deducir en memoria local
		talent_points = maxi(0, talent_points - cost_points)
		watt = maxf(0.0, watt - cost_watt)
		EventBus.currencies_updated.emit(watt, kilowat)
		
		var found = false
		for t in player_talents:
			if str(t.get("talent_id", "")) == talent_id:
				t["level"] = new_lvl
				found = true
				break
		if not found:
			player_talents.append({
				"talent_id": talent_id,
				"talent_branch": branch,
				"level": new_lvl
			})
			
		return {"success": true, "data": d}
	else:
		# Extraer el error real de Supabase (sea "error", "message" o "msg")
		var err_msg = "Error de conexión"
		if typeof(res.get("data")) == TYPE_DICTIONARY:
			var d = res["data"]
			if d.has("error"): err_msg = str(d["error"])
			elif d.has("message"): err_msg = str(d["message"])
			elif d.has("msg"): err_msg = str(d["msg"])
		elif res.has("error") and res["error"] != "":
			err_msg = str(res["error"])
			
		return {"success": false, "error": err_msg}
```

---

###### 📄 Archivo: `game_manager.gd.uid`

```
uid://bu43xvkmy6hod

```

---

##### 📁 Carpeta: `./core\updater/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `ota_updater.gd`

```
# res://core/updater/ota_updater.gd
extends Control

const GITHUB_USER: String = "mariaelenabernia3-jpg"
const GITHUB_REPO: String = "kilowat-game"

const BASE_VERSION: String = "1.0.0"
const UPDATES_DIR: String = "user://updates/"
const VERSION_FILE: String = "user://installed_version.txt"

# ¡Ruta moderna modular para entrar al juego!
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
	
	if OS.has_feature("editor"):
		print("[OTA] Modo editor detectado. Saltando comprobación.")
		_proceed_to_game()
		return

	if not DirAccess.dir_exists_absolute(UPDATES_DIR):
		DirAccess.make_dir_recursive_absolute(UPDATES_DIR)
		
	# 1. Montar parche previo en disco si existe
	_mount_existing_patch()

	# 2. Comprobar nueva versión en GitHub
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
		print("[OTA] Parche montado con éxito en memoria.")
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
	
	# Prioridad 1: Parche .pck liviano (3-5 MB)
	for asset in assets:
		var name_str := str(asset.get("name", "")).to_lower()
		if name_str.ends_with(".pck"):
			target_download_url = str(asset.get("browser_download_url", ""))
			download_name = "patch.pck"
			download_total_bytes = int(asset.get("size", 0))
			is_pck_patch = true
			break
			
	# Prioridad 2: Si no hay parche, APK completa
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
	
	# Verificar código 200 y tamaño para evitar parches corruptos
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
	if pulse_tween: 
		pulse_tween.kill()
	get_tree().change_scene_to_file.call_deferred(MAIN_GAME_SCENE)

```

---

###### 📄 Archivo: `ota_updater.gd.uid`

```
uid://uf8glu0ogx5w

```

---

###### 📄 Archivo: `ota_updater.tscn`

```
[gd_scene format=3 uid="uid://7ckyh62lbs7b"]

[ext_resource type="Script" uid="uid://uf8glu0ogx5w" path="res://core/updater/ota_updater.gd" id="1_otaupdater"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel"]
bg_color = Color(0.08, 0.09, 0.13, 0.98)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.25, 0.5, 0.85, 0.8)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn"]
bg_color = Color(0.12, 0.75, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.5, 0.9, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="OtaUpdater" type="Control" unique_id=1566901861]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_otaupdater")

[node name="Background" type="ColorRect" parent="." unique_id=105167475]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="Center" type="CenterContainer" parent="." unique_id=1679766146]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="Panel" type="PanelContainer" parent="Center" unique_id=134781924]
custom_minimum_size = Vector2(480, 220)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel")

[node name="Margin" type="MarginContainer" parent="Center/Panel" unique_id=946188171]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 20

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin" unique_id=1047011233]
layout_mode = 2
theme_override_constants/separation = 14
alignment = 1

[node name="Logo" type="Label" parent="Center/Panel/Margin/VBox" unique_id=447087760]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.85, 1, 1)
theme_override_font_sizes/font_size = 24
text = "⚡ KILOWAT"
horizontal_alignment = 1

[node name="StatusLabel" type="Label" parent="Center/Panel/Margin/VBox" unique_id=1326654057]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.85, 0.9, 0.9)
theme_override_font_sizes/font_size = 13
text = "Comprobando contenido descargable..."
horizontal_alignment = 1

[node name="ProgressBar" type="ProgressBar" parent="Center/Panel/Margin/VBox" unique_id=1190112639]
custom_minimum_size = Vector2(0, 16)
layout_mode = 2

[node name="ActionButton" type="Button" parent="Center/Panel/Margin/VBox" unique_id=1651534728]
visible = false
custom_minimum_size = Vector2(180, 38)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_color = Color(0.04, 0.06, 0.1, 1)
theme_override_styles/normal = SubResource("StyleBoxFlat_btn")
text = "Descargar"

```

---

#### 📁 Carpeta: `./data/`

##### 📁 Carpeta: `./data\definitions/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `generator_data.gd`

```
# res://data/definitions/generator_data.gd
class_name GeneratorData
extends Resource

@export var id: String = "planta_meme"
@export var name: String = "Planta Meme"
@export var level: int = 1
@export var rarity: String = "COMÚN"
@export var item_type: String = "Generador"
@export_multiline var description: String = "No genera electricidad. Bueno... técnicamente genera un poquito."

@export var slots_required: int = 1
@export var is_purchasable: bool = false
@export var cost_watt: float = 0.0
@export var cost_kilowat: float = 0.0

@export var power_kwp: float = 0.000000001
@export var cycle_time_seconds: float = 60.0
@export var reward_kilowat: float = 0.000000001

@export var texture: Texture2D
```

---

###### 📄 Archivo: `generator_data.gd.uid`

```
uid://b6tlkl0nonx5o

```

---

###### 📄 Archivo: `material_data.gd`

```
# res://data/definitions/material_data.gd
class_name MaterialData
extends Resource

@export var id: String = "cobre_t1"
@export var name: String = "Cobre Bruto"
@export var material_type: String = "cobre" # "cobre", "plastico", "silicio", "hierro"
@export_range(1, 5) var tier: int = 1
@export var rarity_name: String = "Común"
@export var texture: Texture2D

static func get_tier_color(t: int) -> Color:
	match t:
		1: return Color(0.4, 0.75, 1.0)   # Común (Azul claro)
		2: return Color(0.2, 0.85, 0.45)  # Poco Común (Verde)
		3: return Color(0.85, 0.4, 1.0)   # Especial (Púrpura)
		4: return Color(1.0, 0.45, 0.2)   # Épico (Naranja)
		5: return Color(1.0, 0.82, 0.15)  # Legendario (Dorado)
		_: return Color.WHITE
```

---

###### 📄 Archivo: `material_data.gd.uid`

```
uid://ppmwl1t4ibu5

```

---

###### 📄 Archivo: `rack_data.gd`

```
# res://data/definitions/rack_data.gd
class_name RackData
extends Resource

@export var id: String = "rack_1_floor"
@export var name: String = "Estantería de 1 Piso"
@export_range(1, 3) var floors: int = 1
@export var total_slots: int = 2
@export var price_watt: float = 0.0
@export var price_kilowat: float = 0.0
@export var texture: Texture2D
```

---

###### 📄 Archivo: `rack_data.gd.uid`

```
uid://b7yqyg8btlhoj

```

---

##### 📁 Carpeta: `./data\generators/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `generator_cyber_tank.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/cyber_tank.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "cyber_tank"
name = "Cyber Tank 100%"
level = 1
rarity = "EDICIÓN ESPECIAL LIMITADA"
item_type = "Generador Cuántico"
description = "«Batería pesada de plasma continuo y blindaje (Límite 1): 0.000000900 kW/min continuos.»"
slots_required = 1
is_purchasable = true
cost_watt = 0.0
cost_kilowat = 1.00
power_kwp = 9.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 9.0e-07
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_delta_mini.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/delta_mini.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "delta_mini"
name = "EcoFlow DELTA Mini"
level = 1
rarity = "PREMIUM TEMPORADA 1"
item_type = "EcoFlow"
description = "«Batería portátil de gama alta. Silenciosa y constante: 0.000000300 kW/min.»"
slots_required = 1
is_purchasable = false
cost_watt = 0.0
cost_kilowat = 0.0
power_kwp = 3.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 3.0e-07
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_dinamo_manual.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/dinamo_manual.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "dinamo_manual"
name = "Dinamo Manual"
level = 1
rarity = "PASE TEMPORADA 1"
item_type = "Generador"
description = "«Hay que darle a la manivela: genera 0.000000025 kW/min continuos.»"
slots_required = 1
is_purchasable = false
cost_watt = 0.0
cost_kilowat = 0.0
power_kwp = 2.5e-08
cycle_time_seconds = 60.0
reward_kilowat = 2.5e-08
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_ecoflow_spark.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/ecoflow_spark.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "ecoflow_spark"
name = "EcoFlow Spark"
level = 1
rarity = "Común"
item_type = "EcoFlow"
description = "«Batería portátil compacta (Máx 4 por cuenta): 0.000000050 kW/min continuos.»"
slots_required = 1
is_purchasable = true
cost_watt = 0.5
cost_kilowat = 0.0
power_kwp = 5.0e-08
cycle_time_seconds = 60.0
reward_kilowat = 5.0e-08
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_ecoflow_spark_plus.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/ecoflow_spark_plus.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "ecoflow_spark_plus"
name = "EcoFlow Spark Plus"
level = 1
rarity = "Común"
item_type = "EcoFlow"
description = "«Versión mejorada de Spark con celdas de litio (Máx 4): 0.000000100 kW/min continuos.»"
slots_required = 1
is_purchasable = true
cost_watt = 0.8
cost_kilowat = 0.0
power_kwp = 1.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 1.0e-07
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_ecoflow_thunder_pro.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/ecoflow_thunder_pro.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "ecoflow_thunder_pro"
name = "EcoFlow Thunder Pro"
level = 1
rarity = "Épico"
item_type = "EcoFlow"
description = "«Estación eléctrica pesada de titanio (Máx 1): produce 0.000000400 kW/min continuos.»"
slots_required = 1
is_purchasable = true
cost_watt = 0.0
cost_kilowat = 0.50
power_kwp = 4.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 4.0e-07
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_ecoflow_ultra.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/ecoflow_ultra.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "ecoflow_ultra"
name = "EcoFlow Ultra"
level = 1
rarity = "Legendario"
item_type = "EcoFlow"
description = "«Almacenamiento masivo industrial: 0.000000600 kW/min ininterrumpidos.»"
slots_required = 1
is_purchasable = true
cost_watt = 0.0
cost_kilowat = 0.80
power_kwp = 6.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 6.0e-07
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_panel_solar.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/panel_solar.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "panel_solar"
name = "Panel Solar"
level = 1
rarity = "PASE TEMPORADA 1 (GRATIS)"
item_type = "Generador"
description = "«Fotoceldas recicladas: genera 0.000000200 kW/min de energía limpia.»"
slots_required = 1
is_purchasable = false
cost_watt = 0.0
cost_kilowat = 0.0
power_kwp = 2.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 2.0e-07
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_planta_lvl1.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/plantalevel1.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "planta_meme"
name = "Planta Meme"
level = 1
rarity = "EXCLUSIVA DEBUT"
item_type = "Meme"
description = "«No genera electricidad. Bueno... técnicamente genera un poquito: 0.000000005 kW/min.»"
slots_required = 1
is_purchasable = false
cost_watt = 0.0
cost_kilowat = 0.0
power_kwp = 5e-09
cycle_time_seconds = 60.0
reward_kilowat = 5e-09
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `generator_pro_electrico.tres`

```
[gd_resource type="Resource" script_class="GeneratorData" format=3]

[ext_resource type="Script" path="res://data/definitions/generator_data.gd" id="1_gen"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/pro_electrico.png" id="2_tex"]

[resource]
script = ExtResource("1_gen")
id = "pro_electrico"
name = "EcoFlow Pro Eléctrico"
level = 1
rarity = "LEGENDARIO TEMPORADA 1"
item_type = "EcoFlow"
description = "«Cúspide tecnológica del pase de batalla: genera 0.000000800 kW/min.»"
slots_required = 1
is_purchasable = false
cost_watt = 0.0
cost_kilowat = 0.0
power_kwp = 8.0e-07
cycle_time_seconds = 60.0
reward_kilowat = 8.0e-07
texture = ExtResource("2_tex")
```

---

##### 📁 Carpeta: `./data\items/`

###### 📄 Archivo: `.gitkeep`

```

```

---

##### 📁 Carpeta: `./data\racks/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `rack_1_floor.tres`

```
[gd_resource type="Resource" script_class="RackData" format=3]

[ext_resource type="Script" path="res://data/definitions/rack_data.gd" id="1_rack"]
[ext_resource type="Texture2D" path="res://assets/sprites/racks/racks1.png" id="2_tex"]

[resource]
script = ExtResource("1_rack")
id = "rack_1_floor"
name = "Estantería de 1 Piso"
floors = 1
total_slots = 2
price_watt = 0.6
price_kilowat = 0.0
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `rack_2_floors.tres`

```
[gd_resource type="Resource" script_class="RackData" format=3]

[ext_resource type="Script" path="res://data/definitions/rack_data.gd" id="1_rack"]
[ext_resource type="Texture2D" path="res://assets/sprites/racks/racks2.png" id="2_tex"]

[resource]
script = ExtResource("1_rack")
id = "rack_2_floors"
name = "Estantería de 2 Pisos"
floors = 2
total_slots = 4
price_watt = 1.0
price_kilowat = 0.0
texture = ExtResource("2_tex")
```

---

###### 📄 Archivo: `rack_3_floors.tres`

```
[gd_resource type="Resource" script_class="RackData" format=3]

[ext_resource type="Script" path="res://data/definitions/rack_data.gd" id="1_rack"]
[ext_resource type="Texture2D" path="res://assets/sprites/racks/racks3.png" id="2_tex"]

[resource]
script = ExtResource("1_rack")
id = "rack_3_floors"
name = "Estantería de 3 Pisos"
floors = 3
total_slots = 6
price_watt = 2.8
price_kilowat = 0.0
texture = ExtResource("2_tex")
```

---

#### 📁 Carpeta: `./features/`

##### 📁 Carpeta: `./features\auth/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `login_screen.gd`

```
# res://features/auth/login_screen.gd
extends Control

@onready var login_panel: PanelContainer = $CenterContainer/PanelContainer
@onready var username_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/UsernameInput
@onready var password_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/PasswordInput
@onready var referral_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ReferralInput
@onready var login_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsVBox/LoginButton
@onready var register_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsVBox/RegisterButton
@onready var status_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatusLabel

var splash_layer: VBoxContainer = null
var splash_status_lbl: Label = null
var pulse_tween: Tween = null

# res://features/auth/login_screen.gd

const INTRO_SCENE: String = "res://features/intro/splash_intro.tscn"
const MAIN_ROOM_SCENE: String = "res://features/room/main_room.tscn"

func _ready() -> void:
	if login_panel == null: login_panel = find_child("PanelContainer", true, false)
	if username_input == null: username_input = find_child("UsernameInput", true, false)
	if password_input == null: password_input = find_child("PasswordInput", true, false)
	if referral_input == null: referral_input = find_child("ReferralInput", true, false)
	if login_button == null: login_button = find_child("LoginButton", true, false)
	if register_button == null: register_button = find_child("RegisterButton", true, false)
	if status_label == null: status_label = find_child("StatusLabel", true, false)
	
	_hot_reload_game_manager_from_patch()

	login_panel.visible = false
	login_panel.modulate.a = 0.0
	status_label.text = ""
	
	login_button.pressed.connect(_on_login_pressed)
	register_button.pressed.connect(_on_register_pressed)
	
	username_input.text_submitted.connect(func(_t): password_input.grab_focus())
	password_input.text_submitted.connect(func(_t): _on_login_pressed())
	if referral_input:
		referral_input.text_submitted.connect(func(_t): _on_register_pressed())
	
	EventBus.auth_signed_in.connect(_on_signed_in)
	EventBus.auth_signed_up.connect(_on_signed_up)
	EventBus.auth_error.connect(_on_auth_error)
	
	_init_session_flow()

func _hot_reload_game_manager_from_patch() -> void:
	var gm := get_node_or_null("/root/GameManager")
	if gm:
		var target_path = "res://core/state/game_manager.gd"
		var new_script = ResourceLoader.load(target_path, "", ResourceLoader.CACHE_MODE_REPLACE)
		if new_script:
			gm.set_script(new_script)
			if gm.has_method("_ready"): gm._ready()

func _init_session_flow() -> void:
	if not SupabaseAuth.load_saved_session():
		_reveal_login_form()
		return
		
	_create_splash_loader("Estableciendo enlace con la red eléctrica...")
	
	var token_valid: bool = await SupabaseAuth.refresh_access_token()
	if not token_valid:
		_reveal_login_form("Tu sesión ha expirado. Ingresa tus credenciales.")
		return
		
	_update_splash_status("Sincronizando estado de los generadores...")
	var profile_ready: bool = await GameManager.load_profile()
	
	if profile_ready:
		_update_splash_status("✓ Conexión establecida. Iniciando...")
		await get_tree().create_timer(0.3).timeout
		_go_to_main_room()
	else:
		_reveal_login_form("Error al sincronizar tu perfil. Inicia sesión nuevamente.")

func _go_to_main_room() -> void:
	# Si existe la presentación, pasa por ella; si no, entra directo a la habitación
	if ResourceLoader.exists(INTRO_SCENE):
		get_tree().change_scene_to_file(INTRO_SCENE)
	else:
		get_tree().change_scene_to_file(MAIN_ROOM_SCENE)

func _create_splash_loader(initial_text: String) -> void:
	splash_layer = VBoxContainer.new()
	splash_layer.custom_minimum_size = Vector2(440, 180)
	splash_layer.alignment = BoxContainer.ALIGNMENT_CENTER
	splash_layer.add_theme_constant_override("separation", 14)
	
	var terminal_card := PanelContainer.new()
	var t_st := StyleBoxFlat.new()
	t_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	t_st.border_color = Color(0.35, 0.88, 1.0, 0.9)
	t_st.set_border_width_all(2)
	t_st.set_corner_radius_all(12)
	t_st.shadow_color = Color(0.15, 0.6, 0.9, 0.3)
	t_st.shadow_size = 14
	terminal_card.add_theme_stylebox_override("panel", t_st)
	
	var tm := MarginContainer.new()
	tm.add_theme_constant_override("margin_left", 24)
	tm.add_theme_constant_override("margin_top", 20)
	tm.add_theme_constant_override("margin_right", 24)
	tm.add_theme_constant_override("margin_bottom", 20)
	terminal_card.add_child(tm)
	
	var tvbox := VBoxContainer.new()
	tvbox.add_theme_constant_override("separation", 12)
	tm.add_child(tvbox)
	
	var logo_lbl := Label.new()
	logo_lbl.text = "⚡ KILOWAT ⚡"
	logo_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	logo_lbl.add_theme_font_size_override("font_size", 26)
	logo_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	tvbox.add_child(logo_lbl)
	
	var sub_lbl := Label.new()
	sub_lbl.text = "SISTEMA DE GENERACIÓN ELÉCTRICA"
	sub_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sub_lbl.add_theme_font_size_override("font_size", 10)
	sub_lbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.85))
	tvbox.add_child(sub_lbl)
	
	var pulse_bar := ProgressBar.new()
	pulse_bar.custom_minimum_size = Vector2(280, 6)
	pulse_bar.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	pulse_bar.show_percentage = false
	pulse_bar.max_value = 100
	pulse_bar.value = 100
	tvbox.add_child(pulse_bar)
	
	splash_status_lbl = Label.new()
	splash_status_lbl.text = initial_text
	splash_status_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	splash_status_lbl.add_theme_font_size_override("font_size", 12)
	splash_status_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2, 0.95))
	tvbox.add_child(splash_status_lbl)
	
	splash_layer.add_child(terminal_card)
	$CenterContainer.add_child(splash_layer)
	
	pulse_tween = create_tween().set_loops()
	pulse_tween.tween_property(splash_status_lbl, "modulate:a", 0.4, 0.7)
	pulse_tween.tween_property(splash_status_lbl, "modulate:a", 1.0, 0.7)

func _update_splash_status(new_status: String) -> void:
	if splash_status_lbl and is_instance_valid(splash_status_lbl):
		splash_status_lbl.text = new_status

func _reveal_login_form(warning_msg: String = "") -> void:
	if pulse_tween and pulse_tween.is_running():
		pulse_tween.kill()
		
	if splash_layer and is_instance_valid(splash_layer):
		var fade_out = create_tween()
		fade_out.tween_property(splash_layer, "modulate:a", 0.0, 0.2)
		await fade_out.finished
		if is_instance_valid(splash_layer):
			splash_layer.queue_free()
		
	login_panel.visible = true
	login_panel.scale = Vector2(0.96, 0.96)
	login_panel.pivot_offset = login_panel.size / 2.0
	
	var reveal_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	reveal_tween.tween_property(login_panel, "modulate:a", 1.0, 0.35)
	reveal_tween.tween_property(login_panel, "scale", Vector2.ONE, 0.35)
	
	if warning_msg != "":
		status_label.text = warning_msg
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

func _set_loading(is_loading: bool) -> void:
	login_button.disabled = is_loading
	register_button.disabled = is_loading
	username_input.editable = not is_loading
	password_input.editable = not is_loading
	if referral_input: referral_input.editable = not is_loading

func _on_login_pressed() -> void:
	var user_text: String = username_input.text.strip_edges()
	var pass_text: String = password_input.text
	
	if user_text == "" or pass_text == "":
		status_label.text = "Por favor completa ambos campos."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		return
		
	status_label.text = "Conectando con la central..."
	status_label.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	_set_loading(true)
	SupabaseAuth.sign_in(user_text, pass_text)

func _on_register_pressed() -> void:
	var user_text: String = username_input.text.strip_edges()
	var pass_text: String = password_input.text
	var ref_text: String = referral_input.text.strip_edges() if referral_input else ""
	
	if user_text == "" or pass_text == "":
		status_label.text = "Por favor completa usuario y contraseña."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		return
		
	status_label.text = "Creando terminal de usuario..."
	status_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	_set_loading(true)
	SupabaseAuth.sign_up(user_text, pass_text, ref_text)

func _on_signed_in(_user_data: Dictionary) -> void:
	status_label.text = "✓ Acceso concedido. Sincronizando..."
	status_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	var ok: bool = await GameManager.load_profile()
	if ok: 
		_go_to_main_room()
	else:
		_set_loading(false)
		status_label.text = "Error al cargar perfil de usuario."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

func _on_signed_up(_user_data: Dictionary) -> void:
	status_label.text = "✓ Terminal creada con éxito. Entrando..."
	status_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	await get_tree().create_timer(0.4).timeout
	var ok: bool = await GameManager.load_profile()
	if ok: 
		_go_to_main_room()
	else:
		_set_loading(false)
		status_label.text = "Error al inicializar la terminal."
		status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

func _on_auth_error(message: String) -> void:
	_set_loading(false)
	status_label.text = message
	status_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))

```

---

###### 📄 Archivo: `login_screen.gd.uid`

```
uid://bq1x3kdmeos10

```

---

###### 📄 Archivo: `login_screen.tscn`

```
[gd_scene format=3 uid="uid://c7k3rqd07v5xm"]

[ext_resource type="Script" path="res://features/auth/login_screen.gd" id="1_login"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/bg_login.png" id="2_bg"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel"]
bg_color = Color(0.07, 0.09, 0.13, 0.95)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.35, 0.88, 1, 0.9)
corner_radius_top_left = 14
corner_radius_top_right = 14
corner_radius_bottom_right = 14
corner_radius_bottom_left = 14
shadow_color = Color(0.12, 0.5, 0.8, 0.25)
shadow_size = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_input"]
content_margin_left = 14.0
content_margin_right = 14.0
bg_color = Color(0.05, 0.06, 0.09, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.3, 0.45, 0.7)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_input_focus"]
content_margin_left = 14.0
content_margin_right = 14.0
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.35, 0.88, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
shadow_color = Color(0.2, 0.7, 1, 0.3)
shadow_size = 6

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn_login"]
bg_color = Color(0.15, 0.75, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.55, 0.95, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
shadow_color = Color(0.1, 0.6, 0.9, 0.35)
shadow_size = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn_register"]
bg_color = Color(0.09, 0.12, 0.18, 0.85)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.3, 0.45, 0.65, 0.8)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="LoginScreen" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_login")

[node name="BackgroundImage" type="TextureRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
texture = ExtResource("2_bg")
expand_mode = 1
stretch_mode = 6

[node name="CenterContainer" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="PanelContainer" type="PanelContainer" parent="CenterContainer"]
custom_minimum_size = Vector2(400, 0)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel")

[node name="MarginContainer" type="MarginContainer" parent="CenterContainer/PanelContainer"]
layout_mode = 2
theme_override_constants/margin_left = 26
theme_override_constants/margin_top = 24
theme_override_constants/margin_right = 26
theme_override_constants/margin_bottom = 24

[node name="VBoxContainer" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="TitleLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 28
text = "⚡ KILOWAT ⚡"
horizontal_alignment = 1

[node name="SubtitleLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2
theme_override_colors/font_color = Color(0.7, 0.75, 0.85, 0.85)
theme_override_font_sizes/font_size = 11
text = "SISTEMA DE GENERACIÓN ELÉCTRICA"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2

[node name="UsernameInput" type="LineEdit" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 44)
layout_mode = 2
mouse_default_cursor_shape = 1
caret_blink = true
theme_override_styles/normal = SubResource("StyleBoxFlat_input")
theme_override_styles/focus = SubResource("StyleBoxFlat_input_focus")
placeholder_text = "👤 Nombre de Usuario"

[node name="PasswordInput" type="LineEdit" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 44)
layout_mode = 2
mouse_default_cursor_shape = 1
caret_blink = true
theme_override_styles/normal = SubResource("StyleBoxFlat_input")
theme_override_styles/focus = SubResource("StyleBoxFlat_input_focus")
placeholder_text = "🔑 Contraseña"
secret = true

[node name="ReferralInput" type="LineEdit" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
mouse_default_cursor_shape = 1
caret_blink = true
theme_override_styles/normal = SubResource("StyleBoxFlat_input")
theme_override_styles/focus = SubResource("StyleBoxFlat_input_focus")
placeholder_text = "👥 Código de Amigo (Opcional)"

[node name="ButtonsVBox" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="LoginButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsVBox"]
custom_minimum_size = Vector2(0, 46)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.04, 0.08, 0.12, 1)
theme_override_font_sizes/font_size = 15
theme_override_styles/normal = SubResource("StyleBoxFlat_btn_login")
theme_override_styles/hover = SubResource("StyleBoxFlat_btn_login")
text = "⚡ ENTRAR A LA CENTRAL"

[node name="RegisterButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsVBox"]
custom_minimum_size = Vector2(0, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.85, 0.9, 0.98, 1)
theme_override_font_sizes/font_size = 13
theme_override_styles/normal = SubResource("StyleBoxFlat_btn_register")
theme_override_styles/hover = SubResource("StyleBoxFlat_btn_register")
text = "Crear Cuenta Nueva"

[node name="StatusLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 24)
layout_mode = 2
theme_override_font_sizes/font_size = 12
horizontal_alignment = 1
autowrap_mode = 2
```

---

##### 📁 Carpeta: `./features\casino/`

###### 📄 Archivo: `roulette_game.gd`

```
# res://features/casino/roulette_game.gd
extends Control

@onready var back_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var chip_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel
@onready var watt_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilo_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel

@onready var spin_button: Button = $CanvasLayerUI/MainVBox/Body/VBox/ControlsBox/SpinButton
@onready var free_timer_lbl: Label = $CanvasLayerUI/MainVBox/Body/VBox/ControlsBox/FreeTimerLabel
@onready var status_toast_lbl: Label = $CanvasLayerUI/MainVBox/Body/VBox/StatusToast
@onready var wheel_container: Control = $CanvasLayerUI/MainVBox/Body/VBox/WheelArea/Center/WheelContainer

# Texturas oficiales del juego
const TEX_WATT = preload("res://assets/sprites/ui/icon_watt.png")
const TEX_CHIP = preload("res://assets/sprites/ui/icon_chip.png")
const TEX_PASS = preload("res://assets/sprites/ui/icon_battlepass.png")
const TEX_SPARK = preload("res://assets/sprites/generators/ecoflow_spark.png")

var wheel_disc: Control = null
var is_spinning: bool = false
var can_free_spin: bool = false
var free_seconds_left: int = 0
var timer_tick: float = 0.0

const TOTAL_SLOTS: int = 8
const SLICE_ANGLE: float = TAU / 8.0 # 45 grados por casilla

# Datos de las 8 casillas con sus colores, iconos reales y textos (sin mostrar probabilidades)
var slots_data: Array = []

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	spin_button.pressed.connect(_on_spin_pressed)
	
	_setup_slots_data()
	_build_centered_wheel()
	_update_hud()
	_check_status_from_server()

func _setup_slots_data() -> void:
	slots_data = [
		{"name": "+25 XP", "icon": TEX_PASS, "color": Color(0.14, 0.26, 0.44), "tint": Color.WHITE, "icon_size": Vector2(22, 22)},
		{"name": "+0.02 W", "icon": TEX_WATT, "color": Color(0.12, 0.38, 0.28), "tint": Color.WHITE, "icon_size": Vector2(20, 20)},
		{"name": "+50 XP", "icon": TEX_PASS, "color": Color(0.20, 0.22, 0.48), "tint": Color.WHITE, "icon_size": Vector2(22, 22)},
		{"name": "+kWp", "icon": TEX_WATT, "color": Color(0.12, 0.42, 0.52), "tint": Color(0.35, 0.95, 1.0), "icon_size": Vector2(20, 20)},
		{"name": "+0.15 W", "icon": TEX_WATT, "color": Color(0.15, 0.46, 0.32), "tint": Color.WHITE, "icon_size": Vector2(20, 20)},
		{"name": "1 CHIP", "icon": TEX_CHIP, "color": Color(0.55, 0.16, 0.45), "tint": Color.WHITE, "icon_size": Vector2(22, 22)},
		{"name": "+0.50 W", "icon": TEX_WATT, "color": Color(0.18, 0.55, 0.35), "tint": Color.WHITE, "icon_size": Vector2(20, 20)},
		{"name": "SPARK", "icon": TEX_SPARK, "color": Color(0.68, 0.52, 0.12), "tint": Color.WHITE, "icon_size": Vector2(26, 26)}
	]

func _process(delta: float) -> void:
	_update_hud()
	if free_seconds_left > 0 and not can_free_spin:
		timer_tick += delta
		if timer_tick >= 1.0:
			timer_tick = 0.0
			free_seconds_left -= 1
			_update_spin_button_ui()

func _update_hud() -> void:
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens
	if watt_lbl and is_instance_valid(watt_lbl):
		watt_lbl.text = "%.4f" % GameManager.watt
	if kilo_lbl and is_instance_valid(kilo_lbl):
		kilo_lbl.text = "%.6f" % GameManager.kilowat

func _on_back_pressed() -> void:
	if is_spinning: return
	get_tree().change_scene_to_file("res://features/casino/mines/casino_hub.tscn")

func _check_status_from_server() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_roulette_status", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		can_free_spin = bool(res["data"].get("can_free_spin", false))
		free_seconds_left = int(res["data"].get("free_spin_in_seconds", 0))
	_update_spin_button_ui()

func _update_spin_button_ui() -> void:
	if is_spinning:
		spin_button.disabled = true
		spin_button.text = "🎡 Girando la ruleta..."
		free_timer_lbl.text = ""
		return

	if can_free_spin:
		spin_button.disabled = false
		spin_button.text = "🎁 ¡GIRO GRATIS DEL DÍA!"
		var st_free := StyleBoxFlat.new()
		st_free.bg_color = Color(0.15, 0.75, 0.45)
		st_free.set_corner_radius_all(8)
		spin_button.add_theme_stylebox_override("normal", st_free)
		spin_button.add_theme_color_override("font_color", Color(0.04, 0.12, 0.04))
		free_timer_lbl.text = "Tienes 1 tiro gratis disponible cada 24 horas."
		free_timer_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
	else:
		spin_button.disabled = false
		spin_button.text = "⚡ GIRAR POR 0.20 WATT"
		var st_paid := StyleBoxFlat.new()
		st_paid.bg_color = Color(0.15, 0.7, 0.95)
		st_paid.set_corner_radius_all(8)
		spin_button.add_theme_stylebox_override("normal", st_paid)
		spin_button.add_theme_color_override("font_color", Color(0.02, 0.08, 0.15))
		
		var h = int(float(free_seconds_left) / 3600.0)
		var m = int(float(free_seconds_left % 3600) / 60.0)
		var s = free_seconds_left % 60
		free_timer_lbl.text = "Siguiente tiro gratis en: %02d:%02d:%02d" % [h, m, s]
		free_timer_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))

# ====================================================================
# CONSTRUCCIÓN DEL DISCO CENTRADO EN (180, 180) SIN DESPLAZAMIENTO
# ====================================================================

func _build_centered_wheel() -> void:
	for c in wheel_container.get_children(): c.queue_free()

	# El disco rota fijado exactamente en el centro (180, 180) del cuadro
	wheel_disc = Control.new()
	wheel_disc.name = "WheelDisc"
	wheel_disc.position = Vector2(180, 180)
	wheel_disc.size = Vector2.ZERO
	wheel_container.add_child(wheel_disc)

	# 1. Dibujar los polígonos de las 8 casillas centradas en (0, 0)
	var wedge_drawer := Control.new()
	wedge_drawer.name = "WedgeDrawer"
	wedge_drawer.draw.connect(_draw_slices_polygons)
	wheel_disc.add_child(wedge_drawer)

	# 2. Agregar los iconos y textos dentro de cada casilla
	var radius := 165.0
	for i in range(TOTAL_SLOTS):
		var mid_a := i * SLICE_ANGLE
		var data = slots_data[i]

		# Contenedor alineado con el ángulo del sector
		var slice_holder := Control.new()
		slice_holder.rotation = mid_a
		wheel_disc.add_child(slice_holder)

		var hbox := HBoxContainer.new()
		hbox.position = Vector2(55, -13)
		hbox.custom_minimum_size = Vector2(95, 26)
		hbox.add_theme_constant_override("separation", 6)
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		slice_holder.add_child(hbox)

		# Icono real del premio
		var icon_rect := TextureRect.new()
		icon_rect.texture = data["icon"]
		icon_rect.custom_minimum_size = data["icon_size"]
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.modulate = data["tint"]
		icon_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		hbox.add_child(icon_rect)

		# Texto del premio
		var lbl := Label.new()
		lbl.text = data["name"]
		lbl.add_theme_font_size_override("font_size", 11)
		lbl.add_theme_color_override("font_color", Color(1, 1, 1))
		lbl.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
		lbl.add_theme_constant_override("shadow_outline_size", 2)
		lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		hbox.add_child(lbl)

	# 3. Núcleo central
	var hub_drawer := Control.new()
	hub_drawer.draw.connect(func():
		hub_drawer.draw_circle(Vector2.ZERO, 34.0, Color(0.08, 0.10, 0.15))
		hub_drawer.draw_circle(Vector2.ZERO, 26.0, Color(0.12, 0.16, 0.24))
		hub_drawer.draw_arc(Vector2.ZERO, 26.0, 0, TAU, 32, Color(0.35, 0.88, 1.0), 2.0, true)
		hub_drawer.draw_string(ThemeDB.fallback_font, Vector2(-10, 6), "⚡", HORIZONTAL_ALIGNMENT_CENTER, 20, 18, Color(1, 0.85, 0.2))
	)
	wheel_disc.add_child(hub_drawer)

func _draw_slices_polygons() -> void:
	var canvas = wheel_disc.get_node("WedgeDrawer")
	var radius := 165.0

	# Borde exterior de titanio
	canvas.draw_circle(Vector2.ZERO, radius + 8.0, Color(0.06, 0.08, 0.12))
	canvas.draw_arc(Vector2.ZERO, radius + 4.0, 0, TAU, 64, Color(0.35, 0.88, 1.0), 3.0, true)

	for i in range(TOTAL_SLOTS):
		var start_a := (i * SLICE_ANGLE) - (SLICE_ANGLE / 2.0)
		var end_a := start_a + SLICE_ANGLE
		var col: Color = slots_data[i]["color"]

		var points := PackedVector2Array([Vector2.ZERO])
		for step in range(16):
			var a = lerp(start_a, end_a, float(step) / 15.0)
			points.append(Vector2(cos(a), sin(a)) * radius)

		canvas.draw_colored_polygon(points, col)
		# Línea divisoria
		canvas.draw_line(Vector2.ZERO, Vector2(cos(start_a), sin(start_a)) * radius, Color(0.06, 0.08, 0.12, 0.9), 2.0, true)

func _on_spin_pressed() -> void:
	if is_spinning: return

	if not can_free_spin and GameManager.watt < 0.20:
		_show_toast("⚠️ Saldo insuficiente. Necesitas 0.20 WATT para girar.")
		return

	is_spinning = true
	_update_spin_button_ui()

	# Pedir confirmación de tirada a Supabase
	var res = await SupabaseClient.send_request("/rest/v1/rpc/spin_roulette_wheel", HTTPClient.METHOD_POST, {}, true)

	if not res.get("success", false) or not res.get("data", {}).get("success", false):
		is_spinning = false
		var err = res.get("data", {}).get("error", "Error al procesar el tiro.")
		_show_toast("⚠️ " + str(err))
		_check_status_from_server()
		return

	var slot_index: int = int(res["data"].get("slot_index", 0))
	var prize_name: String = str(res["data"].get("reward_title", "Premio"))
	var was_free: bool = bool(res["data"].get("was_free", false))

	# ⚡ DESCUENTO INMEDIATO: Restar los 0.20 WATT en pantalla antes de que empiece a girar
	if not was_free:
		GameManager.watt = maxf(0.0, GameManager.watt - 0.20)
		EventBus.currencies_updated.emit(GameManager.watt, GameManager.kilowat)
		_update_hud()
	else:
		can_free_spin = false
		_update_spin_button_ui()

	# 🎡 La ruleta gira durante 4.2 segundos
	await _animate_wheel_spin(slot_index)

	# Al detenerse la ruleta, sincronizar con la central para sumar el premio ganado
	await GameManager.load_profile()
	_update_hud()
	_show_toast("🎉 ¡GANASTE: %s!" % prize_name)

	is_spinning = false
	_check_status_from_server()

func _animate_wheel_spin(target_slot: int) -> void:
	# La flecha roja está fija ARRIBA (-90 grados o -PI/2)
	# Calculamos el ángulo exacto para que el sector ganador quede centrado bajo la flecha
	var target_sector_angle: float = -(target_slot * SLICE_ANGLE) - (PI / 2.0)
	
	# 6 vueltas completas de giro antes de frenar
	var full_turns: float = TAU * 6.0
	var final_rotation: float = full_turns + target_sector_angle

	var tw := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	wheel_disc.rotation = 0.0
	tw.tween_property(wheel_disc, "rotation", final_rotation, 4.2)
	await tw.finished

func _show_toast(msg: String) -> void:
	status_toast_lbl.text = msg
	status_toast_lbl.modulate.a = 1.0
	var tw := create_tween()
	tw.tween_property(status_toast_lbl, "modulate:a", 0.0, 0.8).set_delay(3.0)

```

---

###### 📄 Archivo: `roulette_game.gd.uid`

```
uid://cvauvw72l2inq

```

---

###### 📄 Archivo: `roulette_game.tscn`

```
[gd_scene format=3 uid="uid://dlqohl3ini8xi"]

[ext_resource type="Script" uid="uid://cvauvw72l2inq" path="res://features/casino/roulette_game.gd" id="1_roul"]
[ext_resource type="Texture2D" uid="uid://c7pvtqts3faj8" path="res://assets/sprites/ui/icon_chip.png" id="2_chip"]
[ext_resource type="Texture2D" uid="uid://qsj8sh8c1wq1" path="res://assets/sprites/ui/icon_watt.png" id="3_watt"]
[ext_resource type="Texture2D" uid="uid://ccmry72o5nhug" path="res://assets/sprites/ui/icon_kilowat.png" id="4_kilo"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill_chip"]
bg_color = Color(0.18, 0.08, 0.16, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(1, 0.45, 0.85, 0.8)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill"]
bg_color = Color(0.1, 0.13, 0.18, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.35, 0.55, 0.7)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel"]
bg_color = Color(0.07, 0.09, 0.14, 0.96)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.8, 0.2, 0.8)
corner_radius_top_left = 14
corner_radius_top_right = 14
corner_radius_bottom_right = 14
corner_radius_bottom_left = 14
shadow_color = Color(1, 0.7, 0, 0.2)
shadow_size = 14

[node name="RouletteGame" type="Control" unique_id=2002322015]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_roul")

[node name="Background" type="ColorRect" parent="." unique_id=1055973366]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="CanvasLayerUI" type="CanvasLayer" parent="." unique_id=2029264465]

[node name="MainVBox" type="VBoxContainer" parent="CanvasLayerUI" unique_id=757966205]
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 0

[node name="TopBar" type="PanelContainer" parent="CanvasLayerUI/MainVBox" unique_id=1568651803]
custom_minimum_size = Vector2(0, 68)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar" unique_id=1030877864]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin" unique_id=911890195]
layout_mode = 2
theme_override_constants/separation = 16

[node name="BackButton" type="Button" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox" unique_id=1238767109]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "← Volver al Casino"

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox" unique_id=749067083]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 18
text = "🎡 RULETA ELÉCTRICA DE LA FORTUNA"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox" unique_id=1238436964]
layout_mode = 2
size_flags_horizontal = 3

[node name="StatsBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox" unique_id=1034079675]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ChipPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox" unique_id=1554298287]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill_chip")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill" unique_id=1747313275]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin" unique_id=253037547]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox" unique_id=487179529]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
texture = ExtResource("2_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox" unique_id=975533102]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 14
text = "0"

[node name="WattPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox" unique_id=1154029243]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill" unique_id=1814583152]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin" unique_id=2118745150]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox" unique_id=30251265]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
texture = ExtResource("3_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox" unique_id=1927723554]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 14
text = "0.0000"

[node name="KiloPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox" unique_id=2015817247]
custom_minimum_size = Vector2(150, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill" unique_id=223534633]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin" unique_id=1568008033]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox" unique_id=330737617]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
texture = ExtResource("4_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox" unique_id=199311671]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
text = "0.000000"

[node name="Body" type="CenterContainer" parent="CanvasLayerUI/MainVBox" unique_id=1783320601]
layout_mode = 2
size_flags_vertical = 3

[node name="VBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/Body" unique_id=2038874826]
layout_mode = 2
theme_override_constants/separation = 12
alignment = 1

[node name="StatusToast" type="Label" parent="CanvasLayerUI/MainVBox/Body/VBox" unique_id=580119701]
custom_minimum_size = Vector2(0, 26)
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
horizontal_alignment = 1

[node name="WheelArea" type="PanelContainer" parent="CanvasLayerUI/MainVBox/Body/VBox" unique_id=1144981959]
custom_minimum_size = Vector2(400, 390)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel")

[node name="Center" type="CenterContainer" parent="CanvasLayerUI/MainVBox/Body/VBox/WheelArea" unique_id=1283812184]
layout_mode = 2

[node name="WheelContainer" type="Control" parent="CanvasLayerUI/MainVBox/Body/VBox/WheelArea/Center" unique_id=1127425318]
custom_minimum_size = Vector2(360, 360)
layout_mode = 2

[node name="Indicator" type="Label" parent="CanvasLayerUI/MainVBox/Body/VBox/WheelArea" unique_id=1008961674]
layout_mode = 2
size_flags_horizontal = 4
size_flags_vertical = 0
theme_override_colors/font_color = Color(1, 0.25, 0.25, 1)
theme_override_font_sizes/font_size = 28
text = "▼"
horizontal_alignment = 1

[node name="ControlsBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/Body/VBox" unique_id=1966143007]
layout_mode = 2
theme_override_constants/separation = 6
alignment = 1

[node name="SpinButton" type="Button" parent="CanvasLayerUI/MainVBox/Body/VBox/ControlsBox" unique_id=1546961888]
custom_minimum_size = Vector2(280, 48)
layout_mode = 2
size_flags_horizontal = 4
mouse_default_cursor_shape = 2
theme_override_font_sizes/font_size = 15
text = "⚡ GIRAR LA RULETA"

[node name="FreeTimerLabel" type="Label" parent="CanvasLayerUI/MainVBox/Body/VBox/ControlsBox" unique_id=1172638387]
layout_mode = 2
theme_override_font_sizes/font_size = 11
horizontal_alignment = 1

```

---

###### 📁 Carpeta: `./features\casino\mines/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `casino_hub.gd`

```
# res://features/casino/mines/casino_hub.gd
extends Control

@onready var back_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var chip_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel
@onready var watt_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilowat_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel

@onready var btn_play_mines: Button = $CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox/BtnPlayMines

var btn_play_roulette: Button = null

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	btn_play_mines.pressed.connect(_on_play_mines_pressed)
	
	# Habilitar la tarjeta de la Ruleta
	var upcoming_card = find_child("UpcomingCard", true, false)
	if upcoming_card:
		var badge = upcoming_card.find_child("Badge", true, false)
		if badge: badge.text = "★ JUEGO DISPONIBLE"
		badge.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		
		var desc = upcoming_card.find_child("Desc", true, false)
		if desc: desc.text = "1 Giro gratis cada 24 horas. ¡Gana Watts, Fichas de Casino, XP para tu Pase y hasta un generador EcoFlow Spark!"
		
		# Crear el botón para entrar a la ruleta
		var vbox = upcoming_card.find_child("VBox", true, false)
		if vbox:
			btn_play_roulette = Button.new()
			btn_play_roulette.text = "🎡 ENTRAR A LA RULETA"
			btn_play_roulette.custom_minimum_size = Vector2(240, 48)
			btn_play_roulette.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			btn_play_roulette.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			
			var st_btn := StyleBoxFlat.new()
			st_btn.bg_color = Color(1.0, 0.82, 0.15)
			st_btn.set_corner_radius_all(6)
			btn_play_roulette.add_theme_stylebox_override("normal", st_btn)
			btn_play_roulette.add_theme_color_override("font_color", Color(0.08, 0.06, 0.01))
			btn_play_roulette.pressed.connect(_on_play_roulette_pressed)
			vbox.add_child(btn_play_roulette)
			
	_update_hud()

func _process(_delta: float) -> void:
	_update_hud()

func _update_hud() -> void:
	if chip_label and is_instance_valid(chip_label):
		chip_label.text = "%.0f" % GameManager.casino_tokens
	if watt_label and is_instance_valid(watt_label):
		watt_label.text = "%.4f" % GameManager.watt
	if kilowat_label and is_instance_valid(kilowat_label):
		kilowat_label.text = "%.6f" % GameManager.kilowat

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://features/room/main_room.tscn")

func _on_play_mines_pressed() -> void:
	get_tree().change_scene_to_file("res://features/casino/mines/mines_game.tscn")

func _on_play_roulette_pressed() -> void:
	get_tree().change_scene_to_file("res://features/casino/roulette_game.tscn")

```

---

####### 📄 Archivo: `casino_hub.gd.uid`

```
uid://d0qespefdwiha

```

---

####### 📄 Archivo: `casino_hub.tscn`

```
[gd_scene format=3 uid="uid://casi0nohub001"]

[ext_resource type="Script" path="res://features/casino/mines/casino_hub.gd" id="1_chub"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_chip.png" id="2_chip"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_watt.png" id="3_watt"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_kilowat.png" id="4_kilo"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill_chip"]
bg_color = Color(0.18, 0.08, 0.16, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(1, 0.45, 0.85, 0.8)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill"]
bg_color = Color(0.1, 0.13, 0.18, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.35, 0.55, 0.7)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_card_hero"]
bg_color = Color(0.08, 0.10, 0.15, 0.95)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.45, 0.85, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(0.9, 0.2, 0.7, 0.25)
shadow_size = 10

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_card_disabled"]
bg_color = Color(0.06, 0.08, 0.11, 0.8)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.25, 0.35, 0.5)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn_play"]
bg_color = Color(0.85, 0.15, 0.55, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.55, 0.85, 1)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6
shadow_color = Color(0.9, 0.2, 0.6, 0.35)
shadow_size = 8

[node name="CasinoHub" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_chub")

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="CanvasLayerUI" type="CanvasLayer" parent="."]

[node name="MainVBox" type="VBoxContainer" parent="CanvasLayerUI"]
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 0

[node name="TopBar" type="PanelContainer" parent="CanvasLayerUI/MainVBox"]
custom_minimum_size = Vector2(0, 68)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="BackButton" type="Button" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "← Volver al Cuarto"

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.45, 0.85, 1)
theme_override_font_sizes/font_size = 18
text = "🎰 SALA DE CASINO & APUESTAS"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="StatsBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ChipPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(150, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill_chip")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 15
text = "0"

[node name="WattPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(130, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("3_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 13
text = "0.0000"

[node name="KiloPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("4_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "0.000000"

[node name="ContentScroll" type="ScrollContainer" parent="CanvasLayerUI/MainVBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/ContentScroll"]
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 3
theme_override_constants/margin_left = 32
theme_override_constants/margin_top = 28
theme_override_constants/margin_right = 32
theme_override_constants/margin_bottom = 28

[node name="GamesHBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 28
alignment = 1

[node name="MinesCard" type="PanelContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox"]
custom_minimum_size = Vector2(560, 460)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_card_hero")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard"]
layout_mode = 2
theme_override_constants/margin_left = 28
theme_override_constants/margin_top = 24
theme_override_constants/margin_right = 28
theme_override_constants/margin_bottom = 24

[node name="VBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin"]
layout_mode = 2
theme_override_constants/separation = 14
alignment = 1

[node name="BadgeRow" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox"]
layout_mode = 2
alignment = 1

[node name="Badge" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox/BadgeRow"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.45, 0.85, 1)
theme_override_font_sizes/font_size = 12
text = "★ JUEGO DE APUESTAS DESTACADO"

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.95, 0.98, 1, 1)
theme_override_font_sizes/font_size = 28
text = "💣 MINAS (MINES CASINO)"
horizontal_alignment = 1

[node name="Desc" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.75, 0.82, 0.92, 0.9)
theme_override_font_sizes/font_size = 14
text = "Descubre diamantes y retira tus ganancias antes de activar una mina. Configura de 2 a 24 minas en un tablero 5x5."
horizontal_alignment = 1
autowrap_mode = 2

[node name="StatsBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 16
alignment = 1

[node name="LimitLabel" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox/StatsBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 1, 0.55, 1)
theme_override_font_sizes/font_size = 13
text = "🪙 Apuesta mínima: 1 Ficha"

[node name="Dot" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox/StatsBox"]
layout_mode = 2
text = "•"

[node name="MultiLabel" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox/StatsBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "⚡ Retiro voluntario en cada paso"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="BtnPlayMines" type="Button" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/MinesCard/Margin/VBox"]
custom_minimum_size = Vector2(280, 52)
layout_mode = 2
size_flags_horizontal = 4
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(1, 0.95, 1, 1)
theme_override_font_sizes/font_size = 16
theme_override_styles/normal = SubResource("StyleBoxFlat_btn_play")
theme_override_styles/hover = SubResource("StyleBoxFlat_btn_play")
text = "⚡ ENTRAR A LA SALA DE MINAS"

[node name="UpcomingCard" type="PanelContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox"]
custom_minimum_size = Vector2(440, 460)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_card_disabled")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/UpcomingCard"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 24
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 24

[node name="VBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/UpcomingCard/Margin"]
layout_mode = 2
theme_override_constants/separation = 12
alignment = 1

[node name="Badge" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/UpcomingCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.6, 0.65, 0.75, 1)
theme_override_font_sizes/font_size = 12
text = "🔒 EN DESARROLLO"
horizontal_alignment = 1

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/UpcomingCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.6, 0.65, 0.75, 1)
theme_override_font_sizes/font_size = 22
text = "🎡 RULETA ELÉCTRICA"
horizontal_alignment = 1

[node name="Desc" type="Label" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesHBox/UpcomingCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.5, 0.55, 0.65, 0.8)
theme_override_font_sizes/font_size = 13
text = "Próximamente: gira la ruleta de bobinas para multiplicar tus fichas o ganar piezas de recambio exclusivas para tus plantas."
horizontal_alignment = 1
autowrap_mode = 2
```

---

####### 📄 Archivo: `mines_game.gd`

```
# res://features/casino/mines/mines_game.gd
extends Control

const TOTAL_TILES: int = 25
const MIN_MINES: int = 2
const MAX_MINES: int = 24

@onready var back_btn: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var chip_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/ChipPill/Margin/HBox/ChipLabel

@onready var bet_input: LineEdit = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/BetInput
@onready var btn_half: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnHalf
@onready var btn_double: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnDouble
@onready var btn_min: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnMin
@onready var btn_max: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns/BtnMax

@onready var mines_slider: HSlider = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox/MinesSlider
@onready var mines_count_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox/CountLabel
@onready var gems_left_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/StatsBox/GemsLeftLabel
@onready var next_mult_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/StatsBox/NextMultLabel

@onready var action_btn: Button = $CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/ActionButton
@onready var grid_container: GridContainer = $CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/Center/BoardPanel/Margin/GridContainer
@onready var status_toast_lbl: Label = $CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/StatusToast

var tex_bomb: Texture2D
var tex_diamond: Texture2D

enum State { IDLE, PLAYING, GAME_OVER }
var current_state: State = State.IDLE

var board_data: Array = []
var revealed_tiles: Array = []
var tile_buttons: Array = []

var selected_mines: int = 3
var current_bet: float = 1.0
var gems_opened: int = 0
var current_multiplier: float = 1.0

func _ready() -> void:
	# Búsqueda defensiva para evitar cualquier error de nodo nulo
	if chip_lbl == null: chip_lbl = find_child("ChipLabel", true, false)
	if bet_input == null: bet_input = find_child("BetInput", true, false)
	if btn_half == null: btn_half = find_child("BtnHalf", true, false)
	if btn_double == null: btn_double = find_child("BtnDouble", true, false)
	if btn_min == null: btn_min = find_child("BtnMin", true, false)
	if btn_max == null: btn_max = find_child("BtnMax", true, false)
	if mines_slider == null: mines_slider = find_child("MinesSlider", true, false)
	if action_btn == null: action_btn = find_child("ActionButton", true, false)
	if grid_container == null: grid_container = find_child("GridContainer", true, false)
	if status_toast_lbl == null: status_toast_lbl = find_child("StatusToast", true, false)
	
	back_btn.pressed.connect(_on_back_pressed)
	action_btn.pressed.connect(_on_action_pressed)
	
	mines_slider.min_value = MIN_MINES
	mines_slider.max_value = MAX_MINES
	mines_slider.value = 3
	mines_slider.value_changed.connect(_on_mines_slider_changed)
	
	bet_input.text = "1"
	bet_input.text_changed.connect(_on_bet_input_changed)
	
	btn_half.pressed.connect(func(): _adjust_bet(0.5))
	btn_double.pressed.connect(func(): _adjust_bet(2.0))
	btn_min.pressed.connect(func(): _set_bet(1.0))
	btn_max.pressed.connect(func(): _set_bet(clampf(GameManager.casino_tokens, 1.0, 5000.0)))
	
	_load_assets()
	_build_board_tiles()
	_update_hud()
	_update_ui_state()

func _load_assets() -> void:
	var path_bomb = "res://assets/sprites/minigames/mines/bomb.png"
	var path_diamond = "res://assets/sprites/minigames/mines/diamond.png"
	if ResourceLoader.exists(path_bomb): tex_bomb = load(path_bomb)
	if ResourceLoader.exists(path_diamond): tex_diamond = load(path_diamond)

func _update_hud() -> void:
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens

func _on_back_pressed() -> void:
	if current_state == State.PLAYING and gems_opened > 0: 
		_cash_out()
	get_tree().change_scene_to_file("res://features/casino/mines/casino_hub.tscn")

func _on_mines_slider_changed(val: float) -> void:
	selected_mines = int(val)
	mines_count_lbl.text = "%d Minas (%d Diamantes)" % [selected_mines, TOTAL_TILES - selected_mines]
	_update_stats_display()

func _on_bet_input_changed(new_text: String) -> void:
	if not new_text.is_valid_float():
		current_bet = 1.0
		return
	var val: float = float(new_text)
	current_bet = clampf(val, 1.0, maxf(1.0, GameManager.casino_tokens))

func _adjust_bet(mult: float) -> void: _set_bet(current_bet * mult)
func _set_bet(val: float) -> void:
	current_bet = maxf(1.0, snappedf(val, 1.0))
	bet_input.text = "%.0f" % current_bet

func _update_stats_display() -> void:
	var total_gems = TOTAL_TILES - selected_mines
	var left = total_gems - gems_opened
	gems_left_lbl.text = "Gemas restantes: %d" % left
	var next_m = _calc_dampened_multiplier(selected_mines, gems_opened + 1)
	next_mult_lbl.text = "Siguiente: %.2fx" % next_m

func _calc_dampened_multiplier(mines: int, opened: int) -> float:
	if opened <= 0: return 1.0
	var safe_mines = clampi(mines, MIN_MINES, MAX_MINES)
	var fair: float = 1.0
	
	for i in range(opened):
		var remaining_tiles: float = float(TOTAL_TILES - i)
		var remaining_safe_tiles: float = float(TOTAL_TILES - safe_mines - i)
		
		# Protección estricta contra división por cero
		if remaining_safe_tiles <= 0.0 or remaining_tiles <= 0.0:
			break
			
		fair *= remaining_tiles / remaining_safe_tiles
		
	var dampened: float = 1.0 + (fair - 1.0) * 0.60
	return maxf(1.02, snappedf(dampened, 0.01))

func _build_board_tiles() -> void:
	for child in grid_container.get_children(): child.queue_free()
	tile_buttons.clear()
	
	for i in range(TOTAL_TILES):
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(76, 76)
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.clip_contents = true
		
		var style_normal := StyleBoxFlat.new()
		style_normal.bg_color = Color(0.12, 0.15, 0.22, 0.95)
		style_normal.border_color = Color(0.2, 0.35, 0.55, 0.8)
		style_normal.set_border_width_all(2)
		style_normal.set_corner_radius_all(8)
		btn.add_theme_stylebox_override("normal", style_normal)
		
		var icon_rect := TextureRect.new()
		icon_rect.name = "Icon"
		icon_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		btn.add_child(icon_rect)
		
		var idx = i
		btn.pressed.connect(func(): _on_tile_clicked(idx))
		grid_container.add_child(btn)
		tile_buttons.append(btn)

func _update_ui_state() -> void:
	match current_state:
		State.IDLE, State.GAME_OVER:
			bet_input.editable = true; mines_slider.editable = true
			btn_half.disabled = false; btn_double.disabled = false; btn_min.disabled = false; btn_max.disabled = false
			action_btn.disabled = false; action_btn.text = "⚡ APOSTAR FICHAS"
			var st_green := StyleBoxFlat.new()
			st_green.bg_color = Color(0.15, 0.75, 0.45, 1.0); st_green.border_color = Color(0.4, 1.0, 0.6)
			st_green.set_border_width_all(2); st_green.set_corner_radius_all(8)
			action_btn.add_theme_stylebox_override("normal", st_green)
			action_btn.add_theme_stylebox_override("hover", st_green)
			action_btn.add_theme_color_override("font_color", Color(0.04, 0.12, 0.04))
		State.PLAYING:
			bet_input.editable = false; mines_slider.editable = false
			btn_half.disabled = true; btn_double.disabled = true; btn_min.disabled = true; btn_max.disabled = true
			if gems_opened == 0:
				action_btn.text = "ELIGE UNA CASILLA..."; action_btn.disabled = true
			else:
				action_btn.disabled = false
				var win_amount: float = current_bet * current_multiplier
				action_btn.text = "💰 RETIRAR %.0f CHIPS (%.2fx)" % [win_amount, current_multiplier]
				var st_gold := StyleBoxFlat.new()
				st_gold.bg_color = Color(1.0, 0.82, 0.15, 1.0); st_gold.border_color = Color(1.0, 0.95, 0.6)
				st_gold.set_border_width_all(2); st_gold.set_corner_radius_all(8)
				action_btn.add_theme_stylebox_override("normal", st_gold)
				action_btn.add_theme_stylebox_override("hover", st_gold)
				action_btn.add_theme_color_override("font_color", Color(0.12, 0.08, 0.01))

func _on_action_pressed() -> void:
	if current_state in [State.IDLE, State.GAME_OVER]: _start_game()
	elif current_state == State.PLAYING and gems_opened > 0: _cash_out()

func _start_game() -> void:
	if GameManager.casino_tokens < current_bet:
		_show_toast("⚠️ Saldo insuficiente en Fichas de casino.")
		_update_ui_state()
		return
		
	GameManager.casino_tokens -= current_bet
	_update_hud()
	_sync_chips_to_supabase()
	
	gems_opened = 0
	current_multiplier = 1.0
	current_state = State.PLAYING
	
	_generate_mines()
	_reset_tile_views()
	_update_stats_display()
	_update_ui_state()

func _generate_mines() -> void:
	board_data.clear(); revealed_tiles.clear()
	for i in range(TOTAL_TILES):
		board_data.append(false); revealed_tiles.append(false)
		
	var placed = 0
	while placed < selected_mines:
		var r: int = randi() % TOTAL_TILES
		if not board_data[r]:
			board_data[r] = true
			placed += 1

func _reset_tile_views() -> void:
	for i in range(TOTAL_TILES):
		var btn: Button = tile_buttons[i]
		btn.disabled = false; btn.text = ""; btn.modulate = Color.WHITE; btn.scale = Vector2.ONE
		var icon: TextureRect = btn.get_node("Icon")
		icon.texture = null
		
		var st := StyleBoxFlat.new()
		st.bg_color = Color(0.12, 0.15, 0.22, 0.95)
		st.border_color = Color(0.2, 0.35, 0.55, 0.85)
		st.set_border_width_all(2); st.set_corner_radius_all(8)
		btn.add_theme_stylebox_override("normal", st)
		btn.add_theme_stylebox_override("disabled", st)

func _on_tile_clicked(idx: int) -> void:
	if current_state != State.PLAYING or revealed_tiles[idx]: return
	revealed_tiles[idx] = true
	var btn: Button = tile_buttons[idx]
	btn.disabled = true
	
	if board_data[idx]: _hit_mine(idx)
	else: _reveal_gem(idx)

func _reveal_gem(idx: int) -> void:
	var btn: Button = tile_buttons[idx]
	var icon: TextureRect = btn.get_node("Icon")
	if tex_diamond: icon.texture = tex_diamond
	else: btn.text = "💎"; btn.add_theme_font_size_override("font_size", 26)
		
	var st_gem := StyleBoxFlat.new()
	st_gem.bg_color = Color(0.2, 0.08, 0.3, 0.95); st_gem.border_color = Color(0.75, 0.3, 1.0, 1.0)
	st_gem.set_border_width_all(2); st_gem.set_corner_radius_all(8)
	btn.add_theme_stylebox_override("disabled", st_gem)
	
	btn.scale = Vector2(0.8, 0.8)
	var tw := create_tween()
	tw.tween_property(btn, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BACK)
	
	gems_opened += 1
	current_multiplier = _calc_dampened_multiplier(selected_mines, gems_opened)
	_update_stats_display()
	_update_ui_state()
	
	if gems_opened >= (TOTAL_TILES - selected_mines): _cash_out()

func _hit_mine(idx: int) -> void:
	current_state = State.GAME_OVER
	var btn: Button = tile_buttons[idx]
	var icon: TextureRect = btn.get_node("Icon")
	if tex_bomb: icon.texture = tex_bomb
	else: btn.text = "💣"; btn.add_theme_font_size_override("font_size", 26)
		
	var st_bomb := StyleBoxFlat.new()
	st_bomb.bg_color = Color(0.35, 0.08, 0.08, 0.95); st_bomb.border_color = Color(1.0, 0.25, 0.25, 1.0)
	st_bomb.set_border_width_all(2); st_bomb.set_corner_radius_all(8)
	btn.add_theme_stylebox_override("disabled", st_bomb)
	
	_show_toast("💥 ¡BOOM! Pisaste una mina. Apuesta perdida.")
	_reveal_full_board(idx)
	_sync_chips_to_supabase()
	_update_ui_state()

func _cash_out() -> void:
	if current_state != State.PLAYING: return
	current_state = State.GAME_OVER
	var total_won: float = current_bet * current_multiplier
	GameManager.casino_tokens += total_won
	_update_hud()
	_sync_chips_to_supabase()
	_show_toast("🏆 ¡Retiro con éxito! Ganaste %.0f FICHAS (%.2fx)" % [total_won, current_multiplier])
	_reveal_full_board(-1)
	_update_ui_state()

func _reveal_full_board(_exploded_idx: int) -> void:
	for i in range(TOTAL_TILES):
		var btn: Button = tile_buttons[i]
		var icon: TextureRect = btn.get_node("Icon")
		btn.disabled = true
		if not revealed_tiles[i]:
			btn.modulate = Color(0.65, 0.65, 0.65, 0.8)
			if board_data[i]:
				if tex_bomb: icon.texture = tex_bomb
				else: btn.text = "💣"
			else:
				if tex_diamond: icon.texture = tex_diamond
				else: btn.text = "💎"

func _sync_chips_to_supabase() -> void:
	SupabaseClient.send_request("/rest/v1/rpc/save_casino_chips", HTTPClient.METHOD_POST, {"p_chips": GameManager.casino_tokens}, true)

func _show_toast(msg: String) -> void:
	status_toast_lbl.text = msg
	status_toast_lbl.modulate.a = 1.0
	var tw := create_tween()
	tw.tween_property(status_toast_lbl, "modulate:a", 0.0, 0.6).set_delay(2.5)

```

---

####### 📄 Archivo: `mines_game.gd.uid`

```
uid://dwmgyk6k43uda

```

---

####### 📄 Archivo: `mines_game.tscn`

```
[gd_scene format=3 uid="uid://c143qmxt5twqc"]

[ext_resource type="Script" path="res://features/casino/mines/mines_game.gd" id="1_mines"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_chip.png" id="2_chip"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill_chip"]
bg_color = Color(0.18, 0.08, 0.16, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(1, 0.45, 0.85, 0.8)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel_left"]
bg_color = Color(0.08, 0.10, 0.15, 0.98)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.25, 0.4, 0.6, 0.8)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_board"]
bg_color = Color(0.05, 0.07, 0.1, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.45, 0.85, 0.9)
corner_radius_top_left = 14
corner_radius_top_right = 14
corner_radius_bottom_right = 14
corner_radius_bottom_left = 14
shadow_color = Color(0.8, 0.2, 0.6, 0.25)
shadow_size = 14

[node name="MinesGame" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_mines")

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="CanvasLayerUI" type="CanvasLayer" parent="."]

[node name="MainVBox" type="VBoxContainer" parent="CanvasLayerUI"]
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 0

[node name="TopBar" type="PanelContainer" parent="CanvasLayerUI/MainVBox"]
custom_minimum_size = Vector2(0, 68)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="BackButton" type="Button" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "← Volver al Casino"

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.45, 0.85, 1)
theme_override_font_sizes/font_size = 18
text = "💣 MINAS (MINES CASINO)"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="ChipPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill_chip")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/ChipPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/ChipPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/ChipPill/Margin/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/ChipPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 15
text = "0"

[node name="BodyLayout" type="MarginContainer" parent="CanvasLayerUI/MainVBox"]
layout_mode = 2
size_flags_vertical = 3
theme_override_constants/margin_left = 28
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 28
theme_override_constants/margin_bottom = 24

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout"]
layout_mode = 2
theme_override_constants/separation = 32

[node name="ControlPanel" type="PanelContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox"]
custom_minimum_size = Vector2(380, 0)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel_left")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 20
theme_override_constants/margin_bottom = 20

[node name="VBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="BetBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.5, 0.9, 1)
theme_override_font_sizes/font_size = 13
text = "Apuesta en Fichas (CHIPS):"

[node name="BetInput" type="LineEdit" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
theme_override_font_sizes/font_size = 15
text = "10"

[node name="QuickBtns" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox"]
layout_mode = 2
theme_override_constants/separation = 6

[node name="BtnHalf" type="Button" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns"]
custom_minimum_size = Vector2(0, 32)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "1/2"

[node name="BtnDouble" type="Button" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns"]
custom_minimum_size = Vector2(0, 32)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "2X"

[node name="BtnMin" type="Button" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns"]
custom_minimum_size = Vector2(0, 32)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "Min"

[node name="BtnMax" type="Button" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/BetBox/QuickBtns"]
custom_minimum_size = Vector2(0, 32)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "Max"

[node name="HSep1" type="HSeparator" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
layout_mode = 2

[node name="MinesBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 6

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.75, 0.85, 0.95, 1)
theme_override_font_sizes/font_size = 13
text = "Número de Minas (2 a 24):"

[node name="CountLabel" type="Label" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.4, 0.4, 1)
theme_override_font_sizes/font_size = 14
text = "3 Minas (22 Diamantes)"

[node name="MinesSlider" type="HSlider" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/MinesBox"]
custom_minimum_size = Vector2(0, 24)
layout_mode = 2
min_value = 2.0
max_value = 24.0
value = 3.0

[node name="HSep2" type="HSeparator" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
layout_mode = 2

[node name="StatsBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 6

[node name="GemsLeftLabel" type="Label" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/StatsBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 13
text = "Gemas restantes: 22"

[node name="NextMultLabel" type="Label" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox/StatsBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
text = "Siguiente: 1.04x"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="ActionButton" type="Button" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/ControlPanel/Margin/VBox"]
custom_minimum_size = Vector2(0, 52)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_font_sizes/font_size = 16
text = "⚡ APOSTAR FICHAS"

[node name="BoardArea" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox"]
layout_mode = 2
size_flags_horizontal = 3
alignment = 1

[node name="StatusToast" type="Label" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea"]
custom_minimum_size = Vector2(0, 32)
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
horizontal_alignment = 1

[node name="Center" type="CenterContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea"]
layout_mode = 2

[node name="BoardPanel" type="PanelContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/Center"]
custom_minimum_size = Vector2(480, 480)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_board")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/Center/BoardPanel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 20
theme_override_constants/margin_bottom = 20

[node name="GridContainer" type="GridContainer" parent="CanvasLayerUI/MainVBox/BodyLayout/HBox/BoardArea/Center/BoardPanel/Margin"]
layout_mode = 2
size_flags_horizontal = 4
size_flags_vertical = 4
theme_override_constants/h_separation = 10
theme_override_constants/v_separation = 10
columns = 5
```

---

##### 📁 Carpeta: `./features\economy/`

###### 📁 Carpeta: `./features\economy\extraction/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `extraction_modal.gd`

```
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
```

---

####### 📄 Archivo: `extraction_modal.gd.uid`

```
uid://dgc6c1tu0og26

```

---

####### 📄 Archivo: `extraction_modal.tscn`

```
[gd_scene format=3 uid="uid://b8mhcd0f03r8s"]

[ext_resource type="Script" path="res://features/economy/extraction/extraction_modal.gd" id="1_extract"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(1, 0.75, 0, 0.35)
shadow_size = 14

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_timer_pill"]
bg_color = Color(0.05, 0.07, 0.1, 0.9)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.18, 0.65, 0.85, 0.8)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_green_btn"]
bg_color = Color(0.18, 0.75, 0.35, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.4, 1, 0.5, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="ExtractionModal" type="Control"]
visible = false
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_extract")

[node name="DarkOverlay" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
color = Color(0.02, 0.03, 0.05, 0.9)

[node name="Center" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Panel" type="PanelContainer" parent="Center"]
custom_minimum_size = Vector2(560, 460)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 22

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 20
text = "💵 TERMINAL DE LIQUIDACIÓN Y RETIRO"
horizontal_alignment = 1

[node name="RateBadge" type="PanelContainer" parent="Center/Panel/Margin/VBox"]
custom_minimum_size = Vector2(0, 36)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_timer_pill")

[node name="RateText" type="Label" parent="Center/Panel/Margin/VBox/RateBadge"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "TASA OFICIAL: 1 KILOWAT = 500 CUP EN TRANSFERENCIA"
horizontal_alignment = 1
vertical_alignment = 1

[node name="InvoiceCard" type="PanelContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/InvoiceCard"]
layout_mode = 2
theme_override_constants/margin_left = 16
theme_override_constants/margin_top = 12
theme_override_constants/margin_right = 16
theme_override_constants/margin_bottom = 12

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin/VBox/InvoiceCard/Margin"]
layout_mode = 2
theme_override_constants/separation = 6

[node name="InvoiceDetailsLabel" type="Label" parent="Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.85, 0.9, 0.9)
theme_override_font_sizes/font_size = 12
text = "Calculando deducción..."

[node name="HSep" type="HSeparator" parent="Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox"]
layout_mode = 2

[node name="PayoutRow" type="HBoxContainer" parent="Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox"]
layout_mode = 2

[node name="PayoutTitle" type="Label" parent="Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox/PayoutRow"]
layout_mode = 2
theme_override_colors/font_color = Color(0.9, 0.95, 1, 1)
theme_override_font_sizes/font_size = 14
text = "Total a recibir en EnZona / Transfermóvil:"

[node name="PayoutAmountLabel" type="Label" parent="Center/Panel/Margin/VBox/InvoiceCard/Margin/VBox/PayoutRow"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.4, 1, 0.55, 1)
theme_override_font_sizes/font_size = 20
text = "$ 0 CUP"
horizontal_alignment = 2

[node name="BalanceRow" type="HBoxContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
alignment = 1

[node name="BalanceTitle" type="Label" parent="Center/Panel/Margin/VBox/BalanceRow"]
layout_mode = 2
theme_override_font_sizes/font_size = 12
text = "Tu Saldo:"

[node name="BalanceVal" type="Label" parent="Center/Panel/Margin/VBox/BalanceRow"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "0.000000 KW"

[node name="StatusMsg" type="Label" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 12
text = "Comprobando requisitos..."
horizontal_alignment = 1

[node name="Buttons" type="HBoxContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="CloseBtn" type="Button" parent="Center/Panel/Margin/VBox/Buttons"]
custom_minimum_size = Vector2(0, 44)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "✕ Cancelar"

[node name="ActionBtn" type="Button" parent="Center/Panel/Margin/VBox/Buttons"]
custom_minimum_size = Vector2(0, 44)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.04, 0.12, 0.04, 1)
theme_override_font_sizes/font_size = 14
theme_override_styles/normal = SubResource("StyleBoxFlat_green_btn")
text = "📲 Retirar por WhatsApp"
```

---

###### 📁 Carpeta: `./features\economy\power_split/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `power_split_modal.gd`

```
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
```

---

####### 📄 Archivo: `power_split_modal.gd.uid`

```
uid://dc7p0qclpkhjy

```

---

####### 📄 Archivo: `power_split_modal.tscn`

```
[gd_scene format=3 uid="uid://psplitmodal001"]

[ext_resource type="Script" path="res://features/economy/power_split/power_split_modal.gd" id="1_split"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_watt.png" id="2_watt"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_kilowat.png" id="3_kilo"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(1, 0.75, 0, 0.35)
shadow_size = 14

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_gold_btn"]
bg_color = Color(1, 0.82, 0.15, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.95, 0.6, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="PowerSplitModal" type="Control"]
visible = false
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_split")

[node name="DarkOverlay" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
color = Color(0.02, 0.03, 0.05, 0.9)

[node name="Center" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Panel" type="PanelContainer" parent="Center"]
custom_minimum_size = Vector2(560, 440)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 22

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="Title" type="Label" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 20
text = "⚡ CALIBRADOR DE FLUJO ELÉCTRICO"
horizontal_alignment = 1

[node name="Info" type="Label" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.85, 0.9, 0.85)
theme_override_font_sizes/font_size = 12
text = "Distribuye el porcentaje de energía que generarán tus plantas. Al ser WATT una moneda blanda interna, se mina a un ritmo 1,000 veces mayor que el Kilowat."
horizontal_alignment = 1
autowrap_mode = 2

[node name="GaugeRow" type="HBoxContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 18

[node name="WattGauge" type="PanelContainer" parent="Center/Panel/Margin/VBox/GaugeRow"]
layout_mode = 2
size_flags_horizontal = 3

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/GaugeRow/WattGauge"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_top = 10
theme_override_constants/margin_right = 12
theme_override_constants/margin_bottom = 10

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin/VBox/GaugeRow/WattGauge/Margin"]
layout_mode = 2
alignment = 1

[node name="HBox" type="HBoxContainer" parent="Center/Panel/Margin/VBox/GaugeRow/WattGauge/Margin/VBox"]
layout_mode = 2
alignment = 1

[node name="Icon" type="TextureRect" parent="Center/Panel/Margin/VBox/GaugeRow/WattGauge/Margin/VBox/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
texture = ExtResource("2_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattPercent" type="Label" parent="Center/Panel/Margin/VBox/GaugeRow/WattGauge/Margin/VBox/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 16
text = "50% WATT"

[node name="Sub" type="Label" parent="Center/Panel/Margin/VBox/GaugeRow/WattGauge/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.7, 0.8, 1)
theme_override_font_sizes/font_size = 10
text = "RITMO RÁPIDO (x1,000)"
horizontal_alignment = 1

[node name="KiloGauge" type="PanelContainer" parent="Center/Panel/Margin/VBox/GaugeRow"]
layout_mode = 2
size_flags_horizontal = 3

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/GaugeRow/KiloGauge"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_top = 10
theme_override_constants/margin_right = 12
theme_override_constants/margin_bottom = 10

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin/VBox/GaugeRow/KiloGauge/Margin"]
layout_mode = 2
alignment = 1

[node name="HBox" type="HBoxContainer" parent="Center/Panel/Margin/VBox/GaugeRow/KiloGauge/Margin/VBox"]
layout_mode = 2
alignment = 1

[node name="Icon" type="TextureRect" parent="Center/Panel/Margin/VBox/GaugeRow/KiloGauge/Margin/VBox/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
texture = ExtResource("3_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloPercent" type="Label" parent="Center/Panel/Margin/VBox/GaugeRow/KiloGauge/Margin/VBox/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 16
text = "50% KILOWAT"

[node name="Sub" type="Label" parent="Center/Panel/Margin/VBox/GaugeRow/KiloGauge/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.7, 0.8, 1)
theme_override_font_sizes/font_size = 10
text = "MONEDA DE RETIRO (1:1)"
horizontal_alignment = 1

[node name="SliderBox" type="MarginContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_constants/margin_left = 16
theme_override_constants/margin_right = 16

[node name="SplitSlider" type="HSlider" parent="Center/Panel/Margin/VBox/SliderBox"]
custom_minimum_size = Vector2(0, 28)
layout_mode = 2
step = 10.0
value = 50.0

[node name="CooldownLabel" type="Label" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 11
text = "✓ Circuito disponible para ajuste."
horizontal_alignment = 1

[node name="Buttons" type="HBoxContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="CloseBtn" type="Button" parent="Center/Panel/Margin/VBox/Buttons"]
custom_minimum_size = Vector2(0, 44)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "✕ Cancelar"

[node name="SaveBtn" type="Button" parent="Center/Panel/Margin/VBox/Buttons"]
custom_minimum_size = Vector2(0, 44)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.08, 0.06, 0.01, 1)
theme_override_font_sizes/font_size = 14
theme_override_styles/normal = SubResource("StyleBoxFlat_gold_btn")
text = "⚡ CALIBRAR Y GUARDAR"
```

---

###### 📁 Carpeta: `./features\economy\shop/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `offer_inspect_modal.gd`

```
# res://features/economy/shop/offer_inspect_modal.gd
extends Control

signal purchase_completed(success: bool)

@onready var generator_texture: TextureRect = $Center/Panel/Margin/HBox/PedestalArea/GeneratorTexture
@onready var timer_label: Label = $Center/Panel/Margin/HBox/PedestalArea/TimerBadge/Margin/HBox/TimerLabel
@onready var buy_btn: Button = $Center/Panel/Margin/HBox/DetailsArea/BuyButton
@onready var close_btn: Button = $Center/Panel/Margin/HBox/DetailsArea/TopRow/CloseButton
@onready var status_msg: Label = $Center/Panel/Margin/HBox/DetailsArea/StatusMsg

var float_timer: float = 0.0
var base_sprite_y: float = 0.0
var second_accum: float = 0.0

const ITEM_ID: String = "cyber_tank"
const PRICE: float = 1.0
const OFFER_FILE: String = "user://cyber_tank_offer.json"
var offer_end_timestamp: int = 0

func _ready() -> void:
	if close_btn: close_btn.pressed.connect(func(): visible = false)
	if buy_btn: buy_btn.pressed.connect(_on_buy_pressed)
	if generator_texture: base_sprite_y = generator_texture.position.y
	_check_ownership()
	_update_countdown_label()

func open_modal() -> void:
	if _get_remaining_seconds() <= 0 or GameManager.get_owned_generator_count(ITEM_ID) >= 1:
		visible = false
		return
	visible = true
	_check_ownership()
	_update_countdown_label()

func _check_ownership() -> void:
	if GameManager.get_owned_generator_count(ITEM_ID) >= 1:
		buy_btn.disabled = true
		buy_btn.text = "🔒 YA ADQUIRIDO (1/1)"
		status_msg.text = "Ya posees esta unidad en tu inventario."
		status_msg.add_theme_color_override("font_color", Color(0.4, 0.95, 0.55))
	else:
		buy_btn.disabled = false
		buy_btn.text = "⚡ COMPRAR POR 1.0 KILOWAT"
		status_msg.text = ""

func _process(delta: float) -> void:
	if not visible: return
	if generator_texture:
		float_timer += delta * 2.8
		generator_texture.position.y = base_sprite_y + (sin(float_timer) * 7.0)

	second_accum += delta
	if second_accum >= 1.0:
		second_accum = 0.0
		_update_countdown_label()

func _get_remaining_seconds() -> int:
	var now: int = int(Time.get_unix_time_from_system())
	if offer_end_timestamp <= 0 and FileAccess.file_exists(OFFER_FILE):
		var f := FileAccess.open(OFFER_FILE, FileAccess.READ)
		if f:
			var parsed = JSON.parse_string(f.get_as_text())
			if typeof(parsed) == TYPE_DICTIONARY and parsed.has("end_timestamp"):
				offer_end_timestamp = int(parsed["end_timestamp"])
			f.close()
				
	if offer_end_timestamp <= 0:
		offer_end_timestamp = now + 604800
		var f := FileAccess.open(OFFER_FILE, FileAccess.WRITE)
		if f:
			f.store_string(JSON.stringify({"end_timestamp": offer_end_timestamp}))
			f.close()
	return maxi(0, offer_end_timestamp - now)

func _update_countdown_label() -> void:
	if timer_label == null: return
	var rem: int = _get_remaining_seconds()
	var d: int = int(float(rem) / 86400.0)
	var h: int = int(float(rem % 86400) / 3600.0)
	var m: int = int(float(rem % 3600) / 60.0)
	var s: int = rem % 60
	timer_label.text = "TERMINA EN: %02dD %02dH %02dM %02dS" % [d, h, m, s] if rem > 0 else "TERMINA EN: EXPIRADA"

func _on_buy_pressed() -> void:
	if GameManager.get_owned_generator_count(ITEM_ID) >= 1: return
	if GameManager.kilowat < PRICE:
		status_msg.text = "⚠️ Saldo insuficiente. Necesitas 1.0 KILOWAT."
		status_msg.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))
		return
		
	buy_btn.disabled = true
	status_msg.text = "Procesando compra en la central..."
	var res: Dictionary = await GameManager.buy_shop_item_secure(ITEM_ID, "generators", PRICE, "kilowat")
	if res.get("success", false):
		purchase_completed.emit(true)
		visible = false
	else:
		buy_btn.disabled = false
		status_msg.text = "⚠️ " + str(res.get("error", "Error en la compra"))
		status_msg.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))
		purchase_completed.emit(false)

```

---

####### 📄 Archivo: `offer_inspect_modal.gd.uid`

```
uid://b8440rlv4xxkj

```

---

####### 📄 Archivo: `offer_inspect_modal.tscn`

```
[gd_scene format=3 uid="uid://x2f5g1apjibx"]

[ext_resource type="Script" path="res://features/economy/shop/offer_inspect_modal.gd" id="1_modal"]
[ext_resource type="Texture2D" path="res://assets/sprites/generators/cyber_tank.png" id="2_spr"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel"]
bg_color = Color(0.08, 0.09, 0.13, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.75, 0.1, 1)
corner_radius_top_left = 14
corner_radius_top_right = 14
corner_radius_bottom_right = 14
corner_radius_bottom_left = 14
shadow_color = Color(1, 0.7, 0, 0.3)
shadow_size = 18

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pedestal"]
bg_color = Color(0.05, 0.06, 0.08, 0.9)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.18, 0.32, 0.45, 0.8)
corner_radius_top_left = 10
corner_radius_top_right = 10
corner_radius_bottom_right = 10
corner_radius_bottom_left = 10

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_glow_base"]
bg_color = Color(0.15, 0.65, 0.85, 0.4)
border_width_top = 3
border_color = Color(0.35, 0.95, 1, 1)
corner_radius_top_left = 60
corner_radius_top_right = 60
corner_radius_bottom_right = 60
corner_radius_bottom_left = 60

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_buy_btn"]
bg_color = Color(1, 0.78, 0.12, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.95, 0.6, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="OfferInspectModal" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_modal")

[node name="DarkOverlay" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.03, 0.04, 0.06, 0.9)

[node name="Center" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="Panel" type="PanelContainer" parent="Center"]
custom_minimum_size = Vector2(880, 480)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel")

[node name="Margin" type="MarginContainer" parent="Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 20

[node name="HBox" type="HBoxContainer" parent="Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 28

[node name="PedestalArea" type="PanelContainer" parent="Center/Panel/Margin/HBox"]
custom_minimum_size = Vector2(380, 0)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_pedestal")

[node name="LightGlow" type="ColorRect" parent="Center/Panel/Margin/HBox/PedestalArea"]
layout_mode = 2
color = Color(0.08, 0.25, 0.4, 0.25)

[node name="PedestalBase" type="Panel" parent="Center/Panel/Margin/HBox/PedestalArea"]
custom_minimum_size = Vector2(260, 42)
layout_mode = 2
size_flags_horizontal = 4
size_flags_vertical = 8
theme_override_styles/panel = SubResource("StyleBoxFlat_glow_base")

[node name="GeneratorTexture" type="TextureRect" parent="Center/Panel/Margin/HBox/PedestalArea"]
custom_minimum_size = Vector2(240, 150)
layout_mode = 2
size_flags_horizontal = 4
size_flags_vertical = 4
texture = ExtResource("2_spr")
expand_mode = 1
stretch_mode = 5

[node name="TimerBadge" type="PanelContainer" parent="Center/Panel/Margin/HBox/PedestalArea"]
custom_minimum_size = Vector2(0, 34)
layout_mode = 2
size_flags_vertical = 8

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/HBox/PedestalArea/TimerBadge"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 12

[node name="HBox" type="HBoxContainer" parent="Center/Panel/Margin/HBox/PedestalArea/TimerBadge/Margin"]
layout_mode = 2
alignment = 1

[node name="Icon" type="Label" parent="Center/Panel/Margin/HBox/PedestalArea/TimerBadge/Margin/HBox"]
layout_mode = 2
text = "⏳ "

[node name="TimerLabel" type="Label" parent="Center/Panel/Margin/HBox/PedestalArea/TimerBadge/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 13
text = "TERMINA EN: 06D 23H 59M 59S"

[node name="DetailsArea" type="VBoxContainer" parent="Center/Panel/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 12

[node name="TopRow" type="HBoxContainer" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2

[node name="RarityBadge" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea/TopRow"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.82, 0.15, 1)
theme_override_font_sizes/font_size = 11
text = "★ EDICIÓN ESPECIAL LIMITADA"

[node name="Spacer" type="Control" parent="Center/Panel/Margin/HBox/DetailsArea/TopRow"]
layout_mode = 2
size_flags_horizontal = 3

[node name="CloseButton" type="Button" parent="Center/Panel/Margin/HBox/DetailsArea/TopRow"]
custom_minimum_size = Vector2(36, 36)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "✕"

[node name="Title" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2
theme_override_colors/font_color = Color(0.95, 0.98, 1, 1)
theme_override_font_sizes/font_size = 24
text = "CYBER TANK 100%"

[node name="Description" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.85, 0.92, 0.9)
theme_override_font_sizes/font_size = 12
text = "Estación eléctrica pesada de plasma cuántico. Generación continua ininterrumpida."
autowrap_mode = 2

[node name="HSeparator" type="HSeparator" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2

[node name="StatsBox" type="VBoxContainer" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="PowerRow" type="HBoxContainer" parent="Center/Panel/Margin/HBox/DetailsArea/StatsBox"]
layout_mode = 2

[node name="Title" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea/StatsBox/PowerRow"]
layout_mode = 2
theme_override_colors/font_color = Color(0.7, 0.75, 0.85, 1)
theme_override_font_sizes/font_size = 13
text = "⚡ Potencia:"

[node name="PowerVal" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea/StatsBox/PowerRow"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 13
text = "0.000002100 KWP"
horizontal_alignment = 2

[node name="IncomeRow" type="HBoxContainer" parent="Center/Panel/Margin/HBox/DetailsArea/StatsBox"]
layout_mode = 2

[node name="Title" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea/StatsBox/IncomeRow"]
layout_mode = 2
theme_override_colors/font_color = Color(0.7, 0.75, 0.85, 1)
theme_override_font_sizes/font_size = 13
text = "🪙 Generación Continua:"

[node name="IncomeVal" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea/StatsBox/IncomeRow"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "+0.000002100 kW / min"
horizontal_alignment = 2

[node name="Spacer" type="Control" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2
size_flags_vertical = 3

[node name="StatusMsg" type="Label" parent="Center/Panel/Margin/HBox/DetailsArea"]
layout_mode = 2
theme_override_font_sizes/font_size = 12
horizontal_alignment = 1

[node name="BuyButton" type="Button" parent="Center/Panel/Margin/HBox/DetailsArea"]
custom_minimum_size = Vector2(0, 48)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.08, 0.06, 0.01, 1)
theme_override_font_sizes/font_size = 15
theme_override_styles/normal = SubResource("StyleBoxFlat_buy_btn")
text = "⚡ COMPRAR POR 1.0 KILOWAT"
```

---

####### 📄 Archivo: `shop_screen.gd`

```
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
				
				# KITS INDUSTRIALES PARA BALLENAS (SUMINISTROS MASIVOS EN CUP)
				{"id": "pack_whale_mat_basic", "name": "Caja de Materiales Básicos", "rarity": "Épico", "stat_desc": "+50 Cobre, +50 Plástico, +50 Silicio (T1)", "description": "Lote inicial de materias primas para reparar y craftear al instante sin grindear.", "is_fiat": true, "fiat_price": "350 CUP",	"texture_path": "res://assets/sprites/ui/icon_chip.png"},
				{"id": "pack_whale_mat_industrial",	"name": "Caja de Suministros Industriales", "rarity": "Legendario",	"stat_desc": "+100 de Todos los Materiales (T1 y T2)", "description": "100 Cobre, 100 Plástico, 100 Silicio y 50 Hierro. El kit predilecto para plantas avanzadas.", "is_fiat": true, "fiat_price": "850 CUP", "texture_path": "res://assets/sprites/ui/icon_kilowat.png"},
				{"id": "pack_whale_vip_parts", "name": "Kit de Mantenimiento VIP", "rarity": "Legendario", "stat_desc": "Piezas Nv.3 Manufacturadas Listas", "description": "Incluye 10 Cables Nv.3, 10 Ventiladores Nv.3 y 5 Paneles Nv.3. Reparación inmediata al 100%.",	"is_fiat": true, "fiat_price": "1400 CUP", "texture_path": "res://assets/sprites/generators/cyber_tank.png"},
				
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

```

---

####### 📄 Archivo: `shop_screen.gd.uid`

```
uid://dn3scmvlmntu7

```

---

####### 📄 Archivo: `shop_screen.tscn`

```
[gd_scene format=3 uid="uid://cshopmodern001"]

[ext_resource type="Script" path="res://features/economy/shop/shop_screen.gd" id="1_shop"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_watt.png" id="2_watt"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_kilowat.png" id="3_kilo"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_chip.png" id="2_chip"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill"]
bg_color = Color(0.1, 0.13, 0.18, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.35, 0.55, 0.7)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(1, 0.75, 0, 0.35)
shadow_size = 14

[node name="ShopScreen" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_shop")

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="CanvasLayer" type="CanvasLayer" parent="."]

[node name="MainVBox" type="VBoxContainer" parent="CanvasLayer"]
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 0

[node name="TopBar" type="PanelContainer" parent="CanvasLayer/MainVBox"]
custom_minimum_size = Vector2(0, 68)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")

[node name="Margin" type="MarginContainer" parent="CanvasLayer/MainVBox/TopBar"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CanvasLayer/MainVBox/TopBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="BackBtn" type="Button" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "← Volver al Cuarto"

[node name="Title" type="Label" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
text = "⚡ MERCADO DE SUMINISTROS"

[node name="Spacer" type="Control" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="CurrenciesBox" type="HBoxContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="WattPill" type="PanelContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/WattPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/WattPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/WattPill/Margin/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattLabel" type="Label" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/WattPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 14
text = "0.0000"

[node name="KiloPill" type="PanelContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox"]
custom_minimum_size = Vector2(170, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/KiloPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/KiloPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/KiloPill/Margin/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("3_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloLabel" type="Label" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/KiloPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
text = "0.000000"

[node name="ChipPill" type="PanelContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox"]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/ChipPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/ChipPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/ChipPill/Margin/HBox"]
custom_minimum_size = Vector2(24, 24)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="CanvasLayer/MainVBox/TopBar/Margin/HBox/CurrenciesBox/ChipPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 14
text = "0"

[node name="TabsBar" type="PanelContainer" parent="CanvasLayer/MainVBox"]
custom_minimum_size = Vector2(0, 52)
layout_mode = 2

[node name="Margin" type="MarginContainer" parent="CanvasLayer/MainVBox/TabsBar"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="TabsHBox" type="HBoxContainer" parent="CanvasLayer/MainVBox/TabsBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="TabGenerators" type="Button" parent="CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox"]
custom_minimum_size = Vector2(180, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "⚡ Generadores"

[node name="TabRacks" type="Button" parent="CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox"]
custom_minimum_size = Vector2(180, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "🗄️ Estanterías"

[node name="TabCurrency" type="Button" parent="CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox"]
custom_minimum_size = Vector2(180, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "🪙 Monedas & CUP"

[node name="TabOffers" type="Button" parent="CanvasLayer/MainVBox/TabsBar/Margin/TabsHBox"]
custom_minimum_size = Vector2(180, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "🎁 Ofertas Especiales"

[node name="ContentScroll" type="ScrollContainer" parent="CanvasLayer/MainVBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="Margin" type="MarginContainer" parent="CanvasLayer/MainVBox/ContentScroll"]
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 3
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 24

[node name="ItemsGrid" type="GridContainer" parent="CanvasLayer/MainVBox/ContentScroll/Margin"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/h_separation = 18
theme_override_constants/v_separation = 18
columns = 5

[node name="EmptyLabel" type="Label" parent="CanvasLayer/MainVBox/ContentScroll/Margin"]
visible = false
layout_mode = 2
theme_override_colors/font_color = Color(0.7, 0.75, 0.85, 1)
theme_override_font_sizes/font_size = 15
text = "No hay ofertas disponibles en este momento."
horizontal_alignment = 1

[node name="ConfirmModal" type="Control" parent="CanvasLayer"]
visible = false
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="DarkOverlay" type="ColorRect" parent="CanvasLayer/ConfirmModal"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
color = Color(0.02, 0.03, 0.05, 0.9)

[node name="Center" type="CenterContainer" parent="CanvasLayer/ConfirmModal"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Panel" type="PanelContainer" parent="CanvasLayer/ConfirmModal/Center"]
custom_minimum_size = Vector2(480, 260)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="CanvasLayer/ConfirmModal/Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 22
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 22
theme_override_constants/margin_bottom = 20

[node name="VBox" type="VBoxContainer" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="Title" type="Label" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 18
text = "CONFIRMAR ADQUISICIÓN"
horizontal_alignment = 1

[node name="Description" type="Label" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 13
text = "¿Deseas adquirir este artículo?"
horizontal_alignment = 1
autowrap_mode = 2

[node name="PriceBox" type="PanelContainer" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox"]
layout_mode = 2

[node name="HBox" type="HBoxContainer" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/PriceBox"]
layout_mode = 2
alignment = 1

[node name="PriceIcon" type="TextureRect" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/PriceBox/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
expand_mode = 1
stretch_mode = 5

[node name="PriceText" type="Label" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/PriceBox/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 15
text = "0.00"

[node name="Buttons" type="HBoxContainer" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="CancelBtn" type="Button" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/Buttons"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
text = "Cancelar"

[node name="ConfirmBtn" type="Button" parent="CanvasLayer/ConfirmModal/Center/Panel/Margin/VBox/Buttons"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
text = "✓ Confirmar"

[node name="DescModal" type="Control" parent="CanvasLayer"]
visible = false
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="DarkOverlay" type="ColorRect" parent="CanvasLayer/DescModal"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
color = Color(0.02, 0.03, 0.05, 0.9)

[node name="Center" type="CenterContainer" parent="CanvasLayer/DescModal"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Panel" type="PanelContainer" parent="CanvasLayer/DescModal/Center"]
custom_minimum_size = Vector2(460, 380)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="CanvasLayer/DescModal/Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 20
theme_override_constants/margin_bottom = 20

[node name="VBox" type="VBoxContainer" parent="CanvasLayer/DescModal/Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 10

[node name="Title" type="Label" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
horizontal_alignment = 1

[node name="ImgBox" type="PanelContainer" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox"]
custom_minimum_size = Vector2(0, 110)
layout_mode = 2

[node name="Texture" type="TextureRect" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox/ImgBox"]
layout_mode = 2
expand_mode = 1
stretch_mode = 5

[node name="RarityLabel" type="Label" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox"]
layout_mode = 2
horizontal_alignment = 1

[node name="PowerLabel" type="Label" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox"]
layout_mode = 2

[node name="DescText" type="Label" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox"]
layout_mode = 2
autowrap_mode = 2

[node name="CloseBtn" type="Button" parent="CanvasLayer/DescModal/Center/Panel/Margin/VBox"]
custom_minimum_size = Vector2(0, 38)
layout_mode = 2
text = "Cerrar"
```

---

##### 📁 Carpeta: `./features\intro/`

###### 📄 Archivo: `splash_intro.gd`

```
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

```

---

###### 📄 Archivo: `splash_intro.gd.uid`

```
uid://b5pwf4pchcfsq

```

---

###### 📄 Archivo: `splash_intro.tscn`

```
[gd_scene format=3 uid="uid://dm1twocqvfos8"]

[ext_resource type="Script" uid="uid://b5pwf4pchcfsq" path="res://features/intro/splash_intro.gd" id="1_intro"]

[sub_resource type="Gradient" id="Gradient_particles"]
offsets = PackedFloat32Array(0, 0.6, 1)
colors = PackedColorArray(0.35, 0.88, 1, 1, 1, 0.85, 0.2, 0.8, 0.1, 0.4, 0.9, 0)

[node name="SplashIntro" type="Control" unique_id=544641996]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_intro")

[node name="Background" type="ColorRect" parent="." unique_id=157873742]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.03, 0.04, 0.06, 1)

[node name="Particles" type="CPUParticles2D" parent="." unique_id=173868177]
position = Vector2(640, 360)
emitting = false
amount = 40
lifetime = 1.2
one_shot = true
explosiveness = 0.85
emission_shape = 1
emission_sphere_radius = 50.0
direction = Vector2(0, 0)
spread = 180.0
gravity = Vector2(0, 80)
initial_velocity_min = 120.0
initial_velocity_max = 320.0
scale_amount_min = 3.0
scale_amount_max = 7.0
color_ramp = SubResource("Gradient_particles")

[node name="Center" type="CenterContainer" parent="." unique_id=681137845]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="CardDZM" type="VBoxContainer" parent="Center" unique_id=427057578]
custom_minimum_size = Vector2(600, 180)
layout_mode = 2
theme_override_constants/separation = 10
alignment = 1

[node name="TitleDZM" type="Label" parent="Center/CardDZM" unique_id=760736938]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.9, 1, 1)
theme_override_colors/font_shadow_color = Color(0.1, 0.45, 0.8, 0.6)
theme_override_constants/shadow_offset_x = 0
theme_override_constants/shadow_offset_y = 0
theme_override_constants/shadow_outline_size = 18
theme_override_font_sizes/font_size = 46
text = "D Z M   S T U D I O"
horizontal_alignment = 1

[node name="SubDZM" type="Label" parent="Center/CardDZM" unique_id=410021242]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.75, 0.9, 0.85)
theme_override_font_sizes/font_size = 14
text = "P R E S E N T S"
horizontal_alignment = 1

[node name="CardClanHater" type="VBoxContainer" parent="Center" unique_id=1479712407]
custom_minimum_size = Vector2(600, 180)
layout_mode = 2
theme_override_constants/separation = 10
alignment = 1

[node name="BadgeClanHater" type="Label" parent="Center/CardClanHater" unique_id=1254526170]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.45, 0.85, 1)
theme_override_font_sizes/font_size = 13
text = "★ A N O T H E R   C R E A T I O N ★"
horizontal_alignment = 1

[node name="TitleClanHater" type="Label" parent="Center/CardClanHater" unique_id=1042493861]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_colors/font_shadow_color = Color(0.85, 0.25, 0.1, 0.6)
theme_override_constants/shadow_offset_x = 0
theme_override_constants/shadow_offset_y = 0
theme_override_constants/shadow_outline_size = 20
theme_override_font_sizes/font_size = 40
text = "ClanHater Project"
horizontal_alignment = 1

[node name="CardKilowat" type="VBoxContainer" parent="Center" unique_id=824811237]
custom_minimum_size = Vector2(700, 220)
layout_mode = 2
theme_override_constants/separation = 12
alignment = 1

[node name="LogoKilowat" type="Label" parent="Center/CardKilowat" unique_id=180546547]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_colors/font_shadow_color = Color(0.18, 0.65, 0.95, 0.8)
theme_override_constants/shadow_offset_x = 0
theme_override_constants/shadow_offset_y = 0
theme_override_constants/shadow_outline_size = 28
theme_override_font_sizes/font_size = 64
text = "⚡ KILOWAT ⚡"
horizontal_alignment = 1

[node name="SubKilowat" type="Label" parent="Center/CardKilowat" unique_id=1557380521]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.9, 1, 0.9)
theme_override_font_sizes/font_size = 14
text = "SISTEMA DE GENERACIÓN ELÉCTRICA"
horizontal_alignment = 1

[node name="FlashOverlay" type="ColorRect" parent="." unique_id=646639720]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
color = Color(0.8, 0.95, 1, 1)

[node name="SkipLabel" type="Label" parent="." unique_id=115918666]
layout_mode = 1
anchors_preset = 3
anchor_left = 1.0
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
offset_left = -220.0
offset_top = -42.0
offset_right = -24.0
offset_bottom = -20.0
grow_horizontal = 0
grow_vertical = 0
theme_override_colors/font_color = Color(0.5, 0.55, 0.65, 0.6)
theme_override_font_sizes/font_size = 12
text = "Toca para saltar ➔"
horizontal_alignment = 2

```

---

##### 📁 Carpeta: `./features\minigames/`

###### 📁 Carpeta: `./features\minigames\coin_click/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `coin_click.gd`

```
# res://features/minigames/coin_click/coin_click.gd
extends Control

const GAME_ID: String = "coinclick"
const FUSE_PUZZLE_SCENE = preload("res://features/minigames/_shared/fuse_puzzle.tscn")
var active_puzzle = null

@export_group("Configuración Mago (Hamster)")
@export var wizard_hframes: int = 6
@export var wizard_vframes: int = 1
@export_range(1.0, 6.0, 0.1) var wizard_scale: float = 2.6

@export_group("Configuración Moneda")
@export var coin_hframes: int = 4
@export var coin_vframes: int = 1
@export_range(1.0, 6.0, 0.1) var coin_scale: float = 2.8

@export_group("Configuración Bomba")
@export var bomb_hframes: int = 4
@export var bomb_vframes: int = 1
@export_range(1.0, 6.0, 0.1) var bomb_scale: float = 2.6

@export_group("Velocidad de Animación")
@export_range(2.0, 30.0, 1.0) var animation_fps: float = 10.0

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var fallback_wall: ColorRect = $FallbackWall
@onready var wizard_sprite: Sprite2D = $PlayArea/WizardSprite
@onready var droppables_container: Node2D = $PlayArea/DroppablesContainer

@onready var score_label: Label = $HUD/TopPanel/MarginContainer/HBoxContainer/ScoreBox/ScoreLabel
@onready var level_label: Label = $HUD/TopPanel/MarginContainer/HBoxContainer/LevelLabel
@onready var timer_label: Label = $HUD/TopPanel/MarginContainer/HBoxContainer/TimeBox/TimerLabel
@onready var exit_button: Button = $HUD/TopPanel/MarginContainer/HBoxContainer/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

var current_level: int = 1
var coins_target: int = 8
var wizard_speed: float = 200.0
var drop_fall_speed: float = 190.0
var drop_interval: float = 1.3
var time_remaining: float = 45.0

var wizard_dir: float = 1.0
var drop_timer: float = 0.0
var anim_timer: float = 0.0
var coins_collected: int = 0
var game_over: bool = false

var tex_wizard: Texture2D
var tex_coin: Texture2D
var tex_bomb: Texture2D
var current_session_token: String = ""

var retry_cooldown_left: int = 0
var retry_tick_accum: float = 0.0

func set_session_token(token: String) -> void: current_session_token = token
func set_game_level(lvl: int) -> void: current_level = clamp(lvl, 1, 4)

func _ready() -> void:
	exit_button.pressed.connect(_return_to_hub)
	action_button.pressed.connect(_return_to_hub)
	retry_button.pressed.connect(_on_retry_pressed)
	
	_load_assets()
	_apply_level_parameters()
	_update_ui()

func _load_assets() -> void:
	var bg_path = "res://assets/sprites/minigames/coinclick/bg.png"
	if ResourceLoader.exists(bg_path):
		bg_texture.texture = load(bg_path)
		fallback_wall.visible = false
	else:
		fallback_wall.visible = true

	var w_path = "res://assets/sprites/minigames/coinclick/wizard.png"
	if ResourceLoader.exists(w_path):
		tex_wizard = load(w_path)
		wizard_sprite.texture = tex_wizard
		wizard_sprite.hframes = wizard_hframes
		wizard_sprite.vframes = wizard_vframes
		wizard_sprite.frame = 0
		wizard_sprite.scale = Vector2(wizard_scale, wizard_scale)

	var c_path = "res://assets/sprites/minigames/coinclick/coin.png"
	if ResourceLoader.exists(c_path): tex_coin = load(c_path)
	var b_path = "res://assets/sprites/minigames/coinclick/bomb.png"
	if ResourceLoader.exists(b_path): tex_bomb = load(b_path)

func _apply_level_parameters() -> void:
	match current_level:
		1: coins_target = 8; wizard_speed = 200.0; drop_fall_speed = 190.0; drop_interval = 1.3; time_remaining = 45.0
		2: coins_target = 14; wizard_speed = 300.0; drop_fall_speed = 260.0; drop_interval = 1.0; time_remaining = 40.0
		3: coins_target = 20; wizard_speed = 420.0; drop_fall_speed = 340.0; drop_interval = 0.75; time_remaining = 35.0
		4: coins_target = 26; wizard_speed = 520.0; drop_fall_speed = 420.0; drop_interval = 0.6; time_remaining = 30.0

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return
		
	wizard_sprite.position.x += wizard_speed * wizard_dir * delta
	if wizard_sprite.position.x <= 160.0:
		wizard_sprite.position.x = 160.0; wizard_dir = 1.0; wizard_sprite.flip_h = false
	elif wizard_sprite.position.x >= 1120.0:
		wizard_sprite.position.x = 1120.0; wizard_dir = -1.0; wizard_sprite.flip_h = true

	var frame_interval: float = 1.0 / maxf(1.0, animation_fps)
	anim_timer += delta
	if anim_timer >= frame_interval:
		anim_timer = 0.0
		var total_wiz_frames: int = wizard_sprite.hframes * wizard_sprite.vframes
		if total_wiz_frames > 1:
			wizard_sprite.frame = (wizard_sprite.frame + 1) % total_wiz_frames
			
		for drop in droppables_container.get_children():
			var spr: Sprite2D = drop.get_node_or_null("Sprite")
			if spr:
				var total_drop_frames: int = spr.hframes * spr.vframes
				if total_drop_frames > 1:
					spr.frame = (spr.frame + 1) % total_drop_frames

	drop_timer += delta
	if drop_timer >= drop_interval:
		drop_timer = 0.0
		_spawn_droppable()

	for drop in droppables_container.get_children():
		drop.position.y += drop_fall_speed * delta
		if drop.position.y >= 710.0:
			if drop.get_meta("is_bomb") == false:
				_on_game_lost("¡Una moneda tocó el suelo!")
				return
			else:
				drop.queue_free()

	time_remaining -= delta
	if time_remaining <= 0.0:
		time_remaining = 0.0
		_on_game_lost("¡Se agotó el tiempo!")

	_update_ui()

func _spawn_droppable() -> void:
	var is_bomb: bool = (randf() < 0.35)
	var spawn_pos := Vector2(wizard_sprite.position.x, wizard_sprite.position.y + 40.0)

	var item_node := Node2D.new()
	item_node.position = spawn_pos
	item_node.set_meta("is_bomb", is_bomb)

	var spr := Sprite2D.new()
	spr.name = "Sprite"
	spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	if is_bomb:
		spr.texture = tex_bomb
		spr.hframes = bomb_hframes; spr.vframes = bomb_vframes; spr.scale = Vector2(bomb_scale, bomb_scale)
	else:
		spr.texture = tex_coin
		spr.hframes = coin_hframes; spr.vframes = coin_vframes; spr.scale = Vector2(coin_scale, coin_scale)
		
	spr.frame = 0
	item_node.add_child(spr)

	var btn := Button.new()
	btn.custom_minimum_size = Vector2(64, 64)
	btn.position = Vector2(-32, -32)
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn.flat = true
	btn.pressed.connect(func(): _on_item_clicked(item_node, is_bomb))
	item_node.add_child(btn)
	droppables_container.add_child(item_node)

func _on_item_clicked(item: Node2D, is_bomb: bool) -> void:
	if game_over: return
	if is_bomb:
		item.queue_free()
		_on_game_lost("¡Tocaste una bomba!")
	else:
		item.queue_free()
		coins_collected += 1
		_update_ui()
		if coins_collected >= coins_target: _on_game_won()

func _update_ui() -> void:
	score_label.text = "MONEDAS: %d / %d" % [coins_collected, coins_target]
	level_label.text = "DIFICULTAD: %d" % current_level
	timer_label.text = "00:%02d" % int(time_remaining)

func _update_retry_button() -> void:
	if retry_button == null: return
	if retry_cooldown_left > 0:
		retry_button.disabled = true
		var m = int(float(retry_cooldown_left) / 60.0)
		var s = retry_cooldown_left % 60
		retry_button.text = "⏳ Espera %02d:%02d" % [m, s]
	else:
		retry_button.disabled = false
		retry_button.text = "🏁 Volver a Jugar"

func _on_game_won() -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "¡VICTORIA!"
	result_title.add_theme_color_override("font_color", Color(0.3, 1.0, 0.4))
	result_message.text = "Guardando victoria en la central..."
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID,
		"p_won": true,
		"p_session_token": current_session_token,
		"p_score_achieved": coins_collected
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var data = res["data"]
		var reward = float(data.get("reward_kwp", 0.000000001))
		var cd = int(data.get("cooldown_seconds", 5))
		var wins_in_lvl = int(data.get("wins_in_level", 0))
		var leveled_up = bool(data.get("leveled_up", false))
		var new_lvl = int(data.get("current_level", current_level))
		var is_inf = bool(data.get("is_infinite", false))
		
		GameManager.set_cooldown_seconds(GAME_ID, cd)
		GameManager.add_temporary_power(reward)
		retry_cooldown_left = cd
		_update_retry_button()
		
		if is_inf and new_lvl == 4:
			result_message.text = "⚡ ¡NIVEL 4 INFINITO!\n+%.9f KWP ganado.\n(Cooldown entre partidas: 2 min)" % reward
		elif leveled_up:
			result_message.text = "⭐ ¡SUBISTE A NIVEL %d!\n+%.9f KWP ganado." % [new_lvl, reward]
		else:
			result_message.text = "¡Nivel superado!\n+%.9f KWP ganado.\n(Progreso nivel: %d / 6 victorias)" % [reward, wins_in_lvl]
			
		# Recompensas de Materiales y Profesión RPG
		result_message.text += GameManager.process_minigame_rpg_rewards(data)

func _on_game_lost(reason: String) -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "DERROTA"
	result_title.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	result_message.text = reason + "\nNo obtienes recompensa. Vuelve a intentarlo."
	cooldown_label.text = ""
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID,
		"p_won": false,
		"p_session_token": current_session_token
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	var cd: int = int(res.get("data", {}).get("cooldown_seconds", 5)) if res.get("success", false) else 5
	GameManager.set_cooldown_seconds(GAME_ID, cd)
	retry_cooldown_left = cd
	_update_retry_button()

func _on_retry_pressed() -> void:
	if retry_cooldown_left > 0: return
	retry_button.disabled = true
	retry_button.text = "Iniciando..."
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": GAME_ID}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		_trigger_in_game_captcha()
		return
		
	if not res.get("success", false) or not res["data"].get("success", false):
		retry_cooldown_left = int(res.get("data", {}).get("remaining_seconds", 3))
		_update_retry_button()
		return
		
	var new_token: String = str(res["data"].get("session_token", ""))
	var new_lvl: int = int(res["data"].get("current_level", current_level))
	_restart_game_scene(new_lvl, new_token)

func _trigger_in_game_captcha() -> void:
	if active_puzzle == null:
		active_puzzle = FUSE_PUZZLE_SCENE.instantiate()
		$HUD.add_child(active_puzzle)
		active_puzzle.puzzle_completed.connect(func(success: bool):
			if success: _on_retry_pressed()
			else:
				retry_cooldown_left = 30
				_update_retry_button()
		)
	active_puzzle.open_challenge()

func _restart_game_scene(new_lvl: int, new_token: String) -> void:
	var path: String = "res://features/minigames/coin_click/coin_click.tscn"
	var new_scene = load(path).instantiate()
	new_scene.set_game_level(new_lvl)
	new_scene.set_session_token(new_token)
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")

```

---

####### 📄 Archivo: `coin_click.gd.uid`

```
uid://dln3kdc2jcad6

```

---

####### 📄 Archivo: `coin_click.tscn`

```
[gd_scene format=3 uid="uid://ccoinclick001"]

[ext_resource type="Script" path="res://features/minigames/coin_click/coin_click.gd" id="1_cclick"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_cyan_btn"]
bg_color = Color(0.15, 0.75, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.5, 0.9, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="CoinClickGame" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_cclick")
wizard_hframes = 10
coin_hframes = 8
bomb_hframes = 16

[node name="BackgroundTexture" type="TextureRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
expand_mode = 1
stretch_mode = 6

[node name="FallbackWall" type="ColorRect" parent="."]
visible = false
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
color = Color(0.12, 0.13, 0.17, 1)

[node name="PlayArea" type="Node2D" parent="."]

[node name="WizardSprite" type="Sprite2D" parent="PlayArea"]
texture_filter = 1
position = Vector2(640, 110)

[node name="DroppablesContainer" type="Node2D" parent="PlayArea"]

[node name="HUD" type="CanvasLayer" parent="."]

[node name="TopPanel" type="PanelContainer" parent="HUD"]
custom_minimum_size = Vector2(0, 64)
anchors_preset = 10
anchor_right = 1.0
grow_horizontal = 2

[node name="MarginContainer" type="MarginContainer" parent="HUD/TopPanel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBoxContainer" type="HBoxContainer" parent="HUD/TopPanel/MarginContainer"]
layout_mode = 2
theme_override_constants/separation = 25

[node name="ScoreBox" type="HBoxContainer" parent="HUD/TopPanel/MarginContainer/HBoxContainer"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="ScoreLabel" type="Label" parent="HUD/TopPanel/MarginContainer/HBoxContainer/ScoreBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 20
text = "MONEDAS: 0 / 10"

[node name="LevelLabel" type="Label" parent="HUD/TopPanel/MarginContainer/HBoxContainer"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.85, 1, 1)
theme_override_font_sizes/font_size = 18
text = "DIFICULTAD: 1"

[node name="Spacer" type="Control" parent="HUD/TopPanel/MarginContainer/HBoxContainer"]
layout_mode = 2
size_flags_horizontal = 3

[node name="TimeBox" type="HBoxContainer" parent="HUD/TopPanel/MarginContainer/HBoxContainer"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="TimeIcon" type="Label" parent="HUD/TopPanel/MarginContainer/HBoxContainer/TimeBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "⏳"

[node name="TimerLabel" type="Label" parent="HUD/TopPanel/MarginContainer/HBoxContainer/TimeBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "00:40"

[node name="ExitButton" type="Button" parent="HUD/TopPanel/MarginContainer/HBoxContainer"]
custom_minimum_size = Vector2(100, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "Salir"

[node name="ResultDialog" type="PanelContainer" parent="HUD"]
visible = false
custom_minimum_size = Vector2(420, 240)
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -210.0
offset_top = -120.0
offset_right = 210.0
offset_bottom = 120.0
grow_horizontal = 2
grow_vertical = 2

[node name="Margin" type="MarginContainer" parent="HUD/ResultDialog"]
layout_mode = 2
theme_override_constants/margin_left = 22
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 22
theme_override_constants/margin_bottom = 22

[node name="VBox" type="VBoxContainer" parent="HUD/ResultDialog/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 22
text = "¡VICTORIA!"
horizontal_alignment = 1

[node name="Message" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 13
text = "+0.000000001 KWP obtenido"
horizontal_alignment = 1

[node name="CooldownLabel" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.8, 0.3, 1)
theme_override_font_sizes/font_size = 12
text = "Espera 5s para la siguiente partida"
horizontal_alignment = 1

[node name="ButtonsHBox" type="HBoxContainer" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ActionButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "Continuar"

[node name="RetryButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.04, 0.08, 0.12, 1)
theme_override_styles/normal = SubResource("StyleBoxFlat_cyan_btn")
text = "Volver a Jugar"
```

---

###### 📁 Carpeta: `./features\minigames\coin_match/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `coin_match.gd`

```
# res://features/minigames/coin_match/coin_match.gd
extends Control

const GAME_ID: String = "coin_match"
const GRID_ROWS: int = 7
const GRID_COLS: int = 7
const CELL_SIZE: float = 64.0
const COIN_HFRAMES: int = 7

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var board_container: Control = $PlayArea/BoardContainer
@onready var highlight_rect: ReferenceRect = $PlayArea/HighlightRect

@onready var score_label: Label = $HUD/TopPanel/Margin/HBox/ScoreBox/ScoreLabel
@onready var level_label: Label = $HUD/TopPanel/Margin/HBox/LevelLabel
@onready var timer_label: Label = $HUD/TopPanel/Margin/HBox/TimeBox/TimerLabel
@onready var exit_button: Button = $HUD/TopPanel/Margin/HBox/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

var current_level: int = 1
var target_score: int = 800
var current_score: int = 0
var time_remaining: float = 50.0
var num_coin_types: int = 5

var current_session_token: String = ""
var game_over: bool = false
var is_processing_matches: bool = false

var grid_data: Array = []
var grid_sprites: Array = []
var selected_cell: Vector2i = Vector2i(-1, -1)
var tex_coins: Texture2D

var retry_cooldown_left: int = 0
var retry_tick_accum: float = 0.0

func set_session_token(token: String) -> void: current_session_token = token
func set_game_level(lvl: int) -> void: current_level = clamp(lvl, 1, 4)

func _ready() -> void:
	exit_button.pressed.connect(_return_to_hub)
	action_button.pressed.connect(_return_to_hub)
	retry_button.pressed.connect(_on_retry_pressed)
	
	_load_assets()
	_apply_level_parameters()
	_setup_board_ui()
	_init_grid()
	_update_ui()

func _load_assets() -> void:
	var bg_path = "res://assets/sprites/minigames/coin_match/bg.png"
	if ResourceLoader.exists(bg_path): bg_texture.texture = load(bg_path)
	var coins_path = "res://assets/sprites/minigames/coin_match/coins.png"
	if ResourceLoader.exists(coins_path): tex_coins = load(coins_path)

func _apply_level_parameters() -> void:
	match current_level:
		1: target_score = 800; time_remaining = 50.0; num_coin_types = 5
		2: target_score = 1500; time_remaining = 45.0; num_coin_types = 5
		3: target_score = 2400; time_remaining = 40.0; num_coin_types = 6
		4: target_score = 3400; time_remaining = 35.0; num_coin_types = 7

func _setup_board_ui() -> void:
	var total_w: float = GRID_COLS * CELL_SIZE
	var total_h: float = GRID_ROWS * CELL_SIZE
	board_container.custom_minimum_size = Vector2(total_w, total_h)
	board_container.size = Vector2(total_w, total_h)
	board_container.position = Vector2((1280.0 - total_w) / 2.0, (720.0 - total_h) / 2.0 + 25.0)
	highlight_rect.visible = false
	highlight_rect.size = Vector2(CELL_SIZE, CELL_SIZE)

func _init_grid() -> void:
	grid_data.clear(); grid_sprites.clear()
	for child in board_container.get_children(): child.queue_free()

	for r in range(GRID_ROWS):
		var row_data = []; var row_sprites = []
		for c in range(GRID_COLS): row_data.append(-1); row_sprites.append(null)
		grid_data.append(row_data); grid_sprites.append(row_sprites)

	for r in range(GRID_ROWS):
		for c in range(GRID_COLS):
			var possible_types = []
			for t in range(num_coin_types):
				if c >= 2 and grid_data[r][c-1] == t and grid_data[r][c-2] == t: continue
				if r >= 2 and grid_data[r-1][c] == t and grid_data[r-2][c] == t: continue
				possible_types.append(t)
			var chosen_type: int = possible_types[randi() % possible_types.size()]
			grid_data[r][c] = chosen_type
			_create_coin_sprite(r, c, chosen_type)

func _create_coin_sprite(r: int, c: int, type_idx: int) -> Sprite2D:
	var spr := Sprite2D.new()
	spr.texture = tex_coins
	spr.hframes = COIN_HFRAMES
	spr.frame = type_idx
	spr.centered = true
	spr.position = Vector2((c + 0.5) * CELL_SIZE, (r + 0.5) * CELL_SIZE)
	if tex_coins:
		var frame_w: float = float(tex_coins.get_width()) / float(COIN_HFRAMES)
		var s: float = 46.0 / maxf(1.0, frame_w)
		spr.scale = Vector2(s, s)
	board_container.add_child(spr)
	grid_sprites[r][c] = spr
	return spr

func _input(event: InputEvent) -> void:
	if game_over or is_processing_matches: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var board_rect: Rect2 = board_container.get_global_rect()
		if board_rect.has_point(event.position):
			var local_pos: Vector2 = board_container.get_local_mouse_position()
			var col = int(local_pos.x / CELL_SIZE)
			var row = int(local_pos.y / CELL_SIZE)
			if row >= 0 and row < GRID_ROWS and col >= 0 and col < GRID_COLS:
				_handle_cell_clicked(Vector2i(col, row))

func _handle_cell_clicked(cell: Vector2i) -> void:
	if selected_cell == Vector2i(-1, -1):
		selected_cell = cell; _highlight_cell(cell)
	else:
		var diff: Vector2i = (cell - selected_cell).abs()
		var is_adjacent: bool = (diff.x == 1 and diff.y == 0) or (diff.x == 0 and diff.y == 1)
		if is_adjacent:
			var first = selected_cell
			selected_cell = Vector2i(-1, -1)
			highlight_rect.visible = false
			_try_swap(first, cell)
		else:
			selected_cell = cell; _highlight_cell(cell)

func _highlight_cell(cell: Vector2i) -> void:
	highlight_rect.visible = true
	highlight_rect.global_position = board_container.global_position + Vector2(cell.x * CELL_SIZE, cell.y * CELL_SIZE)

func _try_swap(a: Vector2i, b: Vector2i) -> void:
	is_processing_matches = true
	_swap_cells(a, b); await _animate_swap(a, b)
	var matches = _find_all_matches()
	if matches.is_empty():
		_swap_cells(a, b); await _animate_swap(a, b)
		is_processing_matches = false
	else:
		await _resolve_board_cascade()

func _swap_cells(a: Vector2i, b: Vector2i) -> void:
	var temp_type = grid_data[a.y][a.x]
	grid_data[a.y][a.x] = grid_data[b.y][b.x]; grid_data[b.y][b.x] = temp_type
	var temp_spr = grid_sprites[a.y][a.x]
	grid_sprites[a.y][a.x] = grid_sprites[b.y][b.x]; grid_sprites[b.y][b.x] = temp_spr

func _animate_swap(a: Vector2i, b: Vector2i) -> void:
	var spr_a: Sprite2D = grid_sprites[a.y][a.x]
	var spr_b: Sprite2D = grid_sprites[b.y][b.x]
	if spr_a == null and spr_b == null: return
	var target_a := Vector2((a.x + 0.5) * CELL_SIZE, (a.y + 0.5) * CELL_SIZE)
	var target_b := Vector2((b.x + 0.5) * CELL_SIZE, (b.y + 0.5) * CELL_SIZE)
	var tween = create_tween().set_parallel(true)
	if spr_a and is_instance_valid(spr_a): tween.tween_property(spr_a, "position", target_a, 0.16).set_trans(Tween.TRANS_QUAD)
	if spr_b and is_instance_valid(spr_b): tween.tween_property(spr_b, "position", target_b, 0.16).set_trans(Tween.TRANS_QUAD)
	await tween.finished

func _find_all_matches() -> Array:
	var matched_cells = []
	for r in range(GRID_ROWS):
		var match_len = 1
		for c in range(1, GRID_COLS):
			if grid_data[r][c] != -1 and grid_data[r][c] == grid_data[r][c-1]: match_len += 1
			else:
				if match_len >= 3:
					for i in range(c - match_len, c):
						var p = Vector2i(i, r); if not p in matched_cells: matched_cells.append(p)
				match_len = 1
		if match_len >= 3:
			for i in range(GRID_COLS - match_len, GRID_COLS):
				var p = Vector2i(i, r); if not p in matched_cells: matched_cells.append(p)

	for c in range(GRID_COLS):
		var match_len = 1
		for r in range(1, GRID_ROWS):
			if grid_data[r][c] != -1 and grid_data[r][c] == grid_data[r-1][c]: match_len += 1
			else:
				if match_len >= 3:
					for i in range(r - match_len, r):
						var p = Vector2i(c, i); if not p in matched_cells: matched_cells.append(p)
				match_len = 1
		if match_len >= 3:
			for i in range(GRID_ROWS - match_len, GRID_ROWS):
				var p = Vector2i(c, i); if not p in matched_cells: matched_cells.append(p)
	return matched_cells

func _resolve_board_cascade() -> void:
	var matches = _find_all_matches()
	while not matches.is_empty():
		current_score += matches.size() * 100
		_update_ui()
		var pop_tween: Tween = create_tween().set_parallel(true)
		for cell in matches:
			var spr = grid_sprites[cell.y][cell.x]
			if spr and is_instance_valid(spr):
				pop_tween.tween_property(spr, "scale", Vector2.ZERO, 0.15)
				pop_tween.tween_property(spr, "modulate:a", 0.0, 0.15)
		await pop_tween.finished
		
		for cell in matches:
			if grid_sprites[cell.y][cell.x] and is_instance_valid(grid_sprites[cell.y][cell.x]):
				grid_sprites[cell.y][cell.x].queue_free()
				grid_sprites[cell.y][cell.x] = null
			grid_data[cell.y][cell.x] = -1

		await _apply_gravity()
		await _refill_board()

		if current_score >= target_score and not game_over:
			_on_game_won()
			is_processing_matches = false
			return
		matches = _find_all_matches()
	is_processing_matches = false

func _apply_gravity() -> void:
	var fall_tween: Tween = null
	var has_fall = false
	for c in range(GRID_COLS):
		var empty_slots = 0
		for r in range(GRID_ROWS - 1, -1, -1):
			if grid_data[r][c] == -1: empty_slots += 1
			elif empty_slots > 0:
				var new_row = r + empty_slots
				grid_data[new_row][c] = grid_data[r][c]; grid_data[r][c] = -1
				var spr = grid_sprites[r][c]
				grid_sprites[new_row][c] = spr; grid_sprites[r][c] = null
				if spr and is_instance_valid(spr):
					if fall_tween == null: fall_tween = create_tween().set_parallel(true)
					var target_pos := Vector2((c + 0.5) * CELL_SIZE, (new_row + 0.5) * CELL_SIZE)
					fall_tween.tween_property(spr, "position", target_pos, 0.2).set_trans(Tween.TRANS_BOUNCE)
					has_fall = true
	if fall_tween and has_fall: await fall_tween.finished

func _refill_board() -> void:
	var spawn_tween: Tween = null
	var has_spawn = false
	for c in range(GRID_COLS):
		for r in range(GRID_ROWS):
			if grid_data[r][c] == -1:
				var new_type = randi() % num_coin_types
				grid_data[r][c] = new_type
				var spr = _create_coin_sprite(r, c, new_type)
				spr.scale = Vector2.ZERO; spr.position.y = -CELL_SIZE
				if spawn_tween == null: spawn_tween = create_tween().set_parallel(true)
				var final_pos := Vector2((c + 0.5) * CELL_SIZE, (r + 0.5) * CELL_SIZE)
				spawn_tween.tween_property(spr, "position", final_pos, 0.22)
				var frame_w: float = float(tex_coins.get_width()) / float(COIN_HFRAMES)
				var final_s: float = 46.0 / maxf(1.0, frame_w)
				spawn_tween.tween_property(spr, "scale", Vector2(final_s, final_s), 0.22)
				has_spawn = true
	if spawn_tween and has_spawn: await spawn_tween.finished

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return
	time_remaining -= delta
	if time_remaining <= 0.0:
		time_remaining = 0.0; _on_game_lost("¡Se agotó el tiempo!")
	_update_ui()

func _update_ui() -> void:
	score_label.text = "PUNTOS: %d / %d" % [current_score, target_score]
	level_label.text = "DIFICULTAD: %d" % current_level
	timer_label.text = "00:%02d" % int(ceil(time_remaining))

func _update_retry_button() -> void:
	if retry_button == null: return
	if retry_cooldown_left > 0:
		retry_button.disabled = true
		var m = int(float(retry_cooldown_left) / 60.0)
		var s = retry_cooldown_left % 60
		retry_button.text = "⏳ Espera %02d:%02d" % [m, s]
	else:
		retry_button.disabled = false
		retry_button.text = "🏁 Volver a Jugar"

func _on_game_won() -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "¡VICTORIA!"
	result_title.add_theme_color_override("font_color", Color(0.3, 1.0, 0.4))
	result_message.text = "Guardando victoria en la central..."

	var payload = {
		"p_game_id": GAME_ID, "p_won": true,
		"p_session_token": current_session_token, "p_score_achieved": current_score
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var data = res["data"]
		var reward = float(data.get("reward_kwp", 0.000000001))
		var cd = int(data.get("cooldown_seconds", 5))
		var wins_in_lvl = int(data.get("wins_in_level", 0))
		var leveled_up = bool(data.get("leveled_up", false))
		var new_lvl = int(data.get("current_level", current_level))
		var is_inf = bool(data.get("is_infinite", false))
		
		GameManager.set_cooldown_seconds(GAME_ID, cd)
		GameManager.add_temporary_power(reward)
		retry_cooldown_left = cd
		_update_retry_button()
		
		if is_inf and new_lvl == 4:
			result_message.text = "⚡ ¡NIVEL 4 INFINITO!\n+%.9f KWP ganado.\n(Cooldown entre partidas: 2 min)" % reward
		elif leveled_up:
			result_message.text = "⭐ ¡SUBISTE A NIVEL %d!\n+%.9f KWP ganado." % [new_lvl, reward]
		else:
			result_message.text = "¡Nivel superado!\n+%.9f KWP ganado.\n(Progreso nivel: %d / 6 victorias)" % [reward, wins_in_lvl]
			
		# Recompensas de Materiales y Profesión RPG
		result_message.text += GameManager.process_minigame_rpg_rewards(data)

func _on_game_lost(reason: String) -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "DERROTA"
	result_title.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	result_message.text = reason + "\nNo obtienes recompensa. Vuelve a intentarlo."
	cooldown_label.text = ""
	retry_cooldown_left = 5
	_update_retry_button()
	var payload = {"p_game_id": GAME_ID, "p_won": false, "p_session_token": current_session_token}
	SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)

func _on_retry_pressed() -> void:
	if retry_cooldown_left > 0: return
	retry_button.disabled = true; retry_button.text = "Iniciando..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": GAME_ID}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		_return_to_hub()
		return
	if res.get("success", false) and res["data"].get("success", false):
		var new_token = str(res["data"].get("session_token", ""))
		var new_lvl = int(res["data"].get("current_level", current_level))
		var new_scene = load("res://features/minigames/coin_match/coin_match.tscn").instantiate()
		new_scene.set_game_level(new_lvl)
		new_scene.set_session_token(new_token)
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
	else:
		_return_to_hub()

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")

```

---

####### 📄 Archivo: `coin_match.gd.uid`

```
uid://i2618ac2htej

```

---

####### 📄 Archivo: `coin_match.tscn`

```
[gd_scene format=3 uid="uid://cg84nstiu4b8o"]

[ext_resource type="Script" path="res://features/minigames/coin_match/coin_match.gd" id="1_cmatch"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_board_bg"]
bg_color = Color(0.08, 0.1, 0.15, 0.88)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.25, 0.45, 0.75, 0.9)
corner_radius_top_left = 10
corner_radius_top_right = 10
corner_radius_bottom_right = 10
corner_radius_bottom_left = 10
shadow_color = Color(0.1, 0.3, 0.6, 0.3)
shadow_size = 12

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(1, 0.75, 0, 0.35)
shadow_size = 14

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_cyan_btn"]
bg_color = Color(0.15, 0.75, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.5, 0.9, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="CoinMatchGame" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_cmatch")

[node name="BackgroundTexture" type="TextureRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
expand_mode = 1
stretch_mode = 6

[node name="PlayArea" type="Control" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 1

[node name="BoardContainer" type="PanelContainer" parent="PlayArea"]
layout_mode = 0
offset_left = 416.0
offset_top = 160.0
offset_right = 864.0
offset_bottom = 608.0
theme_override_styles/panel = SubResource("StyleBoxFlat_board_bg")

[node name="HighlightRect" type="ReferenceRect" parent="PlayArea"]
visible = false
layout_mode = 0
offset_right = 64.0
offset_bottom = 64.0
mouse_filter = 2
border_color = Color(1, 0.9, 0.2, 1)
border_width = 3.0
editor_only = false

[node name="HUD" type="CanvasLayer" parent="."]

[node name="TopPanel" type="PanelContainer" parent="HUD"]
custom_minimum_size = Vector2(0, 64)
anchors_preset = 10
anchor_right = 1.0
grow_horizontal = 2

[node name="Margin" type="MarginContainer" parent="HUD/TopPanel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="HUD/TopPanel/Margin"]
layout_mode = 2
theme_override_constants/separation = 25

[node name="ScoreBox" type="HBoxContainer" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="ScoreLabel" type="Label" parent="HUD/TopPanel/Margin/HBox/ScoreBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 20
text = "PUNTOS: 0 / 1000"

[node name="LevelLabel" type="Label" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.85, 1, 1)
theme_override_font_sizes/font_size = 18
text = "DIFICULTAD: 1"

[node name="Spacer" type="Control" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="TimeBox" type="HBoxContainer" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="TimeIcon" type="Label" parent="HUD/TopPanel/Margin/HBox/TimeBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "⏳"

[node name="TimerLabel" type="Label" parent="HUD/TopPanel/Margin/HBox/TimeBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "00:45"

[node name="ExitButton" type="Button" parent="HUD/TopPanel/Margin/HBox"]
custom_minimum_size = Vector2(100, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "Salir"

[node name="ResultDialog" type="PanelContainer" parent="HUD"]
visible = false
custom_minimum_size = Vector2(420, 240)
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -210.0
offset_top = -120.0
offset_right = 210.0
offset_bottom = 120.0
grow_horizontal = 2
grow_vertical = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="HUD/ResultDialog"]
layout_mode = 2
theme_override_constants/margin_left = 22
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 22
theme_override_constants/margin_bottom = 22

[node name="VBox" type="VBoxContainer" parent="HUD/ResultDialog/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 22
text = "¡VICTORIA!"
horizontal_alignment = 1

[node name="Message" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 13
text = "+0.000000001 KWP obtenido"
horizontal_alignment = 1

[node name="CooldownLabel" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.8, 0.3, 1)
theme_override_font_sizes/font_size = 12
text = "Espera 5s para la siguiente partida"
horizontal_alignment = 1

[node name="ButtonsHBox" type="HBoxContainer" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ActionButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "Continuar"

[node name="RetryButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.04, 0.08, 0.12, 1)
theme_override_styles/normal = SubResource("StyleBoxFlat_cyan_btn")
text = "Volver a Jugar"
```

---

###### 📁 Carpeta: `./features\minigames\crypto_memory/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `crypto_memory.gd`

```
# res://features/minigames/crypto_memory/crypto_memory.gd
extends Control

const COIN_HFRAMES: int = 12
const CARD_SIZE: Vector2 = Vector2(86, 86)
const GAME_ID: String = "crypto_memory"

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var grid_container: GridContainer = $PlayArea/CenterBoard/BoardPanel/Margin/CardsGrid
@onready var score_label: Label = $HUD/TopPanel/Margin/HBox/ScoreBox/ScoreLabel
@onready var level_label: Label = $HUD/TopPanel/Margin/HBox/LevelLabel
@onready var timer_label: Label = $HUD/TopPanel/Margin/HBox/TimeBox/TimerLabel
@onready var exit_button: Button = $HUD/TopPanel/Margin/HBox/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

var current_level: int = 1
var total_pairs_needed: int = 4
var pairs_found: int = 0
var time_remaining: float = 50.0

var current_session_token: String = ""
var game_over: bool = false
var can_flip: bool = true

var first_card = null
var second_card = null
var coin_textures: Array[Texture2D] = []

var retry_cooldown_left: int = 0
var retry_tick_accum: float = 0.0

func set_session_token(token: String) -> void: current_session_token = token
func set_game_level(lvl: int) -> void: current_level = clamp(lvl, 1, 4)

func _ready() -> void:
	exit_button.pressed.connect(_return_to_hub)
	action_button.pressed.connect(_return_to_hub)
	retry_button.pressed.connect(_on_retry_pressed)
	
	_load_assets()
	_apply_level_parameters()
	_setup_board()
	_update_ui()

func _load_assets() -> void:
	var bg_path = "res://assets/sprites/minigames/crypto_memory/bg.png"
	if ResourceLoader.exists(bg_path): bg_texture.texture = load(bg_path)
	elif ResourceLoader.exists("res://assets/sprites/minigames/coin_match/bg.png"):
		bg_texture.texture = load("res://assets/sprites/minigames/coin_match/bg.png")
		
	var file_names = [
		"card_btc.png", "card_eth.png", "card_bnb.png", "card_usdt.png",
		"card_rlt.png", "card_xrp.png", "card_xmr.png", "card_ltc.png",
		"card_eos.png", "card_rocket.png"
	]
	coin_textures.clear()
	for fn in file_names:
		var p1 = "res://assets/sprites/minigames/crypto_memory/" + fn
		var p2 = "res://assets/sprites/minigames/coin_match/" + fn
		if ResourceLoader.exists(p1): coin_textures.append(load(p1))
		elif ResourceLoader.exists(p2): coin_textures.append(load(p2))

func _apply_level_parameters() -> void:
	match current_level:
		1: total_pairs_needed = 4; time_remaining = 50.0; grid_container.columns = 4
		2: total_pairs_needed = 6; time_remaining = 45.0; grid_container.columns = 4
		3: total_pairs_needed = 8; time_remaining = 40.0; grid_container.columns = 4
		4: total_pairs_needed = 10; time_remaining = 35.0; grid_container.columns = 5

func _setup_board() -> void:
	for child in grid_container.get_children(): child.queue_free()
	pairs_found = 0; first_card = null; second_card = null; can_flip = true
	var deck: Array[int] = []
	var max_types: int = max(1, coin_textures.size())
	
	for pair_idx in range(total_pairs_needed):
		var coin_id: int = pair_idx % max_types
		deck.append(coin_id); deck.append(coin_id)
		
	deck.shuffle()
	for i in range(deck.size()):
		var card_btn = _create_card_button(deck[i])
		grid_container.add_child(card_btn)

func _create_card_button(coin_id: int) -> Control:
	var card_root := Control.new()
	card_root.custom_minimum_size = CARD_SIZE; card_root.size = CARD_SIZE
	
	var spr := Sprite2D.new()
	spr.name = "Sprite"
	spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	spr.centered = true
	spr.position = CARD_SIZE / 2.0
	
	if coin_id < coin_textures.size(): spr.texture = coin_textures[coin_id]
	elif coin_textures.size() > 0: spr.texture = coin_textures[0]
		
	spr.hframes = COIN_HFRAMES; spr.frame = 0
	if spr.texture:
		var frame_w: float = float(spr.texture.get_width()) / float(COIN_HFRAMES)
		var scale_factor: float = (CARD_SIZE.x - 6.0) / maxf(1.0, frame_w)
		spr.scale = Vector2(scale_factor, scale_factor)
	card_root.add_child(spr)
	
	var btn := Button.new()
	btn.name = "TouchArea"
	btn.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn.flat = true
	
	card_root.set_meta("coin_id", coin_id)
	card_root.set_meta("is_revealed", false)
	card_root.set_meta("is_matched", false)
	card_root.set_meta("sprite", spr)
	btn.pressed.connect(func(): _on_card_pressed(card_root))
	card_root.add_child(btn)
	return card_root

func _on_card_pressed(card: Control) -> void:
	if game_over or not can_flip: return
	if card.get_meta("is_revealed") or card.get_meta("is_matched"): return
		
	_flip_card_open(card)
	if first_card == null: first_card = card
	elif second_card == null:
		second_card = card
		can_flip = false
		_check_match()

func _flip_card_open(card: Control) -> void:
	card.set_meta("is_revealed", true)
	var spr: Sprite2D = card.get_meta("sprite")
	spr.frame = 4; await get_tree().create_timer(0.04).timeout
	spr.frame = 5; await get_tree().create_timer(0.04).timeout
	spr.frame = 6; await get_tree().create_timer(0.04).timeout
	spr.frame = 7

func _flip_card_closed(card: Control) -> void:
	card.set_meta("is_revealed", false)
	var spr: Sprite2D = card.get_meta("sprite")
	spr.frame = 6; await get_tree().create_timer(0.04).timeout
	spr.frame = 5; await get_tree().create_timer(0.04).timeout
	spr.frame = 4; await get_tree().create_timer(0.04).timeout
	spr.frame = 0

func _play_match_sparkle(card: Control) -> void:
	card.set_meta("is_matched", true)
	var spr: Sprite2D = card.get_meta("sprite")
	spr.frame = 8; await get_tree().create_timer(0.05).timeout
	spr.frame = 9; await get_tree().create_timer(0.05).timeout
	spr.frame = 10; await get_tree().create_timer(0.05).timeout
	spr.frame = 11; await get_tree().create_timer(0.07).timeout
	spr.frame = 7

func _check_match() -> void:
	var id1: int = first_card.get_meta("coin_id")
	var id2: int = second_card.get_meta("coin_id")
	if id1 == id2:
		pairs_found += 1
		_update_ui()
		_play_match_sparkle(first_card)
		_play_match_sparkle(second_card)
		first_card = null; second_card = null; can_flip = true
		if pairs_found >= total_pairs_needed: _on_game_won()
	else:
		await get_tree().create_timer(0.55).timeout
		_flip_card_closed(first_card)
		_flip_card_closed(second_card)
		first_card = null; second_card = null; can_flip = true

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return
	time_remaining -= delta
	if time_remaining <= 0.0:
		time_remaining = 0.0; _on_game_lost("¡Se agotó el tiempo!")
	_update_ui()

func _update_ui() -> void:
	score_label.text = "PAREJAS: %d / %d" % [pairs_found, total_pairs_needed]
	level_label.text = "DIFICULTAD: %d" % current_level
	timer_label.text = "00:%02d" % int(ceil(time_remaining))

func _update_retry_button() -> void:
	if retry_button == null: return
	if retry_cooldown_left > 0:
		retry_button.disabled = true
		var m = int(float(retry_cooldown_left) / 60.0)
		var s = retry_cooldown_left % 60
		retry_button.text = "⏳ Espera %02d:%02d" % [m, s]
	else:
		retry_button.disabled = false
		retry_button.text = "🏁 Volver a Jugar"

func _on_game_won() -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "¡VICTORIA!"
	result_title.add_theme_color_override("font_color", Color(0.3, 1.0, 0.4))
	result_message.text = "Guardando victoria en la central..."

	var payload = {
		"p_game_id": GAME_ID, "p_won": true,
		"p_session_token": current_session_token, "p_score_achieved": pairs_found
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var data = res["data"]
		var reward = float(data.get("reward_kwp", 0.000000001))
		var cd = int(data.get("cooldown_seconds", 5))
		var wins_in_lvl = int(data.get("wins_in_level", 0))
		var leveled_up = bool(data.get("leveled_up", false))
		var new_lvl = int(data.get("current_level", current_level))
		var is_inf = bool(data.get("is_infinite", false))
		
		GameManager.set_cooldown_seconds(GAME_ID, cd)
		GameManager.add_temporary_power(reward)
		retry_cooldown_left = cd
		_update_retry_button()
		
		if is_inf and new_lvl == 4:
			result_message.text = "⚡ ¡NIVEL 4 INFINITO!\n+%.9f KWP ganado.\n(Cooldown entre partidas: 2 min)" % reward
		elif leveled_up:
			result_message.text = "⭐ ¡SUBISTE A NIVEL %d!\n+%.9f KWP ganado." % [new_lvl, reward]
		else:
			result_message.text = "¡Nivel superado!\n+%.9f KWP ganado.\n(Progreso nivel: %d / 6 victorias)" % [reward, wins_in_lvl]
			
		# Recompensas de Materiales y Profesión RPG
		result_message.text += GameManager.process_minigame_rpg_rewards(data)

func _on_game_lost(reason: String) -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "DERROTA"
	result_title.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	result_message.text = reason + "\nNo obtienes recompensa. Vuelve a intentarlo."
	cooldown_label.text = ""
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID, "p_won": false, "p_session_token": current_session_token
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	var cd: int = int(res.get("data", {}).get("cooldown_seconds", 5)) if res.get("success", false) else 5
	GameManager.set_cooldown_seconds(GAME_ID, cd)
	retry_cooldown_left = cd
	_update_retry_button()

func _on_retry_pressed() -> void:
	if retry_cooldown_left > 0: return
	retry_button.disabled = true; retry_button.text = "Iniciando..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": GAME_ID}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		_return_to_hub()
		return
	if res.get("success", false) and res["data"].get("success", false):
		var new_token = str(res["data"].get("session_token", ""))
		var new_lvl = int(res["data"].get("current_level", current_level))
		var new_scene = load("res://features/minigames/crypto_memory/crypto_memory.tscn").instantiate()
		new_scene.set_game_level(new_lvl)
		new_scene.set_session_token(new_token)
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
	else:
		_return_to_hub()

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")

```

---

####### 📄 Archivo: `crypto_memory.gd.uid`

```
uid://c5u1lirswpo0a

```

---

####### 📄 Archivo: `crypto_memory.tscn`

```
[gd_scene format=3 uid="uid://xqo1d53lcqc7"]

[ext_resource type="Script" path="res://features/minigames/crypto_memory/crypto_memory.gd" id="1_cmem"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_board_bg"]
bg_color = Color(0.07, 0.08, 0.12, 0.95)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.2, 0.55, 0.85, 0.9)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(0.15, 0.45, 0.7, 0.35)
shadow_size = 14

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12
shadow_color = Color(1, 0.75, 0, 0.35)
shadow_size = 14

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_cyan_btn"]
bg_color = Color(0.15, 0.75, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.5, 0.9, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="CryptoMemoryGame" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_cmem")

[node name="BackgroundTexture" type="TextureRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
expand_mode = 1
stretch_mode = 6

[node name="PlayArea" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
offset_top = 64.0
grow_horizontal = 2
grow_vertical = 2

[node name="CenterBoard" type="Control" parent="PlayArea"]
custom_minimum_size = Vector2(580, 480)
layout_mode = 2

[node name="BoardPanel" type="PanelContainer" parent="PlayArea/CenterBoard"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_board_bg")

[node name="Margin" type="MarginContainer" parent="PlayArea/CenterBoard/BoardPanel"]
layout_mode = 2
theme_override_constants/margin_left = 18
theme_override_constants/margin_top = 18
theme_override_constants/margin_right = 18
theme_override_constants/margin_bottom = 18

[node name="CardsGrid" type="GridContainer" parent="PlayArea/CenterBoard/BoardPanel/Margin"]
layout_mode = 2
size_flags_horizontal = 4
size_flags_vertical = 4
theme_override_constants/h_separation = 14
theme_override_constants/v_separation = 14
columns = 4

[node name="HUD" type="CanvasLayer" parent="."]

[node name="TopPanel" type="PanelContainer" parent="HUD"]
custom_minimum_size = Vector2(0, 64)
anchors_preset = 10
anchor_right = 1.0
grow_horizontal = 2

[node name="Margin" type="MarginContainer" parent="HUD/TopPanel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="HUD/TopPanel/Margin"]
layout_mode = 2
theme_override_constants/separation = 25

[node name="ScoreBox" type="HBoxContainer" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="ScoreLabel" type="Label" parent="HUD/TopPanel/Margin/HBox/ScoreBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 20
text = "PAREJAS: 0 / 6"

[node name="LevelLabel" type="Label" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.85, 1, 1)
theme_override_font_sizes/font_size = 18
text = "DIFICULTAD: 1"

[node name="Spacer" type="Control" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="TimeBox" type="HBoxContainer" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="TimeIcon" type="Label" parent="HUD/TopPanel/Margin/HBox/TimeBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "⏳"

[node name="TimerLabel" type="Label" parent="HUD/TopPanel/Margin/HBox/TimeBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "00:50"

[node name="ExitButton" type="Button" parent="HUD/TopPanel/Margin/HBox"]
custom_minimum_size = Vector2(100, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "Salir"

[node name="ResultDialog" type="PanelContainer" parent="HUD"]
visible = false
custom_minimum_size = Vector2(420, 240)
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -210.0
offset_top = -120.0
offset_right = 210.0
offset_bottom = 120.0
grow_horizontal = 2
grow_vertical = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="HUD/ResultDialog"]
layout_mode = 2
theme_override_constants/margin_left = 22
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 22
theme_override_constants/margin_bottom = 22

[node name="VBox" type="VBoxContainer" parent="HUD/ResultDialog/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 22
text = "¡VICTORIA!"
horizontal_alignment = 1

[node name="Message" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 13
text = "+0.000000001 KWP obtenido"
horizontal_alignment = 1

[node name="CooldownLabel" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.8, 0.3, 1)
theme_override_font_sizes/font_size = 12
text = "Espera 5s para la siguiente partida"
horizontal_alignment = 1

[node name="ButtonsHBox" type="HBoxContainer" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ActionButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "Continuar"

[node name="RetryButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.04, 0.08, 0.12, 1)
theme_override_styles/normal = SubResource("StyleBoxFlat_cyan_btn")
text = "Volver a Jugar"
```

---

###### 📁 Carpeta: `./features\minigames\flappy_rocket/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `flappy_rocket.gd`

```
# res://features/minigames/flappy_rocket/flappy_rocket.gd
extends Control

const GAME_ID: String = "flappy_rocket"

@export var ship_hframes: int = 4
@export var explosion_hframes: int = 6

@onready var bg_texture: TextureRect = $BackgroundTexture
@onready var pipes_container: Node2D = $PipesContainer
@onready var rocket_area: Area2D = $RocketArea
@onready var rocket_sprite: Sprite2D = $RocketArea/RocketSprite
@onready var rocket_collision: CollisionShape2D = $RocketArea/CollisionShape2D
@onready var explosion_sprite: Sprite2D = $ExplosionSprite
@onready var touch_button: Button = $TouchScreenButton

@onready var score_title: Label = $HUD/TopPanel/Margin/HBox/ScoreBox/ScoreTitle
@onready var level_label: Label = $HUD/TopPanel/Margin/HBox/LevelLabel
@onready var exit_button: Button = $HUD/TopPanel/Margin/HBox/ExitButton

@onready var result_dialog: PanelContainer = $HUD/ResultDialog
@onready var result_title: Label = $HUD/ResultDialog/Margin/VBox/Title
@onready var result_message: Label = $HUD/ResultDialog/Margin/VBox/Message
@onready var cooldown_label: Label = $HUD/ResultDialog/Margin/VBox/CooldownLabel
@onready var action_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/ActionButton
@onready var retry_button: Button = $HUD/ResultDialog/Margin/VBox/ButtonsHBox/RetryButton

const GRAVITY: float = 1000.0
const FLAP_FORCE: float = -350.0

var velocity_y: float = 0.0
var current_level: int = 1
var target_pipes: int = 8
var pipe_speed: float = 210.0
var pipe_gap: float = 230.0
var spawn_interval: float = 2.0

var pipes_passed: int = 0
var game_started: bool = false
var game_over: bool = false
var spawn_timer: float = 0.0
var anim_timer: float = 0.0

var tex_ship: Texture2D
var tex_explosion: Texture2D
var tex_bar: Texture2D
var current_session_token: String = ""

var retry_cooldown_left: int = 0
var retry_tick_accum: float = 0.0

func _ready() -> void:
	touch_button.focus_mode = Control.FOCUS_NONE
	exit_button.pressed.connect(_return_to_hub)
	action_button.pressed.connect(_return_to_hub)
	retry_button.pressed.connect(_on_retry_pressed)
	touch_button.pressed.connect(_flap)
	rocket_area.area_entered.connect(_on_rocket_collision)
	
	_load_assets()
	_apply_level_parameters()
	_setup_collision()
	_update_ui()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE and event.pressed and not event.is_echo()):
		_flap()
		get_viewport().set_input_as_handled()

func _load_assets() -> void:
	var bg_p = "res://assets/sprites/minigames/flappy_rocket/bg.png"
	if ResourceLoader.exists(bg_p): bg_texture.texture = load(bg_p)
		
	var s_p = "res://assets/sprites/minigames/flappy_rocket/ship.png"
	if ResourceLoader.exists(s_p):
		tex_ship = load(s_p)
		rocket_sprite.texture = tex_ship
		rocket_sprite.hframes = max(1, ship_hframes)
		rocket_sprite.frame = 0
		var frame_w: float = float(tex_ship.get_width()) / float(max(1, ship_hframes))
		var final_scale: float = 75.0 / maxf(1.0, frame_w)
		rocket_sprite.scale = Vector2(final_scale, final_scale)
		
	var e_p = "res://assets/sprites/minigames/flappy_rocket/explosion.png"
	if ResourceLoader.exists(e_p):
		tex_explosion = load(e_p)
		explosion_sprite.texture = tex_explosion
		explosion_sprite.hframes = max(1, explosion_hframes)
		var exp_w: float = float(tex_explosion.get_width()) / float(max(1, explosion_hframes))
		var exp_scale: float = 90.0 / maxf(1.0, exp_w)
		explosion_sprite.scale = Vector2(exp_scale, exp_scale)
		
	var b_p = "res://assets/sprites/minigames/flappy_rocket/bar_green.png"
	if ResourceLoader.exists(b_p): tex_bar = load(b_p)

func _setup_collision() -> void:
	var shape := CircleShape2D.new()
	shape.radius = 20.0
	rocket_collision.shape = shape

func set_game_level(lvl: int) -> void: current_level = clamp(lvl, 1, 4)
func set_session_token(token: String) -> void: current_session_token = token

func _apply_level_parameters() -> void:
	match current_level:
		1: target_pipes = 8; pipe_speed = 210.0; pipe_gap = 230.0; spawn_interval = 2.0
		2: target_pipes = 14; pipe_speed = 310.0; pipe_gap = 195.0; spawn_interval = 1.6
		3: target_pipes = 20; pipe_speed = 410.0; pipe_gap = 170.0; spawn_interval = 1.3
		4: target_pipes = 28; pipe_speed = 500.0; pipe_gap = 150.0; spawn_interval = 1.0

func _flap() -> void:
	if game_over: return
	game_started = true
	velocity_y = FLAP_FORCE

func _process(delta: float) -> void:
	if game_over:
		if retry_cooldown_left > 0:
			retry_tick_accum += delta
			if retry_tick_accum >= 1.0:
				retry_tick_accum = 0.0
				retry_cooldown_left -= 1
				_update_retry_button()
		return

	anim_timer += delta
	if anim_timer >= 0.1:
		anim_timer = 0.0
		if rocket_sprite.hframes > 1:
			rocket_sprite.frame = (rocket_sprite.frame + 1) % rocket_sprite.hframes

	if not game_started:
		rocket_area.position.y = 360.0 + sin(Time.get_ticks_msec() * 0.005) * 12.0
		return

	velocity_y += GRAVITY * delta
	rocket_area.position.y += velocity_y * delta
	rocket_area.rotation = clampf(velocity_y * 0.0016, -0.4, 0.6)

	if rocket_area.position.y <= 60.0 or rocket_area.position.y >= 710.0:
		_trigger_crash()
		return

	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		_spawn_pipe_pair()

	for pair in pipes_container.get_children():
		pair.position.x -= pipe_speed * delta
		if not pair.get_meta("passed") and pair.position.x < rocket_area.position.x:
			pair.set_meta("passed", true)
			pipes_passed += 1
			_update_ui()
			if pipes_passed >= target_pipes:
				_on_game_won()
				return
		if pair.position.x < -200.0: pair.queue_free()

func _spawn_pipe_pair() -> void:
	if tex_bar == null: return
	var pair_node := Node2D.new()
	pair_node.position.x = 1350.0
	pair_node.set_meta("passed", false)

	var center_y: float = randf_range(220.0, 500.0)
	var half_gap: float = pipe_gap / 2.0

	var top_pipe = _create_pipe_segment(true)
	top_pipe.position.y = center_y - half_gap
	pair_node.add_child(top_pipe)

	var bottom_pipe = _create_pipe_segment(false)
	bottom_pipe.position.y = center_y + half_gap
	pair_node.add_child(bottom_pipe)
	pipes_container.add_child(pair_node)

func _create_pipe_segment(is_top: bool) -> Area2D:
	var area := Area2D.new()
	var bar_w: float = float(tex_bar.get_width())
	var bar_h: float = float(tex_bar.get_height())
	
	var spr := Sprite2D.new()
	spr.texture = tex_bar
	spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	spr.centered = false
	
	if is_top:
		spr.flip_v = true; spr.modulate = Color(1.0, 0.35, 0.35); spr.position = Vector2(-bar_w / 2.0, -bar_h)
	else:
		spr.modulate = Color(0.4, 1.0, 0.4); spr.position = Vector2(-bar_w / 2.0, 0.0)
	area.add_child(spr)

	var col := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(bar_w * 0.7, bar_h)
	col.shape = rect
	col.position = Vector2(0, -bar_h / 2.0 if is_top else bar_h / 2.0)
	area.add_child(col)
	return area

func _on_rocket_collision(_area: Area2D) -> void: _trigger_crash()

func _trigger_crash() -> void:
	if game_over: return
	game_over = true
	rocket_area.visible = false
	explosion_sprite.position = rocket_area.position
	explosion_sprite.visible = true
	
	for i in range(explosion_hframes):
		explosion_sprite.frame = i
		await get_tree().create_timer(0.07).timeout
		
	explosion_sprite.visible = false
	_on_game_lost("¡Has colisionado!")

func _update_ui() -> void:
	score_title.text = "BARRAS: %d / %d" % [pipes_passed, target_pipes]
	level_label.text = "DIFICULTAD: %d" % current_level

func _update_retry_button() -> void:
	if retry_button == null: return
	if retry_cooldown_left > 0:
		retry_button.disabled = true
		var m = int(float(retry_cooldown_left) / 60.0)
		var s = retry_cooldown_left % 60
		retry_button.text = "⏳ Espera %02d:%02d" % [m, s]
	else:
		retry_button.disabled = false
		retry_button.text = "🏁 Volver a Jugar"

func _on_game_won() -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "¡VICTORIA!"
	result_title.add_theme_color_override("font_color", Color(0.3, 1.0, 0.4))
	result_message.text = "Guardando victoria en la central..."
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID,
		"p_won": true,
		"p_session_token": current_session_token,
		"p_score_achieved": pipes_passed
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var data = res["data"]
		var reward = float(data.get("reward_kwp", 0.000000001))
		var cd = int(data.get("cooldown_seconds", 5))
		var wins_in_lvl = int(data.get("wins_in_level", 0))
		var leveled_up = bool(data.get("leveled_up", false))
		var new_lvl = int(data.get("current_level", current_level))
		var is_inf = bool(data.get("is_infinite", false))
		
		GameManager.set_cooldown_seconds(GAME_ID, cd)
		GameManager.add_temporary_power(reward)
		retry_cooldown_left = cd
		_update_retry_button()
		
		if is_inf and new_lvl == 4:
			result_message.text = "⚡ ¡NIVEL 4 INFINITO!\n+%.9f KWP ganado.\n(Cooldown entre partidas: 2 min)" % reward
		elif leveled_up:
			result_message.text = "⭐ ¡SUBISTE A NIVEL %d!\n+%.9f KWP ganado." % [new_lvl, reward]
		else:
			result_message.text = "¡Nivel superado!\n+%.9f KWP ganado.\n(Progreso nivel: %d / 6 victorias)" % [reward, wins_in_lvl]
			
		# Recompensas de Materiales y Profesión RPG
		result_message.text += GameManager.process_minigame_rpg_rewards(data)

func _on_game_lost(reason: String) -> void:
	game_over = true
	result_dialog.visible = true
	result_title.text = "DERROTA"
	result_title.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	result_message.text = reason + "\nNo obtienes recompensa. Vuelve a intentarlo."
	cooldown_label.text = ""
	retry_button.disabled = true
	retry_button.text = "⏳ Verificando..."

	var payload = {
		"p_game_id": GAME_ID,
		"p_won": false,
		"p_session_token": current_session_token
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/finish_minigame_session", HTTPClient.METHOD_POST, payload, true)
	var cd: int = int(res.get("data", {}).get("cooldown_seconds", 5)) if res.get("success", false) else 5
	GameManager.set_cooldown_seconds(GAME_ID, cd)
	retry_cooldown_left = cd
	_update_retry_button()

func _on_retry_pressed() -> void:
	if retry_cooldown_left > 0: return
	retry_button.disabled = true
	retry_button.text = "Iniciando..."
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": GAME_ID}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		_return_to_hub()
		return
		
	if res.get("success", false) and res["data"].get("success", false):
		var new_token: String = str(res["data"].get("session_token", ""))
		var new_lvl: int = int(res["data"].get("current_level", current_level))
		var new_scene = load("res://features/minigames/flappy_rocket/flappy_rocket.tscn").instantiate()
		new_scene.set_game_level(new_lvl)
		new_scene.set_session_token(new_token)
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
	else:
		_return_to_hub()

func _return_to_hub() -> void:
	get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")

```

---

####### 📄 Archivo: `flappy_rocket.gd.uid`

```
uid://q7rwo1kp3lwm

```

---

####### 📄 Archivo: `flappy_rocket.tscn`

```
[gd_scene format=3 uid="uid://6ob8i83sxkp6"]

[ext_resource type="Script" path="res://features/minigames/flappy_rocket/flappy_rocket.gd" id="1_flappy"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_cyan_btn"]
bg_color = Color(0.15, 0.75, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.5, 0.9, 1, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="FlappyRocketGame" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_flappy")

[node name="BackgroundTexture" type="TextureRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
expand_mode = 1
stretch_mode = 6

[node name="PipesContainer" type="Node2D" parent="."]

[node name="RocketArea" type="Area2D" parent="."]
position = Vector2(280, 360)

[node name="RocketSprite" type="Sprite2D" parent="RocketArea"]
texture_filter = 1
scale = Vector2(2.5, 2.5)

[node name="CollisionShape2D" type="CollisionShape2D" parent="RocketArea"]

[node name="ExplosionSprite" type="Sprite2D" parent="."]
visible = false
texture_filter = 1
scale = Vector2(3, 3)

[node name="TouchScreenButton" type="Button" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_default_cursor_shape = 2
flat = true

[node name="HUD" type="CanvasLayer" parent="."]

[node name="TopPanel" type="PanelContainer" parent="HUD"]
custom_minimum_size = Vector2(0, 64)
anchors_preset = 10
anchor_right = 1.0
grow_horizontal = 2

[node name="Margin" type="MarginContainer" parent="HUD/TopPanel"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="HUD/TopPanel/Margin"]
layout_mode = 2
theme_override_constants/separation = 25

[node name="ScoreBox" type="HBoxContainer" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="ScoreTitle" type="Label" parent="HUD/TopPanel/Margin/HBox/ScoreBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 20
text = "BARRAS: 0 / 10"

[node name="LevelLabel" type="Label" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.85, 1, 1)
theme_override_font_sizes/font_size = 18
text = "DIFICULTAD: 1"

[node name="Spacer" type="Control" parent="HUD/TopPanel/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="ExitButton" type="Button" parent="HUD/TopPanel/Margin/HBox"]
custom_minimum_size = Vector2(100, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "Salir"

[node name="ResultDialog" type="PanelContainer" parent="HUD"]
visible = false
custom_minimum_size = Vector2(420, 240)
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -210.0
offset_top = -120.0
offset_right = 210.0
offset_bottom = 120.0
grow_horizontal = 2
grow_vertical = 2

[node name="Margin" type="MarginContainer" parent="HUD/ResultDialog"]
layout_mode = 2
theme_override_constants/margin_left = 22
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 22
theme_override_constants/margin_bottom = 22

[node name="VBox" type="VBoxContainer" parent="HUD/ResultDialog/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 22
text = "¡VICTORIA!"
horizontal_alignment = 1

[node name="Message" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_font_sizes/font_size = 13
text = "+0.000000001 KWP ganado."
horizontal_alignment = 1

[node name="CooldownLabel" type="Label" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.8, 0.3, 1)
theme_override_font_sizes/font_size = 12
text = "Cooldown de 5s."
horizontal_alignment = 1

[node name="ButtonsHBox" type="HBoxContainer" parent="HUD/ResultDialog/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ActionButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
text = "Continuar"

[node name="RetryButton" type="Button" parent="HUD/ResultDialog/Margin/VBox/ButtonsHBox"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
size_flags_horizontal = 3
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.04, 0.08, 0.12, 1)
theme_override_styles/normal = SubResource("StyleBoxFlat_cyan_btn")
text = "Volver a Jugar"
```

---

###### 📁 Carpeta: `./features\minigames\_shared/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `fuse_puzzle.gd`

```
# res://features/minigames/_shared/fuse_puzzle.gd
extends Control

signal puzzle_completed(success: bool)

@onready var svg_texture_rect: TextureRect = $Panel/Margin/VBox/SvgTextureRect
@onready var timer_label: Label = $Panel/Margin/VBox/TimerLabel
@onready var wire_blue: Button = $Panel/Margin/VBox/WiresContainer/WireBlue
@onready var wire_red: Button = $Panel/Margin/VBox/WiresContainer/WireRed
@onready var wire_yellow: Button = $Panel/Margin/VBox/WiresContainer/WireYellow

var current_challenge_id: String = ""
var time_left: float = 10.0
var is_active: bool = false

func _ready() -> void:
	wire_blue.pressed.connect(func(): _choose_wire(0))
	wire_red.pressed.connect(func(): _choose_wire(1))
	wire_yellow.pressed.connect(func(): _choose_wire(2))

func _process(delta: float) -> void:
	if not is_active: return
	time_left -= delta
	timer_label.text = "⏳ Tiempo restante: %ds" % max(0, int(ceil(time_left)))
	if time_left <= 0.0:
		is_active = false
		_fail_puzzle("Tiempo agotado.")

func open_challenge() -> void:
	visible = true
	is_active = false
	timer_label.text = "Conectando con el circuito..."
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/request_bot_challenge", HTTPClient.METHOD_POST, {}, true)
	if not res.get("success", false) or not res.get("data", {}).get("success", false):
		puzzle_completed.emit(false)
		visible = false
		return
		
	var data = res["data"]
	current_challenge_id = str(data.get("challenge_id", ""))
	var raw_svg: String = str(data.get("svg_data", ""))
	time_left = float(data.get("expires_in_seconds", 10))
	
	var img := Image.new()
	var err := img.load_svg_from_string(raw_svg)
	if err == OK:
		svg_texture_rect.texture = ImageTexture.create_from_image(img)
		
	is_active = true

func _choose_wire(wire_index: int) -> void:
	if not is_active: return
	is_active = false
	
	wire_blue.disabled = true
	wire_red.disabled = true
	wire_yellow.disabled = true
	
	var body = {
		"p_challenge_id": current_challenge_id,
		"p_selected_wire": wire_index
	}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/verify_bot_challenge", HTTPClient.METHOD_POST, body, true)
	
	wire_blue.disabled = false
	wire_red.disabled = false
	wire_yellow.disabled = false
	visible = false
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false) == true:
		puzzle_completed.emit(true)
	else:
		puzzle_completed.emit(false)

func _fail_puzzle(_reason: String) -> void:
	visible = false
	puzzle_completed.emit(false)
```

---

####### 📄 Archivo: `fuse_puzzle.gd.uid`

```
uid://d3dgf5iatvky0

```

---

####### 📄 Archivo: `fuse_puzzle.tscn`

```
[gd_scene format=3 uid="uid://f1uisj7ukemi"]

[ext_resource type="Script" path="res://features/minigames/_shared/fuse_puzzle.gd" id="1_fuse"]

[node name="FusePuzzle" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_fuse")

[node name="Overlay" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.03, 0.04, 0.06, 0.9)

[node name="Panel" type="PanelContainer" parent="."]
custom_minimum_size = Vector2(420, 310)
layout_mode = 1
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -210.0
offset_top = -155.0
offset_right = 210.0
offset_bottom = 155.0
grow_horizontal = 2
grow_vertical = 2

[node name="Margin" type="MarginContainer" parent="Panel"]
layout_mode = 2
theme_override_constants/margin_left = 18
theme_override_constants/margin_top = 16
theme_override_constants/margin_right = 18
theme_override_constants/margin_bottom = 16

[node name="VBox" type="VBoxContainer" parent="Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.3, 1)
theme_override_font_sizes/font_size = 15
text = "⚠️ SOBRECARGA EN LA CAJA DE FUSIBLES"
horizontal_alignment = 1

[node name="Subtitle" type="Label" parent="Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.75, 0.8, 0.9, 1)
theme_override_font_sizes/font_size = 12
text = "Corta el cable del mismo color que el núcleo de energía:"
horizontal_alignment = 1

[node name="SvgTextureRect" type="TextureRect" parent="Panel/Margin/VBox"]
custom_minimum_size = Vector2(340, 75)
layout_mode = 2
size_flags_horizontal = 4
expand_mode = 1
stretch_mode = 5

[node name="TimerLabel" type="Label" parent="Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.4, 0.4, 1)
theme_override_font_sizes/font_size = 12
text = "⏳ Tiempo restante: 10s"
horizontal_alignment = 1

[node name="WiresContainer" type="HBoxContainer" parent="Panel/Margin/VBox"]
layout_mode = 2
size_flags_vertical = 3
theme_override_constants/separation = 12
alignment = 1

[node name="WireBlue" type="Button" parent="Panel/Margin/VBox/WiresContainer"]
custom_minimum_size = Vector2(105, 48)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0, 0.9, 1, 1)
text = "⚡ CABLE AZUL"

[node name="WireRed" type="Button" parent="Panel/Margin/VBox/WiresContainer"]
custom_minimum_size = Vector2(105, 48)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(1, 0.3, 0.3, 1)
text = "⚡ CABLE ROJO"

[node name="WireYellow" type="Button" parent="Panel/Margin/VBox/WiresContainer"]
custom_minimum_size = Vector2(105, 48)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(1, 0.9, 0.2, 1)
text = "⚡ CABLE AMARILLO"
```

---

####### 📄 Archivo: `minigames_hub.gd`

```
# res://features/minigames/_shared/minigames_hub.gd
extends Control

const FUSE_PUZZLE_SCENE = preload("res://features/minigames/_shared/fuse_puzzle.tscn")
const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")

@onready var back_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/BackButton
@onready var power_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/PowerPill/Margin/HBox/PowerLabel
@onready var watt_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilowat_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_label: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel
@onready var games_grid: GridContainer = $CanvasLayerUI/MainVBox/ContentScroll/Margin/GamesGrid

var game_buttons: Dictionary = {}
var game_levels: Dictionary = {"coinclick": 1, "flappy_rocket": 1, "coin_match": 1, "crypto_memory": 1}
var game_level_progress: Dictionary = {"coinclick": 0, "flappy_rocket": 0, "coin_match": 0, "crypto_memory": 0}
var game_is_infinite: Dictionary = {"coinclick": false, "flappy_rocket": false, "coin_match": false, "crypto_memory": false}
var game_reset_seconds: Dictionary = {"coinclick": 86400, "flappy_rocket": 86400, "coin_match": 86400, "crypto_memory": 86400}

var game_reset_labels: Dictionary = {}
var game_diff_bars: Dictionary = {}
var game_diff_labels: Dictionary = {}

var is_captcha_locked: bool = false
var active_puzzle = null
var second_timer: float = 0.0

func _ready() -> void:
	if chip_label == null: chip_label = find_child("ChipLabel", true, false)
	back_button.pressed.connect(_on_back_pressed)
	_update_hud()
	_load_user_games_data()

func _process(delta: float) -> void:
	_update_cooldown_buttons()
	_update_hud()
	
	second_timer += delta
	if second_timer >= 1.0:
		second_timer = 0.0
		_tick_difficulty_resets()

func _tick_difficulty_resets() -> void:
	for gid in game_reset_seconds.keys():
		var rem: int = game_reset_seconds[gid]
		if rem > 0:
			rem -= 1
			game_reset_seconds[gid] = rem
			
			var h: int = int(float(rem) / 3600.0)
			var m: int = int(float(rem % 3600) / 60.0)
			var s: int = rem % 60
			
			if game_reset_labels.has(gid) and is_instance_valid(game_reset_labels[gid]):
				game_reset_labels[gid].text = "🔄 Reinicio (24h): %02d:%02d:%02d" % [h, m, s]
				
			if rem <= 0:
				game_levels[gid] = 1
				game_level_progress[gid] = 0
				game_is_infinite[gid] = false
				game_reset_seconds[gid] = 86400
				if game_diff_bars.has(gid) and is_instance_valid(game_diff_bars[gid]):
					game_diff_bars[gid].value = 1
				if game_diff_labels.has(gid) and is_instance_valid(game_diff_labels[gid]):
					game_diff_labels[gid].text = "⚡ Dificultad: 1 / 4 (0/6 victorias)"

func _update_hud() -> void:
	if power_label and is_instance_valid(power_label):
		power_label.text = "%.9f KWP" % GameManager.total_kwp
	if watt_label and is_instance_valid(watt_label):
		watt_label.text = "%.4f" % GameManager.watt
	if kilowat_label and is_instance_valid(kilowat_label):
		kilowat_label.text = "%.6f" % GameManager.kilowat
	if chip_label and is_instance_valid(chip_label):
		chip_label.text = "%.0f" % GameManager.casino_tokens
		
	# Actualizar el título con el rango del jugador
	var chat_lvl: int = GameManager.get_profession_level("chatarrero")
	var title_node = find_child("Title", true, false)
	if title_node and is_instance_valid(title_node):
		title_node.text = "⚡ CENTRAL DE MINIJUEGOS  |  🛠️ Chatarrero Nv. %d / 25" % chat_lvl

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://features/room/main_room.tscn")

func _load_user_games_data() -> void:
	var uid = SupabaseClient.current_user_id
	if uid != "":
		for gid in ["coinclick", "flappy_rocket", "coin_match", "crypto_memory"]:
			var res = await SupabaseClient.send_request("/rest/v1/rpc/get_minigame_status", HTTPClient.METHOD_POST, {"p_game_id": gid}, true)
			if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
				var data = res["data"]
				game_levels[gid] = int(data.get("current_level", 1))
				game_level_progress[gid] = int(data.get("wins_in_level", 0))
				game_is_infinite[gid] = bool(data.get("is_infinite", false))
				var rem_sec = int(data.get("remaining_seconds", 0))
				game_reset_seconds[gid] = int(data.get("difficulty_reset_in", 86400))
				
				if bool(data.get("requires_captcha", false)):
					is_captcha_locked = true
					
				var local_rem = GameManager.get_remaining_cooldown_seconds(gid)
				if rem_sec > local_rem:
					GameManager.set_cooldown_seconds(gid, rem_sec)

	_build_games_grid()

func _load_thumb_texture(game_id: String) -> Texture2D:
	var paths = [
		"res://assets/sprites/minigames/" + game_id + "/thumb.webp",
		"res://assets/sprites/minigames/" + game_id + "/thumb.jpg",
		"res://assets/sprites/minigames/" + game_id + "/thumb.png"
	]
	for p in paths:
		if ResourceLoader.exists(p):
			var r = load(p)
			if r is Texture2D: return r
	return WATT_ICON

func _update_cooldown_buttons() -> void:
	for gid in game_buttons.keys():
		var btn: Button = game_buttons[gid]
		if btn == null or not is_instance_valid(btn): continue
		
		var rem: int = GameManager.get_remaining_cooldown_seconds(gid)
		if rem > 0:
			btn.disabled = true
			var m = int(float(rem) / 60.0)
			var s = rem % 60
			btn.text = "⏳ Espera %02d:%02d" % [m, s]
			var st_cd := StyleBoxFlat.new()
			st_cd.bg_color = Color(0.12, 0.14, 0.18, 0.95)
			st_cd.border_color = Color(0.25, 0.3, 0.4)
			st_cd.set_border_width_all(1)
			st_cd.set_corner_radius_all(6)
			btn.add_theme_stylebox_override("disabled", st_cd)
			btn.add_theme_color_override("font_disabled_color", Color(1.0, 0.85, 0.3))
		elif is_captcha_locked:
			btn.disabled = false
			btn.text = "⚠️ VERIFICAR"
			var st_warn := StyleBoxFlat.new()
			st_warn.bg_color = Color(0.35, 0.2, 0.05, 1.0)
			st_warn.border_color = Color(1.0, 0.7, 0.1)
			st_warn.set_border_width_all(2)
			st_warn.set_corner_radius_all(6)
			btn.add_theme_stylebox_override("normal", st_warn)
			btn.add_theme_color_override("font_color", Color(1.0, 0.9, 0.4))
		else:
			btn.disabled = false
			btn.text = "⚡ JUGAR AHORA"
			var st_act := StyleBoxFlat.new()
			st_act.bg_color = Color(0.15, 0.75, 0.45, 1.0)
			st_act.border_color = Color(0.4, 1.0, 0.6)
			st_act.set_border_width_all(2)
			st_act.set_corner_radius_all(6)
			btn.add_theme_stylebox_override("normal", st_act)
			btn.add_theme_stylebox_override("hover", st_act)
			btn.add_theme_color_override("font_color", Color(0.04, 0.12, 0.04))

func _build_games_grid() -> void:
	for child in games_grid.get_children(): child.queue_free()
	game_buttons.clear()
	game_reset_labels.clear()
	game_diff_bars.clear()
	game_diff_labels.clear()

	var catalog = [
		{
			"id": "coinclick", 
			"title": "CoinClick", 
			"badge": "🔥 ESCALA KWP", 
			"color": Color(1.0, 0.75, 0.15), 
			"desc": "Atrapa monedas del mago. 6 victorias por nivel para subir. Gana hasta +0.000000014 KWP. Modo infinito en Nv 4 (2m cooldown)."
		},
		{
			"id": "flappy_rocket", 
			"title": "Flappy Rocket", 
			"badge": "⭐ ESCALA KWP", 
			"color": Color(0.25, 0.95, 0.5), 
			"desc": "Esquiva barreras eléctricas. 6 carreras por nivel. Escala de 1 a 14 nano-KWP. Descenso a las 20h y reinicio a las 24h."
		},
		{
			"id": "coin_match", 
			"title": "Coin Match", 
			"badge": "🧩 PUZZLE", 
			"color": Color(0.85, 0.35, 1.0), 
			"desc": "Combina criptomonedas. 6 victorias por nivel. Recompensas crecientes por rango (+1, +4, +8 y +14 nano-KWP)."
		},
		{
			"id": "crypto_memory", 
			"title": "Crypto Memory", 
			"badge": "⚡ MEMORIA", 
			"color": Color(0.35, 0.85, 1.0), 
			"desc": "Encuentra las parejas de cartas. 4 niveles de dificultad (6 victorias c/u). Modo infinito con 2 min de cooldown al completar Nv 4."
		}
	]

	for g in catalog:
		var gid = str(g["id"])
		var border_c: Color = g["color"]
		
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(275, 440)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		var card_st := StyleBoxFlat.new()
		card_st.bg_color = Color(0.08, 0.10, 0.14, 0.95)
		card_st.border_color = border_c
		card_st.set_border_width_all(2)
		card_st.set_corner_radius_all(10)
		card_st.shadow_color = Color(border_c.r, border_c.g, border_c.b, 0.25)
		card_st.shadow_size = 8
		card.add_theme_stylebox_override("panel", card_st)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 14)
		margin.add_theme_constant_override("margin_top", 12)
		margin.add_theme_constant_override("margin_right", 14)
		margin.add_theme_constant_override("margin_bottom", 14)
		card.add_child(margin)
		
		var vbox := VBoxContainer.new()
		vbox.add_theme_constant_override("separation", 8)
		margin.add_child(vbox)
		
		# Cabecera
		var top_row := HBoxContainer.new()
		var badge_lbl := Label.new()
		badge_lbl.text = " " + str(g["badge"]) + " "
		badge_lbl.add_theme_font_size_override("font_size", 10)
		badge_lbl.add_theme_color_override("font_color", border_c)
		
		var badge_pill := PanelContainer.new()
		var b_st := StyleBoxFlat.new()
		b_st.bg_color = Color(0.12, 0.15, 0.22, 0.8)
		b_st.border_color = border_c
		b_st.set_border_width_all(1)
		b_st.set_corner_radius_all(4)
		badge_pill.add_theme_stylebox_override("panel", b_st)
		badge_pill.add_child(badge_lbl)
		top_row.add_child(badge_pill)
		
		var title_lbl := Label.new()
		title_lbl.text = " " + str(g["title"])
		title_lbl.add_theme_font_size_override("font_size", 16)
		title_lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0))
		top_row.add_child(title_lbl)
		vbox.add_child(top_row)
		
		# Miniatura
		var thumb_panel := PanelContainer.new()
		thumb_panel.custom_minimum_size = Vector2(0, 135)
		thumb_panel.clip_contents = true
		var tp_st := StyleBoxFlat.new()
		tp_st.bg_color = Color(0.04, 0.05, 0.07, 0.9)
		tp_st.border_color = Color(0.18, 0.25, 0.35, 0.6)
		tp_st.set_border_width_all(1)
		tp_st.set_corner_radius_all(8)
		thumb_panel.add_theme_stylebox_override("panel", tp_st)
		
		var thumb_rect := TextureRect.new()
		thumb_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		thumb_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumb_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		thumb_rect.texture = _load_thumb_texture(gid)
		thumb_panel.add_child(thumb_rect)
		vbox.add_child(thumb_panel)
		
		# Descripción
		var desc_lbl := Label.new()
		desc_lbl.text = str(g["desc"])
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.75, 0.8, 0.88, 0.85))
		desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		desc_lbl.custom_minimum_size = Vector2(0, 36)
		vbox.add_child(desc_lbl)
		
		# Dificultad (1 a 4 con 6 victorias)
		var diff_box := VBoxContainer.new()
		diff_box.add_theme_constant_override("separation", 4)
		
		var lvl_val: int = game_levels.get(gid, 1)
		var progress_val: int = game_level_progress.get(gid, 0)
		var is_inf: bool = game_is_infinite.get(gid, false)
		
		var diff_lbl := Label.new()
		if is_inf and lvl_val == 4:
			diff_lbl.text = "⚡ Nivel 4: MODO INFINITO (2m cd)"
			diff_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		elif is_inf and lvl_val == 3:
			diff_lbl.text = "⏳ Nivel 3: MODO DESCANSO (2m cd)"
			diff_lbl.add_theme_color_override("font_color", Color(1.0, 0.5, 0.3))
		else:
			diff_lbl.text = "⚡ Dificultad: %d / 4 (%d/6 victorias)" % [lvl_val, progress_val]
			diff_lbl.add_theme_color_override("font_color", Color(0.35, 0.85, 1.0))
			
		diff_lbl.add_theme_font_size_override("font_size", 11)
		diff_box.add_child(diff_lbl)
		game_diff_labels[gid] = diff_lbl
		
		var diff_bar := ProgressBar.new()
		diff_bar.custom_minimum_size = Vector2(0, 6)
		diff_bar.max_value = 4
		diff_bar.value = lvl_val
		diff_bar.show_percentage = false
		diff_box.add_child(diff_bar)
		game_diff_bars[gid] = diff_bar
		vbox.add_child(diff_box)
		
		# Reloj de reinicio de 24h
		var reset_lbl := Label.new()
		var rem_t: int = game_reset_seconds.get(gid, 86400)
		var h = int(float(rem_t) / 3600.0)
		var m = int(float(rem_t % 3600) / 60.0)
		var s = rem_t % 60
		reset_lbl.text = "🔄 Reinicio (24h): %02d:%02d:%02d" % [h, m, s]
		reset_lbl.add_theme_color_override("font_color", Color(0.65, 0.7, 0.8, 0.8))
		reset_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(reset_lbl)
		game_reset_labels[gid] = reset_lbl
		
		vbox.add_spacer(false)
		
		# Botón JUGAR
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(0, 42)
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.text = "⚡ JUGAR AHORA"
		btn.add_theme_font_size_override("font_size", 13)
		btn.pressed.connect(func(): _start_game_flow(gid))
		vbox.add_child(btn)
		
		game_buttons[gid] = btn
		games_grid.add_child(card)

func _start_game_flow(game_id: String) -> void:
	if GameManager.get_remaining_cooldown_seconds(game_id) > 0: return
	if is_captcha_locked:
		_trigger_human_verification(game_id)
		return
		
	var btn: Button = game_buttons.get(game_id)
	if btn: btn.disabled = true
	
	var res = await SupabaseClient.send_request("/rest/v1/rpc/start_minigame_session", HTTPClient.METHOD_POST, {"p_game_id": game_id}, true)
	if res.get("success", false) and res["data"].get("requires_captcha", false):
		is_captcha_locked = true
		_trigger_human_verification(game_id)
		return
		
	if not res.get("success", false) or not res["data"].get("success", false):
		var rem_sec = int(res["data"].get("remaining_seconds", 5))
		GameManager.set_cooldown_seconds(game_id, rem_sec)
		return
		
	var token: String = str(res["data"].get("session_token", ""))
	var lvl: int = int(res["data"].get("current_level", game_levels.get(game_id, 1)))
	game_levels[game_id] = lvl
	
	var scene_path = ""
	match game_id:
		"coinclick": scene_path = "res://features/minigames/coin_click/coin_click.tscn"
		"flappy_rocket": scene_path = "res://features/minigames/flappy_rocket/flappy_rocket.tscn"
		"coin_match": scene_path = "res://features/minigames/coin_match/coin_match.tscn"
		"crypto_memory": scene_path = "res://features/minigames/crypto_memory/crypto_memory.tscn"
		
	var game_scene = load(scene_path).instantiate()
	game_scene.set_game_level(lvl)
	game_scene.set_session_token(token)
	get_tree().root.add_child(game_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = game_scene

func _trigger_human_verification(target_game_id: String) -> void:
	if active_puzzle == null:
		active_puzzle = FUSE_PUZZLE_SCENE.instantiate()
		$CanvasLayerUI.add_child(active_puzzle)
		active_puzzle.puzzle_completed.connect(func(success: bool):
			if success:
				is_captcha_locked = false
				_start_game_flow(target_game_id)
			else:
				is_captcha_locked = true
				GameManager.set_cooldown_seconds(target_game_id, 60)
		)
	active_puzzle.open_challenge()

```

---

####### 📄 Archivo: `minigames_hub.gd.uid`

```
uid://ckvhay6ois21e

```

---

####### 📄 Archivo: `minigames_hub.tscn`

```
[gd_scene format=3 uid="uid://disu5on1ee7jx"]

[ext_resource type="Script" path="res://features/minigames/_shared/minigames_hub.gd" id="1_mhub"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_watt.png" id="2_watt"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_kilowat.png" id="3_kilo"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_chip.png" id="4_chip"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill"]
bg_color = Color(0.1, 0.13, 0.18, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.35, 0.55, 0.7)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[node name="MinigamesHub" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_mhub")

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="CanvasLayerUI" type="CanvasLayer" parent="."]

[node name="MainVBox" type="VBoxContainer" parent="CanvasLayerUI"]
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 0

[node name="TopBar" type="PanelContainer" parent="CanvasLayerUI/MainVBox"]
custom_minimum_size = Vector2(0, 68)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="BackButton" type="Button" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "← Volver al Cuarto"

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
text = "⚡ CENTRAL DE MINIJUEGOS"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="StatsBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="PowerPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(180, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/PowerPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/PowerPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 6
alignment = 1

[node name="Icon" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/PowerPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
text = "⚡"

[node name="PowerLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/PowerPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 13
text = "0.000000000 KWP"

[node name="WattPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 13
text = "0.0000"

[node name="KiloPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(150, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("3_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "0.000000"

[node name="ChipPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(130, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("4_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 13
text = "0"

[node name="ContentScroll" type="ScrollContainer" parent="CanvasLayerUI/MainVBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/ContentScroll"]
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 3
theme_override_constants/margin_left = 28
theme_override_constants/margin_top = 24
theme_override_constants/margin_right = 28
theme_override_constants/margin_bottom = 28

[node name="GamesGrid" type="GridContainer" parent="CanvasLayerUI/MainVBox/ContentScroll/Margin"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/h_separation = 20
theme_override_constants/v_separation = 20
columns = 4
```

---

##### 📁 Carpeta: `./features\progression/`

###### 📁 Carpeta: `./features\progression\battle_pass/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `battle_pass_screen.gd`

```
# res://features/progression/battle_pass/battle_pass_screen.gd
extends Control

const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")
const CHIP_ICON: Texture2D = preload("res://assets/sprites/ui/icon_chip.png")

# Cabecera y Recursos
@onready var close_button: Button = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/CloseButton
@onready var watt_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilo_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_lbl: Label = $CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel

# Barra de Nivel y Botón Premium
@onready var level_label: Label = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/LevelPill/Margin/HBox/LevelLabel
@onready var xp_progress_bar: ProgressBar = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/XPBox/XPProgressBar
@onready var xp_text_label: Label = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/XPBox/XPTextLabel
@onready var buy_premium_button: Button = $CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/BuyPremiumButton

# Pestañas
@onready var pass_tab_button: Button = $CanvasLayerUI/MainVBox/TabsBar/Margin/TabsHBox/PassTabButton
@onready var quests_tab_button: Button = $CanvasLayerUI/MainVBox/TabsBar/Margin/TabsHBox/QuestsTabButton
@onready var tracks_scroll: ScrollContainer = $CanvasLayerUI/MainVBox/TracksScroll
@onready var quests_scroll: ScrollContainer = $CanvasLayerUI/MainVBox/QuestsScroll
@onready var tracks_container: HBoxContainer = $CanvasLayerUI/MainVBox/TracksScroll/TracksContainer
@onready var quests_list: VBoxContainer = $CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper/QuestsList
@onready var reset_timer_label: Label = $CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper/ResetHeader/ResetTimerLabel

# Modal de Vista Previa Grande
@onready var reward_preview_modal: Control = $CanvasLayerUI/RewardPreviewModal
@onready var close_preview_btn: Button = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header/ClosePreviewBtn
@onready var preview_title: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header/PreviewTitle
@onready var bg_preview_box: VBoxContainer = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/BgPreviewBox
@onready var bg_large_image: TextureRect = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/BgPreviewBox/BgLargeImage
@onready var gen_preview_box: HBoxContainer = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox
@onready var gen_image: TextureRect = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenImage
@onready var gen_rarity: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenRarity
@onready var gen_name: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenName
@onready var gen_power: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenPower
@onready var gen_income: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenIncome
@onready var gen_desc: Label = $CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails/GenDesc

var is_premium: bool = false
var current_level: int = 1
var current_xp: int = 0
var xp_needed: int = 500
var clock_timer: float = 0.0

var claimed_free_levels: Array = []
var claimed_premium_levels: Array = []

# Cerrojos para evitar llamadas concurrentes en PC
var is_loading_pass_data: bool = false
var is_loading_quests: bool = false

func _ready() -> void:
	visible = false
	$CanvasLayerUI.visible = true
	if watt_lbl == null: watt_lbl = find_child("WattLabel", true, false)
	if kilo_lbl == null: kilo_lbl = find_child("KiloLabel", true, false)
	if chip_lbl == null: chip_lbl = find_child("ChipLabel", true, false)
	
	close_button.pressed.connect(func(): visible = false)
	if close_preview_btn: close_preview_btn.pressed.connect(func(): reward_preview_modal.visible = false)
	buy_premium_button.pressed.connect(_on_buy_premium_pressed)
	
	pass_tab_button.pressed.connect(_show_tracks)
	quests_tab_button.pressed.connect(_show_quests)
	
	# Soporte para la rueda del ratón en PC sobre la lista horizontal de niveles
	if tracks_scroll:
		tracks_scroll.gui_input.connect(_on_tracks_scroll_gui_input)
	
	_update_hud()
	_show_tracks()
	_load_battle_pass_data()

func _process(delta: float) -> void:
	_update_hud()
	clock_timer += delta
	if clock_timer >= 1.0:
		clock_timer = 0.0
		_update_reset_countdown()

func _input(event: InputEvent) -> void:
	if not visible: return
	# Tecla ESC en PC cierra el modal activo o la ventana del pase
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_ESCAPE:
			if reward_preview_modal and reward_preview_modal.visible:
				reward_preview_modal.visible = false
				get_viewport().set_input_as_handled()
			else:
				visible = false
				get_viewport().set_input_as_handled()

func _on_tracks_scroll_gui_input(event: InputEvent) -> void:
	# En PC, deslizar los 20 niveles horizontalmente con la rueda del ratón
	if event is InputEventMouseButton and tracks_scroll:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			tracks_scroll.scroll_horizontal = maxi(0, tracks_scroll.scroll_horizontal - 90)
			get_viewport().set_input_as_handled()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			tracks_scroll.scroll_horizontal += 90
			get_viewport().set_input_as_handled()

func _update_hud() -> void:
	if watt_lbl and is_instance_valid(watt_lbl):
		watt_lbl.text = "%.4f" % GameManager.watt
	if kilo_lbl and is_instance_valid(kilo_lbl):
		kilo_lbl.text = "%.6f" % GameManager.kilowat
	if chip_lbl and is_instance_valid(chip_lbl):
		chip_lbl.text = "%.0f" % GameManager.casino_tokens

func _update_reset_countdown() -> void:
	var now_utc: Dictionary = Time.get_datetime_dict_from_system(true)
	var seconds_passed_today: int = (now_utc.hour * 3600) + (now_utc.minute * 60) + now_utc.second
	var seconds_until_midnight: int = 86400 - seconds_passed_today
	var h: int = int(float(seconds_until_midnight) / 3600.0)
	var m: int = int(float(seconds_until_midnight % 3600) / 60.0)
	var s: int = seconds_until_midnight % 60
	if reset_timer_label and is_instance_valid(reset_timer_label):
		reset_timer_label.text = "⏳ Reinicio de misiones en: %02d:%02d:%02d" % [h, m, s]

func _show_tracks() -> void:
	tracks_scroll.visible = true
	quests_scroll.visible = false
	_switch_tab_visual(pass_tab_button, quests_tab_button)

func _show_quests() -> void:
	tracks_scroll.visible = false
	quests_scroll.visible = true
	_switch_tab_visual(quests_tab_button, pass_tab_button)
	_build_quests_ui()

func _switch_tab_visual(active_btn: Button, inactive_btn: Button) -> void:
	active_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	inactive_btn.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))

func _on_buy_premium_pressed() -> void:
	if is_premium: return
	if GameManager.kilowat < 2.0:
		visible = false
		if ResourceLoader.exists("res://features/economy/shop/shop_screen.tscn"):
			get_tree().change_scene_to_file("res://features/economy/shop/shop_screen.tscn")
		return
		
	buy_premium_button.disabled = true
	var res: Dictionary = await GameManager.buy_shop_item_secure("premium_pass_s1", "pass", 2.0, "kilowat")
	if res.get("success", false):
		is_premium = true
		_update_ui()
		_load_battle_pass_data()
	else:
		buy_premium_button.disabled = false

func _load_battle_pass_data() -> void:
	if is_loading_pass_data: return
	is_loading_pass_data = true
	
	var uid = SupabaseClient.current_user_id
	if uid == "": 
		is_loading_pass_data = false
		return
		
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_or_create_battle_pass", HTTPClient.METHOD_POST, {}, true)
	is_loading_pass_data = false
	
	if res.get("success", false) and typeof(res["data"]) == TYPE_DICTIONARY and res["data"].get("success", false):
		var bp = res["data"]
		current_level = int(bp.get("current_level", 1))
		current_xp = int(bp.get("current_xp", 0))
		xp_needed = int(bp.get("xp_to_next_level", 500))
		is_premium = bool(bp.get("is_premium", false))
		claimed_free_levels = _parse_claimed(bp.get("claimed_free_levels", []))
		claimed_premium_levels = _parse_claimed(bp.get("claimed_premium_levels", []))
		_update_ui()
		_build_tracks_ui()
		if quests_scroll.visible:
			_build_quests_ui()

func _update_ui() -> void:
	level_label.text = "NIVEL %d / 20" % current_level
	xp_progress_bar.max_value = xp_needed
	xp_progress_bar.value = current_xp
	var pct: int = int((float(current_xp) / float(max(1, xp_needed))) * 100.0)
	xp_text_label.text = "%d / %d XP (%d%%)" % [current_xp, xp_needed, pct]
	
	if is_premium:
		buy_premium_button.text = "✓ PREMIUM ACTIVO"
		buy_premium_button.disabled = true
		buy_premium_button.add_theme_color_override("font_color", Color(0.4, 1.0, 0.4))
	else:
		buy_premium_button.text = "⚡ ACTIVAR PREMIUM (2 KILOWAT)"
		buy_premium_button.disabled = false
		buy_premium_button.add_theme_color_override("font_color", Color(0.08, 0.06, 0.01))

# ====================================================================
# CONSTRUCCIÓN DE LAS 20 COLUMNAS DE NIVELES (FREE & PREMIUM)
# ====================================================================

func _build_tracks_ui() -> void:
	for child in tracks_container.get_children(): child.queue_free()
	
	for lvl in range(1, 21):
		var col := VBoxContainer.new()
		col.custom_minimum_size = Vector2(140, 360)
		col.add_theme_constant_override("separation", 8)
		
		# 1. PISTA PREMIUM (Arriba)
		var prem_card := PanelContainer.new()
		prem_card.custom_minimum_size = Vector2(140, 150)
		var p_st := StyleBoxFlat.new()
		p_st.bg_color = Color(0.12, 0.10, 0.07, 0.95)
		p_st.border_color = Color(1.0, 0.82, 0.15, 1.0)
		p_st.set_border_width_all(1)
		p_st.set_corner_radius_all(8)
		prem_card.add_theme_stylebox_override("panel", p_st)
		
		var pvbox := VBoxContainer.new()
		pvbox.alignment = BoxContainer.ALIGNMENT_BEGIN
		pvbox.add_theme_constant_override("separation", 4)
		var pm := MarginContainer.new()
		pm.add_theme_constant_override("margin_left", 8); pm.add_theme_constant_override("margin_right", 8)
		pm.add_theme_constant_override("margin_top", 6); pm.add_theme_constant_override("margin_bottom", 8)
		pm.add_child(pvbox)
		prem_card.add_child(pm)
		
		var prem_tag := Label.new()
		prem_tag.text = "★ PREMIUM"
		prem_tag.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		prem_tag.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		prem_tag.add_theme_font_size_override("font_size", 9)
		pvbox.add_child(prem_tag)
		
		var is_prem_claimed = (lvl in claimed_premium_levels) or (str(lvl) in claimed_premium_levels)
		var can_claim_prem = is_premium and (lvl <= current_level) and (not is_prem_claimed)
		_populate_reward_box(pvbox, _get_premium_reward_info(lvl), not is_premium, lvl, true, is_prem_claimed, can_claim_prem)
		col.add_child(prem_card)
		
		# 2. INSIGNIA CENTRAL DE NIVEL
		var lvl_pill := PanelContainer.new()
		lvl_pill.custom_minimum_size = Vector2(0, 24)
		var lp_st := StyleBoxFlat.new()
		var reached = (lvl <= current_level)
		lp_st.bg_color = Color(0.15, 0.22, 0.32, 0.95) if reached else Color(0.08, 0.10, 0.14, 0.8)
		lp_st.border_color = Color(0.35, 0.88, 1.0) if reached else Color(0.2, 0.25, 0.35)
		lp_st.set_border_width_all(1)
		lp_st.set_corner_radius_all(12)
		lvl_pill.add_theme_stylebox_override("panel", lp_st)
		
		var lvl_lbl := Label.new()
		lvl_lbl.text = "NV %d" % lvl
		lvl_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lvl_lbl.add_theme_color_override("font_color", Color(0.9, 0.98, 1.0) if reached else Color(0.6, 0.65, 0.75))
		lvl_lbl.add_theme_font_size_override("font_size", 10)
		lvl_pill.add_child(lvl_lbl)
		col.add_child(lvl_pill)
		
		# 3. PISTA GRATUITA (Abajo)
		var free_card := PanelContainer.new()
		free_card.custom_minimum_size = Vector2(140, 150)
		var f_st := StyleBoxFlat.new()
		f_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
		f_st.border_color = Color(0.25, 0.45, 0.75, 0.8)
		f_st.set_border_width_all(1)
		f_st.set_corner_radius_all(8)
		free_card.add_theme_stylebox_override("panel", f_st)
		
		var fvbox := VBoxContainer.new()
		fvbox.alignment = BoxContainer.ALIGNMENT_BEGIN
		fvbox.add_theme_constant_override("separation", 4)
		var fm := MarginContainer.new()
		fm.add_theme_constant_override("margin_left", 8); fm.add_theme_constant_override("margin_top", 6)
		fm.add_theme_constant_override("margin_right", 8); fm.add_theme_constant_override("margin_bottom", 8)
		fm.add_child(fvbox)
		free_card.add_child(fm)
		
		var free_tag := Label.new()
		free_tag.text = "GRATIS"
		free_tag.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		free_tag.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
		free_tag.add_theme_font_size_override("font_size", 9)
		fvbox.add_child(free_tag)
		
		if lvl % 2 == 0:
			var is_free_claimed = (lvl in claimed_free_levels) or (str(lvl) in claimed_free_levels)
			var can_claim_free = (lvl <= current_level) and (not is_free_claimed)
			_populate_reward_box(fvbox, _get_free_reward_info(lvl), false, lvl, false, is_free_claimed, can_claim_free)
		else:
			var empty_space := Control.new()
			empty_space.custom_minimum_size = Vector2(0, 75)
			fvbox.add_child(empty_space)
			var dash := Label.new()
			dash.text = "—"
			dash.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			dash.add_theme_color_override("font_color", Color(0.35, 0.4, 0.5))
			fvbox.add_child(dash)
			
		col.add_child(free_card)
		tracks_container.add_child(col)

func _populate_reward_box(container: VBoxContainer, info: Dictionary, show_lock: bool, lvl: int, is_prem_track: bool, is_claimed: bool, can_claim: bool) -> void:
	var rtype = str(info.get("type", ""))
	
	var visual_box := CenterContainer.new()
	visual_box.custom_minimum_size = Vector2(0, 68)
	
	if rtype == "watt":
		var vb := VBoxContainer.new()
		vb.alignment = BoxContainer.ALIGNMENT_CENTER
		vb.add_theme_constant_override("separation", 2)
		var ico := TextureRect.new()
		ico.texture = WATT_ICON
		ico.custom_minimum_size = Vector2(30, 30)
		ico.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		ico.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		vb.add_child(ico)
		
		var amt := Label.new()
		amt.text = str(info.get("amount_text", ""))
		amt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		amt.add_theme_color_override("font_color", Color(0.4, 0.95, 0.55))
		amt.add_theme_font_size_override("font_size", 10)
		vb.add_child(amt)
		visual_box.add_child(vb)
		
	elif rtype in ["room_bg", "generator"]:
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(110, 64)
		btn.flat = true
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.pressed.connect(func(): _open_preview_modal(info))
		
		var vb := VBoxContainer.new()
		vb.alignment = BoxContainer.ALIGNMENT_CENTER
		vb.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		vb.mouse_filter = Control.MOUSE_FILTER_IGNORE
		vb.add_theme_constant_override("separation", 2)
		
		var thumb := TextureRect.new()
		thumb.custom_minimum_size = Vector2(50, 32) if rtype == "room_bg" else Vector2(36, 36)
		thumb.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		thumb.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var path = str(info.get("texture_path", ""))
		if ResourceLoader.exists(path): thumb.texture = load(path)
		vb.add_child(thumb)
		
		var n_lbl := Label.new()
		n_lbl.text = str(info.get("name", ""))
		n_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		n_lbl.add_theme_font_size_override("font_size", 9)
		n_lbl.add_theme_color_override("font_color", Color(0.35, 0.85, 1.0))
		n_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		vb.add_child(n_lbl)
		
		btn.add_child(vb)
		visual_box.add_child(btn)
		
	container.add_child(visual_box)

	var footer := CenterContainer.new()
	footer.custom_minimum_size = Vector2(0, 30)
	
	if is_claimed:
		var c_btn := Button.new()
		c_btn.text = "✓ Reclamado"
		c_btn.custom_minimum_size = Vector2(115, 26)
		c_btn.disabled = true
		c_btn.add_theme_font_size_override("font_size", 9)
		var dis_st := StyleBoxFlat.new()
		dis_st.bg_color = Color(0.1, 0.15, 0.12, 0.8)
		dis_st.border_color = Color(0.2, 0.5, 0.3, 0.6)
		dis_st.set_border_width_all(1); dis_st.set_corner_radius_all(5)
		c_btn.add_theme_stylebox_override("disabled", dis_st)
		c_btn.add_theme_color_override("font_disabled_color", Color(0.4, 0.85, 0.5, 0.7))
		footer.add_child(c_btn)
	elif can_claim:
		var claim_btn := Button.new()
		claim_btn.text = "⚡ Reclamar"
		claim_btn.custom_minimum_size = Vector2(115, 26)
		claim_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		claim_btn.add_theme_font_size_override("font_size", 10)
		
		var act_st := StyleBoxFlat.new()
		act_st.bg_color = Color(1.0, 0.82, 0.15, 1.0) if is_prem_track else Color(0.15, 0.75, 0.45, 1.0)
		act_st.border_color = Color(1.0, 0.95, 0.6) if is_prem_track else Color(0.4, 1.0, 0.6)
		act_st.set_border_width_all(1); act_st.set_corner_radius_all(5)
		claim_btn.add_theme_stylebox_override("normal", act_st)
		claim_btn.add_theme_stylebox_override("hover", act_st)
		claim_btn.add_theme_color_override("font_color", Color(0.08, 0.06, 0.01) if is_prem_track else Color(0.04, 0.12, 0.04))
		
		claim_btn.pressed.connect(func(): _claim_level_reward(lvl, is_prem_track, claim_btn))
		footer.add_child(claim_btn)
	elif show_lock:
		var l_lbl := Label.new()
		l_lbl.text = "🔒 Bloqueado"
		l_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		l_lbl.add_theme_font_size_override("font_size", 9)
		footer.add_child(l_lbl)
	else:
		var w_lbl := Label.new()
		w_lbl.text = "NV %d Requerido" % lvl
		w_lbl.add_theme_color_override("font_color", Color(0.55, 0.6, 0.7))
		w_lbl.add_theme_font_size_override("font_size", 9)
		footer.add_child(w_lbl)
		
	container.add_child(footer)

func _claim_level_reward(lvl: int, is_prem_track: bool, btn: Button) -> void:
	btn.disabled = true; btn.text = "..."
	var payload = {"p_level": lvl, "p_is_premium": is_prem_track}
	var res = await SupabaseClient.send_request("/rest/v1/rpc/claim_battle_pass_reward", HTTPClient.METHOD_POST, payload, true)
	
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		btn.text = "✓ Reclamado"; btn.disabled = true
		await GameManager.load_profile()
		_load_battle_pass_data()
	else:
		btn.disabled = false
		btn.text = "Reintentar"

func _open_preview_modal(info: Dictionary) -> void:
	var rtype = str(info.get("type", ""))
	preview_title.text = "VISTA PREVIA: " + str(info.get("name", "")).to_upper()
	
	if rtype == "room_bg":
		bg_preview_box.visible = true
		gen_preview_box.visible = false
		var path = str(info.get("texture_path", ""))
		if ResourceLoader.exists(path): bg_large_image.texture = load(path)
	elif rtype == "generator":
		bg_preview_box.visible = false
		gen_preview_box.visible = true
		var path = str(info.get("texture_path", ""))
		if ResourceLoader.exists(path): gen_image.texture = load(path)
		gen_rarity.text = "★ " + str(info.get("rarity", "EXCLUSIVA"))
		gen_name.text = str(info.get("name", ""))
		gen_power.text = "⚡ Potencia: " + str(info.get("power", ""))
		gen_income.text = "🪙 Generación: " + str(info.get("income", ""))
		gen_desc.text = str(info.get("description", ""))
		
	reward_preview_modal.visible = true

func _get_free_reward_info(level: int) -> Dictionary:
	match level:
		2: return {"type": "watt", "amount_text": "+0.05 W"}
		4: return {"type": "watt", "amount_text": "+0.10 W"}
		6: return {"type": "generator", "name": "Generador Manual", "texture_path": "res://assets/sprites/generators/dinamo_manual.png", "rarity": "PASE TEMPORADA 1", "power": "0.000000025 KWP", "income": "+0.000000025 kW/min", "description": "«Hay que darle a la manivela: 0.000000025 kW/min.»"}
		8: return {"type": "watt", "amount_text": "+0.25 W"}
		10: return {"type": "room_bg", "name": "Hab. Taller", "texture_path": "res://assets/sprites/room/bg_habitacion_taller.png"}
		12: return {"type": "watt", "amount_text": "+0.50 W"}
		14: return {"type": "watt", "amount_text": "+0.75 W"}
		16: return {"type": "watt", "amount_text": "+1.00 W"}
		18: return {"type": "watt", "amount_text": "+1.25 W"}
		20: return {"type": "generator", "name": "Panel Solar", "texture_path": "res://assets/sprites/generators/panel_solar.png", "rarity": "PASE TEMPORADA 1", "power": "0.000000200 KWP", "income": "+0.000000200 kW/min", "description": "«Fotoceldas recicladas: 0.000000200 kW/min.»"}
		_: return {"type": "watt", "amount_text": "+0.01 W"}

func _get_premium_reward_info(level: int) -> Dictionary:
	match level:
		1: return {"type": "watt", "amount_text": "+1.0 W"}
		2: return {"type": "watt", "amount_text": "+1.5 W"}
		3: return {"type": "watt", "amount_text": "+2.0 W"}
		4: return {"type": "watt", "amount_text": "+1.0 W"}
		5: return {"type": "room_bg", "name": "Búnker Solar", "texture_path": "res://assets/sprites/room/bg_bunker_solar.png"}
		6: return {"type": "watt", "amount_text": "+2.0 W"}
		7: return {"type": "watt", "amount_text": "+2.5 W"}
		8: return {"type": "watt", "amount_text": "+3.0 W"}
		9: return {"type": "watt", "amount_text": "+2.0 W"}
		10: return {"type": "generator", "name": "DELTA Mini", "texture_path": "res://assets/sprites/generators/delta_mini.png", "rarity": "PREMIUM TEMPORADA 1", "power": "0.000000300 KWP", "income": "+0.000000300 kW/min", "description": "«Batería portátil de gama alta: 0.000000300 kW/min.»"}
		11: return {"type": "watt", "amount_text": "+2.5 W"}
		12: return {"type": "watt", "amount_text": "+3.0 W"}
		13: return {"type": "watt", "amount_text": "+3.5 W"}
		14: return {"type": "watt", "amount_text": "+2.0 W"}
		15: return {"type": "watt", "amount_text": "+4.0 W"}
		16: return {"type": "watt", "amount_text": "+3.0 W"}
		17: return {"type": "watt", "amount_text": "+3.5 W"}
		18: return {"type": "watt", "amount_text": "+4.0 W"}
		19: return {"type": "watt", "amount_text": "+4.0 W"}
		20: return {"type": "generator", "name": "Pro Eléctrico", "texture_path": "res://assets/sprites/generators/pro_electrico.png", "rarity": "LEGENDARIO TEMPORADA 1", "power": "0.000000800 KWP", "income": "+0.000000800 kW/min", "description": "«Cúspide tecnológica del pase de batalla: 0.000000800 kW/min.»"}
		_: return {"type": "watt", "amount_text": "+1.0 W"}

# ====================================================================
# PESTAÑA: MISIONES DEL PASE + CONTRATOS DE LA RED (COEXISTENCIA)
# ====================================================================
func _build_quests_ui() -> void:
	if is_loading_quests: return
	is_loading_quests = true

	# 1. Obtener Misiones clásicas del Pase de Batalla (Minijuegos/Online)
	var res_bp = await SupabaseClient.send_request("/rest/v1/rpc/get_daily_quests_status", HTTPClient.METHOD_POST, {}, true)
	
	# 2. Obtener Contratos Industriales (Piezas del Taller y Watts)
	var contracts: Array = await GameManager.get_daily_contracts_secure()
	
	is_loading_quests = false

	for child in quests_list.get_children():
		child.queue_free()

	# ----------------------------------------------------------------
	# SECCIÓN 1: MISIONES DE JUEGO (XP PARA EL PASE DE BATALLA)
	# ----------------------------------------------------------------
	var sec1_header := Label.new()
	sec1_header.text = "🎮 MISIONES DE JUEGO (SUBIR EL PASE DE TEMPORADA)"
	sec1_header.add_theme_font_size_override("font_size", 13)
	sec1_header.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	quests_list.add_child(sec1_header)

	if res_bp.get("success", false) and typeof(res_bp["data"]) == TYPE_DICTIONARY:
		var q_array = res_bp["data"].get("quests", [])
		for q in q_array:
			var panel := PanelContainer.new()
			var p_st := StyleBoxFlat.new()
			p_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
			p_st.border_color = Color(0.2, 0.35, 0.55, 0.7)
			p_st.set_border_width_all(1); p_st.set_corner_radius_all(8)
			panel.add_theme_stylebox_override("panel", p_st)

			var pm := MarginContainer.new()
			pm.add_theme_constant_override("margin_left", 14); pm.add_theme_constant_override("margin_top", 10)
			pm.add_theme_constant_override("margin_right", 14); pm.add_theme_constant_override("margin_bottom", 10)
			panel.add_child(pm)

			var hbox := HBoxContainer.new()
			hbox.add_theme_constant_override("separation", 14)
			pm.add_child(hbox)

			var vbox := VBoxContainer.new()
			vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			vbox.add_theme_constant_override("separation", 3)

			var q_title := Label.new()
			q_title.text = "%s (+%d XP Pase)" % [str(q.get("title", "")), int(q.get("reward_xp", 0))]
			q_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			q_title.add_theme_font_size_override("font_size", 13)
			vbox.add_child(q_title)

			var q_desc := Label.new()
			q_desc.text = str(q.get("description", ""))
			q_desc.add_theme_font_size_override("font_size", 11)
			q_desc.add_theme_color_override("font_color", Color(0.75, 0.8, 0.9))
			vbox.add_child(q_desc)

			var prog_lbl := Label.new()
			prog_lbl.text = "Progreso: %d / %d" % [int(q.get("current_progress", 0)), int(q.get("target_count", 1))]
			prog_lbl.add_theme_font_size_override("font_size", 10)
			prog_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
			vbox.add_child(prog_lbl)
			hbox.add_child(vbox)

			var q_btn := Button.new()
			q_btn.custom_minimum_size = Vector2(125, 34)
			q_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			var is_comp = bool(q.get("is_completed", false))
			var is_clm = bool(q.get("is_claimed", false))

			if is_clm:
				q_btn.text = "✓ Reclamada"
				q_btn.disabled = true
			elif is_comp:
				q_btn.text = "⚡ Reclamar XP"
				q_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
				var q_id = str(q.get("quest_id", ""))
				q_btn.pressed.connect(func(): _claim_quest(q_id, q_btn))
			else:
				q_btn.text = "En curso"
				q_btn.disabled = true
			hbox.add_child(q_btn)

			quests_list.add_child(panel)

	# Separador visual entre sistemas
	var hsep := HSeparator.new()
	quests_list.add_child(hsep)

	# ----------------------------------------------------------------
	# SECCIÓN 2: CONTRATOS DE LA RED (PUNTOS DE TALENTO Y FICHAS)
	# ----------------------------------------------------------------
	var sec2_header := Label.new()
	sec2_header.text = "📜 CONTRATOS DE LA RED ELÉCTRICA (TALENTOS & FICHAS)"
	sec2_header.add_theme_font_size_override("font_size", 13)
	sec2_header.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	quests_list.add_child(sec2_header)

	if contracts.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No hay contratos industriales disponibles hoy."
		empty_lbl.add_theme_font_size_override("font_size", 11)
		quests_list.add_child(empty_lbl)
		return

	for c in contracts:
		var panel := PanelContainer.new()
		var p_st := StyleBoxFlat.new()
		p_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
		p_st.border_color = Color(1.0, 0.75, 0.2, 0.7)
		p_st.set_border_width_all(1); p_st.set_corner_radius_all(8)
		panel.add_theme_stylebox_override("panel", p_st)

		var pm := MarginContainer.new()
		pm.add_theme_constant_override("margin_left", 14); pm.add_theme_constant_override("margin_top", 10)
		pm.add_theme_constant_override("margin_right", 14); pm.add_theme_constant_override("margin_bottom", 10)
		panel.add_child(pm)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		pm.add_child(hbox)

		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.add_theme_constant_override("separation", 3)

		var c_title := Label.new()
		c_title.text = "📋 " + str(c.get("title", "Contrato"))
		c_title.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
		c_title.add_theme_font_size_override("font_size", 13)
		vbox.add_child(c_title)

		var c_desc := Label.new()
		c_desc.text = str(c.get("description", ""))
		c_desc.add_theme_font_size_override("font_size", 11)
		c_desc.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
		vbox.add_child(c_desc)

		# Comprobación de requisitos
		var p_type = str(c.get("req_piece_type", ""))
		var p_tier = int(c.get("req_piece_tier", 1))
		var p_qty = int(c.get("req_piece_qty", 1))
		var req_w = float(c.get("req_watt", 0.0))

		var have_p = GameManager.get_part_quantity(p_type, p_tier)
		var have_w = GameManager.watt
		var can_deliver = (have_p >= p_qty) and (have_w >= req_w)

		var req_lbl := Label.new()
		var p_names = {"cable": "Cables", "ventilador": "Ventiladores", "panel": "Paneles", "chip": "Microchips", "condensador": "Condensadores"}
		var p_display = p_names.get(p_type, p_type.capitalize())
		req_lbl.text = "Requiere: %s Nv.%d (%d/%d %s) | Watts (%.3f/%.3f %s)" % [
			p_display, p_tier, have_p, p_qty, "✓" if have_p >= p_qty else "✕",
			have_w, req_w, "✓" if have_w >= req_w else "✕"
		]
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_deliver else Color(1.0, 0.45, 0.45))
		vbox.add_child(req_lbl)

		var rew_lbl := Label.new()
		rew_lbl.text = "Recompensa: +%d Ptos. Talento 🏅 | +%d Fichas Casino 🪙 | +%d XP ⭐" % [
			int(c.get("reward_talent_points", 1)),
			int(c.get("reward_casino_tokens", 1)),
			int(c.get("reward_xp", 100))
		]
		rew_lbl.add_theme_font_size_override("font_size", 10)
		rew_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		vbox.add_child(rew_lbl)

		hbox.add_child(vbox)

		# Botón Entregar
		var q_btn := Button.new()
		q_btn.custom_minimum_size = Vector2(135, 36)
		q_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		var is_delivered = bool(c.get("is_delivered", false))

		if is_delivered:
			q_btn.text = "✓ Entregado"
			q_btn.disabled = true
		elif can_deliver:
			q_btn.text = "⚡ Entregar"
			q_btn.disabled = false
			q_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			var c_copy = c.duplicate()
			q_btn.pressed.connect(func():
				q_btn.disabled = true; q_btn.text = "..."
				var res = await GameManager.deliver_contract_secure(c_copy)
				if res.get("success", false):
					_build_quests_ui()
				else:
					q_btn.disabled = false; q_btn.text = "Reintentar"
			)
		else:
			q_btn.text = "🔒 Faltan Piezas"
			q_btn.disabled = true

		hbox.add_child(q_btn)
		quests_list.add_child(panel)

func _claim_quest(quest_id: String, btn: Button) -> void:
	btn.disabled = true
	btn.text = "..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/claim_quest_reward", HTTPClient.METHOD_POST, {"p_quest_id": quest_id}, true)
	if res.get("success", false):
		await GameManager.load_profile()
		_load_battle_pass_data()
	else:
		btn.disabled = false
		btn.text = "Reintentar"

func _parse_claimed(raw) -> Array:
	var res: Array = []
	if typeof(raw) == TYPE_ARRAY:
		for x in raw: res.append(int(x))
	elif typeof(raw) == TYPE_STRING:
		var c = raw.replace("{","").replace("}","").replace("[","").replace("]","").strip_edges()
		if c != "":
			for p in c.split(","): 
				if p.strip_edges() != "": 
					res.append(int(p.strip_edges()))
	return res

```

---

####### 📄 Archivo: `battle_pass_screen.gd.uid`

```
uid://3pptm554fli0

```

---

####### 📄 Archivo: `battle_pass_screen.tscn`

```
[gd_scene format=3 uid="uid://dkv1kf2y7d441"]

[ext_resource type="Script" path="res://features/progression/battle_pass/battle_pass_screen.gd" id="1_bps"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_watt.png" id="2_watt"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_kilowat.png" id="3_kilo"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_chip.png" id="4_chip"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill"]
bg_color = Color(0.1, 0.13, 0.18, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.35, 0.55, 0.7)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_gold_btn"]
bg_color = Color(1, 0.82, 0.15, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.95, 0.6, 1)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6
shadow_color = Color(1, 0.75, 0, 0.35)
shadow_size = 6

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[node name="BattlePassScreen" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_bps")

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.04, 0.05, 0.07, 1)

[node name="CanvasLayerUI" type="Control" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="MainVBox" type="VBoxContainer" parent="CanvasLayerUI"]
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 0

[node name="TopBar" type="PanelContainer" parent="CanvasLayerUI/MainVBox"]
custom_minimum_size = Vector2(0, 68)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="CloseButton" type="Button" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "← Volver al Cuarto"

[node name="Title" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
text = "🎖️ PASE DE TEMPORADA — TEMPORADA 1"

[node name="Spacer" type="Control" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="StatsBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="ChipPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(130, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("4_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 13
text = "0"

[node name="WattPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/WattPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 13
text = "0.0000"

[node name="KiloPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(150, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin"]
layout_mode = 2
theme_override_constants/separation = 8
alignment = 1

[node name="Icon" type="TextureRect" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
custom_minimum_size = Vector2(22, 22)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("3_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloLabel" type="Label" parent="CanvasLayerUI/MainVBox/TopBar/Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 13
text = "0.000000"

[node name="SeasonHeader" type="PanelContainer" parent="CanvasLayerUI/MainVBox"]
custom_minimum_size = Vector2(0, 64)
layout_mode = 2

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/SeasonHeader"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_right = 24

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin"]
layout_mode = 2
theme_override_constants/separation = 20

[node name="LevelPill" type="PanelContainer" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox"]
custom_minimum_size = Vector2(140, 38)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/LevelPill"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_right = 12

[node name="HBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/LevelPill/Margin"]
layout_mode = 2
alignment = 1

[node name="LevelLabel" type="Label" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/LevelPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
text = "NIVEL 1 / 20"

[node name="XPBox" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
alignment = 1

[node name="XPProgressBar" type="ProgressBar" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/XPBox"]
custom_minimum_size = Vector2(0, 14)
layout_mode = 2
max_value = 500.0
show_percentage = false

[node name="XPTextLabel" type="Label" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox/XPBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.75, 0.85, 0.95, 0.9)
theme_override_font_sizes/font_size = 11
text = "0 / 500 XP (0%)"
horizontal_alignment = 1

[node name="BuyPremiumButton" type="Button" parent="CanvasLayerUI/MainVBox/SeasonHeader/Margin/HBox"]
custom_minimum_size = Vector2(250, 42)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.08, 0.06, 0.01, 1)
theme_override_font_sizes/font_size = 13
theme_override_styles/normal = SubResource("StyleBoxFlat_gold_btn")
text = "⚡ ACTIVAR PREMIUM (2 KILOWAT)"

[node name="TabsBar" type="PanelContainer" parent="CanvasLayerUI/MainVBox"]
custom_minimum_size = Vector2(0, 48)
layout_mode = 2

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/TabsBar"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_right = 24

[node name="TabsHBox" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TabsBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 14

[node name="PassTabButton" type="Button" parent="CanvasLayerUI/MainVBox/TabsBar/Margin/TabsHBox"]
custom_minimum_size = Vector2(180, 38)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "🎖️ Pistas del Pase"

[node name="QuestsTabButton" type="Button" parent="CanvasLayerUI/MainVBox/TabsBar/Margin/TabsHBox"]
custom_minimum_size = Vector2(180, 38)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "📋 Misiones Diarias"

[node name="TracksScroll" type="ScrollContainer" parent="CanvasLayerUI/MainVBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="TracksContainer" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/TracksScroll"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 14

[node name="QuestsScroll" type="ScrollContainer" parent="CanvasLayerUI/MainVBox"]
visible = false
layout_mode = 2
size_flags_vertical = 3

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/MainVBox/QuestsScroll"]
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 3
theme_override_constants/margin_left = 32
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 32
theme_override_constants/margin_bottom = 24

[node name="QuestsWrapper" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/QuestsScroll/Margin"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 14

[node name="ResetHeader" type="HBoxContainer" parent="CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper"]
layout_mode = 2

[node name="ResetTimerLabel" type="Label" parent="CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper/ResetHeader"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 14
text = "⏳ Reinicio de misiones en: 00:00:00"

[node name="QuestsList" type="VBoxContainer" parent="CanvasLayerUI/MainVBox/QuestsScroll/Margin/QuestsWrapper"]
layout_mode = 2
theme_override_constants/separation = 10

[node name="RewardPreviewModal" type="Control" parent="CanvasLayerUI"]
visible = false
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="DarkOverlay" type="ColorRect" parent="CanvasLayerUI/RewardPreviewModal"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
color = Color(0.02, 0.03, 0.05, 0.9)

[node name="Center" type="CenterContainer" parent="CanvasLayerUI/RewardPreviewModal"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Panel" type="PanelContainer" parent="CanvasLayerUI/RewardPreviewModal/Center"]
custom_minimum_size = Vector2(760, 460)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")

[node name="Margin" type="MarginContainer" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 22
theme_override_constants/margin_top = 18
theme_override_constants/margin_right = 22
theme_override_constants/margin_bottom = 18

[node name="VBox" type="VBoxContainer" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Header" type="HBoxContainer" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox"]
layout_mode = 2

[node name="PreviewTitle" type="Label" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
text = "VISTA PREVIA DE RECOMPENSA"

[node name="Spacer" type="Control" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header"]
layout_mode = 2
size_flags_horizontal = 3

[node name="ClosePreviewBtn" type="Button" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/Header"]
custom_minimum_size = Vector2(36, 36)
layout_mode = 2
text = "✕"

[node name="BgPreviewBox" type="VBoxContainer" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox"]
visible = false
layout_mode = 2
size_flags_vertical = 3

[node name="BgLargeImage" type="TextureRect" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/BgPreviewBox"]
custom_minimum_size = Vector2(700, 340)
layout_mode = 2
size_flags_horizontal = 4
size_flags_vertical = 3
expand_mode = 1
stretch_mode = 6

[node name="GenPreviewBox" type="HBoxContainer" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox"]
visible = false
layout_mode = 2
size_flags_vertical = 3
theme_override_constants/separation = 20

[node name="GenImage" type="TextureRect" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox"]
custom_minimum_size = Vector2(180, 240)
layout_mode = 2
expand_mode = 1
stretch_mode = 5

[node name="GenDetails" type="VBoxContainer" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 8

[node name="GenRarity" type="Label" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 12
text = "★ RAREZA"

[node name="GenName" type="Label" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 20
text = "Nombre"

[node name="GenPower" type="Label" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.85, 1, 1)
theme_override_font_sizes/font_size = 13
text = "⚡ Potencia"

[node name="GenIncome" type="Label" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 1, 0.5, 1)
theme_override_font_sizes/font_size = 13
text = "🪙 Generación"

[node name="GenDesc" type="Label" parent="CanvasLayerUI/RewardPreviewModal/Center/Panel/Margin/VBox/GenPreviewBox/GenDetails"]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.85, 0.9, 0.9)
theme_override_font_sizes/font_size = 12
autowrap_mode = 2
```

---

###### 📁 Carpeta: `./features\progression\referrals/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `referral_modal.gd`

```
# res://features/progression/referrals/referral_modal.gd
extends Control

@onready var code_label: Label = $Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox/CodeLabel
@onready var copy_btn: Button = $Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox/CopyBtn
@onready var total_refs_lbl: Label = $Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox/TotalRefsVal
@onready var refs_progress_bar: ProgressBar = $Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox/ProgressBar
@onready var power_earned_lbl: Label = $Center/Panel/Margin/VBox/StatsGrid/PowerCard/Margin/VBox/PowerEarnedVal
@onready var friends_list: VBoxContainer = $Center/Panel/Margin/VBox/FriendsScroll/Margin/FriendsList
@onready var close_btn: Button = $Center/Panel/Margin/VBox/TopRow/CloseBtn

var my_referral_code: String = ""

func _ready() -> void:
	visible = false
	close_btn.pressed.connect(func(): visible = false)
	copy_btn.pressed.connect(_on_copy_pressed)

func open_modal() -> void:
	visible = true
	_fetch_referral_data()

func _fetch_referral_data() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_referral_stats", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		var d = res["data"]
		my_referral_code = str(d.get("referral_code", GameManager.username))
		code_label.text = my_referral_code
		
		var refs_count: int = int(d.get("total_referrals", 0))
		total_refs_lbl.text = "%d / 20 Amigos" % refs_count
		if refs_progress_bar:
			refs_progress_bar.value = refs_count
			
		var p_kwp: float = float(d.get("referral_power_kwp", 0.0))
		power_earned_lbl.text = "+%.9f KWP" % p_kwp
		
		for child in friends_list.get_children():
			child.queue_free()
			
		var friends = d.get("friends", [])
		if friends.is_empty():
			var empty_panel := PanelContainer.new()
			var ep_st := StyleBoxFlat.new()
			ep_st.bg_color = Color(0.08, 0.10, 0.14, 0.7)
			ep_st.set_corner_radius_all(6)
			empty_panel.add_theme_stylebox_override("panel", ep_st)
			
			var ep_m := MarginContainer.new()
			ep_m.add_theme_constant_override("margin_top", 16)
			ep_m.add_theme_constant_override("margin_bottom", 16)
			empty_panel.add_child(ep_m)
			
			var empty_lbl := Label.new()
			empty_lbl.text = "Aún no tienes amigos en tu red.\nComparte tu código para recibir potencia permanente de por vida."
			empty_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			empty_lbl.add_theme_color_override("font_color", Color(0.65, 0.70, 0.80))
			empty_lbl.add_theme_font_size_override("font_size", 12)
			ep_m.add_child(empty_lbl)
			friends_list.add_child(empty_panel)
		else:
			for f in friends:
				var row_panel := PanelContainer.new()
				var rp_st := StyleBoxFlat.new()
				var is_done = bool(f.get("completed", false))
				rp_st.bg_color = Color(0.10, 0.14, 0.20, 0.85) if is_done else Color(0.08, 0.10, 0.14, 0.85)
				rp_st.border_color = Color(0.3, 0.85, 0.5) if is_done else Color(0.25, 0.35, 0.5, 0.6)
				rp_st.set_border_width_all(1)
				rp_st.set_corner_radius_all(6)
				row_panel.add_theme_stylebox_override("panel", rp_st)
				
				var rm := MarginContainer.new()
				rm.add_theme_constant_override("margin_left", 12); rm.add_theme_constant_override("margin_right", 12)
				rm.add_theme_constant_override("margin_top", 8); rm.add_theme_constant_override("margin_bottom", 8)
				row_panel.add_child(rm)
				
				var row := HBoxContainer.new()
				rm.add_child(row)
				
				var u_lbl := Label.new()
				u_lbl.text = str(f.get("username", "Jugador")).to_upper()
				u_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				u_lbl.add_theme_font_size_override("font_size", 12)
				row.add_child(u_lbl)
				
				var status_lbl := Label.new()
				if is_done:
					status_lbl.text = "✓ VERIFICADO (+0.000000050 KWP)"
					status_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
				else:
					status_lbl.text = "⏳ En progreso (Nivel 4 de Pase o 30 victorias)"
					status_lbl.add_theme_color_override("font_color", Color(1.0, 0.82, 0.2))
				status_lbl.add_theme_font_size_override("font_size", 11)
				row.add_child(status_lbl)
				
				friends_list.add_child(row_panel)

func _on_copy_pressed() -> void:
	DisplayServer.clipboard_set(my_referral_code)
	copy_btn.text = "✓ ¡CÓDIGO COPIADO!"
	await get_tree().create_timer(1.8).timeout
	copy_btn.text = "📋 COPIAR CÓDIGO"
```

---

####### 📄 Archivo: `referral_modal.gd.uid`

```
uid://bqa4at45hxqe7

```

---

####### 📄 Archivo: `referral_modal.tscn`

```
[gd_scene format=3 uid="uid://cirh7dy3wu0nd"]

[ext_resource type="Script" path="res://features/progression/referrals/referral_modal.gd" id="1_ref"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel"]
bg_color = Color(0.08, 0.10, 0.15, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.35, 0.88, 1, 1)
corner_radius_top_left = 14
corner_radius_top_right = 14
corner_radius_bottom_right = 14
corner_radius_bottom_left = 14
shadow_color = Color(0.15, 0.6, 0.9, 0.25)
shadow_size = 16

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_infobox"]
bg_color = Color(0.12, 0.15, 0.22, 0.85)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.25, 0.45, 0.7, 0.8)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_code_hero"]
bg_color = Color(0.05, 0.07, 0.1, 0.95)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
shadow_color = Color(1, 0.75, 0, 0.2)
shadow_size = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_copy_btn"]
bg_color = Color(1, 0.82, 0.15, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(1, 0.95, 0.6, 1)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_stat_card"]
bg_color = Color(0.1, 0.12, 0.18, 0.9)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.3, 0.45, 0.8)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[node name="ReferralModal" type="Control"]
visible = false
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_ref")

[node name="DarkOverlay" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
color = Color(0.02, 0.03, 0.05, 0.9)

[node name="Center" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Panel" type="PanelContainer" parent="Center"]
custom_minimum_size = Vector2(740, 520)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel")

[node name="Margin" type="MarginContainer" parent="Center/Panel"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 20

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="TopRow" type="HBoxContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2

[node name="Title" type="Label" parent="Center/Panel/Margin/VBox/TopRow"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 20
text = "👥 RED DE ENLACES & REFERIDOS"

[node name="Spacer" type="Control" parent="Center/Panel/Margin/VBox/TopRow"]
layout_mode = 2
size_flags_horizontal = 3

[node name="CloseBtn" type="Button" parent="Center/Panel/Margin/VBox/TopRow"]
custom_minimum_size = Vector2(36, 36)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "✕"

[node name="InfoCard" type="PanelContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_infobox")

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/InfoCard"]
layout_mode = 2
theme_override_constants/margin_left = 14
theme_override_constants/margin_top = 10
theme_override_constants/margin_right = 14
theme_override_constants/margin_bottom = 10

[node name="InfoText" type="Label" parent="Center/Panel/Margin/VBox/InfoCard/Margin"]
layout_mode = 2
theme_override_colors/font_color = Color(0.85, 0.9, 0.95, 0.95)
theme_override_font_sizes/font_size = 12
text = "• Tu amigo recibe +0.000000010 kW/min al registrarse con tu código.
• Cuando tu amigo alcance el Nivel 4 del Pase o 30 victorias, tú ganas +0.000000050 KWP de por vida (hasta 20 amigos)."
autowrap_mode = 2

[node name="CodeHeroCard" type="PanelContainer" parent="Center/Panel/Margin/VBox"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_code_hero")

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/CodeHeroCard"]
layout_mode = 2
theme_override_constants/margin_left = 18
theme_override_constants/margin_right = 14

[node name="HBox" type="HBoxContainer" parent="Center/Panel/Margin/VBox/CodeHeroCard/Margin"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="Prefix" type="Label" parent="Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.7, 0.75, 0.85, 1)
theme_override_font_sizes/font_size = 13
text = "Tu Código Oficial:"

[node name="CodeLabel" type="Label" parent="Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 18
text = "JUGADOR"

[node name="CopyBtn" type="Button" parent="Center/Panel/Margin/VBox/CodeHeroCard/Margin/HBox"]
custom_minimum_size = Vector2(160, 38)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_colors/font_color = Color(0.08, 0.06, 0.01, 1)
theme_override_font_sizes/font_size = 12
theme_override_styles/normal = SubResource("StyleBoxFlat_copy_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_copy_btn")
text = "📋 COPIAR CÓDIGO"

[node name="StatsGrid" type="HBoxContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="RefsCard" type="PanelContainer" parent="Center/Panel/Margin/VBox/StatsGrid"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_styles/panel = SubResource("StyleBoxFlat_stat_card")

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/StatsGrid/RefsCard"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_top = 10
theme_override_constants/margin_right = 12
theme_override_constants/margin_bottom = 10

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin"]
layout_mode = 2
theme_override_constants/separation = 4

[node name="Title" type="Label" parent="Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.7, 0.8, 1)
theme_override_font_sizes/font_size = 11
text = "AMIGOS VERIFICADOS"

[node name="TotalRefsVal" type="Label" parent="Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 16
text = "0 / 20 Amigos"

[node name="ProgressBar" type="ProgressBar" parent="Center/Panel/Margin/VBox/StatsGrid/RefsCard/Margin/VBox"]
custom_minimum_size = Vector2(0, 6)
layout_mode = 2
max_value = 20.0
show_percentage = false

[node name="PowerCard" type="PanelContainer" parent="Center/Panel/Margin/VBox/StatsGrid"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_styles/panel = SubResource("StyleBoxFlat_stat_card")

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/StatsGrid/PowerCard"]
layout_mode = 2
theme_override_constants/margin_left = 12
theme_override_constants/margin_top = 10
theme_override_constants/margin_right = 12
theme_override_constants/margin_bottom = 10

[node name="VBox" type="VBoxContainer" parent="Center/Panel/Margin/VBox/StatsGrid/PowerCard/Margin"]
layout_mode = 2
theme_override_constants/separation = 4

[node name="Title" type="Label" parent="Center/Panel/Margin/VBox/StatsGrid/PowerCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.7, 0.8, 1)
theme_override_font_sizes/font_size = 11
text = "POTENCIA PERMANENTE GANADA"

[node name="PowerEarnedVal" type="Label" parent="Center/Panel/Margin/VBox/StatsGrid/PowerCard/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 16
text = "+0.000000000 KWP"

[node name="FeedTitle" type="Label" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.85, 0.9, 0.95, 1)
theme_override_font_sizes/font_size = 13
text = "HISTORIAL DE INVITADOS"

[node name="FriendsScroll" type="ScrollContainer" parent="Center/Panel/Margin/VBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="Margin" type="MarginContainer" parent="Center/Panel/Margin/VBox/FriendsScroll"]
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="FriendsList" type="VBoxContainer" parent="Center/Panel/Margin/VBox/FriendsScroll/Margin"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 6
```

---

###### 📁 Carpeta: `./features\progression\talents/`

####### 📄 Archivo: `talent_tree_modal.gd`

```
# res://features/progression/talents/talent_tree_modal.gd
class_name TalentTreeModal
extends Control

signal talents_updated()

# Nodos del lienzo
var canvas_view: Control
var circuit_drawer: Control
var inspector_panel: PanelContainer
var points_label: Label
var watt_label: Label
var status_lbl: Label

# Inspector Lateral
var insp_title: Label
var insp_branch: Label
var insp_level: Label
var insp_desc: Label
var insp_cost: Label
var insp_req: Label
var insp_buy_btn: Button

# Pan & Zoom del Árbol
var tree_offset: Vector2 = Vector2.ZERO
var tree_zoom: float = 1.0
var is_dragging: bool = false
var drag_start_mouse: Vector2 = Vector2.ZERO
var drag_start_offset: Vector2 = Vector2.ZERO

var selected_node_id: String = "core_root"
var nodes_data: Dictionary = {}

func _ready() -> void:
	visible = false
	_init_tree_catalog()
	_build_ui_layout()

func open_modal() -> void:
	visible = true
	# Centrar la vista en el núcleo inicial (0, 0)
	tree_zoom = 0.95
	tree_offset = Vector2(460, 360)
	selected_node_id = "core_root"
	
	_update_hud_counters()
	_inspect_node("core_root")
	circuit_drawer.queue_redraw()
	
	await GameManager.load_player_rpg_state()
	if visible:
		_update_hud_counters()
		_inspect_node(selected_node_id)
		circuit_drawer.queue_redraw()

# ====================================================================
# CATÁLOGO DE LOS 28 NODOS ESTELARES (ESTILO RISE OF KINGDOMS)
# ====================================================================
func _init_tree_catalog() -> void:
	nodes_data = {
		# --- NÚCLEO CENTRAL ---
		"core_root": {
			"name": "Núcleo de Operador", "icon": "⚡", "branch": "core", "pos": Vector2(0, 0), "prereq": "",
			"cost_pts": 2, "cost_watt": 0.50, "max_lvl": 1,
			"desc": "Conecta la central con el sistema neuronal. Desbloquea las tres grandes especializaciones energéticas."
		},

		# ============================================================
		# RAMA CHATARRERO (NORTE / ARRIBA) - COLOR NARANJA FUEGO
		# ============================================================
		"gate_chatarrero": {
			"name": "Protocolo Chatarrero", "icon": "🧲", "branch": "chatarrero", "pos": Vector2(0, -110), "prereq": "core_root",
			"cost_pts": 3, "cost_watt": 1.00, "max_lvl": 1,
			"desc": "Inicia la senda del reciclaje y minijuegos. Habilita los talentos de recolección de materiales."
		},
		"chat_iman": {
			"name": "Imán de Chatarra", "icon": "🧲", "branch": "chatarrero", "pos": Vector2(-100, -200), "prereq": "gate_chatarrero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Aumenta la cantidad de materiales brutos obtenidos en minijuegos (+15% por nivel)."
		},
		"chat_suerte": {
			"name": "Detector de Frecuencias", "icon": "🔍", "branch": "chatarrero", "pos": Vector2(100, -200), "prereq": "gate_chatarrero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Mayor probabilidad de conseguir materiales de Tiers superiores al ganar minijuegos (+10% por nivel)."
		},
		"chat_reflejos": {
			"name": "Reflejos Cinéticos", "icon": "⏱️", "branch": "chatarrero", "pos": Vector2(-160, -300), "prereq": "chat_iman",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Reduce el tiempo de enfriamiento (cooldown) entre partidas de minijuegos (-12% por nivel)."
		},
		"chat_reciclaje": {
			"name": "Extracción Rápida", "icon": "📦", "branch": "chatarrero", "pos": Vector2(0, -290), "prereq": "gate_chatarrero",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "+20% XP de Chatarrero por cada minijuego ganado con éxito."
		},
		"chat_doble": {
			"name": "Doble Hallazgo", "icon": "🎲", "branch": "chatarrero", "pos": Vector2(160, -300), "prereq": "chat_suerte",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "+8% de probabilidad por nivel de duplicar el botín completo al ganar un minijuego."
		},
		"chat_aleaciones": {
			"name": "Aleaciones Puras", "icon": "💎", "branch": "chatarrero", "pos": Vector2(-80, -400), "prereq": "chat_reflejos",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Al recolectar materiales Tier 3 o superior, probabilidad del 15% de recibir un lote adicional gratis."
		},
		"chat_maestria": {
			"name": "Maestro Chatarrero", "icon": "🪙", "branch": "chatarrero", "pos": Vector2(80, -400), "prereq": "chat_doble",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Añade una probabilidad del 2% al ganar en dificultad 4 de conseguir una Ficha de Casino adicional."
		},
		"chat_apex": {
			"name": "Sobrecarga de Recolección", "icon": "👑", "branch": "chatarrero", "pos": Vector2(0, -490), "prereq": "chat_reciclaje",
			"cost_pts": 12, "cost_watt": 6.00, "max_lvl": 1,
			"desc": "TALENTO MAESTRO: Todas las victorias en minijuegos otorgan el triple de materiales garantizados."
		},

		# ============================================================
		# RAMA INGENIERO (SURESTE / ABAJO DERECHA) - COLOR AZUL CIAN
		# ============================================================
		"gate_ingeniero": {
			"name": "Protocolo Ingeniero", "icon": "⚙️", "branch": "ingeniero", "pos": Vector2(110, 80), "prereq": "core_root",
			"cost_pts": 3, "cost_watt": 1.00, "max_lvl": 1,
			"desc": "Inicia la maestría del banco de trabajo y la electrónica. Habilita los talentos de crafteo."
		},
		"ing_ahorro": {
			"name": "Corte de Precisión", "icon": "✂️", "branch": "ingeniero", "pos": Vector2(210, 20), "prereq": "gate_ingeniero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "10% de probabilidad por nivel de recuperar la mitad de los materiales utilizados al fabricar una pieza."
		},
		"ing_resistencia": {
			"name": "Lubricación Sintética", "icon": "🛡️", "branch": "ingeniero", "pos": Vector2(210, 160), "prereq": "gate_ingeniero",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "La durabilidad de todas las plantas instaladas en tu sala se desgasta un 10% más lento por nivel."
		},
		"ing_doble_craft": {
			"name": "Producción en Masa", "icon": "🔨", "branch": "ingeniero", "pos": Vector2(320, 20), "prereq": "ing_ahorro",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "+6% de probabilidad por nivel de fabricar una pieza duplicada gratis sin coste extra."
		},
		"ing_reparacion": {
			"name": "Mecánica Cuántica", "icon": "🔧", "branch": "ingeniero", "pos": Vector2(300, 90), "prereq": "gate_ingeniero",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Reparar generadores consume 1 Cable y 1 Ventilador menos por cada nivel de este talento."
		},
		"ing_sobrecarga_gen": {
			"name": "Disipación Criogénica", "icon": "❄️", "branch": "ingeniero", "pos": Vector2(320, 180), "prereq": "ing_resistencia",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Aumenta la vida útil de los generadores activos en 2 horas adicionales antes de apagarse."
		},
		"ing_calibracion": {
			"name": "Afinación de Bobinas", "icon": "🔋", "branch": "ingeniero", "pos": Vector2(420, 30), "prereq": "ing_doble_craft",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Los generadores de nivel 2 o superior reciben un +8% extra de potencia KWP permanente."
		},
		"ing_maestria": {
			"name": "Ingeniería de Plasma", "icon": "⚛️", "branch": "ingeniero", "pos": Vector2(420, 150), "prereq": "ing_sobrecarga_gen",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Probabilidad de que al reparar una planta quede al 110% de durabilidad (Sobrecarga Óptima)."
		},
		"ing_apex": {
			"name": "Reactor Perpetuo", "icon": "👑", "branch": "ingeniero", "pos": Vector2(500, 90), "prereq": "ing_reparacion",
			"cost_pts": 12, "cost_watt": 6.00, "max_lvl": 1,
			"desc": "TALENTO MAESTRO: Las reparaciones de plantas Tier 4 y 5 consumen un 40% menos de piezas de alta tecnología."
		},

		# ============================================================
		# RAMA CORREDOR (SUROESTE / ABAJO IZQUIERDA) - COLOR AMARILLO ORO
		# ============================================================
		"gate_corredor": {
			"name": "Protocolo Corredor", "icon": "💡", "branch": "corredor", "pos": Vector2(-110, 80), "prereq": "core_root",
			"cost_pts": 3, "cost_watt": 1.00, "max_lvl": 1,
			"desc": "Inicia la especialización en finanzas de la red y flujo de energía. Habilita contratos y comisiones reducidas."
		},
		"cor_flujo": {
			"name": "Transformador Pulido", "icon": "⚡", "branch": "corredor", "pos": Vector2(-210, 20), "prereq": "gate_corredor",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Incrementa la tasa de minado pasivo continuo de WATT en un +10% por nivel."
		},
		"cor_comision": {
			"name": "Bolsa de Valores P2P", "icon": "💼", "branch": "corredor", "pos": Vector2(-210, 160), "prereq": "gate_corredor",
			"cost_pts": 4, "cost_watt": 1.50, "max_lvl": 3,
			"desc": "Reduce la tarifa de comisión por vender en el Mercado P2P del 10% base al 8% / 6% / 4%."
		},
		"cor_contratos": {
			"name": "Negociador de la Red", "icon": "📜", "branch": "corredor", "pos": Vector2(-320, 20), "prereq": "cor_flujo",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Entregar Contratos Diarios otorga un +20% adicional de XP de profesiones por nivel."
		},
		"cor_reserva": {
			"name": "Subsidio Eléctrico", "icon": "🏷️", "branch": "corredor", "pos": Vector2(-300, 90), "prereq": "gate_corredor",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Los Contratos Diarios exigen un 20% menos de Watts para ser completados."
		},
		"cor_ranuras": {
			"name": "Licencia Mercantil", "icon": "🏪", "branch": "corredor", "pos": Vector2(-320, 180), "prereq": "cor_comision",
			"cost_pts": 6, "cost_watt": 2.50, "max_lvl": 3,
			"desc": "Desbloquea 1 espacio adicional simultáneo para publicar ventas en el Mercado P2P."
		},
		"cor_inversor": {
			"name": "Especulación de Red", "icon": "📈", "branch": "corredor", "pos": Vector2(-420, 30), "prereq": "cor_contratos",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Reduce el tiempo de bloqueo de calibración de Watts/kW de 6 horas a 4 horas."
		},
		"cor_maestria": {
			"name": "Magnate de la Central", "icon": "🏦", "branch": "corredor", "pos": Vector2(-420, 150), "prereq": "cor_ranuras",
			"cost_pts": 8, "cost_watt": 4.00, "max_lvl": 3,
			"desc": "Al completar los 3 contratos diarios, recibes un bono directo de 1 Ficha de Casino adicional."
		},
		"cor_apex": {
			"name": "Monopolio Eléctrico", "icon": "👑", "branch": "corredor", "pos": Vector2(-500, 90), "prereq": "cor_reserva",
			"cost_pts": 12, "cost_watt": 6.00, "max_lvl": 1,
			"desc": "TALENTO MAESTRO: Las ventas que realices en el Mercado P2P quedan completamente libres de comisión (0% tarifa)."
		}
	}

# ====================================================================
# CONSTRUCCIÓN DE LA INTERFAZ
# ====================================================================
func _build_ui_layout() -> void:
	for child in get_children(): child.queue_free()
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	# 1. Fondo
	var bg := ColorRect.new()
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	bg.color = Color(0.03, 0.04, 0.06, 1.0)
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)

	# 2. Lienzo Interactivo con Pan & Zoom
	canvas_view = Control.new()
	canvas_view.name = "CanvasView"
	canvas_view.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas_view.mouse_filter = Control.MOUSE_FILTER_PASS
	add_child(canvas_view)

	circuit_drawer = Control.new()
	circuit_drawer.name = "CircuitDrawer"
	circuit_drawer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	circuit_drawer.mouse_filter = Control.MOUSE_FILTER_PASS
	circuit_drawer.draw.connect(_draw_tree_canvas)
	canvas_view.add_child(circuit_drawer)

	# 3. TopBar HUD
	var top_panel := PanelContainer.new()
	top_panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top_panel.offset_bottom = 54.0
	var tp_st := StyleBoxFlat.new()
	tp_st.bg_color = Color(0.06, 0.08, 0.12, 0.95)
	tp_st.border_width_bottom = 2
	tp_st.border_color = Color(0.2, 0.5, 0.8, 0.8)
	top_panel.add_theme_stylebox_override("panel", tp_st)

	var tm := MarginContainer.new()
	tm.add_theme_constant_override("margin_left", 20); tm.add_theme_constant_override("margin_right", 20)
	top_panel.add_child(tm)

	var thbox := HBoxContainer.new()
	thbox.add_theme_constant_override("separation", 16)
	tm.add_child(thbox)

	var title := Label.new()
	title.text = "⚡ CONSTELACIÓN DE TALENTOS"
	title.add_theme_font_size_override("font_size", 16)
	title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	thbox.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	thbox.add_child(sp)

	points_label = Label.new()
	points_label.text = "🏅 Puntos: 0"
	points_label.add_theme_font_size_override("font_size", 13)
	points_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	thbox.add_child(points_label)

	watt_label = Label.new()
	watt_label.text = "⚡ Watts: 0.000"
	watt_label.add_theme_font_size_override("font_size", 13)
	watt_label.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
	thbox.add_child(watt_label)

	var btn_center := Button.new()
	btn_center.text = "🎯 Centrar"
	btn_center.custom_minimum_size = Vector2(80, 30)
	btn_center.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_center.pressed.connect(func():
		tree_offset = Vector2(460, 360)
		tree_zoom = 0.95
		circuit_drawer.queue_redraw()
	)
	thbox.add_child(btn_center)

	var close_btn := Button.new()
	close_btn.text = "✕ Salir"
	close_btn.custom_minimum_size = Vector2(70, 30)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): visible = false)
	thbox.add_child(close_btn)
	add_child(top_panel)

	# 4. Inspector Lateral Fijo (A la derecha)
	_build_inspector_card()

func _build_inspector_card() -> void:
	inspector_panel = PanelContainer.new()
	inspector_panel.name = "InspectorCard"
	inspector_panel.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	inspector_panel.anchor_left = 1.0
	inspector_panel.offset_left = -340.0
	inspector_panel.offset_top = 64.0
	inspector_panel.offset_bottom = -20.0
	inspector_panel.offset_right = -16.0
	inspector_panel.mouse_filter = Control.MOUSE_FILTER_STOP

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.14, 0.98)
	p_st.border_width_left = 2; p_st.border_width_top = 2; p_st.border_width_bottom = 2; p_st.border_width_right = 2
	p_st.border_color = Color(0.35, 0.88, 1.0, 0.9)
	p_st.set_corner_radius_all(10)
	p_st.shadow_color = Color(0.1, 0.5, 0.8, 0.3); p_st.shadow_size = 12
	inspector_panel.add_theme_stylebox_override("panel", p_st)

	var im := MarginContainer.new()
	im.add_theme_constant_override("margin_left", 16); im.add_theme_constant_override("margin_right", 16)
	im.add_theme_constant_override("margin_top", 16); im.add_theme_constant_override("margin_bottom", 16)
	inspector_panel.add_child(im)

	var ivbox := VBoxContainer.new()
	ivbox.add_theme_constant_override("separation", 10)
	im.add_child(ivbox)

	insp_branch = Label.new()
	insp_branch.text = "RAMA: CORE"
	insp_branch.add_theme_font_size_override("font_size", 11)
	insp_branch.add_theme_color_override("font_color", Color(0.5, 0.7, 0.9))
	ivbox.add_child(insp_branch)

	insp_title = Label.new()
	insp_title.text = "Núcleo de Operador"
	insp_title.add_theme_font_size_override("font_size", 16)
	insp_title.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
	ivbox.add_child(insp_title)

	insp_level = Label.new()
	insp_level.text = "Nivel: 0 / 1"
	insp_level.add_theme_font_size_override("font_size", 12)
	insp_level.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	ivbox.add_child(insp_level)

	var hsep := HSeparator.new()
	ivbox.add_child(hsep)

	insp_desc = Label.new()
	insp_desc.text = "Descripción..."
	insp_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	insp_desc.size_flags_vertical = Control.SIZE_EXPAND_FILL
	insp_desc.add_theme_font_size_override("font_size", 12)
	insp_desc.add_theme_color_override("font_color", Color(0.85, 0.9, 0.98))
	ivbox.add_child(insp_desc)

	insp_req = Label.new()
	insp_req.text = "★ Talento Inicial del Sistema"
	insp_req.add_theme_font_size_override("font_size", 11)
	ivbox.add_child(insp_req)

	insp_cost = Label.new()
	insp_cost.text = "Coste: 2 Puntos | 0.500 Watts"
	insp_cost.add_theme_font_size_override("font_size", 11)
	ivbox.add_child(insp_cost)

	status_lbl = Label.new()
	status_lbl.text = ""
	status_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_lbl.add_theme_font_size_override("font_size", 11)
	status_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
	ivbox.add_child(status_lbl)

	insp_buy_btn = Button.new()
	insp_buy_btn.text = "⚡ APRENDER TALENTO"
	insp_buy_btn.custom_minimum_size = Vector2(0, 44)
	insp_buy_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	insp_buy_btn.pressed.connect(_on_upgrade_clicked)
	ivbox.add_child(insp_buy_btn)

	add_child(inspector_panel)

# ====================================================================
# PAN, ZOOM Y CLIC EN EL ÁRBOL
# ====================================================================
func _input(event: InputEvent) -> void:
	if not visible: return

	# Evitar arrastrar si el clic está sobre el panel lateral o la barra superior
	var mouse_p = get_viewport().get_mouse_position()
	if mouse_p.y <= 56.0 or mouse_p.x >= (get_viewport_rect().size.x - 360.0):
		if event is InputEventMouseButton and not event.pressed:
			is_dragging = false
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				drag_start_mouse = event.position
				drag_start_offset = tree_offset
				_check_node_click(event.position)
			else:
				is_dragging = false
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_set_tree_zoom(tree_zoom * 1.12, event.position)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_set_tree_zoom(tree_zoom * 0.88, event.position)

	elif event is InputEventMouseMotion and is_dragging:
		tree_offset = drag_start_offset + (event.position - drag_start_mouse)
		circuit_drawer.queue_redraw()

func _set_tree_zoom(new_z: float, center_pt: Vector2) -> void:
	var clamped_z = clampf(new_z, 0.6, 1.6)
	var content_pt = (center_pt - tree_offset) / tree_zoom
	tree_zoom = clamped_z
	tree_offset = center_pt - (content_pt * tree_zoom)
	circuit_drawer.queue_redraw()

func _check_node_click(screen_pos: Vector2) -> void:
	var world_pos = (screen_pos - tree_offset) / tree_zoom
	for nid in nodes_data.keys():
		var n = nodes_data[nid]
		if world_pos.distance_to(n["pos"]) <= 28.0:
			_inspect_node(nid)
			return

# ====================================================================
# DIBUJO ESTELAR COMPLETO (TODOS LOS 28 NODOS VISIBLES)
# ====================================================================
func _draw_tree_canvas() -> void:
	# 1. Rótulos grandes de las 3 ramas flotando en el fondo
	var font = ThemeDB.fallback_font
	var north_lbl_pos = tree_offset + (Vector2(0, -560) * tree_zoom)
	circuit_drawer.draw_string(font, north_lbl_pos + Vector2(-110 * tree_zoom, 0), "🧲 RAMA CHATARRERO", HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color(1.0, 0.45, 0.15, 0.7))

	var east_lbl_pos = tree_offset + (Vector2(450, 230) * tree_zoom)
	circuit_drawer.draw_string(font, east_lbl_pos, "⚙️ RAMA INGENIERO", HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color(0.15, 0.75, 1.0, 0.7))

	var west_lbl_pos = tree_offset + (Vector2(-550, 230) * tree_zoom)
	circuit_drawer.draw_string(font, west_lbl_pos, "💡 RAMA CORREDOR", HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color(1.0, 0.85, 0.2, 0.7))

	# 2. Dibujar líneas de conexión entre nodos
	for nid in nodes_data.keys():
		var n = nodes_data[nid]
		var prereq_id = str(n["prereq"])
		if prereq_id != "" and nodes_data.has(prereq_id):
			var parent = nodes_data[prereq_id]
			var start_pt = tree_offset + (parent["pos"] * tree_zoom)
			var end_pt = tree_offset + (n["pos"] * tree_zoom)

			var child_unlocked = (GameManager.get_talent_level(nid) > 0)
			var parent_unlocked = (GameManager.get_talent_level(prereq_id) > 0)

			var line_col: Color
			var line_width: float = 2.0 * tree_zoom

			if child_unlocked:
				line_col = _get_branch_color(n["branch"])
				line_width = 3.5 * tree_zoom
			elif parent_unlocked:
				line_col = _get_branch_color(n["branch"]).lerp(Color(0.2, 0.3, 0.4), 0.5)
				line_width = 2.0 * tree_zoom
			else:
				line_col = Color(0.18, 0.22, 0.30, 0.4) # Visible tenue para ver el camino
				line_width = 1.5 * tree_zoom

			circuit_drawer.draw_line(start_pt, end_pt, line_col, line_width, true)

	# 3. Dibujar los 28 nodos estelares
	for nid in nodes_data.keys():
		var n = nodes_data[nid]
		var center_pt = tree_offset + (n["pos"] * tree_zoom)
		var lvl = GameManager.get_talent_level(nid)
		var is_unlocked = (lvl > 0)
		var prereq_id = str(n["prereq"])
		var can_unlock = (prereq_id == "" or GameManager.get_talent_level(prereq_id) > 0)
		var is_selected = (selected_node_id == nid)
		var branch_col = _get_branch_color(n["branch"])

		var radius = 22.0 * tree_zoom
		if nid == "core_root": radius = 28.0 * tree_zoom
		elif nid.begins_with("gate_"): radius = 25.0 * tree_zoom

		# Resplandor de selección
		if is_selected:
			circuit_drawer.draw_circle(center_pt, radius + (6.0 * tree_zoom), Color(1, 1, 1, 0.25))
			circuit_drawer.draw_arc(center_pt, radius + (5.0 * tree_zoom), 0, TAU, 32, Color.WHITE, 2.0 * tree_zoom, true)

		# Color de fondo del nodo
		var fill_col: Color
		if is_unlocked:
			fill_col = branch_col.lerp(Color(0.04, 0.06, 0.10), 0.45)
		elif can_unlock:
			fill_col = Color(0.10, 0.14, 0.22, 0.95) # Disponible
		else:
			fill_col = Color(0.06, 0.08, 0.12, 0.85) # Bloqueado tenue

		var border_col: Color
		if is_unlocked:
			border_col = branch_col
		elif can_unlock:
			border_col = branch_col.lerp(Color.WHITE, 0.3) # Brillo listo para comprar
		else:
			border_col = Color(0.25, 0.30, 0.40, 0.5)

		circuit_drawer.draw_circle(center_pt, radius, fill_col)
		circuit_drawer.draw_arc(center_pt, radius, 0, TAU, 32, border_col, (2.5 if can_unlock else 1.5) * tree_zoom, true)

		# Icono del nodo en el centro
		var icon_str = str(n.get("icon", "★"))
		circuit_drawer.draw_string(font, center_pt + Vector2(-8 * tree_zoom, 5 * tree_zoom), icon_str, HORIZONTAL_ALIGNMENT_CENTER, -1, int(14 * tree_zoom), Color.WHITE if (is_unlocked or can_unlock) else Color(0.5, 0.55, 0.65))

		# Indicador de nivel debajo del nodo (ej: 0/3)
		var max_lvl = int(n["max_lvl"])
		var lvl_str = "%d/%d" % [lvl, max_lvl]
		if nid == "core_root" or max_lvl == 1:
			lvl_str = "✓" if is_unlocked else ""
		if lvl_str != "":
			circuit_drawer.draw_string(font, center_pt + Vector2(-10 * tree_zoom, 18 * tree_zoom), lvl_str, HORIZONTAL_ALIGNMENT_CENTER, -1, int(9 * tree_zoom), branch_col if is_unlocked else Color(0.6, 0.7, 0.8))

func _get_branch_color(b: String) -> Color:
	match b:
		"core": return Color(0.35, 0.88, 1.0)
		"chatarrero": return Color(1.0, 0.45, 0.15)
		"ingeniero": return Color(0.15, 0.75, 1.0)
		"corredor": return Color(1.0, 0.85, 0.2)
		_: return Color.WHITE

# ====================================================================
# INSPECTOR LATERAL Y COMPRA
# ====================================================================
func _inspect_node(node_id: String) -> void:
	if not nodes_data.has(node_id): return
	selected_node_id = node_id

	var n = nodes_data[node_id]
	var cur_lvl = GameManager.get_talent_level(node_id)
	var max_lvl = int(n["max_lvl"])
	var is_max = (cur_lvl >= max_lvl)
	var prereq_id = str(n["prereq"])

	var prereq_ok = (prereq_id == "" or GameManager.get_talent_level(prereq_id) > 0)
	var cost_pts = int(n["cost_pts"]) * (cur_lvl + 1)
	var cost_w = float(n["cost_watt"]) * (cur_lvl + 1)

	insp_title.text = str(n["name"])
	insp_branch.text = "RAMA: " + str(n["branch"]).to_upper()
	insp_branch.add_theme_color_override("font_color", _get_branch_color(n["branch"]))
	insp_level.text = "Nivel: %d / %d" % [cur_lvl, max_lvl]
	insp_desc.text = str(n["desc"])

	if prereq_id != "":
		var p_name = nodes_data.get(prereq_id, {}).get("name", "Anterior")
		insp_req.text = "✓ Requiere: " + p_name if prereq_ok else "🔒 Requiere: " + p_name
		insp_req.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if prereq_ok else Color(1.0, 0.4, 0.4))
	else:
		insp_req.text = "★ Talento Inicial del Sistema"
		insp_req.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))

	if is_max:
		insp_cost.text = "✓ MÁXIMO NIVEL ALCANZADO"
		insp_cost.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
		insp_buy_btn.text = "✓ APRENDIDO"
		insp_buy_btn.disabled = true
	else:
		var can_afford = (GameManager.talent_points >= cost_pts) and (GameManager.watt >= cost_w) and prereq_ok
		insp_cost.text = "Coste: %d Puntos de Talento | %.3f Watts" % [cost_pts, cost_w]
		insp_cost.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_afford else Color(1.0, 0.45, 0.45))
		
		insp_buy_btn.text = "⚡ APRENDER (NIVEL %d)" % (cur_lvl + 1)
		insp_buy_btn.disabled = not can_afford

	circuit_drawer.queue_redraw()

func _on_upgrade_clicked() -> void:
	if not nodes_data.has(selected_node_id): return
	var n = nodes_data[selected_node_id]
	var cur_lvl = GameManager.get_talent_level(selected_node_id)
	var cost_pts = int(n["cost_pts"]) * (cur_lvl + 1)
	var cost_w = float(n["cost_watt"]) * (cur_lvl + 1)
	var prereq_id = str(n["prereq"])

	insp_buy_btn.disabled = true
	status_lbl.text = "Enviando solicitud a la central..."
	status_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	
	print("[Talentos] Intentando mejorar: ", selected_node_id, " | Coste: ", cost_pts, " pts, ", cost_w, " W")

	var res = await GameManager.upgrade_talent_secure(selected_node_id, str(n["branch"]), cost_pts, cost_w, prereq_id)
	print("[Talentos] Respuesta del servidor: ", res)

	if res.get("success", false):
		status_lbl.text = "✓ ¡Talento desbloqueado con éxito!"
		status_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
		_update_hud_counters()
		_inspect_node(selected_node_id)
		circuit_drawer.queue_redraw()
		talents_updated.emit()
	else:
		# Mostrar el error exacto recibido sin borrarlo
		var err_msg = str(res.get("error", "Error desconocido"))
		status_lbl.text = "⚠️ " + err_msg
		status_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
		insp_buy_btn.disabled = false

func _update_hud_counters() -> void:
	if points_label: points_label.text = "🏅 Puntos de Talento: %d" % GameManager.talent_points
	if watt_label: watt_label.text = "⚡ Watts: %.3f" % GameManager.watt
```

---

####### 📄 Archivo: `talent_tree_modal.gd.uid`

```
uid://b6tdg1875vuhy

```

---

###### 📁 Carpeta: `./features\progression\tournament/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `event_leaderboard.gd`

```
# res://features/progression/tournament/event_leaderboard.gd
extends Control

var timer_label: Label
var close_btn: Button
var rows_container: VBoxContainer
var user_rank_lbl: Label
var user_power_lbl: Label
var user_diff_lbl: Label
var refresh_btn: Button
var event_remaining_seconds: int = 0
var clock_timer: float = 0.0

func _ready() -> void:
	_build_ui_layout()
	_fetch_leaderboard()

func _build_ui_layout() -> void:
	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.04, 0.05, 0.08, 1.0)
	add_child(overlay)

	var canvas := CanvasLayer.new()
	add_child(canvas)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(center)

	var main_panel := PanelContainer.new()
	main_panel.custom_minimum_size = Vector2(1100, 620)
	center.add_child(main_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_top", 18)
	margin.add_theme_constant_override("margin_right", 20); margin.add_theme_constant_override("margin_bottom", 18)
	main_panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 14)
	margin.add_child(vbox)

	var header := HBoxContainer.new()
	var title := Label.new()
	title.text = "⚡ COMPETENCIA DE POTENCIA"
	title.add_theme_font_size_override("font_size", 22)
	title.add_theme_color_override("font_color", Color(1.0, 0.88, 0.2))
	header.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(sp)

	timer_label = Label.new()
	timer_label.text = "TIEMPO RESTANTE: --"
	header.add_child(timer_label)

	close_btn = Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(36, 36)
	close_btn.pressed.connect(func():
		get_tree().change_scene_to_file("res://features/room/main_room.tscn")
	)
	header.add_child(close_btn)
	vbox.add_child(header)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	rows_container = VBoxContainer.new()
	rows_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(rows_container)

func _process(delta: float) -> void:
	clock_timer += delta
	if clock_timer >= 1.0:
		clock_timer = 0.0
		if event_remaining_seconds > 0:
			event_remaining_seconds -= 1
			_update_timer()

@warning_ignore("integer_division")
func _update_timer() -> void:
	var d = event_remaining_seconds / 86400
	var h = (event_remaining_seconds % 86400) / 3600
	var m = (event_remaining_seconds % 3600) / 60
	var s = event_remaining_seconds % 60
	timer_label.text = "TIEMPO: %dd %02d:%02d:%02d" % [d, h, m, s]

func _fetch_leaderboard() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_power_competition_leaderboard", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res["data"]) == TYPE_DICTIONARY and res["data"].get("success", false):
		var data = res["data"]
		event_remaining_seconds = int(data.get("remaining_seconds", 0))
		_update_timer()
		_build_rows(data.get("leaderboard", []))

func _build_rows(leaderboard: Array) -> void:
	for child in rows_container.get_children(): child.queue_free()
	for item in leaderboard:
		var row := HBoxContainer.new()
		var p_lbl := Label.new()
		p_lbl.text = "#%d %s" % [int(item.get("position", 1)), str(item.get("username", ""))]
		p_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(p_lbl)
		
		var kw_lbl := Label.new()
		kw_lbl.text = "%.9f KWP" % float(item.get("power", 0.0))
		row.add_child(kw_lbl)
		rows_container.add_child(row)

```

---

####### 📄 Archivo: `event_leaderboard.gd.uid`

```
uid://dge4afnjnf2f2

```

---

####### 📄 Archivo: `event_leaderboard.tscn`

```
[gd_scene format=3 uid="uid://dpsfd214jrc8l"]

[ext_resource type="Script" path="res://features/progression/tournament/event_leaderboard.gd" id="1_evleader"]

[node name="EventLeaderboard" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_evleader")
```

---

##### 📁 Carpeta: `./features\room/`

###### 📄 Archivo: `.gitkeep`

```

```

---

###### 📄 Archivo: `main_room.gd`

```
# res://features/room/main_room.gd
extends Node2D

# Componentes Principales de Escena
var room_hud: Node = null
var room_grid: Node = null
var room_background: TextureRect = null
var room_alert_toast: PanelContainer = null
var alert_tween: Tween = null

# Modales de la Escena
var power_split_modal: Control = null
var extraction_modal: Control = null
var rack_manage_dialog: Node = null
var referral_modal: Control = null
var battle_pass_screen: Control = null
var bg_selector_modal: Node = null
var taller_modal: Control = null

# Modal de Selección de Estanterías en el Suelo
var rack_select_modal: Control = null
var rack_select_list: VBoxContainer = null
var rack_select_title: Label = null
var current_target_slot: int = -1

# Botón de Evento Semanal
var event_btn: BaseButton = null
var event_btn_container: Control = null

# Menú Lateral Izquierdo Desplegable (Navegación)
var drawer_root: Control = null
var drawer_is_open: bool = false
var drawer_width: float = 210.0
var drawer_tween: Tween = null
var drawer_tab_btn: Button = null
var drawer_bg_btn: Button = null
var talent_modal: Control = null

# Menú Lateral Derecho Desplegable (Almacén)
var inv_root: Control = null
var inv_is_open: bool = false
var inv_width: float = 290.0
var inv_tween: Tween = null
var inv_tab_btn: Button = null
var inv_list_container: VBoxContainer = null
var inv_tab_gens_btn: Button = null
var inv_tab_racks_btn: Button = null
var current_inv_tab: String = "generators"

# Modal Dinámico de Mercado P2P
var market_modal: Control = null
var market_grid: GridContainer = null
var market_status_lbl: Label = null
var market_tab_browse_btn: Button = null
var market_tab_sell_btn: Button = null
var market_tab_my_btn: Button = null
var current_market_view: String = "browse"
var cached_market_listings: Array = []

# Módulo de Chat
var docked_chat_box: PanelContainer = null
var chat_mode_btn: Button = null
var chat_friends_btn: Button = null
var chat_minimize_btn: Button = null
var chat_messages_vbox: VBoxContainer = null
var chat_scroll: ScrollContainer = null
var chat_input: LineEdit = null
var chat_send_btn: Button = null
var chat_body_vbox: VBoxContainer = null

var is_chat_minimized: bool = false
var chat_channel_mode: String = "global"
var active_friend_id: String = ""
var active_friend_name: String = ""
var chat_poll_timer: float = 0.0
var chat_cooldown_left: float = 0.0
var is_fetching_chat: bool = false
var last_chat_hash: String = ""

# Modal de Amigos
var friends_modal: Control = null
var friends_list_vbox: VBoxContainer = null
var friend_req_input: LineEdit = null
var friend_req_status: Label = null

const RACK_VIEW_SCENE: PackedScene = preload("res://features/room/racks/rack_view.tscn")
const GENERATOR_VIEW_SCENE: PackedScene = preload("res://features/room/generators/generator_view.tscn")

const RACK_1_FLOOR_DATA: RackData = preload("res://data/racks/rack_1_floor.tres")
const RACK_2_FLOORS_DATA: RackData = preload("res://data/racks/rack_2_floors.tres")
const RACK_3_FLOORS_DATA: RackData = preload("res://data/racks/rack_3_floors.tres")
const PLANTA_MEME_DATA: GeneratorData = preload("res://data/generators/generator_planta_lvl1.tres")

const WATT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_watt.png")
const KILOWAT_ICON: Texture2D = preload("res://assets/sprites/ui/icon_kilowat.png")

var spawned_racks: Dictionary = {}

func _ready() -> void:
	_force_load_patch_zoom_controller()
	_resolve_nodes()
	_setup_connections()
	_create_sliding_drawer()
	_create_inventory_drawer()
	_create_docked_chat_box()
	_create_friends_modal()
	_create_rack_select_modal()
	_create_market_modal()
	
	# Instanciar el Taller Mecánico de forma segura en memoria para el .pck
	var taller_script = load("res://features/room/taller/taller_modal.gd")
	if taller_script:
		taller_modal = taller_script.new()
		$CanvasLayerUI.add_child(taller_modal)
		taller_modal.workshop_updated.connect(func():
			_render_placed_generators()
			_refresh_inventory_ui()
		)
	
	# Instanciar el Árbol de Talentos
	var talent_script = load("res://features/progression/talents/talent_tree_modal.gd")
	if talent_script:
		talent_modal = talent_script.new()
		$CanvasLayerUI.add_child(talent_modal)
	
	_apply_equipped_background()
	
	await GameManager.load_player_inventory()
	_render_placed_racks()
	_render_placed_generators()
	_refresh_inventory_ui()
	_check_active_event()

func _process(delta: float) -> void:
	_process_chat(delta)

func _force_load_patch_zoom_controller() -> void:
	var root_viewport = get_tree().root
	
	# 1. Si ya existe uno activo y válido, no crearlo de nuevo
	var existing = root_viewport.get_node_or_null("GlobalZoomController")
	if existing and is_instance_valid(existing):
		return

	# 2. Limpiar residuos antes de instanciar
	for child in root_viewport.get_children():
		if child.name.begins_with("OldZoom") or child.name == "GlobalZoomController":
			child.queue_free()

	# 3. Cargar el script nuevo del .pck ignorando caché
	var z_path := "res://features/room/controls/zoom_controller.gd"
	if ResourceLoader.exists(z_path):
		var z_script = ResourceLoader.load(z_path, "", ResourceLoader.CACHE_MODE_REPLACE)
		if z_script:
			var new_zoom = z_script.new()
			new_zoom.name = "GlobalZoomController"
			root_viewport.add_child(new_zoom)

func _resolve_nodes() -> void:
	room_hud = find_child("RoomHUD", true, false)
	if room_hud == null: room_hud = find_child("HUD", true, false)
	
	room_grid = find_child("RoomGrid", true, false)
	room_background = find_child("RoomBackground", true, false) as TextureRect
	
	event_btn = _find_button(["EventButton", "EventBtn"])
	event_btn_container = find_child("EventButtonContainer", true, false) as Control
	
	if event_btn_container:
		event_btn_container.offset_top = -320.0
		event_btn_container.offset_bottom = -245.0
		event_btn_container.visible = false
	elif event_btn:
		event_btn.visible = false
	
	power_split_modal = find_child("PowerSplitModal", true, false) as Control
	extraction_modal = find_child("ExtractionModal", true, false) as Control
	rack_manage_dialog = find_child("RackManageDialog", true, false)
	referral_modal = find_child("ReferralModal", true, false) as Control
	battle_pass_screen = find_child("BattlePassScreen", true, false) as Control
	bg_selector_modal = find_child("BgSelectorModal", true, false)

func _find_button(names: Array) -> BaseButton:
	for n in names:
		var node = find_child(n, true, false)
		if node is BaseButton: return node
	return null

func _setup_connections() -> void:
	if room_hud:
		if room_hud.has_signal("split_requested") and power_split_modal:
			var split_cb = func():
				_close_all_drawers()
				if power_split_modal.has_method("open_modal"): power_split_modal.open_modal()
				else: power_split_modal.visible = true
			if not room_hud.split_requested.is_connected(split_cb):
				room_hud.split_requested.connect(split_cb)

		if room_hud.has_signal("extract_requested") and extraction_modal:
			var extract_cb = func():
				_close_all_drawers()
				if extraction_modal.has_method("open_modal"): extraction_modal.open_modal()
				else: extraction_modal.visible = true
			if not room_hud.extract_requested.is_connected(extract_cb):
				room_hud.extract_requested.connect(extract_cb)
	
	if bg_selector_modal and bg_selector_modal.has_signal("background_changed"):
		var bg_cb = func(_id): _apply_equipped_background()
		if not bg_selector_modal.background_changed.is_connected(bg_cb):
			bg_selector_modal.background_changed.connect(bg_cb)
			
	if event_btn:
		var ev_cb = func(): get_tree().change_scene_to_file("res://features/progression/tournament/event_leaderboard.tscn")
		if not event_btn.pressed.is_connected(ev_cb):
			event_btn.pressed.connect(ev_cb)
	
	if rack_manage_dialog:
		if rack_manage_dialog.has_signal("generator_unmounted") and not rack_manage_dialog.generator_unmounted.is_connected(_on_generator_unmounted):
			rack_manage_dialog.generator_unmounted.connect(_on_generator_unmounted)
		if rack_manage_dialog.has_signal("generator_mounted") and not rack_manage_dialog.generator_mounted.is_connected(_on_generator_mounted):
			rack_manage_dialog.generator_mounted.connect(_on_generator_mounted)
	
	if room_grid:
		if room_grid.has_signal("slot_selected") and not room_grid.slot_selected.is_connected(_on_slot_clicked):
			room_grid.slot_selected.connect(_on_slot_clicked)
		if room_grid.has_signal("rack_hold_unmounted") and not room_grid.rack_hold_unmounted.is_connected(_on_rack_hold_unmounted):
			room_grid.rack_hold_unmounted.connect(_on_rack_hold_unmounted)

func _check_active_event() -> void:
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_power_competition_leaderboard", HTTPClient.METHOD_POST, {}, true)
	var has_event: bool = false
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY:
		has_event = bool(res["data"].get("success", false))
	if event_btn_container: event_btn_container.visible = has_event
	elif event_btn: event_btn.visible = has_event

func _apply_equipped_background() -> void:
	if room_background == null: return
	var bg_id: String = GameManager.equipped_background
	var path: String = "res://assets/sprites/room/room_background.png"
	if bg_id == "bunker_solar": path = "res://assets/sprites/room/bg_bunker_solar.png"
	elif bg_id == "habitacion_taller": path = "res://assets/sprites/room/bg_habitacion_taller.png"
	if ResourceLoader.exists(path): room_background.texture = load(path)

func _close_all_drawers() -> void:
	if drawer_is_open: _close_drawer()
	if inv_is_open: _close_inventory_drawer()
	if market_modal and market_modal.visible: market_modal.visible = false
	if friends_modal and friends_modal.visible: friends_modal.visible = false
	if taller_modal and taller_modal.visible: taller_modal.visible = false

# ====================================================================
# MENÚ LATERAL IZQUIERDO DESPLEGABLE
# ====================================================================

func _create_sliding_drawer() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	var old_sidebar = find_child("LeftSidebar", true, false)
	if old_sidebar: old_sidebar.visible = false

	drawer_root = Control.new()
	drawer_root.name = "SlidingSideDrawer"
	drawer_root.position = Vector2(-drawer_width, 95.0)
	drawer_root.size = Vector2(drawer_width, 430.0)

	var panel := PanelContainer.new()
	panel.name = "MenuPanel"
	panel.size = Vector2(drawer_width, 430.0)
	panel.custom_minimum_size = Vector2(drawer_width, 430.0)

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	p_st.border_color = Color(0.25, 0.55, 0.85, 0.9)
	p_st.border_width_right = 2
	p_st.border_width_top = 2
	p_st.border_width_bottom = 2
	p_st.corner_radius_top_right = 10
	p_st.corner_radius_bottom_right = 10
	p_st.shadow_color = Color(0.1, 0.45, 0.8, 0.3)
	p_st.shadow_size = 12
	panel.add_theme_stylebox_override("panel", p_st)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 14); margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 12); margin.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	margin.add_child(vbox)

	var title_lbl := Label.new()
	title_lbl.text = "MENÚ"
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_lbl.add_theme_font_size_override("font_size", 13)
	title_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	vbox.add_child(title_lbl)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	var btn_normal := StyleBoxFlat.new()
	btn_normal.bg_color = Color(0.10, 0.13, 0.19, 0.9)
	btn_normal.border_color = Color(0.25, 0.38, 0.55, 0.7)
	btn_normal.set_border_width_all(1)
	btn_normal.set_corner_radius_all(6)

	var btn_hover := StyleBoxFlat.new()
	btn_hover.bg_color = Color(0.14, 0.20, 0.30, 1.0)
	btn_hover.border_color = Color(0.35, 0.88, 1.0, 1.0)
	btn_hover.set_border_width_all(1)
	btn_hover.set_corner_radius_all(6)

	var options = [
		{"id": "taller", "text": "🔧 Taller Mecánico", "color": Color(1.0, 0.85, 0.25)},
		{"id": "talents", "text": "🌳 Árbol de Talentos", "color": Color(0.35, 0.9, 1.0)},
		{"id": "market", "text": "🛒 Mercado P2P", "color": Color(0.3, 0.95, 0.75)},
		{"id": "shop", "text": "Tienda Oficial", "color": Color(0.95, 0.98, 1.0)},
		{"id": "minigames", "text": "Minijuegos", "color": Color(0.95, 0.98, 1.0)},
		{"id": "casino", "text": "Casino", "color": Color(1.0, 0.55, 0.9)},
		{"id": "pass", "text": "Pase de Batalla", "color": Color(1.0, 0.85, 0.2)},
		{"id": "ref", "text": "Referidos", "color": Color(0.4, 0.95, 0.6)},
		{"id": "bg", "text": "Cambiar Fondo", "color": Color(0.85, 0.9, 1.0)}
	]

	for opt in options:
		var b := Button.new()
		b.text = opt["text"]
		b.custom_minimum_size = Vector2(0, 34)
		b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		b.add_theme_stylebox_override("normal", btn_normal)
		b.add_theme_stylebox_override("hover", btn_hover)
		b.add_theme_stylebox_override("pressed", btn_hover)
		b.add_theme_color_override("font_color", opt["color"])
		b.add_theme_font_size_override("font_size", 12)

		var opt_id: String = opt["id"]
		b.pressed.connect(func(): _on_drawer_option_pressed(opt_id))

		if opt_id == "bg":
			drawer_bg_btn = b
			drawer_bg_btn.visible = (GameManager.unlocked_backgrounds.size() > 1)

		vbox.add_child(b)

	drawer_root.add_child(panel)

	drawer_tab_btn = Button.new()
	drawer_tab_btn.name = "DrawerTabButton"
	drawer_tab_btn.text = "▶"
	drawer_tab_btn.position = Vector2(drawer_width, 130.0)
	drawer_tab_btn.custom_minimum_size = Vector2(34, 60)
	drawer_tab_btn.size = Vector2(34, 60)
	drawer_tab_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	var tab_st := StyleBoxFlat.new()
	tab_st.bg_color = Color(0.08, 0.12, 0.18, 0.96)
	tab_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	tab_st.border_width_right = 2
	tab_st.border_width_top = 2
	tab_st.border_width_bottom = 2
	tab_st.corner_radius_top_right = 8
	tab_st.corner_radius_bottom_right = 8
	tab_st.shadow_color = Color(0.15, 0.6, 0.9, 0.4)
	tab_st.shadow_size = 8
	drawer_tab_btn.add_theme_stylebox_override("normal", tab_st)
	drawer_tab_btn.add_theme_stylebox_override("hover", tab_st)
	drawer_tab_btn.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	drawer_tab_btn.add_theme_font_size_override("font_size", 15)
	drawer_tab_btn.pressed.connect(_toggle_drawer)

	drawer_root.add_child(drawer_tab_btn)
	canvas_ui.add_child(drawer_root)

func _toggle_drawer() -> void:
	if drawer_is_open: _close_drawer()
	else: _open_drawer()

func _open_drawer() -> void:
	if inv_is_open: _close_inventory_drawer()
	drawer_is_open = true
	drawer_tab_btn.text = "◀"
	if drawer_bg_btn: drawer_bg_btn.visible = (GameManager.unlocked_backgrounds.size() > 1)
	if drawer_tween and drawer_tween.is_running(): drawer_tween.kill()
	drawer_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	drawer_tween.tween_property(drawer_root, "position:x", 0.0, 0.25)

func _close_drawer() -> void:
	drawer_is_open = false
	drawer_tab_btn.text = "▶"
	if drawer_tween and drawer_tween.is_running(): drawer_tween.kill()
	drawer_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	drawer_tween.tween_property(drawer_root, "position:x", -drawer_width, 0.25)

func _on_drawer_option_pressed(opt_id: String) -> void:
	match opt_id:
		"taller":
			_close_drawer()
			if taller_modal: taller_modal.open_modal()
		"talents":
			_close_drawer()
			if talent_modal: talent_modal.open_modal()
		"market":
			_close_drawer()
			_open_market_modal()
		"shop":
			get_tree().change_scene_to_file("res://features/economy/shop/shop_screen.tscn")
		"minigames":
			get_tree().change_scene_to_file("res://features/minigames/_shared/minigames_hub.tscn")
		"casino":
			get_tree().change_scene_to_file("res://features/casino/mines/casino_hub.tscn")
		"pass":
			_close_drawer()
			if battle_pass_screen: battle_pass_screen.visible = not battle_pass_screen.visible
		"ref":
			_close_drawer()
			if referral_modal:
				if referral_modal.has_method("open_modal"): referral_modal.open_modal()
				else: referral_modal.visible = true
		"bg":
			_close_drawer()
			if bg_selector_modal:
				if bg_selector_modal.has_method("open_modal"): bg_selector_modal.open_modal()
				else: bg_selector_modal.visible = true

# ====================================================================
# MODAL DE SELECCIÓN DE ESTANTERÍA (CREACIÓN Y APERTURA)
# ====================================================================

func _create_rack_select_modal() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	rack_select_modal = Control.new()
	rack_select_modal.name = "RackSelectModal"
	rack_select_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	rack_select_modal.visible = false

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.88)
	rack_select_modal.add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	rack_select_modal.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(540, 420)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.08, 0.10, 0.15, 0.98)
	p_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(12)
	panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 18); margin.add_theme_constant_override("margin_bottom", 18)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 12)
	margin.add_child(vbox)

	var hrow := HBoxContainer.new()
	rack_select_title = Label.new()
	rack_select_title.text = "🗄️ INSTALAR ESTANTERÍA"
	rack_select_title.add_theme_font_size_override("font_size", 17)
	rack_select_title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	hrow.add_child(rack_select_title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hrow.add_child(sp)

	var close_x := Button.new()
	close_x.text = "✕"
	close_x.custom_minimum_size = Vector2(32, 32)
	close_x.pressed.connect(func(): rack_select_modal.visible = false)
	hrow.add_child(close_x)
	vbox.add_child(hrow)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	rack_select_list = VBoxContainer.new()
	rack_select_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rack_select_list.add_theme_constant_override("separation", 10)
	scroll.add_child(rack_select_list)

	canvas_ui.add_child(rack_select_modal)

func _open_rack_select_modal(slot_index: int) -> void:
	_close_all_drawers()
	if rack_select_modal == null: _create_rack_select_modal()
	if rack_select_modal == null: return

	current_target_slot = slot_index
	if rack_select_title: rack_select_title.text = "🗄️ INSTALAR EN ESPACIO #%d" % (slot_index + 1)
	for child in rack_select_list.get_children(): child.queue_free()

	var available_racks: Array = []
	for r in GameManager.player_racks:
		if int(r.get("slot_index", -1)) == -1: available_racks.append(r)

	if available_racks.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No tienes estanterías en tu inventario."
		rack_select_list.add_child(empty_lbl)
	else:
		for r in available_racks:
			var r_data: RackData = _get_rack_data(r)
			var row_panel := PanelContainer.new()
			var rm := MarginContainer.new()
			rm.add_theme_constant_override("margin_left", 12); rm.add_theme_constant_override("margin_right", 12)
			rm.add_theme_constant_override("margin_top", 8); rm.add_theme_constant_override("margin_bottom", 8)
			row_panel.add_child(rm)

			var hbox := HBoxContainer.new()
			hbox.add_theme_constant_override("separation", 14)
			rm.add_child(hbox)

			var name_lbl := Label.new()
			name_lbl.text = r_data.name if r_data else "Estantería"
			name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			hbox.add_child(name_lbl)

			var place_btn := Button.new()
			place_btn.text = "⚡ Colocar aquí"
			place_btn.pressed.connect(_on_rack_selected_from_modal.bind(r, slot_index))
			hbox.add_child(place_btn)

			rack_select_list.add_child(row_panel)

	rack_select_modal.visible = true

func _on_rack_selected_from_modal(chosen_rack: Dictionary, target_slot: int) -> void:
	if rack_select_modal: rack_select_modal.visible = false
	_place_chosen_rack(chosen_rack, target_slot)

func _place_chosen_rack(rack: Dictionary, slot_index: int) -> void:
	for other_rack in GameManager.player_racks:
		if int(other_rack.get("slot_index", -1)) == slot_index and other_rack != rack:
			other_rack["slot_index"] = -1

	rack["slot_index"] = slot_index
	if room_grid: room_grid.set_slot_occupied(slot_index, true)
	_instantiate_rack(rack, slot_index)
	_refresh_inventory_ui()
	
	var r_id = str(rack.get("id", rack.get("rack_id", "")))
	await GameManager.place_rack_in_slot(r_id, slot_index)

# ====================================================================
# MODAL DEL MERCADO P2P (COMPLETO CON ARTÍCULOS Y REPUESTOS)
# ====================================================================

func _create_market_modal() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	market_modal = Control.new()
	market_modal.name = "MarketModal"
	market_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	market_modal.visible = false

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.94)
	market_modal.add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	market_modal.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(980, 600)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.13, 0.98)
	p_st.border_color = Color(0.3, 0.95, 0.75, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(12)
	p_st.shadow_color = Color(0.1, 0.6, 0.45, 0.3)
	p_st.shadow_size = 14
	panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 22); margin.add_theme_constant_override("margin_right", 22)
	margin.add_theme_constant_override("margin_top", 18); margin.add_theme_constant_override("margin_bottom", 18)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 12)
	margin.add_child(vbox)

	var hrow := HBoxContainer.new()
	var title_lbl := Label.new()
	title_lbl.text = "🛒 MERCADO DE JUGADORES (P2P)"
	title_lbl.add_theme_font_size_override("font_size", 18)
	title_lbl.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75))
	hrow.add_child(title_lbl)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hrow.add_child(sp)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(34, 34)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): market_modal.visible = false)
	hrow.add_child(close_btn)
	vbox.add_child(hrow)

	var nav_tabs := HBoxContainer.new()
	nav_tabs.add_theme_constant_override("separation", 10)

	market_tab_browse_btn = Button.new()
	market_tab_browse_btn.text = "🔍 Explorar Ofertas"
	market_tab_browse_btn.custom_minimum_size = Vector2(170, 38)
	market_tab_browse_btn.pressed.connect(func(): current_market_view = "browse"; _refresh_market_view())
	nav_tabs.add_child(market_tab_browse_btn)

	market_tab_sell_btn = Button.new()
	market_tab_sell_btn.text = "📦 Vender mi Inventario"
	market_tab_sell_btn.custom_minimum_size = Vector2(210, 38)
	market_tab_sell_btn.pressed.connect(func(): current_market_view = "sell"; _refresh_market_view())
	nav_tabs.add_child(market_tab_sell_btn)

	market_tab_my_btn = Button.new()
	market_tab_my_btn.text = "📋 Mis Publicaciones"
	market_tab_my_btn.custom_minimum_size = Vector2(170, 38)
	market_tab_my_btn.pressed.connect(func(): current_market_view = "my_sales"; _refresh_market_view())
	nav_tabs.add_child(market_tab_my_btn)
	vbox.add_child(nav_tabs)

	var hsep := HSeparator.new()
	vbox.add_child(hsep)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	market_grid = GridContainer.new()
	market_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	market_grid.columns = 3
	market_grid.add_theme_constant_override("h_separation", 14)
	market_grid.add_theme_constant_override("v_separation", 14)
	scroll.add_child(market_grid)

	market_status_lbl = Label.new()
	market_status_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	market_status_lbl.add_theme_font_size_override("font_size", 12)
	market_status_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	vbox.add_child(market_status_lbl)

	canvas_ui.add_child(market_modal)

func _open_market_modal() -> void:
	_close_all_drawers()
	if market_modal == null: _create_market_modal()
	if market_modal == null: return
	market_modal.visible = true
	current_market_view = "browse"
	_refresh_market_view()

func _refresh_market_view() -> void:
	if market_modal == null: return
	market_status_lbl.text = ""
	market_tab_browse_btn.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75) if current_market_view == "browse" else Color(0.7, 0.75, 0.85))
	market_tab_sell_btn.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75) if current_market_view == "sell" else Color(0.7, 0.75, 0.85))
	market_tab_my_btn.add_theme_color_override("font_color", Color(0.3, 0.95, 0.75) if current_market_view == "my_sales" else Color(0.7, 0.75, 0.85))

	for child in market_grid.get_children(): child.queue_free()

	match current_market_view:
		"browse": _fetch_and_show_browse_listings()
		"sell": _show_sellable_inventory()
		"my_sales": _show_my_listings()

func _fetch_and_show_browse_listings() -> void:
	market_status_lbl.text = "Cargando ofertas activas..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_market_listings", HTTPClient.METHOD_POST, {}, true)
	market_status_lbl.text = ""

	for child in market_grid.get_children(): child.queue_free()

	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		cached_market_listings = res["data"].get("listings", [])
		if cached_market_listings.is_empty():
			var no_lbl := Label.new()
			no_lbl.text = "No hay ofertas de jugadores en el mercado en este momento."
			no_lbl.add_theme_font_size_override("font_size", 13)
			no_lbl.add_theme_color_override("font_color", Color(0.65, 0.7, 0.8))
			market_grid.add_child(no_lbl)
			return

		for l in cached_market_listings:
			var card := PanelContainer.new()
			card.custom_minimum_size = Vector2(285, 180)
			
			var i_type = str(l.get("item_type", ""))
			var sub_type = str(l.get("item_sub_type", ""))
			var p_val = float(l.get("price", 0))
			var cur = str(l.get("currency", "watt"))
			var lid = str(l.get("id", ""))
			var qty = int(l.get("quantity", 1))
			var seller = str(l.get("seller_username", "Jugador"))
			var is_mine = (seller.to_lower() == GameManager.username.to_lower())

			var c_st := StyleBoxFlat.new()
			c_st.bg_color = Color(0.09, 0.12, 0.18, 0.95)
			c_st.border_color = Color(0.3, 0.85, 1.0) if i_type == "generator" else (Color(0.5, 0.6, 1.0) if i_type == "rack" else Color(0.3, 0.95, 0.7))
			c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
			card.add_theme_stylebox_override("panel", c_st)

			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
			cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
			card.add_child(cm)

			var vb := VBoxContainer.new()
			vb.add_theme_constant_override("separation", 5)
			cm.add_child(vb)

			var name_str = ""
			if i_type == "generator": 
				name_str = "⚡ " + _format_gen_name(sub_type)
			elif i_type == "rack": 
				name_str = "🗄️ " + _format_rack_name(sub_type)
			elif i_type == "material": 
				name_str = "📦 %s T%d (Lote x%d)" % [sub_type.capitalize(), int(l.get("part_level", 1)), qty]
			else: 
				name_str = "🔩 %s Nv.%d (Lote x%d)" % [sub_type.capitalize(), int(l.get("part_level", 1)), qty]

			var lbl := Label.new()
			lbl.text = name_str
			lbl.add_theme_font_size_override("font_size", 13)
			lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0))
			vb.add_child(lbl)

			var slbl := Label.new()
			slbl.text = "Vendedor: %s%s" % [seller, " (Tú)" if is_mine else ""]
			slbl.add_theme_font_size_override("font_size", 10)
			slbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.85))
			vb.add_child(slbl)

			var plbl := Label.new()
			plbl.text = "Total: %.4f %s (+10%% comisión)" % [p_val * 1.10, "W" if cur == "watt" else "KW"]
			plbl.add_theme_font_size_override("font_size", 11)
			plbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			vb.add_child(plbl)

			vb.add_spacer(false)

			var buy_b := Button.new()
			buy_b.text = "✕ Eres el vendedor" if is_mine else "⚡ Comprar Artículo"
			buy_b.custom_minimum_size = Vector2(0, 34)
			buy_b.disabled = is_mine
			buy_b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			buy_b.pressed.connect(func():
				buy_b.disabled = true
				var b_res = await SupabaseClient.send_request("/rest/v1/rpc/buy_market_item", HTTPClient.METHOD_POST, {"p_listing_id": lid}, true)
				if b_res.get("success", false) and b_res.get("data", {}).get("success", false):
					market_status_lbl.text = "✓ ¡Compra realizada con éxito!"
					await GameManager.load_profile()
					await GameManager.load_player_inventory()
					_refresh_market_view()
				else:
					market_status_lbl.text = "⚠️ " + str(b_res.get("data", {}).get("error", "Saldo insuficiente o artículo agotado"))
					buy_b.disabled = false
			)
			vb.add_child(buy_b)
			market_grid.add_child(card)

# ====================================================================
# PESTAÑA: VENDER MI INVENTARIO (MATERIALES, REPUESTOS Y GENERADORES)
# ====================================================================
func _show_sellable_inventory() -> void:
	for child in market_grid.get_children(): child.queue_free()
	market_status_lbl.text = "Cargando tus artículos..."
	
	# Cargar inventarios actualizados desde el servidor
	await GameManager.load_player_inventory()
	await GameManager.load_player_rpg_state()
	market_status_lbl.text = ""

	# 1. Filtrar Materiales Brutos desde 1 unidad
	var sellable_materials: Array = []
	for m in GameManager.player_materials:
		if int(m.get("quantity", 0)) >= 1:
			sellable_materials.append(m)

	# 2. Filtrar Generadores desmontados y montados
	var unmounted_gens: Array = []
	var mounted_gens: Array = []
	for g in GameManager.player_generators:
		var is_mounted = (g.get("rack_id") != null and str(g.get("rack_id")) != "" and str(g.get("rack_id")) != "null")
		if not is_mounted:
			unmounted_gens.append(g)
		else:
			mounted_gens.append(g)

	# 3. Filtrar Estanterías en almacén
	var sellable_racks: Array = []
	for r in GameManager.player_racks:
		if int(r.get("slot_index", -1)) == -1:
			sellable_racks.append(r)

	# 4. Filtrar Repuestos y piezas manufacturadas
	var sellable_parts: Array = []
	for p in GameManager.player_parts:
		if int(p.get("quantity", 0)) > 0:
			sellable_parts.append(p)

	# Comprobación de almacén totalmente vacío
	if sellable_materials.is_empty() and unmounted_gens.is_empty() and mounted_gens.is_empty() and sellable_racks.is_empty() and sellable_parts.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "Tu almacén está vacío. Juega minijuegos para recolectar materiales o craftea piezas para venderlas aquí."
		empty_lbl.add_theme_font_size_override("font_size", 13)
		market_grid.add_child(empty_lbl)
		return

	# --- RENDERIZADO DE ARTÍCULOS EN VENTA ---

	# A. Lotes de Materiales Brutos (Cobre, Silicio, Plástico, Hierro)
	for m in sellable_materials:
		var mtype = str(m.get("material_type", ""))
		var mtier = int(m.get("tier", 1))
		var mqty = int(m.get("quantity", 0))
		market_grid.add_child(_build_sell_material_card(mtype, mtier, mqty))

	# B. Repuestos de taller manufacturados
	for p in sellable_parts:
		var ptype = str(p.get("part_type", ""))
		var plvl = int(p.get("part_level", 1))
		var pqty = int(p.get("quantity", 1))
		market_grid.add_child(_build_sell_part_card(ptype, plvl, pqty))

	# C. Generadores en almacén (listos para publicar)
	for g in unmounted_gens:
		var gid = str(g.get("id", ""))
		var gtype = str(g.get("generator_type", ""))
		market_grid.add_child(_build_sell_item_card("generator", gid, "⚡ " + _format_gen_name(gtype)))

	# D. Generadores instalados en estanterías (opción de desmontar)
	for g in mounted_gens:
		var gid = str(g.get("id", ""))
		var gtype = str(g.get("generator_type", ""))
		market_grid.add_child(_build_mounted_gen_card(gid, _format_gen_name(gtype)))

	# E. Estanterías en almacén
	for r in sellable_racks:
		var rid = str(r.get("id", ""))
		var rtype = str(r.get("rack_type", ""))
		market_grid.add_child(_build_sell_item_card("rack", rid, "🗄️ " + _format_rack_name(rtype)))

func _build_mounted_gen_card(gen_id: String, gen_name: String) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 175)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.12, 0.10, 0.08, 0.95)
	c_st.border_color = Color(1.0, 0.6, 0.2, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 6)
	cm.add_child(vb)

	var title := Label.new()
	title.text = "⚡ " + gen_name
	title.add_theme_font_size_override("font_size", 13)
	vb.add_child(title)

	var desc := Label.new()
	desc.text = "Esta planta está activa en tu estantería. Desmóntala para poder venderla."
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.add_theme_font_size_override("font_size", 10)
	desc.add_theme_color_override("font_color", Color(1.0, 0.75, 0.3))
	vb.add_child(desc)

	vb.add_spacer(false)

	var unmount_btn := Button.new()
	unmount_btn.text = "📦 Desmontar al Almacén"
	unmount_btn.custom_minimum_size = Vector2(0, 34)
	unmount_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	unmount_btn.pressed.connect(func():
		unmount_btn.disabled = true
		await GameManager.unmount_generator(gen_id)
		await GameManager.load_player_inventory()
		_render_placed_generators()
		_show_sellable_inventory()
	)
	vb.add_child(unmount_btn)
	return card

func _build_sell_item_card(item_type: String, item_id: String, display_name: String) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 185)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
	c_st.border_color = Color(0.35, 0.88, 1.0, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 6)
	cm.add_child(vb)

	var title := Label.new()
	title.text = display_name
	title.add_theme_font_size_override("font_size", 13)
	vb.add_child(title)

	var input_row := HBoxContainer.new()
	input_row.add_theme_constant_override("separation", 6)

	var price_in := LineEdit.new()
	price_in.placeholder_text = "Precio"
	price_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input_row.add_child(price_in)

	var cur_opt := OptionButton.new()
	cur_opt.add_item("WATT", 0)
	cur_opt.add_item("KILOWAT", 1)
	input_row.add_child(cur_opt)
	vb.add_child(input_row)

	var fee_lbl := Label.new()
	fee_lbl.text = "Tasa (10%): 0.00"
	fee_lbl.add_theme_font_size_override("font_size", 10)
	fee_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	vb.add_child(fee_lbl)

	price_in.text_changed.connect(func(t):
		var p = float(t)
		var c = "WATT" if cur_opt.selected == 0 else "KILOWAT"
		fee_lbl.text = "Tasa (10%%): %.4f %s" % [p * 0.10, c]
	)

	var btn_pub := Button.new()
	btn_pub.text = "🚀 Publicar Venta"
	btn_pub.custom_minimum_size = Vector2(0, 34)
	btn_pub.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_pub.pressed.connect(func():
		var p_val = float(price_in.text)
		if p_val <= 0.0:
			market_status_lbl.text = "⚠️ El precio debe ser mayor a 0."
			return
		btn_pub.disabled = true
		var cur_str = "watt" if cur_opt.selected == 0 else "kilowat"
		var body = {"p_item_type": item_type, "p_item_id": item_id, "p_price": p_val, "p_currency": cur_str}
		var pub_res = await SupabaseClient.send_request("/rest/v1/rpc/publish_market_item", HTTPClient.METHOD_POST, body, true)
		if pub_res.get("success", false) and pub_res.get("data", {}).get("success", false):
			market_status_lbl.text = "✓ ¡Artículo publicado en el mercado!"
			await GameManager.load_player_inventory()
			_show_sellable_inventory()
		else:
			market_status_lbl.text = "⚠️ " + str(pub_res.get("data", {}).get("error", "Error al publicar"))
			btn_pub.disabled = false
	)
	vb.add_child(btn_pub)
	return card

func _build_sell_part_card(part_type: String, part_lvl: int, max_stock: int) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 205)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
	c_st.border_color = Color(0.3, 0.95, 0.75, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 5)
	cm.add_child(vb)

	var title := Label.new()
	title.text = "🔩 %s Nv.%d (Tienes: %d)" % [part_type.capitalize(), part_lvl, max_stock]
	title.add_theme_font_size_override("font_size", 13)
	title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	vb.add_child(title)

	var qty_row := HBoxContainer.new()
	var qty_lbl := Label.new()
	qty_lbl.text = "Cantidad a vender:"
	qty_lbl.add_theme_font_size_override("font_size", 11)
	qty_row.add_child(qty_lbl)

	var qty_spin := SpinBox.new()
	qty_spin.min_value = 1
	qty_spin.max_value = max_stock
	qty_spin.value = 1
	qty_row.add_child(qty_spin)
	vb.add_child(qty_row)

	var input_row := HBoxContainer.new()
	var price_in := LineEdit.new()
	price_in.placeholder_text = "Precio lote"
	price_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input_row.add_child(price_in)

	var cur_opt := OptionButton.new()
	cur_opt.add_item("WATT", 0)
	cur_opt.add_item("KILOWAT", 1)
	input_row.add_child(cur_opt)
	vb.add_child(input_row)

	var fee_lbl := Label.new()
	fee_lbl.text = "Tasa (10%): 0.00"
	fee_lbl.add_theme_font_size_override("font_size", 10)
	fee_lbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.85))
	vb.add_child(fee_lbl)

	price_in.text_changed.connect(func(t):
		var p = float(t)
		var c = "WATT" if cur_opt.selected == 0 else "KILOWAT"
		fee_lbl.text = "Tasa (10%%): %.4f %s" % [p * 0.10, c]
	)

	var btn_pub := Button.new()
	btn_pub.text = "🚀 Publicar Lote"
	btn_pub.custom_minimum_size = Vector2(0, 34)
	btn_pub.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_pub.pressed.connect(func():
		var p_val = float(price_in.text)
		var q_val = int(qty_spin.value)
		if p_val <= 0.0:
			market_status_lbl.text = "⚠️ El precio debe ser mayor a 0."
			return
		btn_pub.disabled = true
		var cur_str = "watt" if cur_opt.selected == 0 else "kilowat"
		var body = {
			"p_part_type": part_type, 
			"p_part_level": part_lvl, 
			"p_quantity": q_val, 
			"p_price": p_val, 
			"p_currency": cur_str
		}
		var pub_res = await SupabaseClient.send_request("/rest/v1/rpc/publish_market_part", HTTPClient.METHOD_POST, body, true)
		if pub_res.get("success", false) and pub_res.get("data", {}).get("success", false):
			market_status_lbl.text = "✓ ¡Lote de repuestos publicado en el mercado!"
			await GameManager.load_player_inventory()
			_show_sellable_inventory()
		else:
			market_status_lbl.text = "⚠️ " + str(pub_res.get("data", {}).get("error", "Error al publicar lote"))
			btn_pub.disabled = false
	)
	vb.add_child(btn_pub)
	return card

func _show_my_listings() -> void:
	for child in market_grid.get_children(): child.queue_free()
	var res = await SupabaseClient.send_request("/rest/v1/market_listings?seller_id=eq." + SupabaseClient.current_user_id + "&status=eq.active&select=*", HTTPClient.METHOD_GET, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_ARRAY:
		var items: Array = res["data"]
		if items.is_empty():
			var no_lbl := Label.new()
			no_lbl.text = "No tienes ningún artículo publicado en venta actualmente."
			no_lbl.add_theme_font_size_override("font_size", 13)
			market_grid.add_child(no_lbl)
			return

		for it in items:
			var card := PanelContainer.new()
			card.custom_minimum_size = Vector2(285, 150)
			var c_st := StyleBoxFlat.new()
			c_st.bg_color = Color(0.09, 0.12, 0.18, 0.95)
			c_st.border_color = Color(1.0, 0.85, 0.2, 0.8)
			c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
			card.add_theme_stylebox_override("panel", c_st)

			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
			cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
			card.add_child(cm)

			var vb := VBoxContainer.new()
			cm.add_child(vb)

			var lid = str(it.get("id", ""))
			var itype = str(it.get("item_type", ""))
			var isub = str(it.get("item_sub_type", ""))
			var iqty = int(it.get("quantity", 1))

			var display = ""
			if itype == "material":
				display = "📦 %s T%d (Lote x%d)" % [isub.capitalize(), int(it.get("part_level", 1)), iqty]
			elif itype == "part": 
				display = "🔩 %s Nv.%d (Lote x%d)" % [isub.capitalize(), int(it.get("part_level", 1)), iqty]
			elif itype == "generator": 
				display = "⚡ " + _format_gen_name(isub)
			else: 
				display = "🗄️ " + _format_rack_name(isub)

			var lbl := Label.new()
			lbl.text = display
			lbl.add_theme_font_size_override("font_size", 13)
			vb.add_child(lbl)

			var plbl := Label.new()
			plbl.text = "Precio: %.4f %s" % [float(it.get("price", 0)), str(it.get("currency", "watt")).to_upper()]
			plbl.add_theme_font_size_override("font_size", 11)
			plbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			vb.add_child(plbl)

			vb.add_spacer(false)

			var cb := Button.new()
			cb.text = "✕ Cancelar y Recuperar"
			cb.custom_minimum_size = Vector2(0, 32)
			cb.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			cb.pressed.connect(func():
				cb.disabled = true
				await SupabaseClient.send_request("/rest/v1/rpc/cancel_market_listing", HTTPClient.METHOD_POST, {"p_listing_id": lid}, true)
				await GameManager.load_player_inventory()
				_show_my_listings()
			)
			vb.add_child(cb)
			market_grid.add_child(card)

# ====================================================================
# AUXILIARES
# ====================================================================
func _format_rack_name(r_type: String) -> String:
	match r_type:
		"rack_2_floors": return "Estantería de 2 Pisos"
		"rack_3_floors": return "Estantería de 3 Pisos"
		_: return "Estantería de 1 Piso"

func _format_gen_name(g_type: String) -> String:
	match g_type:
		"ecoflow_spark": return "EcoFlow Spark"
		"ecoflow_spark_plus": return "EcoFlow Spark Plus"
		"ecoflow_thunder_pro": return "EcoFlow Thunder Pro"
		"ecoflow_ultra": return "EcoFlow Ultra"
		"cyber_tank": return "Cyber Tank 100%"
		"dinamo_manual": return "Generador Manual"
		"delta_mini": return "EcoFlow DELTA Mini"
		"panel_solar": return "Panel Solar"
		"pro_electrico": return "EcoFlow Pro Eléctrico"
		_: return "Planta Meme"

# ====================================================================
# GESTIÓN DE ESPACIOS Y GENERADORES EN LA SALA
# ====================================================================
func _on_slot_clicked(slot_index: int) -> void:
	_close_all_drawers()
	for rack in GameManager.player_racks:
		if int(rack.get("slot_index", -1)) == slot_index:
			if rack_manage_dialog and rack_manage_dialog.has_method("open_dialog"):
				rack_manage_dialog.open_dialog(rack, _get_rack_data(rack))
			return
	_open_rack_select_modal(slot_index)

func _on_rack_hold_unmounted(slot_index: int) -> void:
	var target_rack: Dictionary = {}
	for rack in GameManager.player_racks:
		if int(rack.get("slot_index", -1)) == slot_index:
			target_rack = rack
			break
	if target_rack.is_empty(): return
	
	var r_id: String = str(target_rack.get("id", target_rack.get("rack_id", "")))
	target_rack["slot_index"] = -1
	if room_grid: room_grid.set_slot_occupied(slot_index, false)
	
	for gen in GameManager.player_generators:
		if str(gen.get("rack_id", "")) == r_id:
			var gid: String = str(gen.get("id", ""))
			gen["rack_id"] = null
			gen["slot_in_rack"] = -1
			GameManager.set_generator_power(gid, false, 0.0)
			await GameManager.unmount_generator(gid)
			
	if spawned_racks.has(slot_index):
		if is_instance_valid(spawned_racks[slot_index]):
			spawned_racks[slot_index].queue_free()
		spawned_racks.erase(slot_index)
		
	_render_placed_generators()
	_refresh_inventory_ui()
	await GameManager.unmount_rack_complete(r_id)

func _on_generator_unmounted(gen_id: String) -> void:
	# 1. Desvincular en la memoria local buscando por id o gen_id
	for g in GameManager.player_generators:
		var current_id = str(g.get("id", g.get("gen_id", "")))
		if current_id == gen_id:
			g["rack_id"] = null
			g["slot_in_rack"] = -1
			break

	GameManager.set_generator_power(gen_id, false, 0.0)
	_render_placed_generators()
	_refresh_inventory_ui()

	# 2. Desvincular en el servidor
	var ok: bool = await GameManager.unmount_generator(gen_id)
	if ok:
		show_room_alert("✓ Generador desmontado y guardado en el almacén.", false)
	else:
		show_room_alert("⚠️ Error al sincronizar el desmonte con el servidor.", true)

func _on_generator_mounted(gen_id: String, slot_idx: int) -> void:
	if rack_manage_dialog and "current_rack" in rack_manage_dialog:
		var r_id: String = str(rack_manage_dialog.current_rack.get("id", rack_manage_dialog.current_rack.get("rack_id", "")))
		
		# Llamada segura: tolera tanto Diccionario como Booleano para evitar crasheos
		var raw_res = await GameManager.place_generator_in_rack(gen_id, r_id, slot_idx)
		var is_success: bool = false
		var error_text: String = "No se pudo montar el generador."
		
		if typeof(raw_res) == TYPE_DICTIONARY:
			is_success = bool(raw_res.get("success", false))
			error_text = str(raw_res.get("error", error_text))
		elif typeof(raw_res) == TYPE_BOOL:
			is_success = raw_res

		if not is_success:
			show_room_alert("⚠️ " + error_text, true)
			await GameManager.load_player_inventory()
			_render_placed_generators()
			_refresh_inventory_ui()
			return
		
		show_room_alert("✓ Generador colocado con éxito.", false)

		for g in GameManager.player_generators:
			var is_same_rack = str(g.get("rack_id", "")) == r_id
			var is_same_slot = int(g.get("slot_in_rack", -1)) == slot_idx
			var is_different = str(g.get("id", "")) != gen_id
			if is_same_rack and is_same_slot and is_different:
				g["rack_id"] = null
				g["slot_in_rack"] = -1
		
		for g in GameManager.player_generators:
			if str(g.get("id", "")) == gen_id:
				g["rack_id"] = r_id
				g["slot_in_rack"] = slot_idx
				break
				
		_render_placed_generators()
		_refresh_inventory_ui()

func _render_placed_racks() -> void:
	if room_grid == null: return
	for i in range(6): room_grid.set_slot_occupied(i, false)

	for s_idx in spawned_racks.keys():
		if is_instance_valid(spawned_racks[s_idx]):
			spawned_racks[s_idx].queue_free()
	spawned_racks.clear()

	var occupied_slots: Dictionary = {}
	for rack in GameManager.player_racks:
		var slot_idx: int = int(rack.get("slot_index", -1))
		if slot_idx >= 0 and slot_idx < 6:
			if occupied_slots.has(slot_idx):
				rack["slot_index"] = -1
				continue
			occupied_slots[slot_idx] = true
			room_grid.set_slot_occupied(slot_idx, true)
			_instantiate_rack(rack, slot_idx)

func _instantiate_rack(rack_info: Dictionary, slot_idx: int) -> void:
	if room_grid == null: return
	var anchor = room_grid.get_slot_container(slot_idx)
	if anchor == null: return
	for child in anchor.get_children(): child.queue_free()
	var r_instance = RACK_VIEW_SCENE.instantiate()
	anchor.add_child(r_instance)
	r_instance.setup_rack(_get_rack_data(rack_info), str(rack_info.get("id", "")), slot_idx)
	spawned_racks[slot_idx] = r_instance

func _render_placed_generators() -> void:
	for r_view in spawned_racks.values():
		if is_instance_valid(r_view) and r_view.plant_slots_container != null:
			for marker in r_view.plant_slots_container.get_children():
				for child in marker.get_children():
					child.queue_free()

	var occupied_slots: Dictionary = {}

	for gen in GameManager.player_generators:
		var r_id: String = str(gen.get("rack_id", ""))
		var s_in_rack: int = int(gen.get("slot_in_rack", -1))
		var gid: String = str(gen.get("id", ""))
		
		if r_id != "" and r_id != "null" and s_in_rack >= 0:
			var slot_key = "%s_%d" % [r_id, s_in_rack]
			if occupied_slots.has(slot_key):
				GameManager.set_generator_power(gid, false, 0.0)
				continue
				
			var rack_mounted = false
			var target_slot_idx = -1
			for rack in GameManager.player_racks:
				if str(rack.get("id", rack.get("rack_id", ""))) == r_id:
					target_slot_idx = int(rack.get("slot_index", -1))
					rack_mounted = (target_slot_idx >= 0)
					break
			
			if not rack_mounted:
				GameManager.set_generator_power(gid, false, 0.0)
				continue
				
			if spawned_racks.has(target_slot_idx):
				var marker = spawned_racks[target_slot_idx].get_slot_marker(s_in_rack)
				if marker:
					occupied_slots[slot_key] = true
					var gen_view = GENERATOR_VIEW_SCENE.instantiate()
					marker.add_child(gen_view)
					var res = _get_gen_data(str(gen.get("generator_type", "")))
					var rem_sec = int(gen.get("remaining_active_seconds", 21600))
					var dur = float(gen.get("durability", 100.0))
					var lvl = int(gen.get("level", 1))
					gen_view.setup_from_server(res, gid, rem_sec, dur, lvl)

func _get_rack_data(r: Dictionary) -> RackData:
	match str(r.get("rack_type", "")):
		"rack_2_floors": return RACK_2_FLOORS_DATA
		"rack_3_floors": return RACK_3_FLOORS_DATA
		_: return RACK_1_FLOOR_DATA

func _get_gen_data(t: String) -> GeneratorData:
	var path: String = "res://data/generators/generator_%s.tres" % t
	if ResourceLoader.exists(path): return load(path)
	var fallback_path: String = "res://data/generators/generator_planta_lvl1.tres"
	if ResourceLoader.exists(fallback_path): return load(fallback_path)
	return null

# ====================================================================
# MENÚ DERECHO (INVENTARIO ALMACÉN)
# ====================================================================
func _create_inventory_drawer() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	var screen_w = 1280.0
	inv_root = Control.new()
	inv_root.name = "SlidingInventoryDrawer"
	inv_root.position = Vector2(screen_w, 95.0)
	inv_root.size = Vector2(inv_width, 450.0)

	var panel := PanelContainer.new()
	panel.name = "InvPanel"
	panel.size = Vector2(inv_width, 450.0)
	panel.custom_minimum_size = Vector2(inv_width, 450.0)

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	p_st.border_color = Color(0.25, 0.55, 0.85, 0.9)
	p_st.border_width_left = 2; p_st.border_width_top = 2; p_st.border_width_bottom = 2
	p_st.corner_radius_top_left = 10; p_st.corner_radius_bottom_left = 10
	p_st.shadow_color = Color(0.1, 0.45, 0.8, 0.3)
	p_st.shadow_size = 12
	panel.add_theme_stylebox_override("panel", p_st)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 14); margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 14); margin.add_theme_constant_override("margin_bottom", 14)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	var title_lbl := Label.new()
	title_lbl.text = "📦 INVENTARIO (ALMACÉN)"
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_lbl.add_theme_font_size_override("font_size", 13)
	title_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	vbox.add_child(title_lbl)

	var tabs_hbox := HBoxContainer.new()
	tabs_hbox.add_theme_constant_override("separation", 8)

	inv_tab_gens_btn = Button.new()
	inv_tab_gens_btn.text = "⚡ Generadores"
	inv_tab_gens_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inv_tab_gens_btn.custom_minimum_size = Vector2(0, 32)
	inv_tab_gens_btn.pressed.connect(func(): current_inv_tab = "generators"; _refresh_inventory_ui())
	tabs_hbox.add_child(inv_tab_gens_btn)

	inv_tab_racks_btn = Button.new()
	inv_tab_racks_btn.text = "🗄️ Estanterías"
	inv_tab_racks_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inv_tab_racks_btn.custom_minimum_size = Vector2(0, 32)
	inv_tab_racks_btn.pressed.connect(func(): current_inv_tab = "racks"; _refresh_inventory_ui())
	tabs_hbox.add_child(inv_tab_racks_btn)
	vbox.add_child(tabs_hbox)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	inv_list_container = VBoxContainer.new()
	inv_list_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inv_list_container.add_theme_constant_override("separation", 8)
	scroll.add_child(inv_list_container)

	inv_root.add_child(panel)

	inv_tab_btn = Button.new()
	inv_tab_btn.name = "InvTabButton"
	inv_tab_btn.text = "◀"
	inv_tab_btn.position = Vector2(-34.0, 130.0)
	inv_tab_btn.custom_minimum_size = Vector2(34, 60)
	inv_tab_btn.size = Vector2(34, 60)
	inv_tab_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	var tab_st := StyleBoxFlat.new()
	tab_st.bg_color = Color(0.08, 0.12, 0.18, 0.96)
	tab_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	tab_st.border_width_left = 2; tab_st.border_width_top = 2; tab_st.border_width_bottom = 2
	tab_st.corner_radius_top_left = 8; tab_st.corner_radius_bottom_left = 8
	tab_st.shadow_color = Color(0.15, 0.6, 0.9, 0.4); tab_st.shadow_size = 8
	inv_tab_btn.add_theme_stylebox_override("normal", tab_st)
	inv_tab_btn.add_theme_stylebox_override("hover", tab_st)
	inv_tab_btn.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	inv_tab_btn.add_theme_font_size_override("font_size", 15)
	inv_tab_btn.pressed.connect(_toggle_inventory_drawer)

	inv_root.add_child(inv_tab_btn)
	canvas_ui.add_child(inv_root)

func _toggle_inventory_drawer() -> void:
	if inv_is_open: _close_inventory_drawer()
	else: _open_inventory_drawer()

func _open_inventory_drawer() -> void:
	if drawer_is_open: _close_drawer()
	inv_is_open = true
	inv_tab_btn.text = "▶"
	_refresh_inventory_ui()
	
	var screen_w = 1280.0
	if inv_tween and inv_tween.is_running(): inv_tween.kill()
	inv_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	inv_tween.tween_property(inv_root, "position:x", screen_w - inv_width, 0.25)

func _close_inventory_drawer() -> void:
	inv_is_open = false
	inv_tab_btn.text = "◀"
	var screen_w = 1280.0
	if inv_tween and inv_tween.is_running(): inv_tween.kill()
	inv_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	inv_tween.tween_property(inv_root, "position:x", screen_w, 0.25)

func _refresh_inventory_ui() -> void:
	if inv_list_container == null: return
	for child in inv_list_container.get_children(): child.queue_free()

	var stored_gens: Array = []
	for gen in GameManager.player_generators:
		var is_mounted = (gen.get("rack_id") != null and str(gen.get("rack_id")) != "" and str(gen.get("rack_id")) != "null")
		if not is_mounted: stored_gens.append(gen)

	var stored_racks: Array = []
	for r in GameManager.player_racks:
		if int(r.get("slot_index", -1)) == -1: stored_racks.append(r)

	var is_gens = (current_inv_tab == "generators")
	inv_tab_gens_btn.text = "⚡ Generadores (%d)" % stored_gens.size()
	inv_tab_racks_btn.text = "🗄️ Estanterías (%d)" % stored_racks.size()

	var card_bg := StyleBoxFlat.new()
	card_bg.bg_color = Color(0.09, 0.12, 0.18, 0.9)
	card_bg.border_color = Color(0.2, 0.35, 0.55, 0.7)
	card_bg.set_border_width_all(1); card_bg.set_corner_radius_all(6)

	if is_gens:
		if stored_gens.is_empty():
			var empty_lbl := Label.new()
			empty_lbl.text = "No tienes generadores en almacén."
			empty_lbl.add_theme_font_size_override("font_size", 11)
			inv_list_container.add_child(empty_lbl)
			return

		for gen in stored_gens:
			var g_type = str(gen.get("generator_type", ""))
			var dur = float(gen.get("durability", 100.0))
			var lvl = int(gen.get("level", 1))

			var card := PanelContainer.new()
			card.add_theme_stylebox_override("panel", card_bg)
			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 10); cm.add_theme_constant_override("margin_right", 10)
			cm.add_theme_constant_override("margin_top", 8); cm.add_theme_constant_override("margin_bottom", 8)
			card.add_child(cm)
			
			var row := VBoxContainer.new()
			cm.add_child(row)
			
			var top_row := HBoxContainer.new()
			var name_lbl := Label.new()
			name_lbl.text = "%s (Nv %d)" % [_format_gen_name(g_type), lvl]
			name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			name_lbl.add_theme_font_size_override("font_size", 12)
			top_row.add_child(name_lbl)
			
			var status_lbl := Label.new()
			status_lbl.text = "Dur: %.0f%%" % dur
			status_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if dur >= 50 else Color(1.0, 0.4, 0.4))
			status_lbl.add_theme_font_size_override("font_size", 10)
			top_row.add_child(status_lbl)
			row.add_child(top_row)
			inv_list_container.add_child(card)

	else:
		if stored_racks.is_empty():
			var empty_lbl := Label.new()
			empty_lbl.text = "No tienes estanterías en almacén."
			empty_lbl.add_theme_font_size_override("font_size", 11)
			inv_list_container.add_child(empty_lbl)
			return

		for r in stored_racks:
			var r_data: RackData = _get_rack_data(r)
			var card := PanelContainer.new()
			card.add_theme_stylebox_override("panel", card_bg)
			var cm := MarginContainer.new()
			cm.add_theme_constant_override("margin_left", 10); cm.add_theme_constant_override("margin_right", 10)
			cm.add_theme_constant_override("margin_top", 8); cm.add_theme_constant_override("margin_bottom", 8)
			card.add_child(cm)
			
			var row := VBoxContainer.new()
			cm.add_child(row)
			
			var name_lbl := Label.new()
			name_lbl.text = r_data.name if r_data else "Estantería"
			name_lbl.add_theme_font_size_override("font_size", 12)
			row.add_child(name_lbl)
			inv_list_container.add_child(card)

# ====================================================================
# CHAT Y AMIGOS
# ====================================================================
func _create_docked_chat_box() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	if "saved_chat_channel_mode" in GameManager:
		chat_channel_mode = GameManager.saved_chat_channel_mode
		active_friend_id = GameManager.saved_active_friend_id
		active_friend_name = GameManager.saved_active_friend_name
		is_chat_minimized = GameManager.saved_is_chat_minimized

	docked_chat_box = PanelContainer.new()
	docked_chat_box.name = "DockedChatBox"
	docked_chat_box.custom_minimum_size = Vector2(340, 220)
	docked_chat_box.position = Vector2(20.0, 485.0 if not is_chat_minimized else 665.0)

	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.06, 0.08, 0.12, 0.88)
	p_st.border_color = Color(0.25, 0.55, 0.85, 0.85)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(8)
	docked_chat_box.add_theme_stylebox_override("panel", p_st)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 8); margin.add_theme_constant_override("margin_right", 8)
	margin.add_theme_constant_override("margin_top", 6); margin.add_theme_constant_override("margin_bottom", 6)
	docked_chat_box.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	margin.add_child(vbox)

	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 6)

	chat_mode_btn = Button.new()
	chat_mode_btn.custom_minimum_size = Vector2(80, 26)
	chat_mode_btn.add_theme_font_size_override("font_size", 10)
	chat_mode_btn.pressed.connect(_toggle_chat_mode)
	top_bar.add_child(chat_mode_btn)

	chat_friends_btn = Button.new()
	chat_friends_btn.text = "👥 Amigos"
	chat_friends_btn.custom_minimum_size = Vector2(80, 26)
	chat_friends_btn.add_theme_font_size_override("font_size", 10)
	chat_friends_btn.pressed.connect(_open_friends_modal)
	top_bar.add_child(chat_friends_btn)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top_bar.add_child(sp)

	chat_minimize_btn = Button.new()
	chat_minimize_btn.text = "▲" if is_chat_minimized else "—"
	chat_minimize_btn.custom_minimum_size = Vector2(26, 26)
	chat_minimize_btn.pressed.connect(_toggle_chat_minimize)
	top_bar.add_child(chat_minimize_btn)
	vbox.add_child(top_bar)

	chat_body_vbox = VBoxContainer.new()
	chat_body_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	chat_body_vbox.visible = not is_chat_minimized
	vbox.add_child(chat_body_vbox)

	chat_scroll = ScrollContainer.new()
	chat_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	chat_scroll.follow_focus = true
	chat_body_vbox.add_child(chat_scroll)

	chat_messages_vbox = VBoxContainer.new()
	chat_messages_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	chat_messages_vbox.add_theme_constant_override("separation", 4)
	chat_scroll.add_child(chat_messages_vbox)

	var input_row := HBoxContainer.new()
	input_row.add_theme_constant_override("separation", 4)

	chat_input = LineEdit.new()
	chat_input.placeholder_text = "Escribe aquí..."
	chat_input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	chat_input.custom_minimum_size = Vector2(0, 30)
	chat_input.max_length = 150
	chat_input.text_submitted.connect(func(_t): _send_chat_message(); chat_input.call_deferred("grab_focus"))
	input_row.add_child(chat_input)

	chat_send_btn = Button.new()
	chat_send_btn.text = "⚡"
	chat_send_btn.custom_minimum_size = Vector2(36, 30)
	chat_send_btn.pressed.connect(func(): _send_chat_message(); chat_input.call_deferred("grab_focus"))
	input_row.add_child(chat_send_btn)
	chat_body_vbox.add_child(input_row)

	canvas_ui.add_child(docked_chat_box)
	_update_chat_header_ui()
	_fetch_chat_data()

func _toggle_chat_minimize() -> void:
	is_chat_minimized = not is_chat_minimized
	if "saved_is_chat_minimized" in GameManager:
		GameManager.saved_is_chat_minimized = is_chat_minimized
	chat_body_vbox.visible = not is_chat_minimized
	chat_minimize_btn.text = "▲" if is_chat_minimized else "—"
	docked_chat_box.custom_minimum_size.y = 40.0 if is_chat_minimized else 220.0
	docked_chat_box.position.y = 665.0 if is_chat_minimized else 485.0

func _toggle_chat_mode() -> void:
	if chat_channel_mode == "global":
		if active_friend_id == "":
			_open_friends_modal()
			return
		chat_channel_mode = "private"
	else:
		chat_channel_mode = "global"
	
	if "saved_chat_channel_mode" in GameManager:
		GameManager.saved_chat_channel_mode = chat_channel_mode
	_update_chat_header_ui()
	last_chat_hash = ""
	_fetch_chat_data()

func _update_chat_header_ui() -> void:
	if chat_mode_btn == null: return
	if chat_channel_mode == "global":
		chat_mode_btn.text = "🌍 Global"
		chat_mode_btn.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		chat_input.placeholder_text = "Chat Global..."
	else:
		chat_mode_btn.text = "🔒 " + (active_friend_name if active_friend_name != "" else "Privado")
		chat_mode_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		chat_input.placeholder_text = "Privado a " + active_friend_name + "..."

func _process_chat(delta: float) -> void:
	if chat_cooldown_left > 0.0:
		chat_cooldown_left = maxf(0.0, chat_cooldown_left - delta)
		if chat_send_btn: chat_send_btn.disabled = (chat_cooldown_left > 0.0)

	chat_poll_timer += delta
	if chat_poll_timer >= 3.5:
		chat_poll_timer = 0.0
		_fetch_chat_data()

func _fetch_chat_data() -> void:
	if is_fetching_chat or is_chat_minimized: return
	is_fetching_chat = true

	var endpoint = "/rest/v1/rpc/get_recent_chat_messages"
	var body: Dictionary = {}

	if chat_channel_mode == "private" and active_friend_id != "":
		endpoint = "/rest/v1/rpc/get_private_chat_messages"
		body = {"p_friend_id": active_friend_id}

	var res = await SupabaseClient.send_request(endpoint, HTTPClient.METHOD_POST, body, true)
	is_fetching_chat = false

	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var msgs: Array = res["data"].get("messages", [])
		_render_chat_messages(msgs)

func _render_chat_messages(msgs: Array) -> void:
	if chat_messages_vbox == null: return

	var new_hash := str(msgs.size()) + "_" + (str(msgs[-1]["unix_time"]) if msgs.size() > 0 else "")
	if new_hash == last_chat_hash and chat_messages_vbox.get_child_count() > 0: return
	last_chat_hash = new_hash

	for child in chat_messages_vbox.get_children(): child.queue_free()

	if msgs.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "Sin mensajes aún."
		empty_lbl.add_theme_font_size_override("font_size", 9)
		chat_messages_vbox.add_child(empty_lbl)
		return

	for m in msgs:
		var author = str(m.get("sender_username", m.get("username", "Jugador")))
		var text_content = str(m.get("message", ""))
		var is_me = (author.to_lower() == GameManager.username.to_lower())

		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 4)

		var name_lbl := Label.new()
		name_lbl.text = author + ":"
		name_lbl.add_theme_font_size_override("font_size", 10)
		name_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if is_me else Color(0.35, 0.88, 1.0))
		row.add_child(name_lbl)

		var msg_lbl := Label.new()
		msg_lbl.text = text_content
		msg_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		msg_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		msg_lbl.add_theme_font_size_override("font_size", 10)
		msg_lbl.add_theme_color_override("font_color", Color(0.9, 0.95, 1.0))
		row.add_child(msg_lbl)

		chat_messages_vbox.add_child(row)

	await get_tree().process_frame
	if chat_scroll and is_instance_valid(chat_scroll):
		chat_scroll.scroll_vertical = int(chat_scroll.get_v_scroll_bar().max_value)

func _send_chat_message() -> void:
	if chat_input == null or chat_cooldown_left > 0.0: return
	var txt = chat_input.text.strip_edges()
	if txt == "": return

	chat_input.text = ""
	chat_input.call_deferred("grab_focus")

	var endpoint = "/rest/v1/rpc/send_chat_message"
	var body: Dictionary = {"p_message": txt}

	if chat_channel_mode == "private":
		if active_friend_id == "": return
		endpoint = "/rest/v1/rpc/send_private_message"
		body = {"p_friend_id": active_friend_id, "p_message": txt}

	chat_send_btn.disabled = true
	var res = await SupabaseClient.send_request(endpoint, HTTPClient.METHOD_POST, body, true)

	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		chat_cooldown_left = 3.0
		_fetch_chat_data()
	else:
		chat_send_btn.disabled = false

func _create_friends_modal() -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	friends_modal = Control.new()
	friends_modal.name = "FriendsModal"
	friends_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	friends_modal.visible = false

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.88)
	friends_modal.add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	friends_modal.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(520, 460)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.08, 0.10, 0.15, 0.98)
	p_st.border_color = Color(1.0, 0.85, 0.2, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(10)
	panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16); margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_top", 14); margin.add_theme_constant_override("margin_bottom", 14)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	var hrow := HBoxContainer.new()
	var title := Label.new()
	title.text = "👥 AMIGOS & SOLICITUDES"
	title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	title.add_theme_font_size_override("font_size", 16)
	hrow.add_child(title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hrow.add_child(sp)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(30, 30)
	close_btn.pressed.connect(func(): friends_modal.visible = false)
	hrow.add_child(close_btn)
	vbox.add_child(hrow)

	var add_row := HBoxContainer.new()
	friend_req_input = LineEdit.new()
	friend_req_input.placeholder_text = "Nombre del jugador a invitar..."
	friend_req_input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_row.add_child(friend_req_input)

	var send_req_btn := Button.new()
	send_req_btn.text = "➕ Enviar Solicitud"
	send_req_btn.pressed.connect(_send_friend_request)
	add_row.add_child(send_req_btn)
	vbox.add_child(add_row)

	friend_req_status = Label.new()
	friend_req_status.add_theme_font_size_override("font_size", 11)
	vbox.add_child(friend_req_status)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	friends_list_vbox = VBoxContainer.new()
	friends_list_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(friends_list_vbox)

	canvas_ui.add_child(friends_modal)

func _open_friends_modal() -> void:
	_close_all_drawers()
	if friends_modal == null: _create_friends_modal()
	if friends_modal == null: return
	friends_modal.visible = true
	friend_req_status.text = ""
	_fetch_friends_data()

func _send_friend_request() -> void:
	if friend_req_input == null or friend_req_input.text.strip_edges() == "": return
	friend_req_status.text = "Enviando solicitud..."
	var res = await SupabaseClient.send_request("/rest/v1/rpc/send_friend_request", HTTPClient.METHOD_POST, {"p_target_username": friend_req_input.text.strip_edges()}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		friend_req_status.text = "✓ Solicitud enviada"
		friend_req_input.text = ""
		_fetch_friends_data()
	else:
		friend_req_status.text = "⚠️ " + str(res.get("data", {}).get("error", "Error"))

func _fetch_friends_data() -> void:
	for child in friends_list_vbox.get_children(): child.queue_free()
	var res = await SupabaseClient.send_request("/rest/v1/rpc/get_friends_list", HTTPClient.METHOD_POST, {}, true)
	if res.get("success", false) and typeof(res.get("data")) == TYPE_DICTIONARY and res["data"].get("success", false):
		var friends: Array = res["data"].get("friends", [])
		var reqs: Array = res["data"].get("pending_requests", [])

		if not reqs.is_empty():
			var r_title := Label.new()
			r_title.text = "📩 SOLICITUDES RECIBIDAS:"
			r_title.add_theme_font_size_override("font_size", 11)
			r_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			friends_list_vbox.add_child(r_title)

			for rq in reqs:
				var r_id = str(rq.get("request_id", ""))
				var sender = str(rq.get("sender_username", ""))
				var row := HBoxContainer.new()
				var u_lbl := Label.new()
				u_lbl.text = "• " + sender
				u_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				row.add_child(u_lbl)

				var acc_btn := Button.new()
				acc_btn.text = "✓ Aceptar"
				acc_btn.pressed.connect(func(): _respond_friend_req(r_id, true))
				row.add_child(acc_btn)
				friends_list_vbox.add_child(row)

		var f_title := Label.new()
		f_title.text = "👥 TUS AMIGOS:"
		f_title.add_theme_font_size_override("font_size", 11)
		f_title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		friends_list_vbox.add_child(f_title)

		if friends.is_empty():
			var empty_lbl := Label.new()
			empty_lbl.text = "No tienes amigos agregados aún."
			empty_lbl.add_theme_font_size_override("font_size", 10)
			friends_list_vbox.add_child(empty_lbl)
		else:
			for fr in friends:
				var fid = str(fr.get("friend_id", ""))
				var fname = str(fr.get("username", ""))
				var online = bool(fr.get("is_online", false))

				var row := HBoxContainer.new()
				var name_lbl := Label.new()
				name_lbl.text = ("🟢 " if online else "⚪ ") + fname
				name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				name_lbl.add_theme_font_size_override("font_size", 12)
				row.add_child(name_lbl)

				var chat_btn := Button.new()
				chat_btn.text = "💬 Chatear"
				chat_btn.pressed.connect(func():
					active_friend_id = fid
					active_friend_name = fname
					chat_channel_mode = "private"
					friends_modal.visible = false
					_update_chat_header_ui()
					last_chat_hash = ""
					_fetch_chat_data()
				)
				row.add_child(chat_btn)
				friends_list_vbox.add_child(row)

func _respond_friend_req(request_id: String, accept: bool) -> void:
	await SupabaseClient.send_request("/rest/v1/rpc/respond_friend_request", HTTPClient.METHOD_POST, {"p_request_id": request_id, "p_accept": accept}, true)
	_fetch_friends_data()

func _build_sell_material_card(mat_type: String, tier: int, max_stock: int) -> PanelContainer:
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(285, 205)
	var c_st := StyleBoxFlat.new()
	c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
	c_st.border_color = Color(0.35, 0.88, 1.0, 0.8)
	c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
	card.add_theme_stylebox_override("panel", c_st)

	var cm := MarginContainer.new()
	cm.add_theme_constant_override("margin_left", 14); cm.add_theme_constant_override("margin_right", 14)
	cm.add_theme_constant_override("margin_top", 12); cm.add_theme_constant_override("margin_bottom", 12)
	card.add_child(cm)

	var vb := VBoxContainer.new()
	vb.add_theme_constant_override("separation", 5)
	cm.add_child(vb)

	var title := Label.new()
	title.text = "📦 %s T%d (Tienes: %d)" % [mat_type.capitalize(), tier, max_stock]
	title.add_theme_font_size_override("font_size", 13)
	title.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	vb.add_child(title)

	var qty_row := HBoxContainer.new()
	var qty_lbl := Label.new()
	qty_lbl.text = "Cantidad a vender:"
	qty_lbl.add_theme_font_size_override("font_size", 11)
	qty_row.add_child(qty_lbl)

	var qty_spin := SpinBox.new()
	qty_spin.min_value = 1
	qty_spin.max_value = max_stock
	qty_spin.step = 1
	qty_spin.value = maxi(1, mini(10, max_stock))
	qty_row.add_child(qty_spin)
	vb.add_child(qty_row)

	var input_row := HBoxContainer.new()
	var price_in := LineEdit.new()
	price_in.placeholder_text = "Precio"
	price_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input_row.add_child(price_in)

	var cur_opt := OptionButton.new()
	cur_opt.add_item("WATT", 0)
	cur_opt.add_item("KILOWAT", 1)
	cur_opt.selected = 1 # Por defecto en Kilowatts para que ganen dinero real
	input_row.add_child(cur_opt)
	vb.add_child(input_row)

	var btn_pub := Button.new()
	btn_pub.text = "🚀 Vender por Kilowatts"
	btn_pub.custom_minimum_size = Vector2(0, 34)
	btn_pub.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_pub.pressed.connect(func():
		var p_val = float(price_in.text)
		var q_val = int(qty_spin.value)
		if p_val <= 0.0:
			market_status_lbl.text = "⚠️ El precio debe ser mayor a 0."
			return
		btn_pub.disabled = true
		var cur_str = "watt" if cur_opt.selected == 0 else "kilowat"
		var body = {
			"p_material_type": mat_type, 
			"p_tier": tier, 
			"p_quantity": q_val, 
			"p_price": p_val, 
			"p_currency": cur_str
		}
		var pub_res = await SupabaseClient.send_request("/rest/v1/rpc/publish_market_material", HTTPClient.METHOD_POST, body, true)
		if pub_res.get("success", false) and pub_res.get("data", {}).get("success", false):
			market_status_lbl.text = "✓ ¡Lote de materiales publicado en el mercado!"
			await GameManager.load_player_rpg_state()
			_show_sellable_inventory()
		else:
			market_status_lbl.text = "⚠️ " + str(pub_res.get("data", {}).get("error", "Error al publicar"))
			btn_pub.disabled = false
	)
	vb.add_child(btn_pub)
	return card
	
func show_room_alert(message: String, is_error: bool = true) -> void:
	var canvas_ui = find_child("CanvasLayerUI", true, false)
	if canvas_ui == null: return

	if room_alert_toast == null or not is_instance_valid(room_alert_toast):
		room_alert_toast = PanelContainer.new()
		room_alert_toast.name = "RoomAlertToast"
		room_alert_toast.custom_minimum_size = Vector2(480, 48)
		room_alert_toast.set_anchors_preset(Control.PRESET_CENTER_TOP)
		room_alert_toast.offset_top = 18.0
		room_alert_toast.offset_left = -240.0
		room_alert_toast.offset_right = 240.0
		room_alert_toast.mouse_filter = Control.MOUSE_FILTER_IGNORE

		var lbl := Label.new()
		lbl.name = "AlertLabel"
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		lbl.add_theme_font_size_override("font_size", 12)
		room_alert_toast.add_child(lbl)

		canvas_ui.add_child(room_alert_toast)

	var st := StyleBoxFlat.new()
	st.bg_color = Color(0.15, 0.05, 0.05, 0.96) if is_error else Color(0.05, 0.15, 0.08, 0.96)
	st.border_color = Color(1.0, 0.35, 0.35, 1.0) if is_error else Color(0.35, 1.0, 0.55, 1.0)
	st.set_border_width_all(2)
	st.set_corner_radius_all(10)
	st.shadow_color = Color(0.8, 0.1, 0.1, 0.35) if is_error else Color(0.1, 0.8, 0.3, 0.35)
	st.shadow_size = 10
	room_alert_toast.add_theme_stylebox_override("panel", st)

	var label_node: Label = room_alert_toast.get_node("AlertLabel")
	label_node.text = message
	label_node.add_theme_color_override("font_color", Color(1.0, 0.85, 0.85) if is_error else Color(0.85, 1.0, 0.9))

	room_alert_toast.visible = true
	room_alert_toast.modulate.a = 0.0
	room_alert_toast.position.y = 0.0

	if alert_tween and alert_tween.is_running(): 
		alert_tween.kill()
		
	alert_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	alert_tween.tween_property(room_alert_toast, "modulate:a", 1.0, 0.25)
	alert_tween.tween_property(room_alert_toast, "position:y", 18.0, 0.25)
	alert_tween.tween_interval(3.2)
	alert_tween.tween_property(room_alert_toast, "modulate:a", 0.0, 0.35)
	alert_tween.tween_callback(func(): room_alert_toast.visible = false)

```

---

###### 📄 Archivo: `main_room.gd.uid`

```
uid://bcthcyqoaledp

```

---

###### 📄 Archivo: `main_room.tscn`

```
[gd_scene format=3 uid="uid://cbfoeuiwpudtf"]

[ext_resource type="Script" path="res://features/room/main_room.gd" id="1_room"]
[ext_resource type="Texture2D" path="res://assets/sprites/room/room_background.png" id="2_bg"]
[ext_resource type="PackedScene" path="res://features/room/grid/room_grid.tscn" id="3_grid"]
[ext_resource type="PackedScene" path="res://features/room/components/room_hud.tscn" id="4_hud"]
[ext_resource type="PackedScene" path="res://features/progression/battle_pass/battle_pass_screen.tscn" id="5_bpscene"]
[ext_resource type="PackedScene" path="res://features/progression/referrals/referral_modal.tscn" id="6_referral_modal"]
[ext_resource type="PackedScene" path="res://features/economy/power_split/power_split_modal.tscn" id="7_split_modal"]
[ext_resource type="PackedScene" path="res://features/economy/extraction/extraction_modal.tscn" id="8_extract_modal"]
[ext_resource type="PackedScene" path="res://features/room/racks/rack_manage_dialog.tscn" id="9_rack_dialog"]
[ext_resource type="PackedScene" path="res://features/room/generators/plant_info_card.tscn" id="10_plant_card"]
[ext_resource type="PackedScene" path="res://features/room/components/bg_selector_modal.tscn" id="11_bg_modal"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/btn_tienda.png" id="12_btntienda"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/btn_minijuegos.png" id="13_btnmini"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_battlepass.png" id="15_bpicon"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/btn_evento_potencia.png" id="16_btnev"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_side_btn"]
bg_color = Color(0.08, 0.10, 0.15, 0.88)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.25, 0.38, 0.55, 0.7)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6

[node name="MainRoom" type="Node2D"]
script = ExtResource("1_room")

[node name="RoomBackground" type="TextureRect" parent="."]
offset_right = 1280.0
offset_bottom = 720.0
mouse_filter = 2
texture = ExtResource("2_bg")
expand_mode = 1
stretch_mode = 6

[node name="RoomGrid" parent="." instance=ExtResource("3_grid")]

[node name="CanvasLayerUI" type="CanvasLayer" parent="."]

[node name="RoomHUD" parent="CanvasLayerUI" instance=ExtResource("4_hud")]

[node name="LeftSidebar" type="VBoxContainer" parent="CanvasLayerUI"]
custom_minimum_size = Vector2(170, 0)
layout_mode = 3
anchors_preset = 0
anchor_left = 0.0
anchor_top = 0.0
anchor_right = 0.0
anchor_bottom = 0.0
offset_left = 20.0
offset_top = 84.0
offset_right = 190.0
offset_bottom = 440.0
grow_horizontal = 1
grow_vertical = 1
theme_override_constants/separation = 10

[node name="ShopButton" type="TextureButton" parent="CanvasLayerUI/LeftSidebar"]
custom_minimum_size = Vector2(170, 50)
layout_mode = 2
mouse_default_cursor_shape = 2
texture_normal = ExtResource("12_btntienda")
ignore_texture_size = true
stretch_mode = 6

[node name="MinigamesButton" type="TextureButton" parent="CanvasLayerUI/LeftSidebar"]
custom_minimum_size = Vector2(170, 50)
layout_mode = 2
mouse_default_cursor_shape = 2
texture_normal = ExtResource("13_btnmini")
ignore_texture_size = true
stretch_mode = 6

[node name="CasinoButton" type="Button" parent="CanvasLayerUI/LeftSidebar"]
custom_minimum_size = Vector2(170, 42)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_styles/normal = SubResource("StyleBoxFlat_side_btn")
theme_override_colors/font_color = Color(1, 0.5, 0.9, 1)
text = "  🎰 CASINO"

[node name="BattlePassButton" type="TextureButton" parent="CanvasLayerUI/LeftSidebar"]
custom_minimum_size = Vector2(170, 50)
layout_mode = 2
mouse_default_cursor_shape = 2
texture_normal = ExtResource("15_bpicon")
ignore_texture_size = true
stretch_mode = 6

[node name="ReferralButton" type="Button" parent="CanvasLayerUI/LeftSidebar"]
custom_minimum_size = Vector2(170, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_styles/normal = SubResource("StyleBoxFlat_side_btn")
text = "👥 REFERIDOS"

[node name="ChangeBgButton" type="Button" parent="CanvasLayerUI/LeftSidebar"]
visible = false
custom_minimum_size = Vector2(170, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
theme_override_styles/normal = SubResource("StyleBoxFlat_side_btn")
text = "🖼️ FONDOS"

# BANNER DE EVENTO FIJADO EN LA ESQUINA INFERIOR IZQUIERDA
[node name="EventButtonContainer" type="Control" parent="CanvasLayerUI"]
layout_mode = 3
anchors_preset = 2
anchor_top = 1.0
anchor_bottom = 1.0
offset_left = 20.0
offset_top = -100.0
offset_right = 300.0
offset_bottom = -20.0
grow_vertical = 0

[node name="EventButton" type="TextureButton" parent="CanvasLayerUI/EventButtonContainer"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_default_cursor_shape = 2
texture_normal = ExtResource("16_btnev")
ignore_texture_size = true
stretch_mode = 5

[node name="PowerSplitModal" parent="CanvasLayerUI" instance=ExtResource("7_split_modal")]
visible = false

[node name="ExtractionModal" parent="CanvasLayerUI" instance=ExtResource("8_extract_modal")]
visible = false

[node name="RackManageDialog" parent="CanvasLayerUI" instance=ExtResource("9_rack_dialog")]
visible = false

[node name="PlantInfoCard" parent="CanvasLayerUI" instance=ExtResource("10_plant_card")]
visible = false

[node name="BattlePassScreen" parent="CanvasLayerUI" instance=ExtResource("5_bpscene")]
visible = false

[node name="ReferralModal" parent="CanvasLayerUI" instance=ExtResource("6_referral_modal")]
visible = false

[node name="BgSelectorModal" parent="CanvasLayerUI" instance=ExtResource("11_bg_modal")]
visible = false
```

---

###### 📁 Carpeta: `./features\room\components/`

####### 📄 Archivo: `bg_selector_modal.gd`

```
# res://features/room/components/bg_selector_modal.gd
extends PanelContainer

signal background_changed(bg_id: String)

@onready var bg_list: VBoxContainer = $Margin/VBox/BgScroll/BgList
@onready var close_btn: Button = $Margin/VBox/CloseBgButton

func _ready() -> void:
	close_btn.pressed.connect(func(): visible = false)

func open_modal() -> void:
	for child in bg_list.get_children():
		child.queue_free()
		
	var bg_catalog = [
		{"id": "default", "name": "Habitación Inicial", "desc": "El cuarto oscuro tradicional.", "texture": "res://assets/sprites/room/room_background.png"},
		{"id": "bunker_solar", "name": "Búnker Solar", "desc": "Refugio industrial del Pase de Temporada.", "texture": "res://assets/sprites/room/bg_bunker_solar.png"},
		{"id": "habitacion_taller", "name": "Habitación Taller", "desc": "Banco de trabajo con herramientas.", "texture": "res://assets/sprites/room/bg_habitacion_taller.png"}
	]
	
	for bg in bg_catalog:
		var bg_id: String = bg["id"]
		var is_unlocked: bool = (bg_id in GameManager.unlocked_backgrounds)
		var is_equipped: bool = (GameManager.equipped_background == bg_id)
		
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 84)
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.08, 0.10, 0.15, 0.95)
		c_st.border_color = Color(0.35, 0.88, 1.0) if is_equipped else Color(0.2, 0.25, 0.35)
		c_st.set_border_width_all(2 if is_equipped else 1)
		c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)
		
		var cm := MarginContainer.new()
		cm.add_theme_constant_override("margin_left", 12)
		cm.add_theme_constant_override("margin_right", 12)
		cm.add_theme_constant_override("margin_top", 8)
		cm.add_theme_constant_override("margin_bottom", 8)
		card.add_child(cm)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		cm.add_child(hbox)
		
		var thumb := TextureRect.new()
		thumb.custom_minimum_size = Vector2(100, 60)
		thumb.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		var t_path = str(bg["texture"])
		if ResourceLoader.exists(t_path): thumb.texture = load(t_path)
		hbox.add_child(thumb)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.add_theme_constant_override("separation", 2)
		
		var name_lbl := Label.new()
		name_lbl.text = str(bg["name"])
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0) if is_unlocked else Color(0.5, 0.55, 0.65))
		vbox.add_child(name_lbl)
		
		var desc_lbl := Label.new()
		desc_lbl.text = str(bg["desc"])
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.65, 0.70, 0.80) if is_unlocked else Color(0.4, 0.45, 0.55))
		vbox.add_child(desc_lbl)
		hbox.add_child(vbox)
		
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(110, 36)
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		if is_equipped:
			btn.text = "✓ Puesto"
			btn.disabled = true
		elif is_unlocked:
			btn.text = "⚡ Equipar"
			btn.pressed.connect(func():
				await GameManager.equip_background(bg_id)
				background_changed.emit(bg_id)
				open_modal()
			)
		else:
			btn.text = "🔒 Bloqueado"
			btn.disabled = true
			
		hbox.add_child(btn)
		bg_list.add_child(card)
		
	visible = true
```

---

####### 📄 Archivo: `bg_selector_modal.gd.uid`

```
uid://3sbmugek7g8r

```

---

####### 📄 Archivo: `bg_selector_modal.tscn`

```
[gd_scene format=3 uid="uid://cbgselect001"]

[ext_resource type="Script" path="res://features/room/components/bg_selector_modal.gd" id="1_bgmodal"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(1, 0.82, 0.15, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[node name="BgSelectorModal" type="PanelContainer"]
visible = false
custom_minimum_size = Vector2(620, 420)
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -310.0
offset_top = -210.0
offset_right = 310.0
offset_bottom = 210.0
grow_horizontal = 2
grow_vertical = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")
script = ExtResource("1_bgmodal")

[node name="Margin" type="MarginContainer" parent="."]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_top = 18
theme_override_constants/margin_right = 20
theme_override_constants/margin_bottom = 18

[node name="VBox" type="VBoxContainer" parent="Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="Title" type="Label" parent="Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
text = "🖼️ AMBIENTE DE LA HABITACIÓN"
horizontal_alignment = 1

[node name="BgScroll" type="ScrollContainer" parent="Margin/VBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="BgList" type="VBoxContainer" parent="Margin/VBox/BgScroll"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 8

[node name="CloseBgButton" type="Button" parent="Margin/VBox"]
custom_minimum_size = Vector2(0, 40)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "Cerrar"
```

---

####### 📄 Archivo: `room_hud.gd`

```
# res://features/room/components/room_hud.gd
extends PanelContainer

signal split_requested()
signal extract_requested()

@onready var player_label: Label = $Margin/HBox/PlayerLabel
@onready var power_label: Label = $Margin/HBox/StatsBox/PowerPill/Margin/HBox/PowerLabel
@onready var watt_label: Label = $Margin/HBox/StatsBox/WattPill/Margin/HBox/WattLabel
@onready var kilowat_label: Label = $Margin/HBox/StatsBox/KiloPill/Margin/HBox/KiloLabel
@onready var chip_label: Label = $Margin/HBox/StatsBox/ChipPill/Margin/HBox/ChipLabel

@onready var split_btn: Button = $Margin/HBox/ActionsBox/SplitPowerBtn
@onready var extract_btn: Button = $Margin/HBox/ActionsBox/ExtractBtn
@onready var logout_btn: Button = $Margin/HBox/ActionsBox/LogoutButton

func _ready() -> void:
	split_btn.pressed.connect(func(): split_requested.emit())
	extract_btn.pressed.connect(func(): extract_requested.emit())
	logout_btn.pressed.connect(_on_logout_pressed)
	
	EventBus.power_updated.connect(_update_power)
	EventBus.currencies_updated.connect(func(_w, _k): _update_currencies())
	
	_update_all()

func _process(_delta: float) -> void:
	_update_currencies()

func _update_all() -> void:
	player_label.text = "Operador: " + GameManager.username
	_update_power(GameManager.total_kwp)
	_update_currencies()

func _update_power(kwp: float) -> void:
	if power_label and is_instance_valid(power_label):
		power_label.text = _format_power(kwp)

func _update_currencies() -> void:
	if watt_label and is_instance_valid(watt_label):
		watt_label.text = "%.4f" % GameManager.watt
	if kilowat_label and is_instance_valid(kilowat_label):
		kilowat_label.text = "%.6f" % GameManager.kilowat
	if chip_label and is_instance_valid(chip_label):
		chip_label.text = "%.0f" % GameManager.casino_tokens

func _format_power(kwp: float) -> String:
	if kwp <= 0.0: return "0.000000000 KWP"
	elif kwp >= 1000000.0: return "%.3f GWP" % (kwp / 1000000.0)
	elif kwp >= 1000.0: return "%.3f MWP" % (kwp / 1000.0)
	elif kwp >= 1.0: return "%.4f KWP" % kwp
	else: return "%.9f KWP" % kwp

func _on_logout_pressed() -> void:
	logout_btn.disabled = true
	logout_btn.text = "..."
	await SupabaseAuth.sign_out()
	get_tree().change_scene_to_file("res://features/auth/login_screen.tscn")
```

---

####### 📄 Archivo: `room_hud.gd.uid`

```
uid://c2r3mv5od2e5j

```

---

####### 📄 Archivo: `room_hud.tscn`

```
[gd_scene format=3 uid="uid://croomhud001"]

[ext_resource type="Script" path="res://features/room/components/room_hud.gd" id="1_rhud"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_watt.png" id="2_watt"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_kilowat.png" id="3_kilo"]
[ext_resource type="Texture2D" path="res://assets/sprites/ui/icon_chip.png" id="4_chip"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_topbar"]
bg_color = Color(0.06, 0.08, 0.12, 0.98)
border_width_bottom = 2
border_color = Color(0.18, 0.65, 0.85, 0.8)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill"]
bg_color = Color(0.1, 0.13, 0.18, 0.95)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.35, 0.55, 0.7)
corner_radius_top_left = 16
corner_radius_top_right = 16
corner_radius_bottom_right = 16
corner_radius_bottom_left = 16

[node name="RoomHUD" type="PanelContainer"]
custom_minimum_size = Vector2(0, 68)
anchors_preset = 10
anchor_right = 1.0
grow_horizontal = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_topbar")
script = ExtResource("1_rhud")

[node name="Margin" type="MarginContainer" parent="."]
layout_mode = 2
theme_override_constants/margin_left = 16
theme_override_constants/margin_right = 16

[node name="HBox" type="HBoxContainer" parent="Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="PlayerLabel" type="Label" parent="Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.9, 0.95, 1, 1)
theme_override_font_sizes/font_size = 15
text = "Operador: -"

[node name="StatsBox" type="HBoxContainer" parent="Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="PowerPill" type="PanelContainer" parent="Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(170, 36)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="Margin/HBox/StatsBox/PowerPill"]
layout_mode = 2
theme_override_constants/margin_left = 10
theme_override_constants/margin_right = 10

[node name="HBox" type="HBoxContainer" parent="Margin/HBox/StatsBox/PowerPill/Margin"]
layout_mode = 2
alignment = 1

[node name="Icon" type="Label" parent="Margin/HBox/StatsBox/PowerPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
text = "⚡"

[node name="PowerLabel" type="Label" parent="Margin/HBox/StatsBox/PowerPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 12
text = "0.000000000 KWP"

[node name="WattPill" type="PanelContainer" parent="Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(125, 36)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="Margin/HBox/StatsBox/WattPill"]
layout_mode = 2
theme_override_constants/margin_left = 8
theme_override_constants/margin_right = 8

[node name="HBox" type="HBoxContainer" parent="Margin/HBox/StatsBox/WattPill/Margin"]
layout_mode = 2
alignment = 1

[node name="Icon" type="TextureRect" parent="Margin/HBox/StatsBox/WattPill/Margin/HBox"]
custom_minimum_size = Vector2(20, 20)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("2_watt")
expand_mode = 1
stretch_mode = 5

[node name="WattLabel" type="Label" parent="Margin/HBox/StatsBox/WattPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.4, 0.95, 0.55, 1)
theme_override_font_sizes/font_size = 12
text = "0.0000"

[node name="KiloPill" type="PanelContainer" parent="Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(135, 36)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="Margin/HBox/StatsBox/KiloPill"]
layout_mode = 2
theme_override_constants/margin_left = 8
theme_override_constants/margin_right = 8

[node name="HBox" type="HBoxContainer" parent="Margin/HBox/StatsBox/KiloPill/Margin"]
layout_mode = 2
alignment = 1

[node name="Icon" type="TextureRect" parent="Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
custom_minimum_size = Vector2(20, 20)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("3_kilo")
expand_mode = 1
stretch_mode = 5

[node name="KiloLabel" type="Label" parent="Margin/HBox/StatsBox/KiloPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
theme_override_font_sizes/font_size = 12
text = "0.000000"

[node name="ChipPill" type="PanelContainer" parent="Margin/HBox/StatsBox"]
custom_minimum_size = Vector2(110, 36)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/panel = SubResource("StyleBoxFlat_pill")

[node name="Margin" type="MarginContainer" parent="Margin/HBox/StatsBox/ChipPill"]
layout_mode = 2
theme_override_constants/margin_left = 8
theme_override_constants/margin_right = 8

[node name="HBox" type="HBoxContainer" parent="Margin/HBox/StatsBox/ChipPill/Margin"]
layout_mode = 2
alignment = 1

[node name="Icon" type="TextureRect" parent="Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
custom_minimum_size = Vector2(20, 20)
layout_mode = 2
size_flags_vertical = 4
texture = ExtResource("4_chip")
expand_mode = 1
stretch_mode = 5

[node name="ChipLabel" type="Label" parent="Margin/HBox/StatsBox/ChipPill/Margin/HBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.55, 0.95, 1)
theme_override_font_sizes/font_size = 12
text = "0"

[node name="Spacer" type="Control" parent="Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="ActionsBox" type="HBoxContainer" parent="Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="SplitPowerBtn" type="Button" parent="Margin/HBox/ActionsBox"]
custom_minimum_size = Vector2(90, 36)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "⚡ Minar"

[node name="ExtractBtn" type="Button" parent="Margin/HBox/ActionsBox"]
custom_minimum_size = Vector2(95, 36)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "💵 Extraer"

[node name="LogoutButton" type="Button" parent="Margin/HBox/ActionsBox"]
custom_minimum_size = Vector2(80, 36)
layout_mode = 2
size_flags_vertical = 4
mouse_default_cursor_shape = 2
text = "Salir"
```

---

###### 📁 Carpeta: `./features\room\controls/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `zoom_controller.gd`

```
# res://features/room/controls/zoom_controller.gd
class_name ZoomController
extends Node

var current_zoom: float = 1.0
var current_pan: Vector2 = Vector2.ZERO
var min_zoom: float = 1.0
var max_zoom: float = 2.8

var zoom_tween: Tween = null
var hud_layer: CanvasLayer = null
var reset_btn: Button = null
var mobile_zoom_bar: HBoxContainer = null

# Seguimiento Multi-Touch Android
var touch_points: Dictionary = {}
var start_distance: float = 0.0
var start_zoom: float = 1.0
var start_midpoint: Vector2 = Vector2.ZERO
var start_pan: Vector2 = Vector2.ZERO
var is_pinching: bool = false

# Control PC
var is_dragging_pc: bool = false
var last_scene: Node = null

func _ready() -> void:
	_setup_hud()

func _setup_hud() -> void:
	# Capa visual independiente inmune al escalado
	hud_layer = CanvasLayer.new()
	hud_layer.name = "GlobalZoomHudLayer"
	hud_layer.layer = 127
	add_child(hud_layer)

	# 1. Botón de restablecer (Centro inferior - aparece solo con zoom)
	reset_btn = Button.new()
	reset_btn.name = "ResetZoomBtn"
	reset_btn.visible = false
	reset_btn.custom_minimum_size = Vector2(190, 40)
	reset_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	reset_btn.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	reset_btn.anchor_left = 0.5
	reset_btn.anchor_right = 0.5
	reset_btn.anchor_top = 1.0
	reset_btn.anchor_bottom = 1.0
	reset_btn.offset_left = -95.0
	reset_btn.offset_right = 95.0
	reset_btn.offset_top = -58.0
	reset_btn.offset_bottom = -18.0
	reset_btn.grow_horizontal = Control.GROW_DIRECTION_BOTH
	reset_btn.grow_vertical = Control.GROW_DIRECTION_BEGIN

	var b_st := StyleBoxFlat.new()
	b_st.bg_color = Color(0.06, 0.08, 0.12, 0.96)
	b_st.border_color = Color(0.35, 0.88, 1.0, 1.0)
	b_st.set_border_width_all(2)
	b_st.set_corner_radius_all(20)
	b_st.shadow_color = Color(0.15, 0.6, 0.85, 0.4)
	b_st.shadow_size = 8
	reset_btn.add_theme_stylebox_override("normal", b_st)
	reset_btn.add_theme_stylebox_override("hover", b_st)
	reset_btn.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
	reset_btn.add_theme_font_size_override("font_size", 12)
	reset_btn.text = "🔍 Restablecer Lupa"
	reset_btn.pressed.connect(func(): reset_zoom(true))
	hud_layer.add_child(reset_btn)

	# 2. Botones rápidos de lupa (+ / -) flotantes en la esquina inferior derecha
	mobile_zoom_bar = HBoxContainer.new()
	mobile_zoom_bar.name = "MobileZoomBar"
	mobile_zoom_bar.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	mobile_zoom_bar.anchor_left = 1.0
	mobile_zoom_bar.anchor_right = 1.0
	mobile_zoom_bar.anchor_top = 1.0
	mobile_zoom_bar.anchor_bottom = 1.0
	mobile_zoom_bar.offset_left = -115.0
	mobile_zoom_bar.offset_right = -18.0
	mobile_zoom_bar.offset_top = -62.0
	mobile_zoom_bar.offset_bottom = -22.0
	mobile_zoom_bar.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	mobile_zoom_bar.grow_vertical = Control.GROW_DIRECTION_BEGIN
	mobile_zoom_bar.add_theme_constant_override("separation", 6)

	var btn_out := Button.new()
	btn_out.text = "🔍-"
	btn_out.custom_minimum_size = Vector2(44, 38)
	btn_out.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_out.pressed.connect(func(): _step_zoom(0.80, get_viewport().get_visible_rect().size / 2.0))
	mobile_zoom_bar.add_child(btn_out)

	var btn_in := Button.new()
	btn_in.text = "🔍+"
	btn_in.custom_minimum_size = Vector2(44, 38)
	btn_in.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	btn_in.pressed.connect(func(): _step_zoom(1.25, get_viewport().get_visible_rect().size / 2.0))
	mobile_zoom_bar.add_child(btn_in)

	hud_layer.add_child(mobile_zoom_bar)

func _process(_delta: float) -> void:
	var cur = get_tree().current_scene
	if cur != null and cur != last_scene:
		last_scene = cur
		if current_zoom > 1.02:
			reset_zoom(false)

func _input(event: InputEvent) -> void:
	var vp_size: Vector2 = get_viewport().get_visible_rect().size

	# =========================================================================
	# A) GESTOS NATIVOS DE ANDROID (ScaleGestureDetector del OS)
	# =========================================================================
	if event is InputEventMagnifyGesture:
		_step_zoom(event.factor, event.position)
		get_viewport().set_input_as_handled()
		return

	if event is InputEventPanGesture:
		if current_zoom > 1.05:
			current_pan -= event.delta * 1.5
			_clamp_pan(vp_size)
			_apply_transform()
			get_viewport().set_input_as_handled()
		return

	# =========================================================================
	# B) RECONOCIMIENTO MULTI-TOUCH ROBUSTO PARA ANDROID
	# =========================================================================
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_points[event.index] = event.position
		else:
			touch_points.erase(event.index)
			if touch_points.size() < 2:
				is_pinching = false
				start_distance = 0.0
				if current_zoom < 1.03:
					reset_zoom(true)

		# Si hay 2 dedos en la pantalla, inicializar el pellizco
		if touch_points.size() >= 2:
			_start_pinch()
			get_viewport().set_input_as_handled()

	elif event is InputEventScreenDrag:
		touch_points[event.index] = event.position

		# GESTO DE PELLIZCO ACTIVO
		if touch_points.size() >= 2:
			if not is_pinching or start_distance <= 10.0:
				_start_pinch()

			if start_distance > 10.0:
				var pts = touch_points.values()
				var cur_dist = pts[0].distance_to(pts[1])
				var cur_mid = (pts[0] + pts[1]) / 2.0

				var factor = cur_dist / start_distance
				var target_zoom = clampf(start_zoom * factor, min_zoom, max_zoom)

				var content_pt = (start_midpoint - start_pan) / start_zoom
				current_zoom = target_zoom
				current_pan = cur_mid - (content_pt * current_zoom)
				_clamp_pan(vp_size)
				_apply_transform()

			get_viewport().set_input_as_handled()

		# ARRASTRE CON 1 DEDO POR LA PANTALLA CON ZOOM ACTIVO
		elif touch_points.size() == 1 and current_zoom > 1.05 and not is_pinching:
			current_pan += event.relative
			_clamp_pan(vp_size)
			_apply_transform()
			get_viewport().set_input_as_handled()

	# =========================================================================
	# C) CONTROLES PC (RUEDA DEL RATÓN / CLIC DERECHO)
	# =========================================================================
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_step_zoom(1.18, event.position)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_step_zoom(0.82, event.position)
		elif event.button_index in [MOUSE_BUTTON_RIGHT, MOUSE_BUTTON_MIDDLE]:
			is_dragging_pc = event.pressed and (current_zoom > 1.0)

	elif event is InputEventMouseMotion and is_dragging_pc:
		if current_zoom > 1.0:
			current_pan += event.relative
			_clamp_pan(vp_size)
			_apply_transform()

	elif event is InputEventKey and event.pressed and not event.echo:
		if event.keycode in [KEY_ESCAPE, KEY_SPACE] and current_zoom > 1.05:
			reset_zoom(true)

func _start_pinch() -> void:
	is_pinching = true
	var pts = touch_points.values()
	start_distance = maxf(12.0, pts[0].distance_to(pts[1]))
	start_zoom = current_zoom
	start_midpoint = (pts[0] + pts[1]) / 2.0
	start_pan = current_pan

func _step_zoom(factor: float, center_pos: Vector2) -> void:
	var vp_size: Vector2 = get_viewport().get_visible_rect().size
	var target_zoom: float = clampf(current_zoom * factor, min_zoom, max_zoom)

	if target_zoom <= 1.03:
		current_zoom = 1.0
		current_pan = Vector2.ZERO
	else:
		var content_pt: Vector2 = (center_pos - current_pan) / current_zoom
		current_zoom = target_zoom
		current_pan = center_pos - (content_pt * current_zoom)
		_clamp_pan(vp_size)

	_apply_transform()

func _clamp_pan(vp_size: Vector2) -> void:
	if current_zoom <= 1.0:
		current_pan = Vector2.ZERO
		return
	var min_pan: Vector2 = vp_size * (1.0 - current_zoom)
	current_pan.x = clampf(current_pan.x, min_pan.x, 0.0)
	current_pan.y = clampf(current_pan.y, min_pan.y, 0.0)

func _apply_transform() -> void:
	var t := Transform2D(Vector2(current_zoom, 0), Vector2(0, current_zoom), current_pan)
	get_viewport().global_canvas_transform = t

	# Evitar que la botonera de zoom se deforme con el escalado
	if hud_layer and is_instance_valid(hud_layer):
		hud_layer.transform = t.affine_inverse()

	if reset_btn and is_instance_valid(reset_btn):
		reset_btn.visible = (current_zoom > 1.05)
		if reset_btn.visible:
			reset_btn.text = "🔍 Restablecer Lupa (%.1fx)" % current_zoom

func reset_zoom(animated: bool = true) -> void:
	touch_points.clear()
	start_distance = 0.0
	is_pinching = false
	is_dragging_pc = false

	if current_zoom == 1.0 and current_pan == Vector2.ZERO:
		if reset_btn: reset_btn.visible = false
		return

	if animated:
		if zoom_tween and zoom_tween.is_running(): zoom_tween.kill()
		zoom_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		zoom_tween.tween_method(func(v): current_zoom = v; _apply_transform(), current_zoom, 1.0, 0.2)
		zoom_tween.tween_method(func(v): current_pan = v; _apply_transform(), current_pan, Vector2.ZERO, 0.2)
		zoom_tween.chain().tween_callback(func():
			current_zoom = 1.0
			current_pan = Vector2.ZERO
			_apply_transform()
		)
	else:
		current_zoom = 1.0
		current_pan = Vector2.ZERO
		_apply_transform()

```

---

####### 📄 Archivo: `zoom_controller.gd.uid`

```
uid://b2kse0uqclu26

```

---

###### 📁 Carpeta: `./features\room\generators/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `generator_view.gd`

```
# res://features/room/generators/generator_view.gd
extends Node2D

var instance_id: String = ""
var generator_data: GeneratorData = null
var is_active: bool = false
var is_pinned: bool = false
var target_death_ticks: int = 0
var current_durability: float = 100.0
var current_level: int = 1

@onready var plant_texture: TextureRect = $PlantTexture
@onready var status_indicator: ColorRect = $StatusIndicator
@onready var time_label: Label = $TimeBadge/TimeLabel
@onready var click_area: Button = $ClickArea

func _ready() -> void:
	click_area.pressed.connect(_on_clicked)
	click_area.mouse_entered.connect(_on_mouse_entered)
	click_area.mouse_exited.connect(_on_mouse_exited)

func setup_from_server(data: GeneratorData, db_id: String, remaining_seconds: int, durability: float = 100.0, level: int = 1) -> void:
	generator_data = data
	instance_id = db_id
	current_durability = durability
	current_level = level
	
	if generator_data != null and generator_data.texture != null:
		plant_texture.texture = generator_data.texture
		
	var base_power: float = generator_data.power_kwp if generator_data else 0.000000001
	var base_rate: float = generator_data.reward_kilowat if generator_data else 0.000000001
	
	# Aplicar el bono por nivel permanente (+25% por cada nivel arriba de 1)
	var level_multiplier: float = 1.0 + (max(1, current_level) - 1) * 0.25
	var power_val: float = base_power * level_multiplier
	var rate_val: float = base_rate * level_multiplier
		
	if remaining_seconds > 0 and current_durability > 0.0:
		is_active = true
		target_death_ticks = Time.get_ticks_msec() + (remaining_seconds * 1000)
		status_indicator.color = Color(0.2, 0.9, 0.2, 1) # Verde óptimo
		GameManager.set_generator_power(instance_id, true, power_val, rate_val)
	else:
		is_active = false
		target_death_ticks = 0
		status_indicator.color = Color(0.9, 0.2, 0.2, 1) # Rojo averiado o apagado
		time_label.text = "EN PANNE" if current_durability <= 0.0 else "OFF"
		GameManager.set_generator_power(instance_id, false, power_val, rate_val)

func _process(_delta: float) -> void:
	if not is_active: return
	var current_ticks = Time.get_ticks_msec()
	
	if current_ticks < target_death_ticks:
		var remaining_seconds: int = int((target_death_ticks - current_ticks) / 1000.0)
		var hours: int = int(float(remaining_seconds) / 3600.0)
		var minutes: int = int(float(remaining_seconds % 3600) / 60.0)
		var seconds: int = remaining_seconds % 60
		time_label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
	else:
		is_active = false
		status_indicator.color = Color(0.9, 0.2, 0.2, 1)
		time_label.text = "OFF"
		GameManager.set_generator_power(instance_id, false, 0.0)

func _get_info_payload() -> Dictionary:
	var base_power = generator_data.power_kwp if generator_data else 0.000000001
	var base_rate = generator_data.reward_kilowat if generator_data else 0.000000001
	var mult = 1.0 + (max(1, current_level) - 1) * 0.25
	
	return {
		"name": generator_data.name if generator_data else "Generador",
		"level": current_level,
		"durability": current_durability,
		"rarity": generator_data.rarity if generator_data else "COMÚN",
		"power": "%.9f KWP" % (base_power * mult),
		"income": "+%.9f kW / min" % (base_rate * mult),
		"is_active": is_active,
		"time_left": time_label.text,
		"description": generator_data.description if generator_data else ""
	}
	
func _on_mouse_entered() -> void:
	EventBus.show_plant_info.emit(_get_info_payload(), global_position)

func _on_mouse_exited() -> void:
	if not is_pinned: EventBus.hide_plant_info.emit()

func _on_clicked() -> void:
	if not is_active and instance_id != "" and current_durability > 0.0:
		reactivate_in_supabase()
	else:
		is_pinned = not is_pinned
		if is_pinned: EventBus.show_plant_info.emit(_get_info_payload(), global_position)
		else: EventBus.hide_plant_info.emit()

func reactivate_in_supabase() -> void:
	time_label.text = "..."
	var body = {"p_generator_id": instance_id}
	var res: Dictionary = await SupabaseClient.send_request("/rest/v1/rpc/activate_generator", HTTPClient.METHOD_POST, body, true)
	
	if res.get("success", false) and typeof(res["data"]) == TYPE_DICTIONARY and res["data"].get("success", false):
		var new_sec: int = int(res["data"].get("remaining_active_seconds", 21600))
		setup_from_server(generator_data, instance_id, new_sec, current_durability, current_level)
		
		for g in GameManager.player_generators:
			if str(g.get("id", "")) == instance_id:
				g["remaining_active_seconds"] = new_sec
				break

```

---

####### 📄 Archivo: `generator_view.gd.uid`

```
uid://cvosbmqic6gds

```

---

####### 📄 Archivo: `generator_view.tscn`

```
[gd_scene format=3 uid="uid://cgenview001"]

[ext_resource type="Script" path="res://features/room/generators/generator_view.gd" id="1_gview"]

[node name="GeneratorView" type="Node2D"]
script = ExtResource("1_gview")

[node name="PlantTexture" type="TextureRect" parent="."]
offset_left = -24.0
offset_top = -62.0
offset_right = 24.0
offset_bottom = -10.0
mouse_filter = 2
expand_mode = 1
stretch_mode = 5

[node name="StatusIndicator" type="ColorRect" parent="."]
offset_left = 15.0
offset_top = -60.0
offset_right = 21.0
offset_bottom = -54.0
mouse_filter = 2
color = Color(0.2, 0.9, 0.2, 1)

[node name="TimeBadge" type="ColorRect" parent="."]
offset_left = -21.0
offset_top = -10.0
offset_right = 21.0
mouse_filter = 2
color = Color(0.06, 0.06, 0.08, 0.9)

[node name="TimeLabel" type="Label" parent="TimeBadge"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_colors/font_color = Color(0.9, 1, 0.9, 1)
theme_override_font_sizes/font_size = 8
text = "06:00:00"
horizontal_alignment = 1
vertical_alignment = 1

[node name="ClickArea" type="Button" parent="."]
offset_left = -24.0
offset_top = -62.0
offset_right = 24.0
mouse_default_cursor_shape = 2
flat = true
```

---

####### 📄 Archivo: `plant_info_card.gd`

```
# res://features/room/generators/plant_info_card.gd
extends PanelContainer

@onready var card_rarity: Label = $Margin/VBox/HeaderBox/RarityBadge
@onready var card_level: Label = $Margin/VBox/HeaderBox/LevelBadge
@onready var card_name: Label = $Margin/VBox/PlantNameLabel
@onready var card_power: Label = $Margin/VBox/PowerRow/PowerVal
@onready var card_income: Label = $Margin/VBox/IncomeRow/IncomeVal
@onready var card_status: Label = $Margin/VBox/StatusRow/StatusVal
@onready var card_desc: Label = $Margin/VBox/DescriptionLabel

func _ready() -> void:
	visible = false
	EventBus.show_plant_info.connect(_on_show_info)
	EventBus.hide_plant_info.connect(_on_hide_info)

func _on_show_info(info: Dictionary, plant_global_pos: Vector2) -> void:
	card_name.text = str(info.get("name", "Generador"))
	card_level.text = "NIVEL %d" % int(info.get("level", 1))
	card_rarity.text = "★ " + str(info.get("rarity", "COMÚN"))
	card_power.text = str(info.get("power", "0.000000050 KWP"))
	card_income.text = str(info.get("income", "+0.000000050 kW / min"))
	
	var dur: float = float(info.get("durability", 100.0))
	var is_act: bool = bool(info.get("is_active", false))
	
	if dur <= 0.0:
		card_status.text = "💥 AVERIADA (0% Durabilidad - Ir al Taller)"
		card_status.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
	elif is_act:
		card_status.text = "ACTIVA (%.0f%% Dur.) [%s]" % [dur, str(info.get("time_left", ""))]
		card_status.add_theme_color_override("font_color", Color(0.4, 1.0, 0.4))
	else:
		card_status.text = "APAGADA (%.0f%% Durabilidad)" % dur
		card_status.add_theme_color_override("font_color", Color(1.0, 0.75, 0.2))
		
	card_desc.text = str(info.get("description", ""))
	
	var target_x: float = plant_global_pos.x + 35.0
	var target_y: float = plant_global_pos.y - 120.0
	if target_x + 280.0 > 1260.0: target_x = plant_global_pos.x - 295.0
		
	position = Vector2(target_x, maxf(70.0, target_y))
	visible = true

func _on_hide_info() -> void:
	visible = false

```

---

####### 📄 Archivo: `plant_info_card.gd.uid`

```
uid://d4nl4huk5f4rm

```

---

####### 📄 Archivo: `plant_info_card.tscn`

```
[gd_scene format=3 uid="uid://bbvnvulbjbuqq"]

[ext_resource type="Script" path="res://features/room/generators/plant_info_card.gd" id="1_pinfo"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_card"]
bg_color = Color(0.08, 0.10, 0.15, 0.98)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.35, 0.88, 1, 1)
corner_radius_top_left = 10
corner_radius_top_right = 10
corner_radius_bottom_right = 10
corner_radius_bottom_left = 10

[node name="PlantInfoCard" type="PanelContainer"]
visible = false
custom_minimum_size = Vector2(300, 0)
offset_right = 300.0
offset_bottom = 230.0
mouse_filter = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_card")
script = ExtResource("1_pinfo")

[node name="Margin" type="MarginContainer" parent="."]
layout_mode = 2
theme_override_constants/margin_left = 14
theme_override_constants/margin_top = 14
theme_override_constants/margin_right = 14
theme_override_constants/margin_bottom = 14

[node name="VBox" type="VBoxContainer" parent="Margin"]
layout_mode = 2
theme_override_constants/separation = 8

[node name="HeaderBox" type="HBoxContainer" parent="Margin/VBox"]
layout_mode = 2

[node name="RarityBadge" type="Label" parent="Margin/VBox/HeaderBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.84, 0.1, 1)
theme_override_font_sizes/font_size = 12
text = "★ EXCLUSIVA"

[node name="Spacer" type="Control" parent="Margin/VBox/HeaderBox"]
layout_mode = 2
size_flags_horizontal = 3

[node name="LevelBadge" type="Label" parent="Margin/VBox/HeaderBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.6, 0.8, 1, 1)
theme_override_font_sizes/font_size = 12
text = "NIVEL 1"

[node name="PlantNameLabel" type="Label" parent="Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 16
text = "Planta"

[node name="HSeparator1" type="HSeparator" parent="Margin/VBox"]
layout_mode = 2

[node name="PowerRow" type="HBoxContainer" parent="Margin/VBox"]
layout_mode = 2

[node name="PowerTitle" type="Label" parent="Margin/VBox/PowerRow"]
layout_mode = 2
text = "⚡ Potencia:"

[node name="PowerVal" type="Label" parent="Margin/VBox/PowerRow"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.38, 0.82, 1, 1)
text = "0.000000001 KWP"
horizontal_alignment = 2

[node name="IncomeRow" type="HBoxContainer" parent="Margin/VBox"]
layout_mode = 2

[node name="IncomeTitle" type="Label" parent="Margin/VBox/IncomeRow"]
layout_mode = 2
text = "🪙 Generación:"

[node name="IncomeVal" type="Label" parent="Margin/VBox/IncomeRow"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(1, 0.85, 0.2, 1)
text = "+1e-9 kW / min"
horizontal_alignment = 2

[node name="StatusRow" type="HBoxContainer" parent="Margin/VBox"]
layout_mode = 2

[node name="StatusTitle" type="Label" parent="Margin/VBox/StatusRow"]
layout_mode = 2
text = "🔌 Estado:"

[node name="StatusVal" type="Label" parent="Margin/VBox/StatusRow"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.4, 1, 0.4, 1)
text = "ACTIVA"
horizontal_alignment = 2

[node name="HSeparator2" type="HSeparator" parent="Margin/VBox"]
layout_mode = 2

[node name="DescriptionLabel" type="Label" parent="Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.8, 0.85, 0.9, 0.85)
theme_override_font_sizes/font_size = 11
autowrap_mode = 2
```

---

###### 📁 Carpeta: `./features\room\grid/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `floor_slot.gd`

```
# res://features/room/grid/floor_slot.gd
extends Control

signal slot_clicked(slot_index: int)
signal slot_hold_completed(slot_index: int)

@export var slot_index: int = 0
@export var hold_duration: float = 1.2

@onready var slot_border: ReferenceRect = $SlotBorder
@onready var click_button: Button = $ClickButton
@onready var rack_container: Marker2D = $RackContainer

var is_occupied: bool = false
var is_pressing: bool = false
var was_hold_completed: bool = false
var hold_progress: float = 0.0
var hold_timer: float = 0.0

func _ready() -> void:
	click_button.button_down.connect(_on_button_down)
	click_button.button_up.connect(_on_button_up)
	click_button.mouse_entered.connect(_on_mouse_entered)
	click_button.mouse_exited.connect(_on_mouse_exited)

func set_slot_index(idx: int) -> void:
	slot_index = idx

func set_border_visible(show_border: bool) -> void:
	slot_border.visible = show_border

func _process(delta: float) -> void:
	if is_pressing and is_occupied:
		hold_timer += delta
		hold_progress = clampf(hold_timer / hold_duration, 0.0, 1.0)
		queue_redraw()
		
		if hold_timer >= hold_duration:
			is_pressing = false
			was_hold_completed = true
			hold_progress = 0.0
			queue_redraw()
			slot_hold_completed.emit(slot_index)

func _draw() -> void:
	if is_occupied and hold_progress > 0.0:
		var center := Vector2(size.x / 2.0, size.y / 2.0)
		var radius: float = 34.0
		var bg_color := Color(0.08, 0.1, 0.15, 0.85)
		var arc_color := Color(0.18, 0.92, 0.82, 1.0)
		var width: float = 6.0
		
		draw_arc(center, radius, 0, TAU, 36, bg_color, width + 2.0, true)
		var start_angle := -PI / 2.0
		var end_angle := start_angle + (hold_progress * TAU)
		draw_arc(center, radius, start_angle, end_angle, 36, arc_color, width, true)

func _on_button_down() -> void:
	was_hold_completed = false
	if is_occupied:
		is_pressing = true
		hold_timer = 0.0
		hold_progress = 0.0
		queue_redraw()

func _on_button_up() -> void:
	if was_hold_completed:
		was_hold_completed = false
		is_pressing = false
		hold_progress = 0.0
		queue_redraw()
		return
		
	is_pressing = false
	hold_progress = 0.0
	queue_redraw()
	
	# Si soltó el clic antes de 1.2s, siempre se considera un clic válido
	slot_clicked.emit(slot_index)

func _on_mouse_entered() -> void:
	if not is_occupied: slot_border.border_color = Color(0.4, 1.0, 0.4, 0.7)

func _on_mouse_exited() -> void:
	if is_pressing:
		is_pressing = false
		hold_progress = 0.0
		queue_redraw()
	if not is_occupied: slot_border.border_color = Color(0.3, 0.7, 0.3, 0.25)

```

---

####### 📄 Archivo: `floor_slot.gd.uid`

```
uid://fhawg5akvohd

```

---

####### 📄 Archivo: `floor_slot.tscn`

```
[gd_scene format=3 uid="uid://cfloorslot001"]

[ext_resource type="Script" path="res://features/room/grid/floor_slot.gd" id="1_slot"]

[node name="FloorSlot" type="Control"]
custom_minimum_size = Vector2(140, 220)
layout_mode = 3
anchors_preset = 0
offset_right = 140.0
offset_bottom = 220.0
mouse_filter = 1
script = ExtResource("1_slot")

[node name="SlotBorder" type="ReferenceRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
border_color = Color(0.3, 0.7, 0.3, 0.3)
border_width = 1.5
editor_only = false

[node name="ClickButton" type="Button" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_default_cursor_shape = 2
flat = true

[node name="RackContainer" type="Marker2D" parent="."]
position = Vector2(70, 220)
```

---

####### 📄 Archivo: `room_grid.gd`

```
# res://features/room/grid/room_grid.gd
extends Node2D

signal slot_selected(slot_index: int)
signal rack_hold_unmounted(slot_index: int)

@export_group("Dimensiones de Estantería")
@export var slot_width: float = 140.0
@export var slot_height: float = 220.0
@export var show_guides: bool = true

@export_group("Posicionamiento Manual por Coordenadas")
@export var custom_slot_positions: Array[Vector2] = []

const FLOOR_SLOT_SCENE: PackedScene = preload("res://features/room/grid/floor_slot.tscn")

@onready var slots_container: Node2D = $SlotsContainer
@onready var custom_markers: Node2D = $CustomMarkers

var slots_list: Array = []

func _ready() -> void:
	build_grid()

func build_grid() -> void:
	for child in slots_container.get_children():
		child.queue_free()
	slots_list.clear()

	# Coordenadas exactas para los 6 estantes en 2 filas de 3
	var final_positions: Array[Vector2] = [
		Vector2(480, 360), Vector2(680, 360), Vector2(890, 360), # Fila 1 (Superior)
		Vector2(480, 600), Vector2(680, 600), Vector2(890, 600)  # Fila 2 (Inferior)
	]

	for i in range(final_positions.size()):
		var slot_instance = FLOOR_SLOT_SCENE.instantiate()
		slot_instance.custom_minimum_size = Vector2(slot_width, slot_height)
		slot_instance.size = Vector2(slot_width, slot_height)
		
		var base_pos: Vector2 = final_positions[i]
		var top_left_x: float = base_pos.x - (slot_width / 2.0)
		var top_left_y: float = base_pos.y - slot_height
		slot_instance.position = Vector2(top_left_x, top_left_y)
		
		slots_container.add_child(slot_instance)
		slot_instance.set_slot_index(i)
		slot_instance.set_border_visible(show_guides)
		
		if not slot_instance.slot_clicked.is_connected(_on_slot_clicked):
			slot_instance.slot_clicked.connect(_on_slot_clicked)
			
		var slot_idx_val: int = i
		slot_instance.slot_hold_completed.connect(func(_idx): rack_hold_unmounted.emit(slot_idx_val))
		slots_list.append(slot_instance)
		
func set_slot_occupied(index: int, occupied: bool) -> void:
	if index >= 0 and index < slots_list.size():
		slots_list[index].is_occupied = occupied

func _on_slot_clicked(index: int) -> void:
	slot_selected.emit(index)

func get_slot_container(index: int) -> Marker2D:
	if index >= 0 and index < slots_list.size():
		return slots_list[index].rack_container
	return null
```

---

####### 📄 Archivo: `room_grid.gd.uid`

```
uid://dsnvgj78s8sp2

```

---

####### 📄 Archivo: `room_grid.tscn`

```
[gd_scene format=3 uid="uid://gv7vnjp665xq"]

[ext_resource type="Script" path="res://features/room/grid/room_grid.gd" id="1_rgrid"]

[node name="RoomGrid" type="Node2D"]
script = ExtResource("1_rgrid")
show_guides = true

[node name="CustomMarkers" type="Node2D" parent="."]

# FILA 1 (Superior: 3 Estantes)
[node name="Slot0" type="Marker2D" parent="CustomMarkers"]
position = Vector2(480, 360)
gizmo_extents = 20.0

[node name="Slot1" type="Marker2D" parent="CustomMarkers"]
position = Vector2(670, 360)
gizmo_extents = 20.0

[node name="Slot2" type="Marker2D" parent="CustomMarkers"]
position = Vector2(860, 360)
gizmo_extents = 20.0

# FILA 2 (Inferior: 3 Estantes)
[node name="Slot3" type="Marker2D" parent="CustomMarkers"]
position = Vector2(480, 600)
gizmo_extents = 20.0

[node name="Slot4" type="Marker2D" parent="CustomMarkers"]
position = Vector2(670, 600)
gizmo_extents = 20.0

[node name="Slot5" type="Marker2D" parent="CustomMarkers"]
position = Vector2(860, 600)
gizmo_extents = 20.0

[node name="SlotsContainer" type="Node2D" parent="."]
```

---

###### 📁 Carpeta: `./features\room\racks/`

####### 📄 Archivo: `.gitkeep`

```

```

---

####### 📄 Archivo: `rack_manage_dialog.gd`

```
# res://features/room/racks/rack_manage_dialog.gd
extends PanelContainer

signal generator_unmounted(gen_id: String)
signal generator_mounted(gen_id: String, slot_idx: int)

@onready var dialog_title: Label = $Margin/VBox/DialogTitle
@onready var dialog_status: Label = $Margin/VBox/DialogStatus
@onready var slots_list: VBoxContainer = $Margin/VBox/SlotsScroll/SlotsList
@onready var close_btn: Button = $Margin/VBox/CloseBtn

var current_rack: Dictionary = {}
var current_rack_data: RackData = null

func _ready() -> void:
	close_btn.pressed.connect(func(): visible = false)

func open_dialog(rack: Dictionary, rack_data: RackData) -> void:
	current_rack = rack
	current_rack_data = rack_data
	dialog_title.text = "GESTIÓN: %s" % rack_data.name.to_upper()
	
	for child in slots_list.get_children():
		child.queue_free()
		
	var rack_id: String = str(rack.get("id", rack.get("rack_id", "")))
	var placed_count: int = 0
	
	for slot_idx in range(rack_data.total_slots):
		var slot_card := PanelContainer.new()
		var slot_hbox := HBoxContainer.new()
		slot_hbox.add_theme_constant_override("separation", 12)
		
		var slot_num_lbl := Label.new()
		slot_num_lbl.text = "Espacio %d:" % (slot_idx + 1)
		slot_num_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		slot_hbox.add_child(slot_num_lbl)
		
		var installed_gen: Dictionary = {}
		for gen in GameManager.player_generators:
			if str(gen.get("rack_id", "")) == rack_id and int(gen.get("slot_in_rack", -1)) == slot_idx:
				installed_gen = gen
				break
				
		if not installed_gen.is_empty():
			placed_count += 1
			var g_type = str(installed_gen.get("generator_type", ""))
			var tier = _get_generator_tier(g_type)
			var tier_name = ["Común", "Poco Común", "Especial", "Épico", "Legendario"][tier - 1]
			
			var name_lbl := Label.new()
			name_lbl.text = "%s [%s]" % [_format_gen_name(g_type), tier_name]
			name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			slot_hbox.add_child(name_lbl)
			
			var unmount_btn := Button.new()
			unmount_btn.text = "❌ Quitar"
			unmount_btn.custom_minimum_size = Vector2(90, 32)
			unmount_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			unmount_btn.add_theme_color_override("font_color", Color(1.0, 0.35, 0.35))
			
			var gid = str(installed_gen.get("id", ""))
			unmount_btn.pressed.connect(func():
				visible = false
				generator_unmounted.emit(gid)
			)
			slot_hbox.add_child(unmount_btn)
		else:
			var empty_lbl := Label.new()
			empty_lbl.text = "(Vacío)"
			empty_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			empty_lbl.add_theme_color_override("font_color", Color(0.5, 0.55, 0.65))
			slot_hbox.add_child(empty_lbl)
			
			var mount_btn := MenuButton.new()
			mount_btn.text = "➕ Colocar..."
			mount_btn.custom_minimum_size = Vector2(110, 32)
			mount_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			mount_btn.add_theme_color_override("font_color", Color(0.4, 1.0, 0.55))
			
			var popup: PopupMenu = mount_btn.get_popup()
			popup.clear()
			
			var unplaced_gens: Array = []
			for gen in GameManager.player_generators:
				var is_unmounted = (gen.get("rack_id") == null or str(gen.get("rack_id")) == "" or str(gen.get("rack_id")) == "null")
				if is_unmounted:
					unplaced_gens.append(gen)
					
			if unplaced_gens.is_empty():
				popup.add_item("Sin equipos en almacén")
				popup.set_item_disabled(0, true)
			else:
				for i in range(unplaced_gens.size()):
					var g_type = str(unplaced_gens[i].get("generator_type", ""))
					var limit = _get_room_limit_for_type(g_type)
					var active_count = _get_active_count_for_type(g_type)
					
					if active_count >= limit:
						popup.add_item("%s (Límite %d/%d en sala)" % [_format_gen_name(g_type), active_count, limit], i)
						popup.set_item_disabled(i, true)
					else:
						popup.add_item("%s (%d/%d en sala)" % [_format_gen_name(g_type), active_count, limit], i)
					
				var s_idx = slot_idx
				var list_copy = unplaced_gens.duplicate()
				popup.id_pressed.connect(func(clicked_idx: int):
					if clicked_idx >= 0 and clicked_idx < list_copy.size():
						visible = false
						generator_mounted.emit(str(list_copy[clicked_idx]["id"]), s_idx)
				)
			slot_hbox.add_child(mount_btn)
			
		slot_card.add_child(slot_hbox)
		slots_list.add_child(slot_card)
		
	dialog_status.text = "Espacios en uso: %d / %d" % [placed_count, rack_data.total_slots]
	visible = true

# ====================================================================
# CONTROL DE LIMITES Y TIERS
# ====================================================================

func _get_generator_tier(g_type: String) -> int:
	if GameManager.has_method("get_generator_tier"):
		return GameManager.get_generator_tier(g_type)
	match g_type:
		"planta_meme", "dinamo_manual", "ecoflow_spark", "bateria_plomo": return 1
		"ecoflow_spark_plus", "panel_solar", "molino_eolico": return 2
		"delta_mini", "inverter_silencioso": return 3
		"ecoflow_thunder_pro", "pro_electrico", "turbina_hidro": return 4
		"ecoflow_ultra", "cyber_tank", "reactor_magnetico": return 5
		_: return 1

func _get_room_limit_for_type(g_type: String) -> int:
	var tier = _get_generator_tier(g_type)
	match tier:
		1: return 4 # 4 de cada modelo común
		2: return 3 # 3 de cada modelo poco común
		3: return 2 # 2 de cada modelo especial
		4: return 1 # 1 de cada modelo épico
		5: return 1 # 1 de cada modelo legendario
		_: return 1

func _get_active_count_for_type(g_type: String) -> int:
	var count: int = 0
	for gen in GameManager.player_generators:
		var is_mounted = (gen.get("rack_id") != null and str(gen.get("rack_id")) != "" and str(gen.get("rack_id")) != "null")
		if is_mounted and str(gen.get("generator_type", "")) == g_type:
			count += 1
	return count

func _format_gen_name(g_type: String) -> String:
	match g_type:
		"planta_meme": return "Planta Meme"
		"dinamo_manual": return "Generador Manual"
		"ecoflow_spark": return "EcoFlow Spark"
		"bateria_plomo": return "Batería de Plomo"
		"ecoflow_spark_plus": return "EcoFlow Spark Plus"
		"panel_solar": return "Panel Solar"
		"molino_eolico": return "Mini Molino Eólico"
		"delta_mini": return "EcoFlow DELTA Mini"
		"inverter_silencioso": return "Inverter Silencioso"
		"ecoflow_thunder_pro": return "EcoFlow Thunder Pro"
		"pro_electrico": return "EcoFlow Pro Eléctrico"
		"turbina_hidro": return "Turbina Hidroeléctrica"
		"ecoflow_ultra": return "EcoFlow Ultra"
		"cyber_tank": return "Cyber Tank 100%"
		"reactor_magnetico": return "Reactor Magnético"
		_: return "Generador"
```

---

####### 📄 Archivo: `rack_manage_dialog.gd.uid`

```
uid://dmabmspey7rkp

```

---

####### 📄 Archivo: `rack_manage_dialog.tscn`

```
[gd_scene format=3 uid="uid://crackman001"]

[ext_resource type="Script" path="res://features/room/racks/rack_manage_dialog.gd" id="1_rackman"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_modal"]
bg_color = Color(0.09, 0.11, 0.16, 0.98)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.35, 0.88, 1, 1)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[node name="RackManageDialog" type="PanelContainer"]
visible = false
custom_minimum_size = Vector2(520, 420)
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -260.0
offset_top = -210.0
offset_right = 260.0
offset_bottom = 210.0
grow_horizontal = 2
grow_vertical = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_modal")
script = ExtResource("1_rackman")

[node name="Margin" type="MarginContainer" parent="."]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_top = 18
theme_override_constants/margin_right = 20
theme_override_constants/margin_bottom = 18

[node name="VBox" type="VBoxContainer" parent="Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="DialogTitle" type="Label" parent="Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.35, 0.88, 1, 1)
theme_override_font_sizes/font_size = 18
text = "GESTIÓN DE ESTANTERÍA"
horizontal_alignment = 1

[node name="DialogStatus" type="Label" parent="Margin/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.7, 0.75, 0.85, 0.9)
theme_override_font_sizes/font_size = 12
text = "Espacios en uso: 0 / 2"
horizontal_alignment = 1

[node name="HSep" type="HSeparator" parent="Margin/VBox"]
layout_mode = 2

[node name="SlotsScroll" type="ScrollContainer" parent="Margin/VBox"]
layout_mode = 2
size_flags_vertical = 3

[node name="SlotsList" type="VBoxContainer" parent="Margin/VBox/SlotsScroll"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 10

[node name="CloseBtn" type="Button" parent="Margin/VBox"]
custom_minimum_size = Vector2(0, 38)
layout_mode = 2
mouse_default_cursor_shape = 2
text = "Cerrar"
```

---

####### 📄 Archivo: `rack_view.gd`

```
# res://features/room/racks/rack_view.gd
extends Node2D

var instance_id: String = ""
var rack_data: RackData = null
var current_floor_slot: int = -1

@onready var sprite: Sprite2D = $Sprite
@onready var plant_slots_container: Node2D = $PlantSlots

func setup_rack(data: RackData, db_id: String = "", floor_idx: int = -1) -> void:
	rack_data = data
	instance_id = db_id
	current_floor_slot = floor_idx
	
	if rack_data != null and rack_data.texture != null:
		sprite.texture = rack_data.texture
		sprite.visible = true
		sprite.centered = true
		sprite.offset = Vector2(0, -rack_data.texture.get_height() / 2.0)
	else:
		sprite.visible = false

func get_slot_marker(slot_index: int) -> Marker2D:
	var markers = plant_slots_container.get_children()
	if slot_index >= 0 and slot_index < markers.size():
		return markers[slot_index]
	return null
```

---

####### 📄 Archivo: `rack_view.gd.uid`

```
uid://bvnt08750o2yx

```

---

####### 📄 Archivo: `rack_view.tscn`

```
[gd_scene format=3 uid="uid://crackview001"]

[ext_resource type="Script" path="res://features/room/racks/rack_view.gd" id="1_rview"]

[node name="RackView" type="Node2D"]
script = ExtResource("1_rview")

[node name="Sprite" type="Sprite2D" parent="."]

[node name="PlantSlots" type="Node2D" parent="."]

[node name="Slot0" type="Marker2D" parent="PlantSlots"]
position = Vector2(-40, -15)
gizmo_extents = 15.0

[node name="Slot1" type="Marker2D" parent="PlantSlots"]
position = Vector2(30, -15)
gizmo_extents = 15.0

[node name="Slot2" type="Marker2D" parent="PlantSlots"]
position = Vector2(-40, -60)
gizmo_extents = 15.0

[node name="Slot3" type="Marker2D" parent="PlantSlots"]
position = Vector2(30, -60)
gizmo_extents = 15.0

[node name="Slot4" type="Marker2D" parent="PlantSlots"]
position = Vector2(-40, -110)
gizmo_extents = 15.0

[node name="Slot5" type="Marker2D" parent="PlantSlots"]
position = Vector2(30, -110)
gizmo_extents = 15.0
```

---

###### 📁 Carpeta: `./features\room\taller/`

####### 📄 Archivo: `taller_modal.gd`

```
# res://features/room/taller/taller_modal.gd
class_name TallerModal
extends Control

signal workshop_updated()

var current_tab: String = "craft" # "craft", "repair", "upgrade", "inventory"
var selected_tier: int = 1
var modal_zoom: float = 1.0
var min_zoom: float = 0.75
var max_zoom: float = 1.6

var main_panel: PanelContainer
var content_list: VBoxContainer
var tab_craft_btn: Button
var tab_repair_btn: Button
var tab_upgrade_btn: Button
var tab_parts_btn: Button
var status_lbl: Label
var zoom_label: Label
var header_title: Label

# Detección táctil
var modal_touches: Dictionary = {}
var initial_pinch_dist: float = 0.0
var initial_pinch_zoom: float = 1.0

var parts_texture_cache: Dictionary = {}

func _ready() -> void:
	visible = false
	_build_ui_layout()

func open_modal() -> void:
	visible = true
	current_tab = "craft"
	_set_zoom(1.0)
	_refresh_view()
	
	await GameManager.load_player_parts()
	await GameManager.load_player_rpg_state()
	if visible: _refresh_view()

func _input(event: InputEvent) -> void:
	if not visible: return
	
	if event is InputEventScreenTouch:
		if event.pressed:
			modal_touches[event.index] = event.position
			if modal_touches.size() == 2:
				var pts = modal_touches.values()
				initial_pinch_dist = pts[0].distance_to(pts[1])
				initial_pinch_zoom = modal_zoom
				get_viewport().set_input_as_handled()
		else:
			modal_touches.erase(event.index)
			if modal_touches.size() < 2:
				initial_pinch_dist = 0.0

	elif event is InputEventScreenDrag:
		modal_touches[event.index] = event.position
		if modal_touches.size() >= 2 and initial_pinch_dist > 15.0:
			var pts = modal_touches.values()
			var current_dist: float = pts[0].distance_to(pts[1])
			var factor: float = current_dist / initial_pinch_dist
			_set_zoom(clampf(initial_pinch_zoom * factor, min_zoom, max_zoom))
			get_viewport().set_input_as_handled()

func _set_zoom(val: float) -> void:
	modal_zoom = clampf(val, min_zoom, max_zoom)
	if main_panel and is_instance_valid(main_panel):
		main_panel.pivot_offset = Vector2(460, 290)
		main_panel.scale = Vector2(modal_zoom, modal_zoom)
	if zoom_label and is_instance_valid(zoom_label):
		zoom_label.text = "%.0f%%" % (modal_zoom * 100.0)

func _build_ui_layout() -> void:
	for child in get_children(): child.queue_free()

	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var overlay := ColorRect.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0.02, 0.03, 0.05, 0.92)
	add_child(overlay)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	main_panel = PanelContainer.new()
	main_panel.custom_minimum_size = Vector2(920, 580)
	var p_st := StyleBoxFlat.new()
	p_st.bg_color = Color(0.07, 0.09, 0.13, 0.98)
	p_st.border_color = Color(1.0, 0.75, 0.2, 1.0)
	p_st.set_border_width_all(2); p_st.set_corner_radius_all(12)
	p_st.shadow_color = Color(1.0, 0.6, 0.1, 0.3); p_st.shadow_size = 14
	main_panel.add_theme_stylebox_override("panel", p_st)
	center.add_child(main_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20); margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 16); margin.add_theme_constant_override("margin_bottom", 16)
	main_panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	# Cabecera
	var header := HBoxContainer.new()
	header_title = Label.new()
	header_title.text = "🔧 TALLER DE INNOVACIÓN"
	header_title.add_theme_font_size_override("font_size", 17)
	header_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.25))
	header.add_child(header_title)

	var sp := Control.new()
	sp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(sp)

	# Barra de zoom
	var zoom_box := HBoxContainer.new()
	zoom_box.add_theme_constant_override("separation", 4)
	
	var btn_zoom_out := Button.new()
	btn_zoom_out.text = "🔍 -"
	btn_zoom_out.custom_minimum_size = Vector2(36, 30)
	btn_zoom_out.pressed.connect(func(): _set_zoom(modal_zoom - 0.2))
	zoom_box.add_child(btn_zoom_out)

	zoom_label = Label.new()
	zoom_label.text = "100%"
	zoom_label.add_theme_font_size_override("font_size", 11)
	zoom_label.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	zoom_box.add_child(zoom_label)

	var btn_zoom_in := Button.new()
	btn_zoom_in.text = "🔍 +"
	btn_zoom_in.custom_minimum_size = Vector2(36, 30)
	btn_zoom_in.pressed.connect(func(): _set_zoom(modal_zoom + 0.2))
	zoom_box.add_child(btn_zoom_in)

	var btn_reset_zoom := Button.new()
	btn_reset_zoom.text = "100%"
	btn_reset_zoom.custom_minimum_size = Vector2(46, 30)
	btn_reset_zoom.pressed.connect(func(): _set_zoom(1.0))
	zoom_box.add_child(btn_reset_zoom)
	header.add_child(zoom_box)

	var close_btn := Button.new()
	close_btn.text = "✕"
	close_btn.custom_minimum_size = Vector2(32, 30)
	close_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	close_btn.pressed.connect(func(): visible = false)
	header.add_child(close_btn)
	vbox.add_child(header)

	# Fila de pestañas
	var tabs_row := HBoxContainer.new()
	tabs_row.add_theme_constant_override("separation", 8)

	tab_craft_btn = Button.new()
	tab_craft_btn.text = "🔨 Fabricar Piezas"
	tab_craft_btn.custom_minimum_size = Vector2(165, 34)
	tab_craft_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_craft_btn.pressed.connect(func(): current_tab = "craft"; _refresh_view())
	tabs_row.add_child(tab_craft_btn)

	tab_repair_btn = Button.new()
	tab_repair_btn.text = "🛠️ Reparar Plantas"
	tab_repair_btn.custom_minimum_size = Vector2(165, 34)
	tab_repair_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_repair_btn.pressed.connect(func(): current_tab = "repair"; _refresh_view())
	tabs_row.add_child(tab_repair_btn)

	tab_upgrade_btn = Button.new()
	tab_upgrade_btn.text = "⚡ Subir Nivel"
	tab_upgrade_btn.custom_minimum_size = Vector2(150, 34)
	tab_upgrade_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_upgrade_btn.pressed.connect(func(): current_tab = "upgrade"; _refresh_view())
	tabs_row.add_child(tab_upgrade_btn)

	tab_parts_btn = Button.new()
	tab_parts_btn.text = "📦 Almacén"
	tab_parts_btn.custom_minimum_size = Vector2(130, 34)
	tab_parts_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tab_parts_btn.pressed.connect(func(): current_tab = "inventory"; _refresh_view())
	tabs_row.add_child(tab_parts_btn)
	vbox.add_child(tabs_row)

	var hsep := HSeparator.new()
	vbox.add_child(hsep)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	content_list = VBoxContainer.new()
	content_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content_list.add_theme_constant_override("separation", 10)
	scroll.add_child(content_list)

	status_lbl = Label.new()
	status_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_lbl.add_theme_font_size_override("font_size", 12)
	status_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	vbox.add_child(status_lbl)

func _refresh_view() -> void:
	status_lbl.text = ""
	var ing_lvl: int = GameManager.get_profession_level("ingeniero")
	header_title.text = "🔧 TALLER  |  ⚙️ Ingeniero Nv. %d / 25" % ing_lvl

	tab_craft_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "craft" else Color(0.7, 0.75, 0.85))
	tab_repair_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "repair" else Color(0.7, 0.75, 0.85))
	tab_upgrade_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "upgrade" else Color(0.7, 0.75, 0.85))
	tab_parts_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if current_tab == "inventory" else Color(0.7, 0.75, 0.85))

	for child in content_list.get_children(): child.queue_free()

	match current_tab:
		"craft": _build_crafting_tab()
		"repair": _build_repair_tab()
		"upgrade": _build_upgrade_tab()
		"inventory": _build_inventory_tab()

# ====================================================================
# PESTAÑA 1: FABRICACIÓN DE PIEZAS (CRAFTEO)
# ====================================================================
func _build_crafting_tab() -> void:
	# Selector de Tiers (1 al 5)
	var tier_selector := HBoxContainer.new()
	tier_selector.add_theme_constant_override("separation", 6)
	
	var ing_lvl: int = GameManager.get_profession_level("ingeniero")

	for t in range(1, 6):
		var t_btn := Button.new()
		t_btn.text = "Tier %d" % t
		t_btn.custom_minimum_size = Vector2(80, 30)
		t_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		var req_lvl = 0
		match t:
			2: req_lvl = 6
			3: req_lvl = 12
			4: req_lvl = 18
			5: req_lvl = 25
			
		var is_unlocked = (ing_lvl >= req_lvl)
		if not is_unlocked:
			t_btn.text = "🔒 T%d (Nv%d)" % [t, req_lvl]
			t_btn.add_theme_color_override("font_color", Color(0.5, 0.55, 0.65))
		elif t == selected_tier:
			t_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		else:
			t_btn.add_theme_color_override("font_color", Color(0.8, 0.85, 0.9))
			
		var chosen_t = t
		t_btn.pressed.connect(func():
			if ing_lvl >= req_lvl:
				selected_tier = chosen_t
				_build_crafting_tab()
			else:
				status_lbl.text = "⚠️ Requiere Ingeniero Nivel %d para desbloquear Tier %d." % [req_lvl, chosen_t]
		)
		tier_selector.add_child(t_btn)
	content_list.add_child(tier_selector)

	var hsep := HSeparator.new()
	content_list.add_child(hsep)

	# Catálogo de las 5 piezas crafteables
	var recipes = [
		{"type": "cable", "name": "Cable", "cobre": 4, "plastico": 2, "silicio": 0, "hierro": 0},
		{"type": "ventilador", "name": "Ventilador", "cobre": 0, "plastico": 2, "silicio": 0, "hierro": 4},
		{"type": "panel", "name": "Panel", "cobre": 3, "plastico": 0, "silicio": 3, "hierro": 0},
		{"type": "chip", "name": "Microchip", "cobre": 2, "plastico": 0, "silicio": 4, "hierro": 1},
		{"type": "condensador", "name": "Condensador Plasma", "cobre": 5, "plastico": 0, "silicio": 5, "hierro": 5}
	]

	for r in recipes:
		var ptype = str(r["type"])
		var have_cob = GameManager.get_material_quantity("cobre", selected_tier)
		var have_pla = GameManager.get_material_quantity("plastico", selected_tier)
		var have_sil = GameManager.get_material_quantity("silicio", selected_tier)
		var have_hie = GameManager.get_material_quantity("hierro", selected_tier)

		var can_craft: bool = true
		var cost_texts: Array = []

		if int(r["cobre"]) > 0:
			var ok = have_cob >= int(r["cobre"])
			if not ok: can_craft = false
			cost_texts.append("Cobre T%d: %d/%d %s" % [selected_tier, have_cob, int(r["cobre"]), "✓" if ok else "✕"])

		if int(r["plastico"]) > 0:
			var ok = have_pla >= int(r["plastico"])
			if not ok: can_craft = false
			cost_texts.append("Plástico T%d: %d/%d %s" % [selected_tier, have_pla, int(r["plastico"]), "✓" if ok else "✕"])

		if int(r["silicio"]) > 0:
			var ok = have_sil >= int(r["silicio"])
			if not ok: can_craft = false
			cost_texts.append("Silicio T%d: %d/%d %s" % [selected_tier, have_sil, int(r["silicio"]), "✓" if ok else "✕"])

		if int(r["hierro"]) > 0:
			var ok = have_hie >= int(r["hierro"])
			if not ok: can_craft = false
			cost_texts.append("Hierro T%d: %d/%d %s" % [selected_tier, have_hie, int(r["hierro"]), "✓" if ok else "✕"])

		# Tarjeta visual
		var card := PanelContainer.new()
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
		c_st.border_color = Color(0.25, 0.45, 0.65, 0.8)
		c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)

		var m := MarginContainer.new()
		m.add_theme_constant_override("margin_left", 14); m.add_theme_constant_override("margin_right", 14)
		m.add_theme_constant_override("margin_top", 10); m.add_theme_constant_override("margin_bottom", 10)
		card.add_child(m)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		m.add_child(hbox)

		var info_vbox := VBoxContainer.new()
		info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var name_lbl := Label.new()
		name_lbl.text = "🔩 %s (Tier %d)" % [str(r["name"]), selected_tier]
		name_lbl.add_theme_font_size_override("font_size", 14)
		info_vbox.add_child(name_lbl)

		var cost_lbl := Label.new()
		cost_lbl.text = "Materiales: " + " | ".join(cost_texts)
		cost_lbl.add_theme_font_size_override("font_size", 11)
		cost_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_craft else Color(1.0, 0.45, 0.45))
		info_vbox.add_child(cost_lbl)
		hbox.add_child(info_vbox)

		# Botón Fabricar
		var craft_btn := Button.new()
		craft_btn.text = "⚡ Fabricar"
		craft_btn.custom_minimum_size = Vector2(130, 36)
		craft_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		craft_btn.disabled = not can_craft
		craft_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		craft_btn.pressed.connect(func():
			craft_btn.disabled = true
			var res = await GameManager.craft_piece_secure(ptype, selected_tier, 1)
			if res.get("success", false):
				var d = res.get("data", {})
				var bonus_txt = " (¡Bono Doble!)" if d.get("double_bonus", false) else ""
				status_lbl.text = "✓ ¡Fabricado con éxito! +%d XP Ingeniero%s" % [d.get("xp_gained", 20), bonus_txt]
				workshop_updated.emit()
				_refresh_view()
			else:
				status_lbl.text = "⚠️ " + str(res.get("error", "Error al fabricar"))
				craft_btn.disabled = false
		)
		hbox.add_child(craft_btn)
		content_list.add_child(card)

# ====================================================================
# PESTAÑA 2: REPARACIÓN DE PLANTAS (ACTUALIZADA A LAS 5 RAREZAS)
# ====================================================================
func _build_repair_tab() -> void:
	if GameManager.player_generators.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No tienes generadores para reparar."
		empty_lbl.add_theme_font_size_override("font_size", 12)
		content_list.add_child(empty_lbl)
		return

	for gen in GameManager.player_generators:
		var gid = str(gen.get("id", ""))
		var gtype = str(gen.get("generator_type", ""))
		var dur = float(gen.get("durability", 100.0))
		var lvl = int(gen.get("level", 1))

		var card := PanelContainer.new()
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.09, 0.12, 0.18, 0.95)
		c_st.border_color = Color(0.25, 0.45, 0.65, 0.8)
		c_st.set_border_width_all(1)
		c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)

		var m := MarginContainer.new()
		m.add_theme_constant_override("margin_left", 14)
		m.add_theme_constant_override("margin_right", 14)
		m.add_theme_constant_override("margin_top", 10)
		m.add_theme_constant_override("margin_bottom", 10)
		card.add_child(m)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 16)
		m.add_child(hbox)

		var info_vbox := VBoxContainer.new()
		info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		# Nombre y Rareza
		var tier = GameManager.get_generator_tier(gtype)
		var tier_name = ["Común", "Poco Común", "Especial", "Épico", "Legendario"][tier - 1]

		var name_lbl := Label.new()
		name_lbl.text = "%s [%s] (Nivel %d)" % [_format_name(gtype), tier_name, lvl]
		name_lbl.add_theme_font_size_override("font_size", 14)
		info_vbox.add_child(name_lbl)

		# Barra de Durabilidad
		var dur_bar := ProgressBar.new()
		dur_bar.custom_minimum_size = Vector2(0, 8)
		dur_bar.max_value = 100.0
		dur_bar.value = dur
		dur_bar.show_percentage = false
		info_vbox.add_child(dur_bar)

		var status_text := Label.new()
		status_text.text = "Durabilidad: %.1f%% %s" % [dur, "✓ Óptima" if dur >= 50 else ("⚠️ Desgastada" if dur > 0 else "💥 AVERIADA")]
		status_text.add_theme_font_size_override("font_size", 11)
		status_text.add_theme_color_override("font_color", Color(0.4, 1.0, 0.5) if dur >= 50 else (Color(1.0, 0.7, 0.2) if dur > 0 else Color(1.0, 0.35, 0.35)))
		info_vbox.add_child(status_text)

		# Cálculo de Requisitos según la Rareza (Tier 1 a 5)
		var req_c = 0; var req_v = 0; var req_p = 0; var req_chip = 0; var req_cond = 0
		match tier:
			1: req_c = 6; req_v = 4
			2: req_c = 8; req_v = 5
			3: req_c = 10; req_v = 6; req_p = 4
			4: req_c = 12; req_v = 8; req_chip = 4
			5: req_c = 15; req_v = 10; req_chip = 6; req_cond = 4

		var have_c = GameManager.get_part_quantity("cable", tier)
		var have_v = GameManager.get_part_quantity("ventilador", tier)
		var have_p = GameManager.get_part_quantity("panel", tier)
		var have_chip = GameManager.get_part_quantity("chip", tier)
		var have_cond = GameManager.get_part_quantity("condensador", tier)

		var can_repair: bool = true
		var cost_strs: Array = []
		
		if req_c > 0:
			var ok = have_c >= req_c; if not ok: can_repair = false
			cost_strs.append("Cable Nv%d (%d/%d %s)" % [tier, have_c, req_c, "✓" if ok else "✕"])
		if req_v > 0:
			var ok = have_v >= req_v; if not ok: can_repair = false
			cost_strs.append("Vent Nv%d (%d/%d %s)" % [tier, have_v, req_v, "✓" if ok else "✕"])
		if req_p > 0:
			var ok = have_p >= req_p; if not ok: can_repair = false
			cost_strs.append("Panel Nv%d (%d/%d %s)" % [tier, have_p, req_p, "✓" if ok else "✕"])
		if req_chip > 0:
			var ok = have_chip >= req_chip; if not ok: can_repair = false
			cost_strs.append("Chip Nv%d (%d/%d %s)" % [tier, have_chip, req_chip, "✓" if ok else "✕"])
		if req_cond > 0:
			var ok = have_cond >= req_cond; if not ok: can_repair = false
			cost_strs.append("Cond Nv%d (%d/%d %s)" % [tier, have_cond, req_cond, "✓" if ok else "✕"])

		var req_lbl := Label.new()
		req_lbl.text = "Piezas: " + " | ".join(cost_strs)
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_repair else Color(1.0, 0.45, 0.45))
		info_vbox.add_child(req_lbl)

		hbox.add_child(info_vbox)

		# Botón de Reparación
		var rep_btn := Button.new()
		rep_btn.custom_minimum_size = Vector2(170, 38)
		rep_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		rep_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

		if dur >= 100.0:
			rep_btn.text = "✓ Al 100%"
			rep_btn.disabled = true
		elif not can_repair:
			rep_btn.text = "🔒 Faltan Piezas"
			rep_btn.disabled = true
		else:
			rep_btn.text = "🔨 Reparar al 100%"
			rep_btn.disabled = false
			rep_btn.pressed.connect(func():
				rep_btn.disabled = true
				var res = await GameManager.repair_generator_secure(gid)
				if res.get("success", false):
					status_lbl.text = "✓ ¡Generador reparado al 100%!"
					workshop_updated.emit()
					_refresh_view()
				else:
					status_lbl.text = "⚠️ " + str(res.get("error", "Error"))
					rep_btn.disabled = false
			)
		hbox.add_child(rep_btn)
		content_list.add_child(card)

# ====================================================================
# PESTAÑA 3: SUBIR NIVEL DE PLANTAS (ADAPTADA A LAS 5 RAREZAS)
# ====================================================================
func _build_upgrade_tab() -> void:
	if GameManager.player_generators.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "No tienes generadores para mejorar."
		empty_lbl.add_theme_font_size_override("font_size", 12)
		content_list.add_child(empty_lbl)
		return

	for gen in GameManager.player_generators:
		var gid = str(gen.get("id", ""))
		var gtype = str(gen.get("generator_type", ""))
		var lvl = int(gen.get("level", 1))
		var tier = GameManager.get_generator_tier(gtype)
		var tier_name = ["Común", "Poco Común", "Especial", "Épico", "Legendario"][tier - 1]

		var card := PanelContainer.new()
		var c_st := StyleBoxFlat.new()
		c_st.bg_color = Color(0.08, 0.11, 0.16, 0.95)
		c_st.border_color = Color(1.0, 0.8, 0.2, 0.8) if lvl < 4 else Color(0.3, 0.5, 0.7, 0.5)
		c_st.set_border_width_all(1); c_st.set_corner_radius_all(8)
		card.add_theme_stylebox_override("panel", c_st)

		var m := MarginContainer.new()
		m.add_theme_constant_override("margin_left", 14); m.add_theme_constant_override("margin_right", 14)
		m.add_theme_constant_override("margin_top", 10); m.add_theme_constant_override("margin_bottom", 10)
		card.add_child(m)

		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 16)
		m.add_child(hbox)

		var info_vbox := VBoxContainer.new()
		info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var name_lbl := Label.new()
		name_lbl.text = "%s [%s] — Nivel %d %s" % [_format_name(gtype), tier_name, lvl, "★ MÁXIMO" if lvl >= 4 else "➔ Nivel %d" % (lvl + 1)]
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		info_vbox.add_child(name_lbl)

		var bonus_lbl := Label.new()
		bonus_lbl.text = "⚡ Bono actual: +%d%% kW/min | Próximo nivel: +%d%% kW/min" % [(lvl - 1) * 25, lvl * 25] if lvl < 4 else "⚡ Potencia máxima alcanzada (+75% permanente)"
		bonus_lbl.add_theme_font_size_override("font_size", 11)
		bonus_lbl.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
		info_vbox.add_child(bonus_lbl)

		# Comprobación rigurosa de piezas según el Tier de la planta y nivel objetivo
		var can_upgrade: bool = false
		var req_desc: String = ""

		if lvl < 4:
			var target_lvl = lvl + 1
			var req_c = 10 if target_lvl == 2 else (16 if target_lvl == 3 else 24)
			var req_v = 8 if target_lvl == 2 else (12 if target_lvl == 3 else 18)
			var req_p = 6 if target_lvl == 2 else (10 if target_lvl == 3 else 14)
			var req_chip = 4 if target_lvl == 2 else (6 if target_lvl == 3 else 8)
			var req_cond = 2 if target_lvl == 2 else (3 if target_lvl == 3 else 4)

			if tier == 1: req_p = 0
			if tier <= 2: req_chip = 0; req_cond = 0
			if tier <= 4: req_cond = 0

			var have_c = GameManager.get_part_quantity("cable", tier)
			var have_v = GameManager.get_part_quantity("ventilador", tier)
			var have_p = GameManager.get_part_quantity("panel", tier)
			var have_chip = GameManager.get_part_quantity("chip", tier)
			var have_cond = GameManager.get_part_quantity("condensador", tier)

			can_upgrade = true
			var cost_strs: Array = []

			if req_c > 0:
				var ok = have_c >= req_c; if not ok: can_upgrade = false
				cost_strs.append("Cable Nv%d (%d/%d %s)" % [tier, have_c, req_c, "✓" if ok else "✕"])
			if req_v > 0:
				var ok = have_v >= req_v; if not ok: can_upgrade = false
				cost_strs.append("Vent Nv%d (%d/%d %s)" % [tier, have_v, req_v, "✓" if ok else "✕"])
			if req_p > 0:
				var ok = have_p >= req_p; if not ok: can_upgrade = false
				cost_strs.append("Panel Nv%d (%d/%d %s)" % [tier, have_p, req_p, "✓" if ok else "✕"])
			if req_chip > 0:
				var ok = have_chip >= req_chip; if not ok: can_upgrade = false
				cost_strs.append("Chip Nv%d (%d/%d %s)" % [tier, have_chip, req_chip, "✓" if ok else "✕"])
			if req_cond > 0:
				var ok = have_cond >= req_cond; if not ok: can_upgrade = false
				cost_strs.append("Cond Nv%d (%d/%d %s)" % [tier, have_cond, req_cond, "✓" if ok else "✕"])

			req_desc = "Requisitos Nv.%d: " % target_lvl + " | ".join(cost_strs)
		else:
			req_desc = "Generador mejorado al límite máximo permitido."

		var req_lbl := Label.new()
		req_lbl.text = req_desc
		req_lbl.add_theme_font_size_override("font_size", 10)
		req_lbl.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if can_upgrade else (Color(0.7, 0.75, 0.85) if lvl >= 4 else Color(1.0, 0.45, 0.45)))
		info_vbox.add_child(req_lbl)
		hbox.add_child(info_vbox)

		# Botón Subir Nivel
		var up_btn := Button.new()
		up_btn.custom_minimum_size = Vector2(180, 38)
		up_btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		up_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

		if lvl >= 4:
			up_btn.text = "✓ Nivel Máximo"
			up_btn.disabled = true
		elif not can_upgrade:
			up_btn.text = "🔒 Faltan Repuestos"
			up_btn.disabled = true
		else:
			up_btn.text = "⚡ Subir a Nivel %d" % (lvl + 1)
			up_btn.disabled = false
			up_btn.pressed.connect(func():
				up_btn.disabled = true
				var res = await GameManager.upgrade_generator_secure(gid)
				if res.get("success", false):
					status_lbl.text = "🎉 ¡Generador subido de nivel con éxito!"
					workshop_updated.emit()
					_refresh_view()
				else:
					status_lbl.text = "⚠️ " + str(res.get("error", "Error"))
					up_btn.disabled = false
			)
		hbox.add_child(up_btn)
		content_list.add_child(card)

# ====================================================================
# PESTAÑA 4: ALMACÉN (MATERIALES Y PIEZAS)
# ====================================================================
func _build_inventory_tab() -> void:
	var section_mat := Label.new()
	section_mat.text = "📦 MATERIALES BRUTOS (FARMEO DE MINIJUEGOS)"
	section_mat.add_theme_color_override("font_color", Color(0.35, 0.88, 1.0))
	section_mat.add_theme_font_size_override("font_size", 12)
	content_list.add_child(section_mat)

	var grid_mat := GridContainer.new()
	grid_mat.columns = 4
	grid_mat.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid_mat.add_theme_constant_override("h_separation", 10)
	grid_mat.add_theme_constant_override("v_separation", 10)

	var mat_types = [
		{"type": "cobre", "name": "Cobre Bruto"},
		{"type": "plastico", "name": "Plástico Rec."},
		{"type": "silicio", "name": "Silicio/Cuarzo"},
		{"type": "hierro", "name": "Chatarra Hierro"}
	]

	for m in mat_types:
		for t in range(1, 6):
			var count = GameManager.get_material_quantity(m["type"], t)
			if count > 0:
				var p_card := PanelContainer.new()
				p_card.custom_minimum_size = Vector2(160, 60)
				var st := StyleBoxFlat.new()
				st.bg_color = Color(0.08, 0.10, 0.15, 0.9)
				st.border_color = Color(0.2, 0.45, 0.65, 0.7)
				st.set_border_width_all(1); st.set_corner_radius_all(6)
				p_card.add_theme_stylebox_override("panel", st)

				var pm := MarginContainer.new()
				pm.add_theme_constant_override("margin_left", 8); pm.add_theme_constant_override("margin_right", 8)
				pm.add_theme_constant_override("margin_top", 6); pm.add_theme_constant_override("margin_bottom", 6)
				p_card.add_child(pm)

				var pvbox := VBoxContainer.new()
				pm.add_child(pvbox)

				var l_name := Label.new()
				l_name.text = "%s (T%d)" % [m["name"], t]
				l_name.add_theme_font_size_override("font_size", 11)
				pvbox.add_child(l_name)

				var l_qty := Label.new()
				l_qty.text = "Cantidad: %d" % count
				l_qty.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6))
				l_qty.add_theme_font_size_override("font_size", 11)
				pvbox.add_child(l_qty)

				grid_mat.add_child(p_card)
	content_list.add_child(grid_mat)

	var hsep := HSeparator.new()
	content_list.add_child(hsep)

	var section_parts := Label.new()
	section_parts.text = "🔩 PIEZAS MANUFACTURADAS (LISTAS PARA USAR)"
	section_parts.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	section_parts.add_theme_font_size_override("font_size", 12)
	content_list.add_child(section_parts)

	var grid_parts := GridContainer.new()
	grid_parts.columns = 5
	grid_parts.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid_parts.add_theme_constant_override("h_separation", 10)
	grid_parts.add_theme_constant_override("v_separation", 10)

	var piece_categories = [
		{"type": "cable", "name": "Cable"},
		{"type": "ventilador", "name": "Ventilador"},
		{"type": "panel", "name": "Panel"},
		{"type": "chip", "name": "Microchip"},
		{"type": "condensador", "name": "Condensador"}
	]

	for cat in piece_categories:
		for lvl in range(1, 6):
			var count = GameManager.get_part_quantity(cat["type"], lvl)
			var p_card := PanelContainer.new()
			p_card.custom_minimum_size = Vector2(150, 75)
			var st := StyleBoxFlat.new()
			st.bg_color = Color(0.08, 0.10, 0.15, 0.9)
			st.border_color = Color(0.2, 0.35, 0.55, 0.7)
			st.set_border_width_all(1); st.set_corner_radius_all(6)
			p_card.add_theme_stylebox_override("panel", st)

			var pm := MarginContainer.new()
			pm.add_theme_constant_override("margin_left", 8); pm.add_theme_constant_override("margin_right", 8)
			pm.add_theme_constant_override("margin_top", 6); pm.add_theme_constant_override("margin_bottom", 6)
			p_card.add_child(pm)

			var pvbox := VBoxContainer.new()
			pm.add_child(pvbox)

			var l_name := Label.new()
			l_name.text = "%s Nv. %d" % [cat["name"], lvl]
			l_name.add_theme_font_size_override("font_size", 11)
			pvbox.add_child(l_name)

			var l_qty := Label.new()
			l_qty.text = "Posees: %d" % count
			l_qty.add_theme_font_size_override("font_size", 11)
			l_qty.add_theme_color_override("font_color", Color(0.4, 1.0, 0.6) if count > 0 else Color(0.6, 0.65, 0.75))
			pvbox.add_child(l_qty)

			grid_parts.add_child(p_card)

	content_list.add_child(grid_parts)

func _format_name(gtype: String) -> String:
	match gtype:
		"ecoflow_spark": return "EcoFlow Spark"
		"ecoflow_spark_plus": return "EcoFlow Spark Plus"
		"ecoflow_thunder_pro": return "EcoFlow Thunder Pro"
		"ecoflow_ultra": return "EcoFlow Ultra"
		"cyber_tank": return "Cyber Tank 100%"
		"dinamo_manual": return "Generador Manual"
		"delta_mini": return "EcoFlow DELTA Mini"
		"panel_solar": return "Panel Solar"
		"pro_electrico": return "EcoFlow Pro Eléctrico"
		_: return "Planta Meme"
```

---

####### 📄 Archivo: `taller_modal.gd.uid`

```
uid://b1ybpmpaefeqm

```

---

#### 📁 Carpeta: `./game/`

 *[Carpeta Vacía]*

---

#### 📁 Carpeta: `./shared/`

##### 📁 Carpeta: `./shared\components/`

###### 📄 Archivo: `.gitkeep`

```

```

---

##### 📁 Carpeta: `./shared\themes/`

###### 📄 Archivo: `.gitkeep`

```

```

---

##### 📁 Carpeta: `./shared\utils/`

###### 📄 Archivo: `.gitkeep`

```

```

---

