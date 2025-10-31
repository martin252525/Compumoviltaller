# ✅ Checklist de Archivos para GitHub

Este documento te ayuda a verificar que tienes todos los archivos necesarios antes de subir a GitHub.

---

## 🚫 Archivos que NO DEBEN subirse

Estos archivos están (o deberían estar) en `.gitignore`:

- [ ] ❌ `.env` - Credenciales de Firebase (NUNCA subir)
- [ ] ❌ `node_modules/` - Dependencias (se instalan con npm install)
- [ ] ❌ `dist/` - Build de producción (se genera con npm run build)
- [ ] ❌ `.DS_Store` - Archivos del sistema macOS
- [ ] ❌ `*.log` - Logs de npm/error
- [ ] ❌ `.vscode/` - Configuración personal del editor (opcional)
- [ ] ❌ `.idea/` - Configuración de IntelliJ (opcional)

---

## ✅ Archivos que SÍ DEBEN subirse

### 📄 Configuración Base

- [ ] ✅ `.gitignore` - Lista de archivos a ignorar
- [ ] ✅ `.env.example` - Plantilla de variables de entorno (SIN credenciales reales)
- [ ] ✅ `package.json` - Dependencias del proyecto
- [ ] ✅ `package-lock.json` - Versiones exactas de dependencias
- [ ] ✅ `tsconfig.json` - Configuración de TypeScript
- [ ] ✅ `vite.config.ts` - Configuración de Vite

### 📖 Documentación

- [ ] ✅ `README.md` - Documentación principal
- [ ] ✅ `README_GITHUB.md` - README optimizado para GitHub (opcional, renombrar a README.md)
- [ ] ✅ `QUICKSTART.md` - Guía rápida de inicio
- [ ] ✅ `TECHNICAL_REPORT.md` - Documentación técnica
- [ ] ✅ `FIREBASE_SETUP.md` - Configuración de Firebase
- [ ] ✅ `FLUTTER_MIGRATION_GUIDE.md` - Guía para Flutter
- [ ] ✅ `MOCK_MODE.md` - Documentación del modo Mock
- [ ] ✅ `TROUBLESHOOTING_API.md` - Solución de problemas
- [ ] ✅ `API_TEST_INSTRUCTIONS.md` - Verificación de API
- [ ] ✅ `GITHUB_UPLOAD_INSTRUCTIONS.md` - Cómo subir a GitHub
- [ ] ✅ `CONTRIBUTING.md` - Guía de contribución
- [ ] ✅ `SECURITY.md` - Política de seguridad
- [ ] ✅ `CHANGELOG.md` - Historial de cambios
- [ ] ✅ `LICENSE` - Licencia MIT
- [ ] ✅ `Attributions.md` - Atribuciones
- [ ] ✅ `STATUS.md` - Estado del proyecto
- [ ] ✅ `FILES_CHECKLIST.md` - Este archivo

### 🎯 Código Fuente

- [ ] ✅ `App.tsx` - Componente principal
- [ ] ✅ `index.html` - HTML principal (debe estar en root)
- [ ] ✅ `main.tsx` - Entry point de React (debe existir)

### 📁 Carpeta: `/components`

- [ ] ✅ `ApiHealthCheck.tsx`
- [ ] ✅ `EmptyState.tsx`
- [ ] ✅ `ErrorDisplay.tsx`
- [ ] ✅ `Header.tsx`
- [ ] ✅ `LoadingSpinner.tsx`
- [ ] ✅ `LoginScreen.tsx`
- [ ] ✅ `SearchAndFilter.tsx`
- [ ] ✅ `UserProfile.tsx`
- [ ] ✅ `VoteProcessCard.tsx`
- [ ] ✅ `VoteProcessDetail.tsx`
- [ ] ✅ `VoteProcessList.tsx`
- [ ] ✅ `VotingHistory.tsx`

### 📁 Carpeta: `/components/ui` (ShadCN)

