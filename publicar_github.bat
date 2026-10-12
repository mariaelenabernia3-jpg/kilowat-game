@echo off
title Publicador Automatico de GitHub - KiloWatt
color 0b
echo ======================================================
echo       SUBIENDO ACTUALIZACIONES A GITHUB
echo ======================================================
echo.

echo Preparando archivos...
git add .

set "mensaje="
set /p "mensaje=Escribe que cambiaste (o presiona ENTER para continuar): "
if not defined mensaje set "mensaje=Actualizacion Parche con taller y correcciones"

echo.
echo Creando punto de guardado (commit)...
git commit -m "%mensaje%"

echo.
echo Subiendo cambios a tu repositorio remoto...
git push origin main

echo.
echo ======================================================
echo   LISTO! TUS CAMBIOS YA ESTAN PUBLICADOS EN GITHUB
echo ======================================================
echo.
pause