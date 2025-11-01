# 🎯 GUÍA RÁPIDA: Probar la App en Emulador (5 Minutos)

## ✅ Método Más Fácil - Usar Android Studio

### 📱 PASO 1: Crear Emulador (Solo la primera vez)

1. **Abre Android Studio**
   - Si está en la pantalla de bienvenida, haz clic en **"More Actions"** (3 puntos verticales)
   - Si tienes un proyecto abierto, ve a **Tools → Device Manager**

2. **Crear Nuevo Dispositivo**
   - Haz clic en **"Create Device"** o el botón **+**
   
3. **Seleccionar Hardware**
   - Categoría: **Phone**
   - Dispositivo: **Pixel 5** (recomendado)
   - Haz clic en **"Next"**

4. **Descargar Sistema Operativo**
   - Pestaña: **Recommended**
   - Selecciona: **Tiramisu (Android 13, API 33)** o **UpsideDownCake (Android 14, API 34)**
   - Si dice "Download", haz clic y espera (puede tardar 5-10 minutos)
   - Una vez descargado, selecciónalo y haz clic en **"Next"**

5. **Finalizar Configuración**
   - Nombre: `Pixel_5_API_33` (o deja el predeterminado)
   - Haz clic en **"Finish"**

### 🚀 PASO 2: Iniciar el Emulador

En el **Device Manager** de Android Studio:
- Busca tu emulador recién creado
- Haz clic en el botón **▶️ (Play)** junto a él
- **Espera 1-2 minutos** a que cargue completamente
- Verás una ventana del teléfono virtual

### 💻 PASO 3: Ejecutar tu App

Abre una terminal (PowerShell o CMD) y ejecuta:

```bash
cd C:\Users\dell\cmutem-202502-app\app
flutter devices
```

Deberías ver algo como:
```
emulator-5554 • Android SDK built for x86 • android • android-x64
```

Ahora ejecuta tu app:
```bash
flutter run
```

O si hay varios dispositivos:
```bash
flutter run -d emulator-5554
```

## 🎬 ¡Eso es todo!

Tu app comenzará a compilar y se instalará en el emulador. La primera vez puede tardar 2-3 minutos.

---

## 🐛 Problemas Comunes

### ❌ "No devices found"
**Solución**: 
- Asegúrate de que el emulador esté completamente iniciado
- Espera a que veas la pantalla de inicio de Android
- Ejecuta `flutter devices` de nuevo

### ❌ El emulador no inicia
**Posibles causas**:
1. **Virtualización deshabilitada en BIOS**
   - Reinicia PC → Entra a BIOS (F2, F10 o DEL)
   - Busca "Intel VT-x" o "AMD-V" o "Virtualization"
   - Habilítalo → Guarda y reinicia

2. **Falta HAXM** (solo Intel)
   - En Android Studio: **Tools → SDK Manager → SDK Tools**
   - Marca **"Intel x86 Emulator Accelerator (HAXM installer)"**
   - Haz clic en **Apply**
   - Ejecuta el instalador desde: `C:\Users\dell\AppData\Local\Android\sdk\extras\intel\Hardware_Accelerated_Execution_Manager\`

### ❌ El emulador es muy lento
**Soluciones**:
1. Cierra otros programas pesados (Chrome, navegadores, etc.)
2. En Device Manager → Editar emulador → **Graphics: Hardware**
3. Aumenta RAM a 2048 MB o más
4. **O mejor**: Usa tu **Motorola físico** (mucho más rápido) siguiendo `GUIA_PROBAR_APP.md`

### ❌ Error al compilar la app
```bash
# Limpia y vuelve a intentar
cd C:\Users\dell\cmutem-202502-app\app
flutter clean
flutter pub get
flutter run
```

---

## 📊 Emulador vs Motorola Físico

| | Emulador | Tu Motorola |
|---|---|---|
| **Velocidad** | 🐌 Lento | 🚀 Rápido |
| **Setup** | ⏱️ 15-20 min | ⚡ 2 min |
| **Recursos PC** | 💻 Alto | 💻 Bajo |
| **Realismo** | ⚠️ Simulado | ✅ 100% Real |
| **Recomendación** | Solo si no tienes cel | ⭐ **Mejor opción** |

---

## 📞 Atajos Rápidos

### Listar emuladores
```bash
C:\Users\dell\AppData\Local\Android\sdk\emulator\emulator.exe -list-avds
```

### Iniciar emulador desde terminal
```bash
C:\Users\dell\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_5_API_33
```

### Ver todos los dispositivos (físicos y emuladores)
```bash
flutter devices
```

### Ejecutar app
```bash
cd C:\Users\dell\cmutem-202502-app\app
flutter run
```

### Durante desarrollo (app corriendo)
- `r` - Recarga rápida (hot reload)
- `R` - Reinicio completo (hot restart)
- `q` - Salir

---

## 🎯 Resumen Ultra-Rápido

```
1. Abre Android Studio
2. More Actions → Device Manager → Create Device
3. Pixel 5 → Next → Tiramisu API 33 → Next → Finish
4. Click en ▶️ para iniciar emulador
5. Abre terminal: flutter run
```

**¡Listo! 🎉**

---

**💡 Tip Pro**: Si el emulador tarda mucho, **usa tu Motorola**. Es 10x más rápido y representa mejor cómo funcionará tu app en producción. Ver `GUIA_PROBAR_APP.md`.

