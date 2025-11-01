@echo off
title Ejecutar App en Emulador
color 0A
echo.
echo ========================================
echo   EJECUTAR APP EN EMULADOR ANDROID
echo ========================================
echo.

set SDK_ROOT=C:\Users\dell\AppData\Local\Android\sdk
set APP_DIR=C:\Users\dell\cmutem-202502-app\app

echo [1/4] Verificando emuladores disponibles...
echo.
"%SDK_ROOT%\emulator\emulator.exe" -list-avds
echo.

echo [2/4] Verificando dispositivos conectados...
echo.
flutter devices
echo.

set /p CONTINUE=¿Ya iniciaste el emulador en Android Studio? (S/N):
if /i "%CONTINUE%" neq "S" (
    echo.
    echo Por favor:
    echo 1. Abre Android Studio
    echo 2. Ve a Device Manager
    echo 3. Click en el boton Play del emulador
    echo 4. Espera a que cargue completamente
    echo 5. Vuelve a ejecutar este script
    echo.
    pause
    exit /b 0
)

echo.
echo [3/4] Esperando que el emulador este completamente listo...
timeout /t 5 /nobreak >nul

:CHECK_LOOP
echo Verificando dispositivos...
flutter devices | findstr "emulator" >nul
if errorlevel 1 (
    echo Emulador no detectado aun. Esperando 5 segundos mas...
    timeout /t 5 /nobreak >nul
    goto CHECK_LOOP
)

echo.
echo [✓] Emulador detectado!
echo.

echo [4/4] Ejecutando aplicacion Flutter...
echo.
echo NOTA: La primera compilacion puede tardar 2-3 minutos
echo.

cd /d "%APP_DIR%"
flutter run

echo.
echo ========================================
echo   Proceso Finalizado
echo ========================================
echo.
pause

