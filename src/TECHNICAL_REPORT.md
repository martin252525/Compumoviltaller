# Informe Técnico - Sistema de Votación Web

## 1. Arquitectura Empleada

### 1.1 Patrón Arquitectónico

La aplicación implementa una **arquitectura por capas** (Layered Architecture) con clara separación de responsabilidades:

```
┌─────────────────────────────────────┐
│    Capa de Presentación             │
│  (Components, UI, Views)            │
├─────────────────────────────────────┤
│    Capa de Dominio                  │
│  (Hooks, Business Logic, Types)     │
├─────────────────────────────────────┤
│    Capa de Datos                    │
│  (Services, API, Firebase)          │
└─────────────────────────────────────┘
```

### 1.2 Descripción de Capas

#### **Capa de Presentación** (`/components`)
Responsable de la interfaz de usuario y la interacción con el usuario.

**Componentes principales:**
- `Header.tsx`: Navegación y menú de usuario
- `LoginScreen.tsx`: Pantalla de autenticación
- `VoteProcessList.tsx`: Lista de procesos de votación
- `VoteProcessDetail.tsx`: Detalle y votación
- `UserProfile.tsx`: Perfil del usuario
- `VotingHistory.tsx`: Historial de participación
- `SearchAndFilter.tsx`: Búsqueda y filtros
- `ErrorDisplay.tsx`, `LoadingSpinner.tsx`, `EmptyState.tsx`: Estados de UI

**Principios aplicados:**
- Componentes pequeños y reutilizables
- Separación de lógica de presentación
- Props tipadas con TypeScript
- Manejo de estados de UI (loading, error, empty, success)

#### **Capa de Dominio** (`/hooks`, `/types`)
Contiene la lógica de negocio y las reglas de la aplicación.

**Custom Hooks:**
- `useAuth.ts`: Gestión de autenticación
- `useVoteProcesses.ts`: Lista de votaciones con paginación
- `useVoteProcess.ts`: Detalle de una votación específica
- `useUserVotes.ts`: Historial de votos del usuario

**Tipos de Dominio:**
- `VoteProcess`: Modelo de proceso de votación
- `VoteOption`: Modelo de opción de voto
- `UserVote`: Modelo de voto de usuario
- `PaginatedResponse<T>`: Tipo genérico de paginación
- `ErrorState`: Modelo de estado de error

**Beneficios:**
- Reutilización de lógica entre componentes
- Testabilidad mejorada
- Separación de concerns
- Type safety con TypeScript

#### **Capa de Datos** (`/services`)
Maneja la comunicación con servicios externos y persistencia.

**Servicios:**

1. **`firebase.service.ts`**
   - Inicialización de Firebase
   - Autenticación con Google
   - Gestión de sesión
   - Obtención de tokens

2. **`api.service.ts`**
   - Consumo de API REST
   - Manejo de timeouts
   - Interceptores de headers
   - Manejo centralizado de errores
   - Serialización/deserialización

**Patrones aplicados:**
- Singleton para servicios
- Error handling centralizado
- Timeout management
- Token refresh automático

## 2. Mapeo de Modelos

### 2.1 Modelos de Dominio

Los modelos se definieron siguiendo estrictamente la especificación OpenAPI:

```typescript
// Vote Process Model
interface VoteProcess {
  id: string;                    // UUID del proceso
  title: string;                 // Título de la votación
  description: string;           // Descripción detallada
  startDate: string;            // ISO 8601 datetime
  endDate: string;              // ISO 8601 datetime
  status: 'DRAFT' | 'ACTIVE' | 'CLOSED' | 'CANCELLED';
  createdAt: string;            // Timestamp de creación
  updatedAt: string;            // Timestamp de actualización
  options: VoteOption[];        // Opciones disponibles
  totalVotes?: number;          // Total de votos (opcional)
}

// Vote Option Model
interface VoteOption {
  id: string;                   // UUID de la opción
  voteProcessId: string;        // FK al proceso
  optionText: string;           // Texto de la opción
  votes: number;                // Contador de votos
  createdAt: string;            // Timestamp de creación
}

// User Vote Model
interface UserVote {
  id: string;                   // UUID del voto
  voteProcess: VoteProcess;     // Proceso completo
  selectedOption: VoteOption;   // Opción seleccionada
  votedAt: string;              // Timestamp del voto
}
```

### 2.2 Estrategia de Serialización

