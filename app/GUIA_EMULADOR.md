# 📱 Guía: Probar App en Emulador Virtual

## ✅ Opción Rápida - Crear Emulador desde Android Studio

### Paso 1: Abrir AVD Manager
1. Abre **Android Studio**
2. En la pantalla principal, haz clic en **"More Actions"** o los **tres puntos**
3. Selecciona **"Virtual Device Manager"** o **"AVD Manager"**

### Paso 2: Crear un Nuevo Dispositivo Virtual
1. Haz clic en **"Create Device"** o **"Create Virtual Device"**
2. Selecciona un dispositivo (recomendado: **Pixel 4** o **Pixel 5**)
3. Haz clic en **"Next"**

### Paso 3: Seleccionar Imagen del Sistema
1. Selecciona una imagen del sistema (recomendado: **Android 13 (Tiramisu)** o **Android 14**)
2. Si no está descargada, haz clic en **"Download"** junto a ella
3. Espera que descargue (puede tardar varios minutos)
4. Haz clic en **"Next"**

### Paso 4: Configurar el AVD
1. Dale un nombre (ejemplo: **Pixel_5_API_33**)
2. Configura la memoria RAM (recomendado: **2048 MB** o más)
3. Habilita **"Graphics: Hardware - GLES 2.0"** para mejor rendimiento
4. Haz clic en **"Finish"**

### Paso 5: Iniciar el Emulador
1. En el AVD Manager, haz clic en el botón **▶️ (Play)** junto al emulador
2. Espera que el emulador inicie (puede tardar 1-2 minutos la primera vez)
3. Una ventana del emulador aparecerá

## 🚀 Ejecutar la App en el Emulador

Una vez que el emulador esté corriendo:

### Opción A: Desde la Terminal
```bash
cd C:\Users\dell\cmutem-202502-app\app

# Verificar que el emulador esté detectado
flutter devices

# Ejecutar la app
flutter run
```

### Opción B: Desde Android Studio
1. Abre el proyecto en Android Studio
2. Espera que sincronice
3. En la parte superior, selecciona el emulador de la lista de dispositivos
4. Presiona **Shift+F10** o el botón **▶️ Run**

## 📋 Comandos Útiles

### Listar emuladores disponibles
```bash
flutter emulators
```

### Listar dispositivos conectados (incluyendo emuladores corriendo)
```bash
flutter devices
```

### Ejecutar en emulador específico
```bash
flutter run -d emulator-5554
```

### Iniciar emulador desde línea de comandos
```bash
# Primero, lista los emuladores disponibles
C:\Users\dell\AppData\Local\Android\sdk\emulator\emulator.exe -list-avds

# Luego, inicia el emulador deseado
C:\Users\dell\AppData\Local\Android\sdk\emulator\emulator.exe -avd [NOMBRE_DEL_AVD]
```

## ⚡ Solución Rápida - Crear AVD por Línea de Comandos

Si Android Studio tarda mucho, puedes crear un emulador desde la terminal:

### 1. Instalar cmdline-tools (si no están instalados)
```bash
# Abre Android Studio
# Ve a: File → Settings → Appearance & Behavior → System Settings → Android SDK
# Pestaña "SDK Tools"
# Marca "Android SDK Command-line Tools"
# Haz clic en "Apply"
```

### 2. Listar imágenes del sistema disponibles
```bash
C:\Users\dell\AppData\Local\Android\sdk\cmdline-tools\latest\bin\sdkmanager.bat --list
```

### 3. Descargar una imagen del sistema
```bash
# Android 13 (API 33)
C:\Users\dell\AppData\Local\Android\sdk\cmdline-tools\latest\bin\sdkmanager.bat "system-images;android-33;google_apis_playstore;x86_64"
```

### 4. Crear el AVD
```bash
echo no | C:\Users\dell\AppData\Local\Android\sdk\cmdline-tools\latest\bin\avdmanager.bat create avd -n Pixel_5_API_33 -k "system-images;android-33;google_apis_playstore;x86_64" -d pixel_5
```

