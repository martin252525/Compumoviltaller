# Guía Completa: Ejecutar App en Emulador Android

Esta guía te ayudará a ejecutar la aplicación en un emulador Android después de que el dispositivo físico Motorola no pudo conectarse.

## 📋 Requisitos Previos

- Android Studio instalado
- Flutter SDK instalado y configurado
- Al menos 8GB de RAM disponible
- 10GB de espacio en disco

## 🚀 Pasos Rápidos (Para usuarios experimentados)

```bash
# 1. Abrir Android Studio y crear AVD
# 2. Iniciar el emulador
# 3. En la terminal del proyecto:
cd app
flutter pub get
flutter run
```

## 📝 Guía Paso a Paso Detallada

### Paso 1: Verificar Instalación de Flutter

Abre una terminal y ejecuta:

```bash
flutter doctor
```

Deberías ver algo como:
```
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Android Studio (version 2023.x)
```

Si hay problemas marcados con [✗], síguelos para resolverlos antes de continuar.

### Paso 2: Crear un Emulador Android (AVD)

#### Opción A: Desde Android Studio (Recomendado)

1. **Abrir Android Studio**
   
2. **Ir a Device Manager:**
   - Menú: `Tools` → `Device Manager`
   - O busca el ícono de teléfono en la barra lateral derecha

3. **Crear un nuevo dispositivo virtual:**
   - Click en `Create Device` o `+`
   - Selecciona `Phone` → `Pixel 5` (recomendado)
   - Click `Next`

4. **Descargar imagen del sistema:**
   - Selecciona la pestaña `Recommended`
   - Elige `API 33` (Android 13) o `API 34` (Android 14)
   - Si aparece "Download" al lado, haz click para descargar
   - Espera a que termine la descarga (puede tardar varios minutos)
   - Click `Next`

5. **Configurar AVD:**
   - Nombre: `Pixel_5_API_33` (o el que prefieras)
   - Startup orientation: `Portrait`
   - En "Advanced Settings" (opcional):
     - RAM: 2048 MB (mínimo)
     - Internal Storage: 2048 MB
     - SD Card: 512 MB
   - Click `Finish`

#### Opción B: Desde la Terminal (Avanzado)

```bash
# Listar AVDs disponibles
flutter emulators

# Crear un nuevo AVD
flutter emulators --create --name pixel_5_api_33

# Si no funciona, usa avdmanager:
avdmanager create avd -n Pixel_5_API_33 -k "system-images;android-33;google_apis;x86_64" -d pixel_5
```

### Paso 3: Iniciar el Emulador

#### Opción A: Desde Android Studio
1. Abre Device Manager
2. Click en el botón ▶ (Play) junto a tu AVD
3. Espera a que el emulador inicie completamente (puede tardar 1-3 minutos la primera vez)
4. Verás la pantalla de inicio de Android

#### Opción B: Desde la Terminal
```bash
# Listar emuladores disponibles
flutter emulators

# Iniciar un emulador específico
flutter emulators --launch Pixel_5_API_33
```

### Paso 4: Verificar que el Emulador está Conectado

```bash
flutter devices
```

Deberías ver algo como:
```
1 connected device:

sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64 • Android 13 (API 33)
```

### Paso 5: Instalar Dependencias del Proyecto

Navega al directorio del proyecto:

```bash
cd /ruta/a/Compumoviltaller/app
flutter pub get
```

Espera a que se descarguen todas las dependencias.

### Paso 6: Ejecutar la Aplicación

```bash
flutter run
```

O si tienes múltiples dispositivos conectados:

```bash
flutter run -d emulator-5554
```

**Nota importante:** La primera compilación puede tardar 5-10 minutos. Las siguientes serán mucho más rápidas.

### Paso 7: Esperar la Compilación e Instalación

Verás algo como:
```
Launching lib/main.dart on sdk gphone64 x86 64 in debug mode...
Running Gradle task 'assembleDebug'...
✓ Built build/app/outputs/flutter-apk/app-debug.apk.
Installing build/app/outputs/flutter-apk/app.apk...
Waiting for sdk gphone64 x86 64 to report its views...
Debug service listening on ws://127.0.0.1:xxxxx/
```

## 🎯 Funcionalidades Disponibles sin Firebase

La aplicación funcionará en modo "solo lectura" sin configurar Firebase:

### ✅ Lo que SÍ funciona:
- Ver lista de votaciones
- Buscar votaciones
- Filtrar por estado (Activa, Finalizada, Próxima)
- Ver detalles de cada votación
- Ver resultados de votaciones
- Navegar por la interfaz

### ❌ Lo que NO funciona (requiere Firebase):
- Iniciar sesión con Google
- Realizar votos
- Ver historial de votos personales
- Ver perfil de usuario

La app mostrará un mensaje indicando que Firebase no está configurado cuando intentes usar estas funciones.

## 🔧 Solución de Problemas Comunes

### Error: "No devices found"

**Solución:**
```bash
# Verificar que el emulador está corriendo
flutter devices

# Si no aparece, reiniciar adb
adb kill-server
adb start-server
flutter devices
```

### Error: "Waiting for another flutter command to release the startup lock"

**Solución:**
```bash
# En Windows:
del %LOCALAPPDATA%\flutter\flutter_lock

# En Mac/Linux:
rm ~/.flutter/flutter_lock
```

### El emulador es muy lento