**Deserialización (API → App):**
```typescript
// La API devuelve JSON que TypeScript valida
const response = await fetch(url);
const data: VoteProcess = await response.json();
// TypeScript garantiza el tipo en tiempo de compilación
```

**Serialización (App → API):**
```typescript
// Modelo de request
interface VoteRequest {
  voteProcessId: string;
  optionId: string;
}

// Envío al servidor
await fetch(url, {
  method: 'POST',
  body: JSON.stringify(voteRequest),
  headers: { 'Content-Type': 'application/json' }
});
```

### 2.3 Paginación

```typescript
interface PaginatedResponse<T> {
  content: T[];           // Array de elementos
  totalElements: number;  // Total de registros
  totalPages: number;     // Total de páginas
  size: number;          // Tamaño de página
  number: number;        // Página actual (0-indexed)
  first: boolean;        // Es primera página
  last: boolean;         // Es última página
}
```

## 3. Manejo de Errores

### 3.1 Clasificación de Errores

```typescript
type ErrorType = 
  | 'network'    // Error de conectividad
  | 'client'     // Error 4xx (solicitud incorrecta)
  | 'server'     // Error 5xx (servidor)
  | 'timeout'    // Timeout de solicitud
  | 'business';  // Error de negocio

interface ErrorState {
  type: ErrorType;
  message: string;
  code?: number;
  canRetry: boolean;  // Puede reintentarse
}
```

### 3.2 Manejo por Capa

#### **En el Servicio API:**
```typescript
private async handleResponse<T>(response: Response): Promise<T> {
  if (!response.ok) {
    const status = response.status;
    
    // Error de cliente (4xx)
    if (status >= 400 && status < 500) {
      throw this.createError('client', errorMessage, status);
    } 
    // Error de servidor (5xx)
    else if (status >= 500) {
      throw this.createError('server', errorMessage, status);
    }
  }
  return response.json();
}
```

#### **Manejo de Timeout:**
```typescript
private async fetchWithTimeout(
  url: string,
  options: RequestInit = {},
  timeout: number = 10000
): Promise<Response> {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeout);

  try {
    const response = await fetch(url, {
      ...options,
      signal: controller.signal,
    });
    clearTimeout(timeoutId);
    return response;
  } catch (error: any) {
    if (error.name === 'AbortError') {
      throw this.createError('timeout', 'Request timeout', 408);
    }
    throw this.createError('network', 'Network error', 0);
  }
}
```

#### **En la UI:**
```typescript
// Componente ErrorDisplay muestra mensajes diferenciados
const getErrorTitle = () => {
  switch (error.type) {
    case 'network': return 'Error de Conexión';
    case 'server': return 'Error del Servidor';
    case 'timeout': return 'Tiempo de Espera Agotado';
    case 'client': return 'Error de Solicitud';
    default: return 'Error';
  }
}
```

### 3.3 Estrategia de Retry

```typescript
// Los errores retryables son:
canRetry: type === 'network' || type === 'timeout' || code >= 500

// UI muestra botón de retry cuando es posible
{error.canRetry && onRetry && (
  <Button onClick={onRetry}>Reintentar</Button>
)}
```

## 4. Medidas de Seguridad Aplicadas

### 4.1 Gestión de Credenciales

**❌ NO HACER:**
```typescript
// NUNCA hardcodear credenciales
const apiKey = "AIzaSyXXXXXXXXXXXX";
```

**✅ HACER:**
```typescript
// Usar variables de entorno
const apiKey = import.meta.env.VITE_FIREBASE_API_KEY || "YOUR_API_KEY";
```

**Archivos de configuración:**
- `.env`: Credenciales reales (en `.gitignore`)
- `.env.example`: Plantilla sin credenciales (en Git)

### 4.2 Autenticación

**Token Management:**
```typescript
// Obtener token de Firebase
async getIdToken(): Promise<string | null> {
  const user = this.getCurrentUser();
  if (!user) return null;
  return await user.getIdToken();
}

// Enviar en headers de API
const headers = {
  'Authorization': `Bearer ${token}`
};
```

**Persistencia Segura:**
```typescript
// Firebase maneja la persistencia de manera segura
setPersistence(this.auth, browserLocalPersistence);
```

### 4.3 Validación de Acceso

**Endpoints Públicos:**
- `GET /api/vote-processes` - Sin autenticación
- `GET /api/vote-processes/{id}` - Sin autenticación

**Endpoints Privados:**
- `POST /api/votes` - Requiere token
- `GET /api/votes/user` - Requiere token
- `GET /api/votes/check/{id}` - Requiere token

