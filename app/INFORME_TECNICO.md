# Informe Técnico - Sistema de Votación Móvil

## 1. Resumen Ejecutivo

Este documento presenta la implementación de una aplicación móvil Flutter para Android que permite a los usuarios autenticarse y participar en procesos de votación mediante el consumo de una API REST.

## 2. Arquitectura Implementada

### 2.1 Arquitectura por Capas

La aplicación sigue el principio de **Arquitectura Limpia** (Clean Architecture) dividida en tres capas principales:

#### Capa de Presentación (presentation/)
- **Responsabilidad**: Interfaz de usuario y manejo de interacciones
- **Componentes**:
  - `screens/`: Pantallas completas de la aplicación
  - `widgets/`: Componentes reutilizables de UI
- **Tecnología**: Flutter Widgets, Material Design 3

#### Capa de Dominio (domain/)
- **Responsabilidad**: Lógica de negocio y gestión de estado
- **Componentes**:
  - `providers/`: Providers de Riverpod para gestión de estado
  - `states/`: Definición de estados de la aplicación
- **Tecnología**: Riverpod, Freezed

#### Capa de Datos (data/)
- **Responsabilidad**: Comunicación con fuentes de datos externas
- **Componentes**:
  - `models/`: Modelos de datos
  - `services/`: Servicios de API
  - `repositories/`: Repositorios de datos
- **Tecnología**: Dio, JSON Serialization

### 2.2 Flujo de Datos

```
UI (Presentation) 
  ↓ (lee estado)
Providers (Domain) 
  ↓ (llama métodos)
Repositories (Data) 
  ↓ (consume)
API Services (Data)
  ↓ (HTTP)
API Externa
```

## 3. Gestión de Estado

### 3.1 Riverpod

Se eligió **Riverpod** como solución de gestión de estado por:

- **Type Safety**: Detección de errores en tiempo de compilación
- **Testabilidad**: Fácil de probar sin dependencias del contexto
- **Performance**: Reconstrucciones optimizadas
- **Developer Experience**: Mejor experiencia de desarrollo con code generation

### 3.2 Providers Implementados

#### AuthProviders
- `authServiceProvider`: Servicio de autenticación
- `currentUserProvider`: Stream del usuario actual
- `authStateProvider`: Estado de autenticación

#### VoteProviders
- `voteRepositoryProvider`: Repositorio de votaciones
- `voteListProvider`: Lista de votaciones con paginación
- `voteDetailProvider`: Detalle de una votación específica
- `voteHistoryProvider`: Historial de votos del usuario

### 3.3 Estados Definidos

Utilizando **Freezed** para inmutabilidad y pattern matching:

```dart
@freezed
class VoteListState with _$VoteListState {
  const factory VoteListState.initial() = _Initial;
  const factory VoteListState.loading() = _Loading;
  const factory VoteListState.loaded(...) = _Loaded;
  const factory VoteListState.error(String message) = _Error;
}
```

## 4. Consumo de API

### 4.1 Cliente HTTP

Se utiliza **Dio** como cliente HTTP con las siguientes configuraciones:

- **Base URL**: `https://api.sebastian.cl/vote`
- **Timeout**: 30 segundos (connect y receive)
- **Interceptores**: LogInterceptor para debugging
- **Headers**: Accept y Content-Type application/json

### 4.2 Mapeo de Modelos

#### Serialización JSON
Uso de `json_serializable` para generación automática de código:

```dart
@JsonSerializable()
class VoteModel {
  final String id;
  final String title;
  // ...
  
  factory VoteModel.fromJson(Map<String, dynamic> json) =>
      _$VoteModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$VoteModelToJson(this);
}
```

#### Modelos Principales

1. **VoteModel**: Representa una votación completa
2. **VoteOption**: Representa una opción dentro de una votación
3. **UserVote**: Representa el voto de un usuario
4. **PaginatedResponse<T>**: Respuesta paginada genérica

### 4.3 Endpoints Consumidos

| Endpoint | Método | Autenticación | Descripción |
|----------|--------|---------------|-------------|
| `/votes` | GET | No | Lista paginada de votaciones |
| `/votes/{id}` | GET | No | Detalle de votación |
| `/votes/{id}/cast` | POST | Sí | Realizar voto |
| `/user/votes` | GET | Sí | Historial del usuario |
| `/votes/{id}/results` | GET | No | Resultados de votación |

## 5. Autenticación y Seguridad

### 5.1 Firebase Authentication

Implementación de autenticación con Firebase:

```dart
// Flujo de autenticación
GoogleSignIn → Firebase Auth → ID Token → Secure Storage
```

#### Características:
- Inicio de sesión con Google
- Persistencia de sesión con FlutterSecureStorage
- ID Token automáticamente renovado por Firebase
- Cierre de sesión seguro

### 5.2 Medidas de Seguridad

1. **Almacenamiento Seguro**:
   - Tokens en FlutterSecureStorage (encriptado)
   - Datos de perfil en SharedPreferences

2. **Sin Credenciales en Código**:
   - Configuración de Firebase mediante google-services.json
   - Variables de entorno para configuraciones sensibles

3. **Validación de Tokens**:
   - Verificación de token antes de operaciones sensibles
   - Interceptor para agregar Authorization header

