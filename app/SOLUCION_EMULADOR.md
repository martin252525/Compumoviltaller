# Solución: Dispositivo Motorola No Conecta - Usar Emulador

## 🔴 Problema
Tu dispositivo Motorola no se pudo conectar para ejecutar la aplicación.

## ✅ Solución
Usar un emulador Android en su lugar. La aplicación está **lista para ejecutarse** en emulador sin configuración adicional.

## 🚀 Pasos Rápidos (5 minutos)

### 1. Abrir Android Studio
- Inicia Android Studio

### 2. Crear/Iniciar Emulador
- Ve a: `Tools` → `Device Manager`
- Si no tienes un AVD:
  - Click `Create Device`
  - Selecciona `Pixel 5`
  - Descarga `API 33` o `API 34`
  - Click `Finish`
- Click en el botón ▶ (Play) para iniciar el emulador
- Espera 1-2 minutos a que inicie completamente

### 3. Ejecutar la App
Abre una terminal en el proyecto y ejecuta:

```bash
cd app
flutter pub get
flutter run
```

**Primera vez:** La compilación puede tardar 5-10 minutos.
**Siguientes veces:** Solo 30-60 segundos.

## 📱 ¿Qué Podrás Hacer?

### ✅ Sin Configurar Firebase (Inmediatamente):
- Ver todas las votaciones disponibles
- Buscar votaciones por título/descripción
- Filtrar por estado (Activa, Finalizada, Próxima)
- Ver detalles completos de cada votación
- Ver resultados en tiempo real
- Navegar por toda la interfaz

### ⚠️ Requiere Configurar Firebase (Opcional):
- Iniciar sesión con Google
- Realizar votos
- Ver tu historial de votos

## 🔥 Configurar Firebase (Opcional)

Solo si quieres habilitar autenticación y votación:

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Crea un proyecto nuevo
3. Agrega una app Android con package: `cm.utem.app`
4. Descarga `google-services.json`
5. Cópialo a: `app/android/app/google-services.json`
6. Habilita Google Sign-In en Authentication
7. Ejecuta: `flutter clean && flutter run`

**Guía completa:** Ver [GUIA_EMULADOR_COMPLETA.md](GUIA_EMULADOR_COMPLETA.md)

## 🐛 Problemas Comunes

### "No devices found"
```bash
adb kill-server
adb start-server
flutter devices
```

### "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### Emulador muy lento
- Asegúrate de tener instalado Intel HAXM (o AMD Hypervisor)
- Reduce la RAM del emulador a 2048 MB
- Cierra otras aplicaciones

### Error de Firebase en los logs
✅ **Esto es normal y esperado** si no configuraste Firebase.
La app funcionará de todos modos.

## 📞 Alternativas

### Opción 1: Arreglar conexión del Motorola
1. En el teléfono: `Ajustes` → `Acerca del teléfono`
2. Toca 7 veces en "Número de compilación"
3. Ve a `Opciones de desarrollador`
4. Activa "Depuración USB"
5. Conecta con cable USB
6. Autoriza la conexión en el teléfono
7. Ejecuta: `flutter run`

### Opción 2: Compilar APK y transferir
```bash
flutter build apk --debug
```
El APK estará en: `build/app/outputs/flutter-apk/app-debug.apk`

Transfiere este archivo a tu Motorola por:
- Email
- Google Drive
- Cable USB
- WhatsApp
- Bluetooth

Instálalo desde el teléfono (permite "Instalar desde fuentes desconocidas" si es necesario).

## 📊 Verificación

Antes de solicitar ayuda, verifica que:
- [ ] Android Studio está instalado
- [ ] `flutter doctor` no muestra errores críticos
- [ ] El emulador aparece en `flutter devices`
- [ ] Ejecutaste `flutter pub get` en el directorio `app/`

## 📚 Documentación Completa

- [Guía Completa del Emulador](GUIA_EMULADOR_COMPLETA.md) - Instrucciones detalladas paso a paso
- [README.md](README.md) - Documentación general del proyecto
- [INFORME_TECNICO.md](INFORME_TECNICO.md) - Arquitectura y diseño técnico

---

💡 **Consejo:** El emulador es más lento que un dispositivo real, pero es perfecto para desarrollo y pruebas. Una vez que funcione, las siguientes ejecuciones serán mucho más rápidas gracias al Hot Reload de Flutter.