**Validación en Cliente:**
```typescript
// Verificar autenticación antes de mostrar opciones
const canVote = () => {
  return isAuthenticated && 
         voteProcess.status === 'ACTIVE' && 
         !hasVoted;
}
```

### 4.4 Sanitización de Datos

**TypeScript Type Safety:**
```typescript
// Los tipos previenen inyección de datos incorrectos
interface VoteRequest {
  voteProcessId: string;  // Solo acepta strings
  optionId: string;       // Validado por tipo
}
```

**Validación de Respuestas:**
```typescript
// Verificar estructura antes de usar
if (!response.ok) {
  // Manejar error antes de procesar datos
  throw new Error();
}
const data: VoteProcess = await response.json();
```

### 4.5 Protección CSRF

- Firebase tokens incluyen protección contra CSRF
- Tokens de corta duración con refresh automático
- Validación de origen en Firebase

### 4.6 HTTPS

- API usa HTTPS: `https://api.sebastian.cl/vote`
- Firebase usa HTTPS por defecto
- Previene man-in-the-middle attacks

## 5. Características Adicionales

### 5.1 Infinite Scroll

Implementación usando Intersection Observer API:

```typescript
const handleObserver = useCallback((entries) => {
  const [entry] = entries;
  if (entry.isIntersecting && hasMore && !loading) {
    onLoadMore();
  }
}, [hasMore, loading, onLoadMore]);

useEffect(() => {
  const observer = new IntersectionObserver(handleObserver);
  observer.observe(observerTarget.current);
}, [handleObserver]);
```

### 5.2 Búsqueda y Filtros en Tiempo Real

Debouncing implícito mediante hooks de React:

```typescript
const {
  data,
  loadingState,
  error,
} = useVoteProcesses({
  search,        // Se actualiza en tiempo real
  status: statusFilter,
});

// Resetear página al cambiar filtros
useEffect(() => {
  resetPage();
}, [search, statusFilter]);
```

### 5.3 Manejo de Estados de UI

Cuatro estados principales:

1. **Idle**: Estado inicial
2. **Loading**: Cargando datos
3. **Success**: Datos cargados
4. **Error**: Error en carga

```typescript
type LoadingState = 'idle' | 'loading' | 'success' | 'error';
```

## 6. Optimizaciones

### 6.1 Code Splitting

- Componentes cargados bajo demanda
- Lazy loading de vistas

### 6.2 Memoización

```typescript
// useCallback para funciones
const handleVote = useCallback(async () => {
  // ...
}, [selectedOption]);

// useMemo para valores computados (si fuera necesario)
```

### 6.3 Performance

- Virtual scrolling para listas grandes (via infinite scroll)
- Paginación para reducir carga inicial
- Debouncing en búsqueda

## 7. Testing Strategy

### 7.1 Pruebas Unitarias

**Servicios:**
```typescript
describe('apiService', () => {
  it('should handle timeout errors', async () => {
    // Mock timeout
    // Verify error type is 'timeout'
  });
});
```

**Hooks:**
```typescript
describe('useAuth', () => {
  it('should sign in with Google', async () => {
    // Test authentication flow
  });
});
```

### 7.2 Pruebas de Integración

**Components:**
```typescript
describe('VoteProcessDetail', () => {
  it('should submit vote when option selected', async () => {
    // Test voting flow
  });
});
```

## 8. Conclusiones

### 8.1 Logros

✅ Arquitectura limpia y escalable  
✅ Separación clara de responsabilidades  
✅ Manejo robusto de errores  
✅ Seguridad mediante variables de entorno  
✅ Type safety con TypeScript  
✅ UX fluida con infinite scroll  
✅ Responsive design  

### 8.2 Posibles Mejoras Futuras

- Implementar caché de datos con React Query
- Añadir pruebas E2E con Playwright
- Implementar Progressive Web App (PWA)
- Añadir soporte offline
- Implementar notificaciones push
- Añadir analytics

### 8.3 Lecciones Aprendidas

1. La arquitectura por capas facilita el mantenimiento
2. TypeScript previene muchos errores en tiempo de desarrollo
3. El manejo centralizado de errores mejora la UX
4. Las variables de entorno son esenciales para la seguridad
5. Los custom hooks encapsulan lógica compleja efectivamente

---

**Fecha:** 30 de Octubre, 2025  
**Versión:** 1.0.0  
**Tecnologías:** React 18, TypeScript, Firebase, Tailwind CSS
