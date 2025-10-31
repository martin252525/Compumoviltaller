# Guía de Migración a Flutter

Esta guía te ayudará a trasladar los conceptos y arquitectura de esta aplicación web React a tu proyecto Flutter.

## 🎯 Objetivo

Esta aplicación web sirve como **referencia arquitectural** para tu proyecto Flutter. No es necesario copiar el código, sino entender los patrones y estructuras utilizados.

## 📐 Mapeo de Conceptos: React → Flutter

### Estructura de Carpetas

**React (Este proyecto):**
```
/
├── components/      # Widgets de UI
├── hooks/          # Lógica de negocio
├── services/       # Servicios (API, Firebase)
└── types/          # Modelos de datos
```

**Flutter (Recomendado):**
```
lib/
├── presentation/
│   ├── screens/          # Páginas/pantallas
│   ├── widgets/          # Widgets reutilizables
│   └── providers/        # Estado (Riverpod/Provider)
├── domain/
│   ├── models/          # Modelos de datos
│   ├── repositories/    # Interfaces de repositorios
│   └── use_cases/       # Casos de uso
└── data/
    ├── services/        # Servicios (API, Firebase)
    └── repositories/    # Implementaciones de repositorios
```

### Componentes → Widgets

| React Component | Flutter Widget |
|----------------|----------------|
| `LoginScreen.tsx` | `LoginScreen` (StatelessWidget) |
| `VoteProcessList.tsx` | `VoteProcessList` (StatefulWidget) |
| `VoteProcessCard.tsx` | `VoteProcessCard` (StatelessWidget) |
| `Header.tsx` | `AppBar` + `Drawer` |
| `LoadingSpinner.tsx` | `CircularProgressIndicator` |
| `ErrorDisplay.tsx` | Widget personalizado con `Card` |

### Hooks → State Management

| React Hook | Flutter Equivalente |
|-----------|---------------------|
| `useAuth()` | Provider/Riverpod `authProvider` |
| `useVoteProcesses()` | Provider/Riverpod `voteProcessesProvider` |
| `useState()` | `StatefulWidget` + `setState()` |
| `useEffect()` | `initState()` + `dispose()` |
| `useCallback()` | Métodos de clase |

### Servicios

**React (`api.service.ts`):**
```typescript
class ApiService {
  async getVoteProcesses(page, size, search, status) {
    // ...
  }
}
```

**Flutter (`api_service.dart`):**
```dart
class ApiService {
  Future<PaginatedResponse<VoteProcess>> getVoteProcesses({
    required int page,
    required int size,
    String? search,
    String? status,
  }) async {
    // ...
  }
}
```

## 🔥 Firebase en Flutter

### Dependencias Necesarias

```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  google_sign_in: ^6.1.6
```

### Inicialización

**React:**
```typescript
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
```

**Flutter:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

### Autenticación con Google

**React:**
```typescript
const provider = new GoogleAuthProvider();
const result = await signInWithPopup(auth, provider);
```

**Flutter:**
```dart
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);
await FirebaseAuth.instance.signInWithCredential(credential);
```

### Escuchar Cambios de Autenticación

**React:**
```typescript
onAuthStateChanged(auth, (user) => {
  setUser(user);
});
```

**Flutter:**
```dart
FirebaseAuth.instance.authStateChanges().listen((User? user) {
  // Actualizar estado
});
```

## 🌐 Consumo de API

### HTTP Client

**Dependencia:**
```yaml
dependencies:
  http: ^1.1.0
  dio: ^5.4.0  # Alternativa más completa
```

### Implementación con Dio

**React (`api.service.ts`):**
```typescript
async getVoteProcesses(page, size) {
  const response = await fetch(`${API_BASE_URL}/api/vote-processes?page=${page}&size=${size}`);
  return response.json();
}
```

**Flutter (`api_service.dart`):**
```dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.sebastian.cl/vote',
    connectTimeout: Duration(seconds: 10),
  ));

  Future<PaginatedResponse<VoteProcess>> getVoteProcesses({
    required int page,
    required int size,
  }) async {
    try {
      final response = await _dio.get(
        '/api/vote-processes',
        queryParameters: {'page': page, 'size': size},
      );
      return PaginatedResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
```

### Headers de Autenticación

**React:**
```typescript
const token = await firebaseService.getIdToken();
headers['Authorization'] = `Bearer ${token}`;
```

