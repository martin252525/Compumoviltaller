@echo off
echo ====================================
echo Crear Emulador Android Automaticamente
echo ====================================
echo.

set SDK_ROOT=C:\Users\dell\AppData\Local\Android\sdk
set EMULATOR_NAME=Flutter_Pixel_5

echo Paso 1: Verificando SDK...
if not exist "%SDK_ROOT%" (
    echo ERROR: SDK de Android no encontrado en %SDK_ROOT%
    pause
    exit /b 1
)

echo SDK encontrado: %SDK_ROOT%
echo.

echo Paso 2: Listando emuladores existentes...
"%SDK_ROOT%\emulator\emulator.exe" -list-avds
echo.

echo Paso 3: ¿Quieres crear un nuevo emulador? (S/N)
set /p CREATE=
if /i "%CREATE%" neq "S" goto LAUNCH

echo.
echo Creando emulador %EMULATOR_NAME%...
echo Esto puede tardar varios minutos en la primera vez...
echo.

echo Descargando imagen del sistema (esto puede tardar mucho)...
echo Por favor, usa Android Studio GUI para mejor experiencia.
echo.
echo Abre Android Studio y ve a:
echo   - More Actions ^> Virtual Device Manager
echo   - Create Device
echo   - Selecciona Pixel 5
echo   - Descarga Android 13 (API 33)
echo.
pause
goto END

:LAUNCH
echo.
echo Emuladores disponibles:
"%SDK_ROOT%\emulator\emulator.exe" -list-avds
echo.

set /p AVD_NAME=Ingresa el nombre del emulador a iniciar:
if "%AVD_NAME%"=="" (
    echo No se ingreso ningun nombre.
    pause
    exit /b 1
)

echo.
echo Iniciando emulador %AVD_NAME%...
echo La ventana del emulador aparecera en breve...
echo.

start "" "%SDK_ROOT%\emulator\emulator.exe" -avd %AVD_NAME% -no-snapshot-load

echo.
echo Esperando que el emulador inicie...
echo Esto puede tardar 1-2 minutos...
timeout /t 5 /nobreak >nul

:CHECK_DEVICE
echo Verificando dispositivos...
flutter devices
echo.

set /p CONTINUE=¿El emulador ya aparece en la lista? (S para ejecutar app, N para esperar mas):
if /i "%CONTINUE%"=="N" (
    timeout /t 5 /nobreak >nul
    goto CHECK_DEVICE
)

echo.
echo Ejecutando aplicacion Flutter...
cd /d C:\Users\dell\cmutem-202502-app\app
flutter run

:END
echo.
echo Proceso finalizado.
pause

