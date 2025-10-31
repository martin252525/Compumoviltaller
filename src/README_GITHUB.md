# 🗳️ Sistema de Votación - Demo Web

<div align="center">

![React](https://img.shields.io/badge/React-18.3-blue?logo=react)
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-blue?logo=typescript)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-4.x-38bdf8?logo=tailwind-css)
![Firebase](https://img.shields.io/badge/Firebase-10.x-orange?logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Demo-yellow)

**Demo interactiva de un sistema de votación desarrollada en React + TypeScript**

[Ver Demo](#) • [Documentación](README.md) • [Reportar Bug](../../issues) • [Solicitar Feature](../../issues)

</div>

---

## ⚠️ Aviso Importante

**Este es un proyecto universitario de demostración.** NO debe usarse para:
- ❌ Votaciones oficiales o legales
- ❌ Recopilar información personal sensible
- ❌ Procesos de votación reales

**Solo para:**
- ✅ Aprendizaje y demostración
- ✅ Referencia arquitectural
- ✅ Prototipado
- ✅ Desarrollo universitario

Ver [SECURITY.md](SECURITY.md) para más información.

---

## 🎯 Descripción

Prototipo web de un sistema de votación desarrollado como **referencia arquitectural** para un proyecto universitario en Flutter. Implementa autenticación Firebase, consumo de API REST, y arquitectura por capas.

### ✨ Características Principales

- 🔐 **Autenticación** con Firebase (Google Sign-In)
- 📊 **Listado de votaciones** con paginación, búsqueda y filtros
- 🗳️ **Sistema de votación** interactivo y seguro
- 📈 **Visualización de resultados** con gráficos (Recharts)
- 👤 **Perfil de usuario** con historial de votaciones
- 🎨 **UI moderna** con Tailwind CSS y ShadCN
- 📱 **Responsive design** (mobile-first)
- 🔌 **Modo Mock** para desarrollo sin API
- 🧪 **Verificador de API** incluido

---

## 🚀 Quick Start

### Opción A: Probar con Datos Mock (Sin configuración)

```bash
# 1. Instalar dependencias
npm install

# 2. Ejecutar
npm run dev

# 3. Abrir http://localhost:5173
# 4. Click en "Usar Datos de Prueba (Mock)"
```

### Opción B: Con API Real y Firebase

```bash
# 1. Instalar
npm install

# 2. Configurar Firebase
cp .env.example .env
# Edita .env con tus credenciales de Firebase

# 3. Verificar API
# Abre test-api.html en tu navegador

# 4. Ejecutar
npm run dev
```

📖 **Guía completa:** [QUICKSTART.md](QUICKSTART.md)

---

## 📸 Screenshots

### 🏠 Lista de Votaciones
![Lista de Votaciones](docs/screenshots/vote-list.png)
*Lista paginada con búsqueda y filtros*

### 📊 Detalle y Votación
![Detalle de Votación](docs/screenshots/vote-detail.png)
*Vista detallada con opciones y resultados*

### 👤 Perfil de Usuario
![Perfil](docs/screenshots/user-profile.png)
*Perfil con historial de votaciones*

---

## 🏗️ Arquitectura

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (React Components + Tailwind)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Business Logic Layer           │
│    (Custom Hooks + State Mgmt)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Data Access Layer              │
│  (API Service + Firebase Service)   │
└──────────────┬──────────────────────┘
               │
      ┌────────┴────────┐
      │                 │
┌─────▼─────┐    ┌─────▼─────┐
│ External  │    │ Firebase  │
│    API    │    │   Auth    │
└───────────┘    └───────────┘
```

### 📁 Estructura del Proyecto

```
/
├── components/          # Componentes de UI
│   ├── ui/             # Componentes ShadCN
│   ├── VoteProcessList.tsx
│   ├── VoteProcessDetail.tsx
│   ├── UserProfile.tsx
│   └── ...
├── hooks/              # Custom hooks (lógica de negocio)
│   ├── useVoteProcesses.ts
│   ├── useVoteProcess.ts
│   ├── useAuth.ts
│   └── useUserVotes.ts
├── services/           # Servicios (acceso a datos)
│   ├── api.service.ts
│   ├── firebase.service.ts
│   └── mock-api.service.ts
├── types/              # Definiciones TypeScript
├── styles/             # Estilos globales
└── App.tsx             # Componente principal
```

📖 **Documentación técnica:** [TECHNICAL_REPORT.md](TECHNICAL_REPORT.md)

---

## 🛠️ Stack Tecnológico

### Core
- **React 18.3** - Framework UI
- **TypeScript 5.x** - Type safety
- **Vite 5.x** - Build tool

### UI/UX
- **Tailwind CSS 4.x** - Styling
- **ShadCN UI** - Componentes
- **Lucide React** - Iconos
- **Recharts** - Gráficos

### Backend/Auth
- **Firebase 10.x** - Autenticación
- **Fetch API** - HTTP client

### Routing
- **React Router DOM 6.x** - Navegación

---

## 📚 Documentación

| Documento | Descripción |
|-----------|-------------|
| [README.md](README.md) | Documentación principal |
| [QUICKSTART.md](QUICKSTART.md) | Guía rápida de inicio |
| [TECHNICAL_REPORT.md](TECHNICAL_REPORT.md) | Reporte técnico completo |
| [FIREBASE_SETUP.md](FIREBASE_SETUP.md) | Configuración de Firebase |
| [MOCK_MODE.md](MOCK_MODE.md) | Uso del modo Mock |
| [TROUBLESHOOTING_API.md](TROUBLESHOOTING_API.md) | Solución de problemas |
| [API_TEST_INSTRUCTIONS.md](API_TEST_INSTRUCTIONS.md) | Verificación de API |
| [FLUTTER_MIGRATION_GUIDE.md](FLUTTER_MIGRATION_GUIDE.md) | Migrar a Flutter |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Guía de contribución |
| [SECURITY.md](SECURITY.md) | Política de seguridad |
| [CHANGELOG.md](CHANGELOG.md) | Historial de cambios |

---

## 🧪 Testing

### Verificar API

```bash
# Método 1: HTML standalone
open test-api.html

# Método 2: Consola del navegador
fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1')
  .then(r => r.json())
  .then(console.log)
```

### Probar Aplicación

```bash
# Desarrollo
npm run dev

# Build
npm run build

# Preview build
npm run preview
```

---

## 🔧 Configuración

### Variables de Entorno

Crea un archivo `.env` basado en `.env.example`:

```env
VITE_FIREBASE_API_KEY=tu_api_key
VITE_FIREBASE_AUTH_DOMAIN=tu_proyecto.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=tu_proyecto_id
VITE_FIREBASE_STORAGE_BUCKET=tu_proyecto.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789012
VITE_FIREBASE_APP_ID=1:123456789012:web:abc123
```

⚠️ **NUNCA** subas el archivo `.env` a GitHub

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor:

1. Lee [CONTRIBUTING.md](CONTRIBUTING.md)
2. Fork el proyecto
3. Crea una rama (`git checkout -b feature/AmazingFeature`)
4. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
5. Push a la rama (`git push origin feature/AmazingFeature`)
6. Abre un Pull Request

---

## 🐛 Reportar Bugs

¿Encontraste un bug? [Abre un Issue](../../issues/new) con:

- Descripción clara del problema
- Pasos para reproducir
- Comportamiento esperado vs actual
- Screenshots (si aplica)
- Versión del navegador y OS

---

## 💡 Roadmap

- [ ] Tests unitarios con Vitest
- [ ] Tests E2E con Playwright
- [ ] CI/CD con GitHub Actions
- [ ] Docker support
- [ ] i18n (internacionalización)
- [ ] Dark mode
- [ ] PWA support
- [ ] Offline mode

---

## 📖 API Externa

Este proyecto consume la API:
- **Base URL:** `https://api.sebastian.cl/vote`
- **Documentación:** [Swagger UI](https://api.sebastian.cl/vote/swagger-ui/index.html)

### Endpoints Principales

```
GET  /api/vote-processes          # Listar procesos (con paginación)
GET  /api/vote-processes/{id}     # Obtener proceso específico
POST /api/vote-processes/{id}/vote # Votar (requiere autenticación)
```

---

## 🎓 Contexto Académico

Este proyecto es parte de un curso universitario sobre desarrollo de aplicaciones móviles. Sirve como:

- 📘 Referencia arquitectural para implementación en Flutter
- 🎯 Demostración de arquitectura por capas
- 🔍 Ejemplo de consumo de APIs REST
- 🔐 Implementación de autenticación con Firebase
- 📱 Prototipo de UI/UX

**Migración a Flutter:** Ver [FLUTTER_MIGRATION_GUIDE.md](FLUTTER_MIGRATION_GUIDE.md)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

```
MIT License - Copyright (c) 2025
```

---

## 👏 Agradecimientos

- [Firebase](https://firebase.google.com/) - Autenticación
- [ShadCN UI](https://ui.shadcn.com/) - Componentes UI
- [Tailwind CSS](https://tailwindcss.com/) - Framework CSS
- [Recharts](https://recharts.org/) - Visualización de datos
- [Lucide](https://lucide.dev/) - Iconos
- [API Sebastian.cl](https://api.sebastian.cl/) - API de prueba

---

## 📞 Contacto

**Proyecto:** Sistema de Votación - Demo Web

**Maintainer:** [Tu Nombre]
- GitHub: [@tu-usuario](https://github.com/tu-usuario)
- Email: tu.email@universidad.cl

**Universidad:** [Nombre de tu Universidad]
**Curso:** [Nombre del curso]
**Semestre:** [Semestre académico]

---

## ⭐ Star History

Si este proyecto te fue útil, considera darle una ⭐

[![Star History](https://api.star-history.com/svg?repos=tu-usuario/vote-app-web&type=Date)](https://star-history.com/#tu-usuario/vote-app-web&Date)

---

<div align="center">

**[⬆ Volver arriba](#-sistema-de-votación---demo-web)**

Hecho con ❤️ para fines educativos

</div>
