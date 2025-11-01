# Sistema de Votación - Aplicación Móvil Flutter

## ⚡ Inicio Rápido

```bash
cd app
flutter pub get
flutter run
```

**Nota:** La app funciona sin configurar Firebase. Podrás explorar votaciones, buscar y ver detalles. Para habilitar autenticación y votar, consulta la [sección de Firebase](#configuración-de-firebase-opcional).

## Descripción

Aplicación móvil desarrollada en Flutter para Android que permite a los usuarios autenticarse mediante Firebase Authentication con Google y participar en votaciones a través de la API REST disponible en `https://api.sebastian.cl/vote`.

## 🎯 Ejecutar en Emulador

¿Problemas para conectar tu dispositivo físico? Consulta la [**Guía Completa del Emulador**](GUIA_EMULADOR_COMPLETA.md) para instrucciones paso a paso.

## Características Principales

### Autenticación (Opcional - Requiere Firebase)
- ✅ Inicio de sesión con Google mediante Firebase Authentication
- ✅ Persistencia de sesión
- ✅ Cierre de sesión seguro
- ✅ Pantalla de perfil de usuario

### Votaciones (Funciona sin Firebase)
- ✅ Listado de votaciones con paginación infinita (infinite scroll)
- ✅ Búsqueda de votaciones por título/descripción
- ✅ Filtros por estado (Activa, Finalizada, Próxima)
- ✅ Vista detallada de cada votación
- ✅ Visualización de resultados en tiempo real
- ⚠️ Proceso de votación seguro (requiere autenticación)
- ⚠️ Historial de votaciones del usuario (requiere autenticación)

### Arquitectura
- ✅ Arquitectura por capas (Presentación, Dominio, Datos)
- ✅ Gestión de estado con Riverpod
- ✅ Separación de responsabilidades
- ✅ Código mantenible y escalable

### Manejo de Errores
- ✅ Estados diferenciados: Loading, Success, Error, Empty
- ✅ Mensajes de error específicos para:
  - Errores de red (SocketException)
  - Timeout
  - Errores 4xx (No autorizado, No encontrado)
  - Errores 5xx (Error del servidor)
- ✅ Botón de reintentar en caso de error
- ✅ Pull-to-refresh en todas las listas

## Estructura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada de la aplicación
├── consts/
│   └── app_const.dart                 # Constantes de la aplicación
├── data/                              # Capa de datos
│   ├── models/
│   │   └── vote_model.dart           # Modelos de datos
│   ├── services/
│   │   └── vote_api_service.dart     # Servicio de consumo de API
│   └── repositories/
│       └── vote_repository.dart       # Repositorio de votaciones
├── domain/                            # Capa de dominio
│   ├── providers/
│   │   ├── auth_providers.dart       # Providers de autenticación
│   │   └── vote_providers.dart       # Providers de votaciones
│   └── states/
│       └── vote_state.dart           # Estados de la aplicación
├── presentation/                      # Capa de presentación
│   ├── screens/
│   │   ├── splash_screen.dart        # Pantalla de inicio
│   │   ├── votes_list_screen.dart    # Lista de votaciones
│   │   ├── vote_detail_screen.dart   # Detalle de votación
│   │   └── profile_screen.dart       # Perfil de usuario
│   └── widgets/
│       ├── vote_card.dart            # Card de votación
│       ├── loading_indicator.dart    # Indicador de carga
│       ├── error_view.dart           # Vista de error
│       └── empty_view.dart           # Vista vacía
└── screens/                           # Pantallas legacy
    └── login_screen.dart             # Pantalla de login
```

## Tecnologías Utilizadas

### Dependencias Principales
- **flutter_riverpod**: ^3.0.3 - Gestión de estado
- **firebase_core**: ^4.2.0 - Core de Firebase
- **firebase_auth**: ^6.1.1 - Autenticación con Firebase
- **google_sign_in**: ^7.2.0 - Inicio de sesión con Google
- **dio**: ^5.9.0 - Cliente HTTP para consumo de API
- **flutter_secure_storage**: ^9.2.4 - Almacenamiento seguro de tokens
- **shared_preferences**: ^2.5.3 - Almacenamiento local
- **freezed**: ^3.2.3 - Generación de código para modelos inmutables
- **json_serializable**: ^6.11.1 - Serialización JSON
- **intl**: ^0.20.2 - Formateo de fechas

### Dependencias de Desarrollo
- **build_runner**: ^2.7.1 - Generación de código
- **freezed_annotation**: ^3.1.0 - Anotaciones para Freezed
- **riverpod_generator**: ^3.0.3 - Generación de providers
- **flutter_lints**: ^6.0.0 - Análisis estático

## Configuración e Instalación

### Prerrequisitos
- Flutter SDK 3.9.2 o superior
- Dart SDK 3.9.2 o superior
- Android Studio / VS Code
- Emulador Android o dispositivo físico
- (Opcional) Cuenta de Google Cloud Platform para Firebase

### Instalación Rápida

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/martin252525/Compumoviltaller.git
   cd app
   ```

2. Instalar dependencias:
   ```bash
   flutter pub get
   ```

3. **Ejecutar en emulador o dispositivo:**
   ```bash
   flutter run
   ```

**¡Listo!** La app funcionará inmediatamente en modo exploración (sin autenticación).

### Configuración de Firebase (Opcional)

⚠️ **Solo necesario si quieres habilitar:**
- Inicio de sesión con Google
- Realizar votos
- Ver historial personal de votos

Si solo quieres probar la app y ver las votaciones, **puedes omitir esta sección**.

#### Pasos para configurar Firebase:

1. Crear un proyecto en [Firebase Console](https://console.firebase.google.com/)

2. Habilitar Firebase Authentication:
   - Ir a Authentication > Sign-in method
   - Habilitar "Google" como proveedor

3. Agregar app Android al proyecto:
   - Package name: `cm.utem.app`
   - Descargar `google-services.json`
   - Colocar en `android/app/google-services.json`

4. (Opcional) Agregar SHA-1 y SHA-256 para producción:
   ```bash
   # Generar tus propias claves de debug:
   cd android
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

5. Recompilar la app:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

3. Generar código (modelos, estados):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Ejecutar la aplicación:
   ```bash
   flutter run
   ```

## Endpoints de la API Utilizados

Base URL: `https://api.sebastian.cl/vote`

### 1. Listar Votaciones
- **Endpoint**: `GET /votes`
- **Autenticación**: No requerida
- **Parámetros**:
  - `page` (int, opcional): Número de página (default: 0)
  - `size` (int, opcional): Tamaño de página (default: 10)
  - `search` (string, opcional): Búsqueda por título/descripción
  - `status` (string, opcional): Filtro por estado (ACTIVE, FINISHED, UPCOMING)
- **Respuesta**: Objeto paginado con lista de votaciones

### 2. Detalle de Votación
- **Endpoint**: `GET /votes/{voteId}`
- **Autenticación**: No requerida
- **Respuesta**: Objeto VoteModel con detalles completos

### 3. Realizar Voto
- **Endpoint**: `POST /votes/{voteId}/cast`
- **Autenticación**: Requerida (Bearer Token)
- **Body**:
  ```json
  {
    "optionId": "string"
  }
  ```
- **Respuesta**: 200 OK si el voto fue exitoso

### 4. Historial de Votos del Usuario
- **Endpoint**: `GET /user/votes`
- **Autenticación**: Requerida (Bearer Token)
- **Respuesta**: Lista de votos realizados por el usuario

### 5. Resultados de Votación
- **Endpoint**: `GET /votes/{voteId}/results`
- **Autenticación**: No requerida
- **Respuesta**: VoteModel con resultados actualizados

## Modelos de Datos

### VoteModel
```dart
{
  "id": "string",
  "title": "string",
  "description": "string",
  "startDate": "DateTime",
  "endDate": "DateTime",
  "status": "string", // ACTIVE, FINISHED, UPCOMING
  "options": [VoteOption],
  "totalVotes": "int?"
}
```

### VoteOption
```dart
{
  "id": "string",
  "name": "string",
  "description": "string?",
  "votes": "int"
}
```

### UserVote
```dart
{
  "voteId": "string",
  "optionId": "string",
  "votedAt": "DateTime"
}
```

## Seguridad

- ✅ No hay credenciales hardcodeadas en el código
- ✅ Tokens almacenados de forma segura con FlutterSecureStorage
- ✅ Variables de entorno para configuración sensible
- ✅ Validación de tokens en cada petición autenticada
- ✅ Timeout configurado para todas las peticiones HTTP (30 segundos)

## Pruebas

### Ejecutar Pruebas Unitarias
```bash
flutter test
```

### Cobertura de Código
```bash
flutter test --coverage
```

## CI/CD

El proyecto está configurado con GitHub Actions para:
- ✅ Análisis estático del código (flutter analyze)
- ✅ Ejecución de pruebas unitarias
- ✅ Compilación en modo debug

## Capturas de Pantalla

(Agregar capturas de pantalla de la aplicación)

## Decisiones Técnicas

### Arquitectura por Capas
Se implementó una arquitectura limpia con separación en tres capas:
- **Presentación**: Widgets y pantallas (UI)
- **Dominio**: Lógica de negocio, providers y estados
- **Datos**: Repositorios, servicios API y modelos

### Gestión de Estado con Riverpod
Se eligió Riverpod por:
- Type-safety y compile-time safety
- Mejor testabilidad
- No dependencia del BuildContext
- Soporte para async/await nativo

### Manejo de Errores
Se implementó un sistema robusto que diferencia entre:
- Errores de red (sin conexión)
- Timeouts
- Errores del cliente (4xx)
- Errores del servidor (5xx)

### Serialización JSON
Se utilizó `json_serializable` con `freezed` para:
- Generación automática de código
- Inmutabilidad de modelos
- Type-safety completo

## Problemas Conocidos

- La API puede tener limitaciones de rate limiting
- Es necesario configurar Firebase para cada entorno

## Mejoras Futuras

- [ ] Agregar más pruebas (widgets y de integración)
- [ ] Implementar caché local de votaciones
- [ ] Soporte para modo offline
- [ ] Notificaciones push para nuevas votaciones
- [ ] Soporte para múltiples idiomas (i18n)
- [ ] Tema oscuro
- [ ] Animaciones mejoradas

## Autor

- **Nombre**: Martin
- **GitHub**: [@martin252525](https://github.com/martin252525)
- **Repositorio**: [Compumoviltaller](https://github.com/martin252525/Compumoviltaller)

## Licencia

Este proyecto es parte de un trabajo académico para el curso de Computación Móvil.

## Documentación Adicional

Para más información sobre la API, consultar:
- [Swagger UI](https://api.sebastian.cl/vote/swagger-ui/index.html)
- [Especificación OpenAPI](https://api.sebastian.cl/vote/v3/api-docs)