- [ ] ✅ `accordion.tsx`
- [ ] ✅ `alert.tsx`
- [ ] ✅ `alert-dialog.tsx`
- [ ] ✅ `aspect-ratio.tsx`
- [ ] ✅ `avatar.tsx`
- [ ] ✅ `badge.tsx`
- [ ] ✅ `breadcrumb.tsx`
- [ ] ✅ `button.tsx`
- [ ] ✅ `calendar.tsx`
- [ ] ✅ `card.tsx`
- [ ] ✅ `carousel.tsx`
- [ ] ✅ `chart.tsx`
- [ ] ✅ `checkbox.tsx`
- [ ] ✅ `collapsible.tsx`
- [ ] ✅ `command.tsx`
- [ ] ✅ `context-menu.tsx`
- [ ] ✅ `dialog.tsx`
- [ ] ✅ `drawer.tsx`
- [ ] ✅ `dropdown-menu.tsx`
- [ ] ✅ `form.tsx`
- [ ] ✅ `hover-card.tsx`
- [ ] ✅ `input.tsx`
- [ ] ✅ `input-otp.tsx`
- [ ] ✅ `label.tsx`
- [ ] ✅ `menubar.tsx`
- [ ] ✅ `navigation-menu.tsx`
- [ ] ✅ `pagination.tsx`
- [ ] ✅ `popover.tsx`
- [ ] ✅ `progress.tsx`
- [ ] ✅ `radio-group.tsx`
- [ ] ✅ `resizable.tsx`
- [ ] ✅ `scroll-area.tsx`
- [ ] ✅ `select.tsx`
- [ ] ✅ `separator.tsx`
- [ ] ✅ `sheet.tsx`
- [ ] ✅ `sidebar.tsx`
- [ ] ✅ `skeleton.tsx`
- [ ] ✅ `slider.tsx`
- [ ] ✅ `sonner.tsx`
- [ ] ✅ `switch.tsx`
- [ ] ✅ `table.tsx`
- [ ] ✅ `tabs.tsx`
- [ ] ✅ `textarea.tsx`
- [ ] ✅ `toggle.tsx`
- [ ] ✅ `toggle-group.tsx`
- [ ] ✅ `tooltip.tsx`
- [ ] ✅ `use-mobile.ts`
- [ ] ✅ `utils.ts`

### 📁 Carpeta: `/components/figma`

- [ ] ✅ `ImageWithFallback.tsx` - Componente protegido

### 📁 Carpeta: `/hooks`

- [ ] ✅ `useAuth.ts`
- [ ] ✅ `useUserVotes.ts`
- [ ] ✅ `useVoteProcess.ts`
- [ ] ✅ `useVoteProcesses.ts`

### 📁 Carpeta: `/services`

- [ ] ✅ `api.service.ts`
- [ ] ✅ `firebase.service.ts`
- [ ] ✅ `mock-api.service.ts`

### 📁 Carpeta: `/types`

- [ ] ✅ `vote.types.ts`

### 📁 Carpeta: `/styles`

- [ ] ✅ `globals.css`

### 🧪 Herramientas

- [ ] ✅ `test-api.html` - Verificador standalone de API

### 📁 Carpeta: `/guidelines` (opcional)

- [ ] ✅ `Guidelines.md` - Guías internas

---

## 🔍 Verificación Rápida

### Comando 1: Contar archivos importantes

```bash
# Contar archivos TypeScript/TSX
find . -name "*.ts" -o -name "*.tsx" | grep -v node_modules | wc -l

# Contar archivos de documentación
ls *.md | wc -l
```

**Resultado esperado:**
- ~60+ archivos TypeScript/TSX
- ~15+ archivos Markdown

### Comando 2: Verificar que .env NO esté tracked

```bash
git ls-files | grep .env
```

**Resultado esperado:**
- Debe mostrar solo `.env.example`
- NO debe mostrar `.env`

### Comando 3: Verificar .gitignore

```bash
cat .gitignore | grep -E "(\.env$|node_modules|dist)"
```

**Resultado esperado:**
```
.env
node_modules
dist
```

### Comando 4: Ver todos los archivos que se subirán

```bash
git add .
git status
```

**Debe mostrar en verde:**
- Archivos de código (.ts, .tsx, .css)
- Documentación (.md)
- Configuración (.json, .config.ts)
- `.gitignore`
- `.env.example`

**NO debe mostrar:**
- `.env`
- `node_modules/`
- `dist/`

---

## 📊 Estadísticas del Proyecto

### Por Tipo de Archivo

```bash
# TypeScript/TSX
find . -name "*.ts" -o -name "*.tsx" | grep -v node_modules | wc -l
# Esperado: ~60

# Markdown
ls *.md | wc -l
# Esperado: ~15

# JSON
ls *.json | wc -l
# Esperado: ~3
```

### Por Carpeta

```bash
# Componentes
ls components/*.tsx | wc -l
# Esperado: ~12

# Hooks
ls hooks/*.ts | wc -l
# Esperado: 4

# Services
ls services/*.ts | wc -l
# Esperado: 3

# Types
ls types/*.ts | wc -l
# Esperado: 1
```

---

## ⚠️ Verificación de Seguridad

### Buscar credenciales hardcodeadas

```bash
# Buscar strings sospechosos en todo el código
grep -r "AIzaSy" --include="*.ts" --include="*.tsx" .

# Buscar palabras clave de Firebase en archivos .ts/.tsx
grep -r "firebaseConfig" --include="*.ts" --include="*.tsx" .
```