**Soluciones:**
1. Asegúrate de tener Intel HAXM o AMD Hypervisor instalado
2. En Android Studio: `Tools` → `SDK Manager` → `SDK Tools` → instala "Intel x86 Emulator Accelerator (HAXM installer)"
3. Reduce la RAM del AVD a 2048 MB
4. Cierra otras aplicaciones pesadas

### Error: "Gradle build failed"

**Solución:**
```bash
# Limpiar el proyecto
cd app
flutter clean
flutter pub get
flutter run
```

### Error relacionado con Firebase

Este error es **normal y esperado** si no has configurado Firebase. La app funcionará de todos modos en modo exploración. Verás en los logs:
```
Firebase no pudo inicializarse: ...
La app funcionará sin autenticación
```

Esto está bien y es el comportamiento esperado.

## 🔥 Configurar Firebase (Opcional)

Si quieres habilitar la autenticación y votar:

### 1. Crear Proyecto en Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Click en "Agregar proyecto"
3. Nombre: `VotingApp` (o el que prefieras)
4. Sigue los pasos (puedes desactivar Google Analytics)

### 2. Agregar App Android

1. En el proyecto de Firebase, click en el ícono de Android
2. **Package name:** `cm.utem.app` (importante: debe coincidir exactamente)
3. **App nickname:** `Voting App`
4. Deja los campos SHA-1 y SHA-256 vacíos por ahora (para desarrollo)
5. Click `Registrar app`

### 3. Descargar google-services.json

1. Descarga el archivo `google-services.json`
2. Colócalo en: `app/android/app/google-services.json`

### 4. Habilitar Autenticación con Google

1. En Firebase Console: `Authentication` → `Sign-in method`
2. Click en `Google`
3. Activa el switch
4. Selecciona un correo de soporte
5. Click `Guardar`

### 5. Agregar SHA-1 para producción (Opcional)

Para generar tu propia SHA-1:

```bash
cd app/android
# En Windows
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

# En Mac/Linux
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Copia el valor SHA-1 y SHA-256 que aparece, y agrégalo en Firebase Console → Project Settings → Your apps → SHA certificate fingerprints

### 6. Recompilar la App

```bash
flutter clean
flutter pub get
flutter run
```

## 📱 Hot Reload durante el Desarrollo

Mientras la app está corriendo, puedes:

- Presionar `r` en la terminal para hacer hot reload (aplicar cambios sin reiniciar)
- Presionar `R` para hot restart (reiniciar la app)
- Presionar `q` para salir
- Presionar `p` para toggle performance overlay

## 🎨 Probar Diferentes Escenarios

### Probar Lista de Votaciones
1. La app inicia en la pantalla de splash
2. Después de 2 segundos, muestra la lista de votaciones
3. Puedes hacer scroll, buscar y filtrar

### Probar Búsqueda
1. En la lista, escribe en el campo de búsqueda
2. Los resultados se actualizan dinámicamente

### Probar Filtros
1. Click en los chips: "Todas", "Activas", "Finalizadas", "Próximas"
2. La lista se filtra automáticamente

### Probar Detalle de Votación
1. Click en cualquier votación de la lista
2. Se abre la pantalla de detalle con toda la información

## 📊 Logs y Debugging

Para ver logs detallados:

```bash
# Ver todos los logs
flutter logs

# Ver logs filtrados
flutter logs | grep -i "error"

# Ver logs de la app específicamente
adb logcat | grep flutter
```

## 🔄 Actualizar la App después de Cambios en el Código

```bash
# Si solo cambiaste código Dart:
# Presiona 'r' en la terminal donde corre flutter run

# Si cambiaste dependencias o configuración nativa:
flutter clean
flutter pub get
flutter run
```

## ✅ Checklist de Verificación

Antes de solicitar ayuda, verifica:

- [ ] `flutter doctor` no muestra errores críticos
- [ ] El emulador está corriendo (`flutter devices` lo muestra)
- [ ] Ejecutaste `flutter pub get`
- [ ] La terminal muestra "Waiting for sdk gphone64..." (indica que está instalando)
- [ ] El emulador muestra la pantalla de Android (no está bloqueado)

## 🆘 Obtener Ayuda

Si sigues teniendo problemas:

1. **Captura el error completo** de la terminal
2. **Verifica los logs:** `flutter logs > logs.txt`
3. **Copia el output de:** `flutter doctor -v`
4. Incluye tu sistema operativo y versión de Flutter

## 📚 Recursos Adicionales

- [Documentación oficial Flutter](https://docs.flutter.dev/)
- [Flutter Emulator Setup](https://docs.flutter.dev/get-started/install)
- [Android Studio User Guide](https://developer.android.com/studio/intro)
- [Firebase Setup for Flutter](https://firebase.google.com/docs/flutter/setup)

## 🎓 Alternativas al Emulador

Si el emulador no funciona en tu computadora:

1. **Dispositivo físico con USB Debugging:**
   - Habilita "Opciones de desarrollador" en tu Motorola
   - Activa "Depuración USB"
   - Conecta con cable USB
   - Ejecuta `flutter run`

2. **Emulador en la nube:**
   - [Appetize.io](https://appetize.io/)
   - [BrowserStack](https://www.browserstack.com/)
   - [Firebase Test Lab](https://firebase.google.com/docs/test-lab)

3. **Compilar APK y compartir:**
   ```bash
   flutter build apk --debug
   # El APK estará en: build/app/outputs/flutter-apk/app-debug.apk
   # Compártelo por email, Drive, etc.
   ```

---

**¡Éxito!** Si seguiste esta guía, tu app debería estar corriendo en el emulador. 🎉
