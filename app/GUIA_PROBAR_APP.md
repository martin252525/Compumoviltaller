# 📱 Guía Rápida - Conectar Motorola y Probar la App

## 1️⃣ Habilitar Depuración USB en tu Motorola

1. **Abre Configuración** en tu Motorola
2. Ve a **"Acerca del teléfono"** o **"About phone"**
3. Busca **"Número de compilación"** o **"Build number"**
4. Toca **7 veces** sobre él (aparecerá un mensaje "Ahora eres desarrollador")
5. Regresa al menú principal de Configuración
6. Busca **"Opciones de desarrollador"** o **"Developer options"**
7. Activa la opción **"Depuración USB"** o **"USB debugging"**
8. Conecta el cable USB a tu PC

## 2️⃣ Autorizar la Conexión

Cuando conectes el celular:
1. En el Motorola aparecerá un mensaje: **"¿Permitir depuración USB?"**
2. Marca la casilla **"Confiar siempre en este equipo"**
3. Toca **"Aceptar"** o **"OK"**

## 3️⃣ Verificar la Conexión

Abre PowerShell o CMD y ejecuta:

```bash
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe devices
```

Deberías ver algo como:
```
List of devices attached
ZY22XXXXX    device
```

Si no aparece, prueba:
```bash
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe kill-server
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe start-server
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe devices
```

## 4️⃣ Ejecutar la Aplicación

### Opción A: Con Flutter directamente
```bash
cd C:\Users\dell\cmutem-202502-app\app
flutter devices
flutter run
```

### Opción B: Seleccionar dispositivo específico
```bash
flutter devices   # Anota el ID de tu Motorola
flutter run -d [ID_DEL_DISPOSITIVO]
```

### Opción C: Desde Android Studio
1. Abre Android Studio
2. Abre el proyecto: `C:\Users\dell\cmutem-202502-app\app`
3. Espera que sincronice
4. En la parte superior verás el selector de dispositivos
5. Selecciona tu Motorola
6. Presiona el botón ▶️ (Run) o Shift+F10

## 5️⃣ Si Hay Errores de Compilación

### Error: Firebase no configurado
**Solución temporal**: Comentar Firebase temporalmente para probar la UI

Edita `lib/main.dart`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Comentar temporalmente Firebase
  // await Firebase.initializeApp();
  
  VoteApiService.initialize();
  
  runApp(const ProviderScope(child: MyApp()));
}
```

### Error: Missing google-services.json
**Necesitas configurar Firebase**:
1. Ve a https://console.firebase.google.com/
2. Crea un proyecto o usa uno existente
3. Agrega una app Android
4. Descarga `google-services.json`
5. Colócalo en: `android/app/google-services.json`

## 6️⃣ Problemas Comunes

### El dispositivo no aparece
- **Solución 1**: Cambia el modo USB del celular a "Transferencia de archivos"
- **Solución 2**: Usa otro cable USB
- **Solución 3**: Reinstala los drivers USB del Motorola

### Error "Unauthorized"
- **Solución**: Desbloquea el celular y acepta el mensaje de depuración USB

### Error de compilación Gradle
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### El emulador es muy lento
```bash
# Usar dispositivo físico siempre es más rápido
flutter run   # Selecciona tu Motorola cuando pregunte
```

## 7️⃣ Ejecutar en Modo Release (Más Rápido)

```bash
flutter run --release
```

O para generar APK instalable:
```bash
flutter build apk --release
```

El APK estará en: `build/app/outputs/flutter-apk/app-release.apk`

## 8️⃣ Comandos Útiles Durante el Desarrollo

Mientras la app está corriendo:
- `r` - Hot reload (recarga rápida)
- `R` - Hot restart (reinicio completo)
- `p` - Ver widget inspector
- `o` - Cambiar entre Android/iOS
- `q` - Salir

## 9️⃣ Ver Logs en Tiempo Real

```bash
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe logcat | findstr flutter
```

## 🔟 Troubleshooting Final

Si nada funciona:
```bash
# Paso 1: Limpiar todo
flutter clean
cd android
./gradlew clean
cd ..

# Paso 2: Reinstalar dependencias
flutter pub get

# Paso 3: Revisar configuración
flutter doctor -v

# Paso 4: Probar
flutter run
```

## ✅ Checklist Antes de Ejecutar

- [ ] Depuración USB habilitada en el Motorola
- [ ] Cable USB conectado
- [ ] Mensaje de depuración aceptado en el celular
- [ ] `adb devices` muestra el dispositivo
- [ ] Firebase configurado (o comentado temporalmente)
- [ ] Dependencias instaladas (`flutter pub get`)

## 📞 Comandos Rápidos para Copiar y Pegar

```bash
# Verificar dispositivos
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe devices

# Ir al proyecto
cd C:\Users\dell\cmutem-202502-app\app

# Obtener dependencias
flutter pub get

# Ejecutar app
flutter run

# Si hay múltiples dispositivos, listar primero
flutter devices

# Ejecutar en dispositivo específico
flutter run -d [DEVICE_ID]

# Ejecutar en modo release (más rápido)
flutter run --release

# Ver logs
C:\Users\dell\AppData\Local\Android\sdk\platform-tools\adb.exe logcat -s flutter
```

---

**¿Problemas? Avísame qué mensaje de error aparece y te ayudo a solucionarlo! 🚀**

