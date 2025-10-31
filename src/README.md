# Sistema de Votación - Aplicación Web

Aplicación web desarrollada con React, TypeScript y Tailwind CSS que permite a los usuarios autenticarse mediante Firebase Authentication y participar en procesos de votación consumiendo la API de votación.

> ⚠️ **IMPORTANTE**: Esta es una aplicación web de demostración desarrollada en React para servir como referencia arquitectural para el proyecto Flutter original. No está destinada para uso en producción.

## 🎓 Proyecto Académico

Universidad Tecnológica Metropolitana  
Departamento de Computación e Informática  
Computación Móvil  
Profesor: Sebastián Salazar Molina

## 🏗️ Arquitectura

La aplicación sigue una arquitectura por capas con separación de responsabilidades:

### Capas

1. **Capa de Presentación** (`/components`)
   - Componentes de UI reutilizables
   - Vistas de páginas
   - Manejo de estados de UI (loading, error, empty, success)

2. **Capa de Dominio** (`/hooks`, `/types`)
   - Custom hooks para lógica de negocio
   - Tipos e interfaces TypeScript
   - Gestión de estado de la aplicación

3. **Capa de Datos** (`/services`)
   - Servicios de API
   - Integración con Firebase
   - Manejo de errores centralizado

### Estructura de Archivos

```
/
├── components/           # Componentes de UI
│   ├── ui/              # Componentes base (shadcn/ui)
│   ├── Header.tsx       # Navegación principal
│   ├── LoginScreen.tsx  # Pantalla de autenticación
│   ├── VoteProcessList.tsx      # Lista de votaciones
│   ├── VoteProcessDetail.tsx    # Detalle y votación
│   ├── UserProfile.tsx          # Perfil de usuario
│   ├── VotingHistory.tsx        # Historial de votos
│   ├── SearchAndFilter.tsx      # Búsqueda y filtros
│   ├── ErrorDisplay.tsx         # Manejo de errores
│   ├── LoadingSpinner.tsx       # Estados de carga
│   └── EmptyState.tsx           # Estados vacíos
├── hooks/               # Custom hooks
│   ├── useAuth.ts       # Autenticación
│   ├── useVoteProcesses.ts      # Listado de votaciones
│   ├── useVoteProcess.ts        # Detalle de votación
│   └── useUserVotes.ts          # Historial de votos
├── services/            # Servicios
│   ├── firebase.service.ts      # Firebase Auth
│   └── api.service.ts           # API REST
├── types/               # Definiciones TypeScript
│   └── vote.types.ts    # Tipos del dominio
└── App.tsx             # Componente principal
```

## 🚀 Instalación y Configuración

### Prerrequisitos

- Node.js 18+ y npm
- Cuenta de Firebase
- Acceso a la API de votación

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd vote-app
   ```

2. **Instalar dependencias**
   ```bash
   npm install
   ```

3. **Configurar Firebase**

   a. Crear un proyecto en [Firebase Console](https://console.firebase.google.com)
   
   b. Habilitar autenticación con Google:
      - Ve a Authentication > Sign-in method
      - Habilita Google como proveedor
      - Configura el email de soporte
   
   c. Agregar las SHA keys de evaluación:
      - Ve a Project Settings > General
      - Agrega las siguientes SHA-1:
        - `6C:93:6F:47:18:74:7C:16:F5:1B:9F:62:E5:7A:D0:96:01:8C:EE:19`
        - `D4:FC:F5:44:4E:56:AD:1E:05:5D:19:87:5D:78:4B:3D:28:BF:5A:B7`
   
   d. Obtener credenciales:
      - Ve a Project Settings > General > Your apps
      - Copia las credenciales de configuración

4. **Configurar variables de entorno**
   ```bash
   cp .env.example .env
   ```
   
   Edita `.env` con tus credenciales de Firebase:
   ```env
   VITE_FIREBASE_API_KEY=tu_api_key
   VITE_FIREBASE_AUTH_DOMAIN=tu_proyecto.firebaseapp.com
   VITE_FIREBASE_PROJECT_ID=tu_project_id
   VITE_FIREBASE_STORAGE_BUCKET=tu_proyecto.appspot.com
   VITE_FIREBASE_MESSAGING_SENDER_ID=tu_sender_id
   VITE_FIREBASE_APP_ID=tu_app_id
   ```

5. **Ejecutar en modo desarrollo**
   ```bash
   npm run dev
   ```

6. **Construir para producción**
   ```bash
   npm run build
   ```

## 📡 API Endpoints Utilizados

### Documentación API
- **Base URL**: `https://api.sebastian.cl/vote`
- **Swagger**: https://api.sebastian.cl/vote/swagger-ui/index.html

### Endpoints Implementados

#### 1. Listar Procesos de Votación (Público)
```
GET /api/vote-processes
```
**Parámetros Query:**
- `page` (number): Número de página (default: 0)
- `size` (number): Tamaño de página (default: 10)
- `search` (string, opcional): Búsqueda por título o descripción
- `status` (string, opcional): Filtrar por estado (ACTIVE, CLOSED, DRAFT, CANCELLED)

**Respuesta:**
```typescript
{
  content: VoteProcess[],
  totalElements: number,
  totalPages: number,
  size: number,
  number: number,
  first: boolean,
  last: boolean
}
```

#### 2. Obtener Detalle de Votación (Público)
```
GET /api/vote-processes/{id}
```
**Parámetros:**
- `id` (string): ID del proceso de votación

**Respuesta:**
```typescript
{
  id: string,
  title: string,
  description: string,
  startDate: string,
  endDate: string,
  status: 'DRAFT' | 'ACTIVE' | 'CLOSED' | 'CANCELLED',
  createdAt: string,
  updatedAt: string,
  options: VoteOption[]
}
```

