# Diagrama de Flujo - Inicio de la Aplicación

## Antes (❌ Fallaba sin Firebase)

```
[App Start]
    ↓
[Initialize Firebase] ← ❌ CRASH si falta google-services.json
    ↓
[Show Splash]
    ↓
[Check Auth]
    ↓
[Navigate to Login/Home]
```

## Ahora (✅ Funciona sin Firebase)

```
[App Start]
    ↓
[Try Initialize Firebase]
    ├─ Success → [Firebase Available = true]
    └─ Failure → [Firebase Available = false] ← ✅ NO CRASH
    ↓
[Show Splash]
    ↓
[Check Firebase Available?]
    ├─ Yes → [Check Auth] → [Login or Home]
    └─ No  → [Go to Home (Guest Mode)] ← ✅ Modo exploración
```

## Flujo de Usuario - Sin Firebase

```
[Splash Screen]
    ↓ (2 segundos)
[Votes List Screen]
    ├─ Ver votaciones ✅
    ├─ Buscar ✅
    ├─ Filtrar ✅
    ├─ Ver detalles ✅
    └─ Click "Iniciar Sesión"
        ↓
    [Login Screen]
        └─ Intenta login
            ↓
        [Mensaje: "Firebase no configurado"]
            ↓
        [Botón: "Explorar sin sesión"] → Volver a lista
```

## Flujo de Usuario - Con Firebase

```
[Splash Screen]
    ↓ (2 segundos)
[Check Auth]
    ├─ Autenticado → [Votes List Screen] (con perfil)
    └─ No autenticado → [Login Screen]
        ↓
    [Click "Google Sign-In"]
        ↓
    [Autenticación exitosa]
        ↓
    [Votes List Screen]
        ├─ Ver votaciones ✅
        ├─ Buscar ✅
        ├─ Filtrar ✅
        ├─ Ver detalles ✅
        ├─ VOTAR ✅ (nueva funcionalidad)
        └─ Ver perfil ✅ (nueva funcionalidad)
```

## Arquitectura de Providers

```
[firebaseAvailableProvider]
    ↓ (bool: true/false)
[authServiceProvider]
    ├─ Firebase Available = true
    │   └─ Full AuthService (Google Sign-In, Token, etc.)
    └─ Firebase Available = false
        └─ Limited AuthService (siempre retorna null/false)
            ↓
[currentUserProvider]
    ├─ Firebase Available = true
    │   └─ FirebaseAuth.instance.authStateChanges()
    └─ Firebase Available = false
        └─ Stream.value(null) ← Usuario siempre null
            ↓
[UI Components]
    └─ Adaptan según estado del usuario
        ├─ User = null → Mostrar "Iniciar Sesión"
        └─ User != null → Mostrar perfil/avatar
```

## Build Process

```
[Android Build]
    ↓
[Check google-services.json exists?]
    ├─ Yes → [Apply Google Services Plugin] → [Firebase incluido]
    └─ No  → [Skip Google Services Plugin] → [Build sin Firebase]
        ↓
[Generate APK]
    └─ ✅ Siempre exitoso (sin importar Firebase)
```

## Casos de Uso

### Caso 1: Desarrollo sin Firebase (Tú ahora)
```
Developer
    ↓
1. flutter pub get
2. flutter run
    ↓
✅ App inicia
✅ Puede ver votaciones
✅ Puede buscar/filtrar
✅ Puede ver detalles
⚠️  No puede votar (requiere auth)
```

### Caso 2: Configurar Firebase después
```
Developer
    ↓
1. Crear proyecto Firebase
2. Descargar google-services.json
3. Copiar a android/app/
4. flutter clean
5. flutter run
    ↓
✅ App inicia con Firebase
✅ Puede autenticarse
✅ Puede votar
✅ Puede ver perfil
✅ Todas las funcionalidades habilitadas
```

### Caso 3: Usuario final sin cuenta Google
```
End User
    ↓
1. Instala app
2. Ve splash
3. Ve lista votaciones
4. Explora sin login
    ↓
✅ Experiencia completa de visualización
⚠️  No puede votar sin autenticarse
```

## Pantallas y Estados

