@echo off
title Traer cambios de GitHub - KiloWatt
color 0a
echo ======================================================
echo     DESCARGANDO CAMBIOS PUBLICADOS POR TU AMIGO
echo ======================================================
echo.

:: 1. Consultar que hay de nuevo en GitHub
echo Conectando con GitHub...
git fetch origin main

:: 2. Mostrar la lista exacta de lo que tu amigo cambio o creo
echo.
echo ======================================================
echo  ARCHIVOS DETECTADOS:
echo  [M = Modificado por tu amigo]
echo  [A = Archivo nuevo agregado]
echo  [D = Archivo eliminado]
echo ======================================================
git diff --name-status HEAD origin/main
echo.

:: 3. Reemplazar archivos locales por la version de GitHub
echo Descargando y reemplazando tus archivos locales...
git reset --hard origin/main

echo.
echo ======================================================
echo   PROYECTO ACTUALIZADO AL 100%%
echo   Tienes exactamente la misma version que subio tu amigo.
echo ======================================================
echo.
pause