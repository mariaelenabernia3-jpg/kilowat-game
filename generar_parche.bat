@echo off
title Generador de Parches KILOWAT
cd /d "%~dp0"

echo ========================================================
echo        GENERADOR DE PARCHES AUTOMATICO - KILOWAT
echo ========================================================
echo.

:: 1. Intentar detectar el archivo de Godot automáticamente
set "GODOT_EXE="

for %%f in (*godot*.exe) do (
    set "GODOT_EXE=%%f"
    goto :encontrado
)

for %%f in ("..\"*godot*.exe) do (
    set "GODOT_EXE=%%~ff"
    goto :encontrado
)

where godot.exe >nul 2>nul
if %errorlevel% equ 0 (
    set "GODOT_EXE=godot.exe"
    goto :encontrado
)

:pedir_ruta
echo [!] No se encontro el ejecutable de Godot en esta carpeta.
echo.
echo SOLUCION: Arrastra el icono de tu ejecutable de Godot (el .exe con el que abres el motor)
echo directamente dentro de esta ventana negra y presiona ENTER:
echo.
set /p "GODOT_EXE=Ruta de Godot: "
set "GODOT_EXE=%GODOT_EXE:"=%"

:encontrado
echo [*] Motor detectado: "%GODOT_EXE%"
echo.

:: Crear carpeta de parches
if not exist "Parches_Salida" mkdir "Parches_Salida"

:: Eliminar parche anterior si existía para verificar el nuevo
if exist "Parches_Salida\patch.pck" del /f /q "Parches_Salida\patch.pck"

echo [*] Exportando patch.pck en segundo plano...
echo (Espera unos segundos...)
echo.

"%GODOT_EXE%" --headless --export-pack "Android" "Parches_Salida\patch.pck"

if not exist "Parches_Salida\patch.pck" (
    echo [!] Fallo con el preset 'Android'. Intentando con 'Windows Desktop'...
    "%GODOT_EXE%" --headless --export-pack "Windows Desktop" "Parches_Salida\patch.pck"
)

if not exist "Parches_Salida\patch.pck" (
    echo.
    echo ========================================================
    echo [ERROR] No se pudo generar el archivo patch.pck.
    echo Posibles causas:
    echo 1. No tienes configurado el preset de exportacion en Godot.
    echo 2. Tu proyecto tiene algun error de sintaxis que impide exportar.
    echo ========================================================
    echo.
    pause
    exit /b
)

echo.
echo ========================================================
echo [OK] ¡Parche generado con EXITO!
echo Archivo listo en: %cd%\Parches_Salida\patch.pck
echo ========================================================
echo.
echo [1] Abriendo la carpeta donde esta el parche...
explorer "Parches_Salida"

echo [2] Abriendo tu pagina de GitHub Releases en el navegador...
start https://github.com/mariaelenabernia3-jpg/kilowat-game/releases/new
echo.
echo ========================================================
echo PASOS FINALES EN GITHUB:
echo 1. Escribe la version (ej: v1.0.1) en 'Tag'.
echo 2. Arrastra el archivo 'patch.pck' de la carpeta a la web.
echo 3. Dale al boton verde 'Publish release'.
echo ========================================================
echo.
pause