**Flutter:**
```dart
final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
_dio.options.headers['Authorization'] = 'Bearer $idToken';
```

## 📊 Modelos de Datos

### Conversión de TypeScript a Dart

**React (`vote.types.ts`):**
```typescript
export interface VoteProcess {
  id: string;
  title: string;
  description: string;
  startDate: string;
  endDate: string;
  status: 'DRAFT' | 'ACTIVE' | 'CLOSED' | 'CANCELLED';
  options: VoteOption[];
}
```

**Flutter (`vote_process.dart`):**
```dart
class VoteProcess {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final VoteProcessStatus status;
  final List<VoteOption> options;

  VoteProcess({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.options,
  });

  factory VoteProcess.fromJson(Map<String, dynamic> json) {
    return VoteProcess(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: VoteProcessStatus.values.firstWhere(
        (e) => e.toString() == 'VoteProcessStatus.${json['status']}',
      ),
      options: (json['options'] as List)
          .map((e) => VoteOption.fromJson(e))
          .toList(),
    );
  }
}

enum VoteProcessStatus { DRAFT, ACTIVE, CLOSED, CANCELLED }
```

## 🎨 UI Components

### LoadingSpinner

**React:**
```tsx
<Loader2 className="animate-spin" />
```

**Flutter:**
```dart
Center(
  child: CircularProgressIndicator(),
)
```

### Cards

**React (shadcn/ui):**
```tsx
<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
  </CardHeader>
  <CardContent>Content</CardContent>
</Card>
```

**Flutter (Material):**
```dart
Card(
  child: Column(
    children: [
      ListTile(
        title: Text('Title'),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Text('Content'),
      ),
    ],
  ),
)
```

### Infinite Scroll

**React (IntersectionObserver):**
```tsx
const observerTarget = useRef(null);
useEffect(() => {
  const observer = new IntersectionObserver(/* ... */);
  // ...
});
```

**Flutter (ScrollController):**
```dart
final _scrollController = ScrollController();

@override
void initState() {
  super.initState();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.9) {
      _loadMore();
    }
  });
}
```

## 🔐 Seguridad

### Variables de Entorno

**React (`.env`):**
```env
VITE_FIREBASE_API_KEY=xxx
```

**Flutter (`.env` con flutter_dotenv):**
```yaml
# pubspec.yaml
dependencies:
  flutter_dotenv: ^5.1.0

assets:
  - .env
```

```dart
// Cargar
await dotenv.load();
final apiKey = dotenv.env['FIREBASE_API_KEY'];
```

**Alternativa: flutter_config**
```yaml
dependencies:
  flutter_config: ^2.0.2
```

### Configuración de Firebase (Android)

1. Descarga `google-services.json` de Firebase Console
2. Colócalo en `android/app/`
3. Agrega en `android/build.gradle`:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.0'
}
```

4. Agrega en `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```

### Configuración de Firebase (iOS)

1. Descarga `GoogleService-Info.plist` de Firebase Console
2. Agrega el archivo en Xcode al proyecto (Runner)
3. NO lo agregues a `.gitignore` (Firebase lo requiere)

## 📱 State Management

### Provider Pattern (Recomendado)

**Dependencia:**
```yaml
dependencies:
  provider: ^6.1.1
```

**Ejemplo:**
```dart
class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _loading = true;

  User? get user => _user;
  bool get loading => _loading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _init();
  }

  void _init() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      _loading = false;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    // Implementación
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
```

### Riverpod (Alternativa Moderna)

**Dependencia:**
```yaml
dependencies:
  flutter_riverpod: ^2.4.9
```

**Ejemplo:**
```dart
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      state = AsyncValue.data(user);
    });
  }
}
```

## 🧪 Testing

### Unit Tests

**React (Vitest):**
```typescript
describe('ApiService', () => {
  it('should fetch vote processes', async () => {
    const result = await apiService.getVoteProcesses(0, 10);
    expect(result.content).toBeDefined();
  });
});
```

**Flutter:**
```dart
void main() {
  group('ApiService', () {
    test('should fetch vote processes', () async {
      final service = ApiService();
      final result = await service.getVoteProcesses(page: 0, size: 10);
      expect(result.content, isNotEmpty);
    });
  });
}
```

### Widget Tests

```dart
void main() {
  testWidgets('LoginScreen shows sign in button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen()),
    );
    
    expect(find.text('Continuar con Google'), findsOneWidget);
  });
}
```

## 📚 Paquetes Recomendados

### Esenciales
```yaml
dependencies:
  # Firebase
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  google_sign_in: ^6.1.6
  
  # HTTP
  dio: ^5.4.0
  
  # State Management
  provider: ^6.1.1
  # O riverpod:
  flutter_riverpod: ^2.4.9
  
  # UI
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.9
  
  # Utilidades
  intl: ^0.18.1  # Formateo de fechas
  shared_preferences: ^2.2.2  # Persistencia local