#### 3. Enviar Voto (Requiere Autenticación)
```
POST /api/votes
Authorization: Bearer {firebase-token}
```
**Body:**
```typescript
{
  voteProcessId: string,
  optionId: string
}
```

**Respuesta:**
```typescript
{
  id: string,
  userId: string,
  voteProcessId: string,
  optionId: string,
  votedAt: string
}
```

#### 4. Obtener Historial de Votos (Requiere Autenticación)
```
GET /api/votes/user
Authorization: Bearer {firebase-token}
```
**Parámetros Query:**
- `page` (number): Número de página
- `size` (number): Tamaño de página

**Respuesta:** Paginación de votos del usuario

#### 5. Verificar Voto en Proceso (Requiere Autenticación)
```
GET /api/votes/check/{voteProcessId}
Authorization: Bearer {firebase-token}
```
**Respuesta:** Voto si existe, 204 si no ha votado

## 🔐 Seguridad

### Buenas Prácticas Implementadas

1. **Variables de Entorno**
   - Credenciales de Firebase en archivo `.env`
   - No se incluyen credenciales en el código fuente
   - Archivo `.env.example` como plantilla

2. **Autenticación**
   - Tokens de Firebase enviados en headers de autorización
   - Persistencia de sesión con `browserLocalPersistence`
   - Manejo seguro de cierre de sesión

3. **Validación de Datos**
   - Tipado estricto con TypeScript
   - Validación de modelos según especificación OpenAPI
   - Manejo de errores centralizado

4. **Restricciones de Acceso**
   - Endpoints públicos: Listar y ver detalles
   - Endpoints privados: Votar y ver historial
   - Validación de autenticación en cliente y servidor

## 🎨 Componentes Principales

### Manejo de Estados

La aplicación implementa manejo completo de estados UI:

1. **Loading State**: Spinner con mensaje descriptivo
2. **Error State**: Mensajes diferenciados por tipo de error
   - Red (network)
   - Cliente 4xx (client)
   - Servidor 5xx (server)
   - Timeout
   - Negocio (business)
3. **Empty State**: Mensajes cuando no hay datos
4. **Success State**: Contenido renderizado correctamente

### Características Implementadas

- ✅ Autenticación con Google (Firebase)
- ✅ Persistencia de sesión
- ✅ Listado de votaciones con paginación infinita
- ✅ Búsqueda y filtros en tiempo real
- ✅ Vista detallada de procesos de votación
- ✅ Flujo de votación validado
- ✅ Perfil de usuario
- ✅ Historial de votaciones
- ✅ Manejo robusto de errores con retry
- ✅ Responsive design
- ✅ Arquitectura por capas
- ✅ Tipado con TypeScript

## 🧪 Pruebas

### Ejecutar Pruebas
```bash
npm test
```

### Cobertura
```bash
npm run test:coverage
```

## 📦 Tecnologías Utilizadas

- **React 18**: Framework de UI
- **TypeScript**: Tipado estático
- **Tailwind CSS**: Estilos utility-first
- **Firebase**: Autenticación
- **Vite**: Build tool y dev server
- **shadcn/ui**: Componentes de UI
- **date-fns**: Manejo de fechas
- **lucide-react**: Iconos
- **sonner**: Toast notifications

## 🎯 Características Destacadas

### 1. Arquitectura Limpia
Separación clara entre presentación, dominio y datos, facilitando mantenimiento y escalabilidad.

### 2. Gestión de Estado
Custom hooks para encapsular lógica de negocio y estado de la aplicación.

### 3. Manejo de Errores
Sistema centralizado de errores con mensajes descriptivos y opción de retry.

### 4. Experiencia de Usuario
- Infinite scroll para paginación fluida
- Búsqueda y filtros en tiempo real
- Estados de carga, error y vacío bien diferenciados
- Diseño responsive

### 5. Seguridad
- No hay credenciales en el código
- Validación de autenticación
- Tokens JWT en headers

## 👥 Equipo de Desarrollo

Este proyecto fue desarrollado como parte del curso de Computación Móvil de la Universidad Tecnológica Metropolitana.

## ⚠️ Solución de Problemas

### La API no responde

1. **Verificar que la API está disponible:**
   - Accede a https://api.sebastian.cl/vote/swagger-ui/index.html
   - Verifica tu conexión a internet

2. **Usar el modo Mock (Datos de Prueba):**
   - ✨ **NUEVO:** Ahora puedes usar la aplicación con datos de prueba
   - Click en **"Usar Datos de Prueba (Mock)"** cuando aparezca el error
   - Explora todas las funcionalidades sin depender de la API externa
   - Consulta `MOCK_MODE.md` para más detalles

3. **Error CORS:**
   - Este es un problema del lado del servidor
   - Contacta al administrador de la API

4. **Usar el diagnóstico integrado:**
   - La aplicación incluye un verificador de salud de la API
   - Aparece automáticamente cuando hay errores de red
   - Sigue las sugerencias que proporciona

5. **Guía detallada:**
   - Consulta `TROUBLESHOOTING_API.md` para diagnóstico completo

### No puedo votar

1. **Verificar autenticación:**
   - Asegúrate de haber iniciado sesión
   - Verifica que el token de Firebase esté siendo enviado

2. **Verificar estado del proceso:**
   - Solo se puede votar en procesos con estado "ACTIVE"
   - No se puede votar dos veces en el mismo proceso

## 📄 Licencia

Proyecto académico - Universidad Tecnológica Metropolitana

---

**Nota**: Esta es una aplicación web de demostración. Para el proyecto original en Flutter, consulta los requisitos del curso.