### 5. Iniciar el AVD
```bash
C:\Users\dell\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_5_API_33
```

## 🐛 Solución de Problemas

### El emulador no inicia
**Causa**: Virtualización no habilitada en BIOS
**Solución**:
1. Reinicia tu PC
2. Entra al BIOS/UEFI (generalmente presionando F2, F10, o DEL durante el arranque)
3. Busca "Virtualization" o "Intel VT-x" o "AMD-V"
4. Habilítalo
5. Guarda y reinicia

### El emulador es muy lento
**Soluciones**:
1. Usa **Hardware Graphics** en la configuración del AVD
2. Aumenta la RAM asignada al emulador (2048 MB o más)
3. Cierra otros programas pesados
4. Usa una imagen del sistema **sin Play Store** (más ligera)

### Error: "HAXM is not installed"
**Solución**:
```bash
# Descarga HAXM desde Android Studio:
# SDK Manager → SDK Tools → Intel x86 Emulator Accelerator (HAXM installer)
# Luego ejecuta el instalador manualmente desde:
C:\Users\dell\AppData\Local\Android\sdk\extras\intel\Hardware_Accelerated_Execution_Manager\intelhaxm-android.exe
```

### Error: "emulator: ERROR: x86 emulation currently requires hardware acceleration!"
**Solución**: Instala HAXM (ver arriba) o habilita Hyper-V en Windows

## 🎯 Recomendaciones para Mejor Rendimiento

### Configuración Óptima del AVD
- **Dispositivo**: Pixel 4 o Pixel 5
- **API Level**: 30-33 (Android 11-13)
- **RAM**: 2048 MB mínimo, 4096 MB ideal
- **Almacenamiento**: 2048 MB
- **Graphics**: Hardware - GLES 2.0
- **Imagen**: google_apis_playstore (si necesitas Play Services) o google_apis (más ligero)

### Durante el Desarrollo
- Usa **Hot Reload** (`r` en la terminal) en lugar de reiniciar
- Mantén el emulador abierto entre compilaciones
- Usa modo **Release** para testing final: `flutter run --release`

## 📊 Comparación: Emulador vs Dispositivo Físico

| Característica | Emulador | Motorola Físico |
|----------------|----------|-----------------|
| Velocidad | ⚠️ Lento-Medio | ✅ Rápido |
| Setup | ⏱️ Largo (descarga GB) | ⚡ Rápido (minutos) |
| Recursos PC | 💻 Alto (RAM, CPU) | 💻 Bajo |
| Realismo | ⚠️ Simulado | ✅ Real |
| Sensores | ⚠️ Limitado | ✅ Completo |
| Recomendación | Para pruebas UI | ✅ **Mejor opción** |

## ✅ Checklist para Emulador

- [ ] Android Studio instalado
- [ ] AVD Manager abierto
- [ ] Emulador creado (Pixel 4/5, Android 11+)
- [ ] Emulador iniciado y funcionando
- [ ] `flutter devices` muestra el emulador
- [ ] App ejecutándose con `flutter run`

## 🚀 Inicio Rápido (3 pasos)

```bash
# 1. Abrir Android Studio y crear emulador desde AVD Manager
# (GUI es la forma más fácil)

# 2. Iniciar el emulador desde Android Studio
# (Botón ▶️ en AVD Manager)

# 3. Ejecutar la app
cd C:\Users\dell\cmutem-202502-app\app
flutter run
```

---

**💡 Consejo**: Si el emulador tarda mucho o es muy lento, es mejor usar tu **Motorola físico** siguiendo la guía `GUIA_PROBAR_APP.md`. Es mucho más rápido y representa mejor el comportamiento real de la app.

## 🎬 Video Tutorial (Opcional)

Si prefieres ver un video, busca en YouTube:
- "Create Android Emulator Android Studio 2024"
- "Flutter Android Emulator Setup"

---

**¿Problemas? Avísame qué error aparece y te ayudo! 🚀**