**Resultado esperado:**
- Solo debe aparecer en `firebase.service.ts`
- El valor debe ser `getEnvVar('VITE_FIREBASE_API_KEY', 'YOUR_FIREBASE_API_KEY')`
- NO debe haber valores reales hardcodeados

---

## 🎨 Estructura Visual

```
vote-app-web/
│
├── 📄 Archivos de configuración
│   ├── .gitignore           ✅ Crítico
│   ├── .env.example         ✅ Crítico
│   ├── package.json         ✅ Crítico
│   ├── tsconfig.json        ✅
│   └── vite.config.ts       ✅
│
├── 📖 Documentación (15 archivos)
│   ├── README.md                       ✅
│   ├── QUICKSTART.md                   ✅
│   ├── TECHNICAL_REPORT.md             ✅
│   ├── FIREBASE_SETUP.md               ✅
│   ├── FLUTTER_MIGRATION_GUIDE.md      ✅
│   ├── MOCK_MODE.md                    ✅
│   ├── TROUBLESHOOTING_API.md          ✅
│   ├── API_TEST_INSTRUCTIONS.md        ✅
│   ├── GITHUB_UPLOAD_INSTRUCTIONS.md   ✅
│   ├── CONTRIBUTING.md                 ✅
│   ├── SECURITY.md                     ✅
│   ├── CHANGELOG.md                    ✅
│   ├── LICENSE                         ✅
│   ├── Attributions.md                 ✅
│   └── STATUS.md                       ✅
│
├── 🎯 Código principal
│   ├── App.tsx              ✅
│   ├── main.tsx             ✅ (debe existir)
│   └── index.html           ✅ (debe existir)
│
├── 📁 components/ (12 archivos + 40 UI)
│   ├── *.tsx                ✅ Todos los componentes
│   ├── ui/                  ✅ ShadCN components
│   └── figma/               ✅ ImageWithFallback
│
├── 📁 hooks/ (4 archivos)
│   └── *.ts                 ✅ Custom hooks
│
├── 📁 services/ (3 archivos)
│   └── *.ts                 ✅ API, Firebase, Mock
│
├── 📁 types/ (1 archivo)
│   └── vote.types.ts        ✅ Type definitions
│
├── 📁 styles/ (1 archivo)
│   └── globals.css          ✅ Global styles
│
└── 🧪 test-api.html         ✅ API tester
```

---

## 🎯 Checklist Final PRE-GitHub

Antes de ejecutar `git push`, verifica:

### Seguridad
- [ ] NO existe archivo `.env` (solo `.env.example`)
- [ ] `.gitignore` está presente y completo
- [ ] `firebase.service.ts` usa `getEnvVar()`, no valores hardcodeados
- [ ] No hay API keys visibles en el código

### Documentación
- [ ] Todos los archivos .md están presentes (15 archivos)
- [ ] README.md tiene tu información de contacto actualizada
- [ ] LICENSE tiene el año y nombre correctos

### Código
- [ ] Todos los componentes están en `/components`
- [ ] Todos los hooks están en `/hooks`
- [ ] Todos los servicios están en `/services`
- [ ] No hay `console.log` innecesarios
- [ ] El proyecto compila: `npm run build` ✅

### Testing
- [ ] El proyecto corre: `npm run dev` ✅
- [ ] El modo API funciona (si la API está disponible)
- [ ] El modo Mock funciona
- [ ] La autenticación Firebase puede configurarse

### Git
- [ ] `git status` no muestra archivos sensibles
- [ ] Primer commit está listo
- [ ] Remote de GitHub está configurado

---

## ✅ Si Marcaste Todo

**¡Estás listo para subir a GitHub!**

Sigue las instrucciones en `GITHUB_UPLOAD_INSTRUCTIONS.md`

```bash
git add .
git commit -m "Initial commit: Sistema de votación v1.0.0"
git push -u origin main
```

---

## ❌ Si Falta Algo

### Archivos de configuración faltantes

```bash
# Crear .gitignore si no existe
# (Ya debería existir)

# Crear .env.example si no existe
cp .env .env.example
# Luego edita .env.example y reemplaza valores reales con placeholders
```

### Documentación faltante

Todos los archivos de documentación deberían estar presentes. Si falta alguno, revisa el proyecto original o créalo basándote en los existentes.

### Código faltante

Si falta algún archivo de código crítico, verifica:
```bash
npm run build
```

Si el build falla, te indicará qué archivos faltan.

---

## 📞 Necesitas Ayuda

Si algo no está claro:
1. Revisa `GITHUB_UPLOAD_INSTRUCTIONS.md`
2. Lee `QUICKSTART.md`
3. Consulta `README.md`

---

**Última actualización:** Octubre 2025
**Versión del checklist:** 1.0.0