4. **Timeout de Peticiones**:
   - 30 segundos para evitar bloqueos indefinidos

## 6. Manejo de Errores

### 6.1 Clasificación de Errores

La aplicación diferencia entre varios tipos de errores:

```dart
String _getErrorMessage(dynamic error) {
  if (error.toString().contains('SocketException')) {
    return 'Error de conexión. Verifica tu internet.';
  } else if (error.toString().contains('TimeoutException')) {
    return 'Tiempo de espera agotado.';
  } else if (error.toString().contains('401')) {
    return 'No autorizado.';
  } else if (error.toString().contains('5')) {
    return 'Error del servidor.';
  }
  return 'Error inesperado.';
}
```

### 6.2 Estados de Error en UI

- **ErrorView**: Componente reutilizable para mostrar errores
- **Botón de Reintentar**: Permite al usuario volver a intentar la operación
- **Mensajes Descriptivos**: Explicaciones claras del problema

### 6.3 Estados de Carga

- **LoadingIndicator**: Indicador de progreso centralizado
- **Shimmer Effects**: Para mejor UX (futuro)
- **Pull-to-Refresh**: En todas las listas

## 7. Experiencia de Usuario

### 7.1 Navegación

- **Splash Screen**: Verifica autenticación al iniciar
- **Login Screen**: Autenticación con Google
- **Votes List**: Lista principal con búsqueda y filtros
- **Vote Detail**: Detalle completo con opción de votar
- **Profile**: Perfil de usuario con historial

### 7.2 Funcionalidades de UI

#### Búsqueda y Filtros
- Campo de búsqueda en tiempo real
- Filtros por estado (Activa, Finalizada, Próxima)
- Chips interactivos para selección de filtros

#### Paginación Infinita
- Carga automática al hacer scroll
- Indicador de carga al final de la lista
- Optimización de peticiones (solo cuando es necesario)

#### Pull-to-Refresh
- En lista de votaciones
- En detalle de votación
- En perfil de usuario

### 7.3 Estados de UI

1. **Initial**: Estado inicial
2. **Loading**: Cargando datos
3. **Loaded**: Datos cargados exitosamente
4. **Empty**: Sin datos disponibles
5. **Error**: Error al cargar datos

## 8. Pruebas (Por Implementar)

### 8.1 Pruebas Unitarias

```dart
// Ejemplo de prueba para VoteRepository
test('getVotes returns paginated response', () async {
  final repository = VoteRepository();
  final response = await repository.getVotes(page: 0, size: 10);
  expect(response, isA<PaginatedResponse<VoteModel>>());
});
```

### 8.2 Pruebas de Widgets

```dart
// Ejemplo de prueba para VoteCard
testWidgets('VoteCard displays vote information', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: VoteCard(vote: mockVote, onTap: () {}),
    ),
  );
  expect(find.text('Test Vote'), findsOneWidget);
});
```

### 8.3 Cobertura Objetivo

- **Modelos**: 80%
- **Servicios**: 70%
- **Providers**: 60%
- **Widgets**: 50%

## 9. CI/CD (Por Configurar)

### 9.1 GitHub Actions

```yaml
name: Flutter CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --debug
```

### 9.2 Verificaciones Automáticas

1. **Análisis Estático**: `flutter analyze`
2. **Pruebas**: `flutter test`
3. **Build**: `flutter build apk --debug`

## 10. Mejoras y Trabajo Futuro

### 10.1 Funcionalidades Pendientes

- [ ] Caché local de votaciones (Hive/SQLite)
- [ ] Modo offline con sincronización
- [ ] Notificaciones push (Firebase Cloud Messaging)
- [ ] Compartir resultados en redes sociales
- [ ] Gráficos avanzados de resultados (charts_flutter)

### 10.2 Optimizaciones

- [ ] Implementar lazy loading de imágenes
- [ ] Reducir tamaño del APK
- [ ] Optimizar rendimiento con const constructors
- [ ] Implementar code splitting

### 10.3 UX Improvements

- [ ] Animaciones de transición
- [ ] Tema oscuro
- [ ] Soporte para tablets
- [ ] Accesibilidad mejorada
- [ ] Internacionalización (i18n)

## 11. Conclusiones

### 11.1 Objetivos Cumplidos

✅ Arquitectura limpia por capas
✅ Autenticación con Firebase y Google
✅ Consumo completo de API REST
✅ Gestión de estado con Riverpod
✅ Manejo robusto de errores
✅ UI responsive y moderna
✅ Código mantenible y escalable

### 11.2 Lecciones Aprendidas

1. **Riverpod**: Excelente para proyectos escalables, curva de aprendizaje moderada
2. **Freezed**: Ahorra mucho código boilerplate
3. **Firebase**: Integración sencilla pero requiere configuración cuidadosa
4. **API REST**: Importante tener buena documentación (OpenAPI)

### 11.3 Desafíos Superados

- Configuración inicial de Firebase para Android
- Manejo de estados complejos con Riverpod
- Paginación infinita con gestión de estado
- Serialización de respuestas genéricas paginadas

## 12. Referencias

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Firebase Auth](https://firebase.google.com/docs/auth)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [API Documentation](https://api.sebastian.cl/vote/swagger-ui/index.html)

---

**Autor**: Martin
**Fecha**: Mayo 2025
**Versión**: 1.0.0