```
┌─────────────────────────────────────────┐
│         Splash Screen                   │
│                                         │
│   [Icon] Sistema de Votación           │
│   [Loading...]                          │
│                                         │
│   Checking Firebase...                  │
└─────────────────────────────────────────┘
            ↓
┌─────────────────────────────────────────┐
│      Votes List Screen                  │
│  ┌───────────────────────────────────┐  │
│  │ [Search: _____________] [🔍]      │  │
│  └───────────────────────────────────┘  │
│  [Todas] [Activas] [Finalizadas]       │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📋 Votación Ejemplo             │   │
│  │ Estado: Activa                   │   │
│  │ Fecha: 01/11/2025               │   │
│  └─────────────────────────────────┘   │
│  ┌─────────────────────────────────┐   │
│  │ 📋 Otra Votación                │   │
│  │ Estado: Próxima                 │   │
│  │ Fecha: 05/11/2025               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [Iniciar Sesión] ← Sin Firebase       │
└─────────────────────────────────────────┘
            ↓ Click en votación
┌─────────────────────────────────────────┐
│      Vote Detail Screen                 │
│                                         │
│  📋 Votación Ejemplo                   │
│  ─────────────────────────────────────  │
│  Descripción: Lorem ipsum...           │
│                                         │
│  Opciones:                              │
│  ⚪ Opción A - 45 votos                │
│  ⚪ Opción B - 32 votos                │
│  ⚪ Opción C - 23 votos                │
│                                         │
│  [Votar] ← Requiere autenticación      │
└─────────────────────────────────────────┘
```

## Error Handling Flow

```
[Operation: Initialize Firebase]
    ↓
[Try-Catch Block]
    ├─ Success Path:
    │   └─ firebaseInitialized = true
    │       └─ Log: "Firebase inicializado correctamente"
    │           └─ Full features available
    │
    └─ Error Path:
        └─ firebaseInitialized = false
            └─ Log Warning:
                "Firebase no pudo inicializarse"
                "La app funcionará sin autenticación"
                "Para habilitar: [instrucciones]"
            └─ Limited features (read-only)
                └─ ✅ App continúa funcionando
```

## Estrategia de Migración

```
[Estado Actual]
    ↓
[Sin Firebase] ← Estás aquí
    ├─ Ver votaciones ✅
    ├─ Buscar ✅
    ├─ Filtrar ✅
    └─ Ver detalles ✅
        ↓
    [Cuando necesites auth]
        ↓
[Agregar Firebase]
    ├─ Proyecto Firebase
    ├─ google-services.json
    └─ Recompilar
        ↓
[Con Firebase]
    ├─ Todo lo anterior ✅
    ├─ Autenticación ✅
    ├─ Votar ✅
    └─ Perfil ✅
```

## Resumen Visual

```
┌─────────────────────────────────────────────────────────┐
│                  ANTES (Sin Solución)                   │
├─────────────────────────────────────────────────────────┤
│ Motorola no conecta → ❌ No puede probar app           │
│ Sin google-services.json → ❌ App crashea al iniciar   │
│ Build falla → ❌ No compila                            │
└─────────────────────────────────────────────────────────┘
                        ↓
              [IMPLEMENTACIÓN]
                        ↓
┌─────────────────────────────────────────────────────────┐
│                  AHORA (Con Solución)                   │
├─────────────────────────────────────────────────────────┤
│ Emulador → ✅ Guías completas                          │
│ Sin google-services.json → ✅ Funciona en modo guest   │
│ Build → ✅ Siempre exitoso                             │
│ Firebase opcional → ✅ Configurar cuando necesites     │
│ Documentación → ✅ 4 guías completas                   │
└─────────────────────────────────────────────────────────┘
```

## Comandos Clave

```bash
# Ejecutar inmediatamente (SIN Firebase)
cd app
flutter pub get
flutter run
# ✅ Funciona ahora mismo

# Configurar Firebase (OPCIONAL, después)
# 1. Obtener google-services.json de Firebase Console
# 2. Copiarlo a android/app/
# 3. Ejecutar:
flutter clean
flutter pub get
flutter run
# ✅ Ahora con todas las funcionalidades
```

---

## Leyenda
- ✅ = Funciona / Disponible
- ❌ = No funciona / Falla
- ⚠️ = Advertencia / Limitación
- 🔥 = Firebase
- 📱 = App
- 🔐 = Autenticación
- 📋 = Votación