```

### Opcionales pero Útiles
```yaml
dependencies:
  # Navegación
  go_router: ^13.0.0
  
  # Formularios
  flutter_form_builder: ^9.1.1
  
  # Notificaciones
  flutter_local_notifications: ^16.3.0
  
  # Animaciones
  lottie: ^3.0.0
```

## 🎯 Checklist de Migración

### Configuración Inicial
- [ ] Crear proyecto Flutter
- [ ] Configurar Firebase (Android + iOS)
- [ ] Instalar dependencias necesarias
- [ ] Configurar variables de entorno

### Capa de Datos
- [ ] Crear modelos de datos (`VoteProcess`, `VoteOption`, etc.)
- [ ] Implementar `ApiService` con Dio
- [ ] Implementar `FirebaseService`
- [ ] Crear repositorios

### Capa de Dominio
- [ ] Definir casos de uso
- [ ] Crear providers/notifiers para estado

### Capa de Presentación
- [ ] Crear screens (Login, Home, Detail, Profile)
- [ ] Crear widgets reutilizables
- [ ] Implementar navegación
- [ ] Agregar manejo de estados (loading, error, empty)

### Funcionalidades
- [ ] Autenticación con Google
- [ ] Listado de votaciones
- [ ] Paginación infinita
- [ ] Búsqueda y filtros
- [ ] Vista de detalle
- [ ] Flujo de votación
- [ ] Perfil de usuario
- [ ] Historial de votos

### Testing
- [ ] Unit tests para servicios
- [ ] Unit tests para modelos
- [ ] Widget tests para componentes clave
- [ ] Integration tests para flujos completos

### CI/CD
- [ ] Configurar GitHub Actions / Bitrise / Codemagic
- [ ] Automatizar tests
- [ ] Configurar builds automáticos

## 💡 Mejores Prácticas

### 1. Separación de Responsabilidades
Mantén la arquitectura por capas como en esta aplicación React.

### 2. Manejo de Errores
Implementa un sistema robusto de manejo de errores como el `ErrorState` de esta app.

### 3. Loading States
Usa estados de carga explícitos para mejor UX.

### 4. Null Safety
Aprovecha el null safety de Dart para evitar errores en runtime.

### 5. Constantes
Define constantes para URLs, colores, tamaños, etc.

```dart
class AppConstants {
  static const String apiBaseUrl = 'https://api.sebastian.cl/vote';
  static const Duration apiTimeout = Duration(seconds: 10);
}
```

## 🔍 Diferencias Clave

| Aspecto | React/Web | Flutter/Mobile |
|---------|-----------|----------------|
| **Navegación** | URLs y rutas | Navigator y routes |
| **Estado** | Hooks | Provider/Riverpod/Bloc |
| **Storage** | localStorage | SharedPreferences |
| **HTTP** | fetch/axios | http/dio |
| **Estilos** | CSS/Tailwind | Widgets con propiedades |
| **Responsive** | Media queries | MediaQuery + LayoutBuilder |

## 📖 Recursos Adicionales

- [Documentación oficial de Flutter](https://flutter.dev/docs)
- [Firebase para Flutter](https://firebase.flutter.dev/)
- [Cookbook de Flutter](https://docs.flutter.dev/cookbook)
- [Pub.dev](https://pub.dev/) - Repositorio de paquetes
- [Flutter Architectural Samples](https://github.com/brianegan/flutter_architecture_samples)

## 🎓 Notas para el Proyecto Universitario

Esta aplicación web implementa:

✅ Arquitectura por capas  
✅ Autenticación Firebase  
✅ Consumo de API REST  
✅ Paginación  
✅ Búsqueda y filtros  
✅ Manejo de estados  
✅ Seguridad (tokens, env vars)  
✅ Tipado fuerte  

Todos estos conceptos son aplicables y transferibles a Flutter.

---

**¡Éxito con tu proyecto Flutter!** 🚀
