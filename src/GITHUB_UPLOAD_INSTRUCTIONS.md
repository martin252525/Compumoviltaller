# 📤 Instrucciones para Subir a GitHub

Esta guía te ayudará a subir tu proyecto a GitHub de forma segura, sin exponer credenciales.

---

## ✅ Pre-requisitos

Antes de subir, verifica:

- [ ] Git instalado en tu computadora
- [ ] Cuenta de GitHub creada
- [ ] NO tienes un archivo `.env` con credenciales reales en el proyecto
- [ ] Tienes `.gitignore` configurado (ya incluido)

---

## 🚀 Pasos para Subir

### 1. Preparar el Proyecto

**A. Verificar que NO hay credenciales expuestas:**

```bash
# Buscar archivos .env (no deberían existir)
ls -la | grep .env

# Si existe .env, asegúrate de que esté en .gitignore
cat .gitignore | grep .env
```

✅ **Correcto:** Solo debe existir `.env.example` (sin credenciales reales)
❌ **Incorrecto:** Si existe `.env` con credenciales, NUNCA lo subas

**B. Verificar .gitignore:**

```bash
cat .gitignore
```

Debe incluir:
```
.env
.env.local
node_modules
dist
```

**C. Renombrar README (opcional):**

Si quieres usar el README optimizado para GitHub:

```bash
# Backup del README original
mv README.md README_LOCAL.md

# Usar el README de GitHub
mv README_GITHUB.md README.md
```

O simplemente edita `README.md` con la información que prefieras.

---

### 2. Crear Repositorio en GitHub

**Opción A: Por Interfaz Web**

1. Ve a https://github.com
2. Click en el botón **"+"** (arriba derecha)
3. Selecciona **"New repository"**
4. Configura:
   - **Repository name:** `vote-app-web` (o el nombre que prefieras)
   - **Description:** "Demo web de sistema de votación - Proyecto universitario"
   - **Visibility:** 
     - 🔓 **Public** - Si quieres que sea visible para todos
     - 🔒 **Private** - Si solo quieres acceso restringido
   - ❌ **NO** marques "Add a README file" (ya tienes uno)
   - ❌ **NO** agregues .gitignore (ya tienes uno)
   - ✅ **SÍ** agrega una licencia: MIT License
5. Click en **"Create repository"**

**Opción B: Por GitHub CLI (si tienes gh instalado)**

```bash
gh repo create vote-app-web --public --description "Demo web de sistema de votación"
```

---

### 3. Inicializar Git en tu Proyecto

Abre la terminal en la carpeta de tu proyecto:

```bash
# Inicializar repositorio Git
git init

# Verificar estado
git status
```

Deberías ver algo como:
```
On branch main
Untracked files:
  .gitignore
  README.md
  package.json
  ...
```

⚠️ **IMPORTANTE:** Si ves `.env` en la lista, ¡NO CONTINÚES! Elimínalo o agrégalo a .gitignore.

---

### 4. Agregar Archivos al Staging

```bash
# Agregar todos los archivos (excepto los del .gitignore)
git add .

# Verificar qué se agregó
git status
```

Verifica que aparezcan en verde:
- ✅ `.gitignore`
- ✅ `.env.example`
- ✅ `package.json`
- ✅ `README.md`
- ✅ Carpetas: `components/`, `hooks/`, `services/`, etc.

Y que NO aparezcan:
- ❌ `.env`
- ❌ `node_modules/`
- ❌ `dist/`

---

### 5. Crear el Primer Commit

```bash
git commit -m "Initial commit: Sistema de votación completo v1.0.0"
```

O con más detalle:

```bash
git commit -m "Initial commit: Sistema de votación completo

- Implementación React + TypeScript
- Autenticación Firebase
- Consumo API REST
- Modo Mock para desarrollo
- Documentación completa
- UI con Tailwind + ShadCN
- Arquitectura por capas"
```

---

### 6. Conectar con GitHub

Copia la URL de tu repositorio de GitHub. Debería verse así:
```
https://github.com/tu-usuario/vote-app-web.git
```

Ejecuta:

```bash
# Agregar repositorio remoto
git remote add origin https://github.com/tu-usuario/vote-app-web.git

# Verificar que se agregó correctamente
git remote -v
```

Deberías ver:
```
origin  https://github.com/tu-usuario/vote-app-web.git (fetch)
origin  https://github.com/tu-usuario/vote-app-web.git (push)
```

---

### 7. Subir los Archivos

```bash
# Cambiar nombre de rama a 'main' (si es necesario)
git branch -M main

# Subir archivos
git push -u origin main
```

Si es la primera vez, te pedirá autenticación:

**Opción 1: HTTPS (recomendado)**
- Username: tu nombre de usuario de GitHub
- Password: **Personal Access Token** (NO tu contraseña)

**Cómo crear Personal Access Token:**
1. Ve a GitHub > Settings > Developer settings > Personal access tokens > Tokens (classic)
2. Click "Generate new token (classic)"
3. Nombre: "Git CLI Access"
4. Scopes: Marca `repo`
5. Click "Generate token"
6. Copia el token (¡no lo perderás, no se muestra de nuevo!)

**Opción 2: SSH (alternativa)**
```bash
# Cambiar de HTTPS a SSH
git remote set-url origin git@github.com:tu-usuario/vote-app-web.git
```

---

### 8. Verificar que se Subió Correctamente

1. Ve a tu repositorio en GitHub: `https://github.com/tu-usuario/vote-app-web`
2. Verifica que veas:
   - ✅ Todos tus archivos y carpetas
   - ✅ README.md se muestra en la página principal
   - ✅ `.env.example` está presente
   - ❌ `.env` NO está presente
   - ❌ `node_modules/` NO está presente

---

## 🔒 Verificación de Seguridad

### ¡IMPORTANTE! Verifica que NO subiste credenciales:

**1. Buscar en GitHub:**

Ve a tu repositorio y usa la barra de búsqueda:

```
VITE_FIREBASE_API_KEY
```

- ❌ Si encuentra resultados en archivos `.env` → **¡BORRA EL REPOSITORIO!**
- ✅ Si solo encuentra `.env.example` con valores de ejemplo → Correcto

**2. Verificar localmente:**

```bash
# Buscar credenciales en el historial de Git
git log --all --full-history --source -- **/.env
```

Si devuelve resultados, significa que `.env` se subió en algún commit. Ver sección "Solución de Emergencia".

---

## 🆘 Solución de Emergencia

### Si subiste `.env` con credenciales por error:

**⚠️ NO intentes simplemente borrar el archivo y hacer commit. Las credenciales siguen en el historial.**

**Solución:**

1. **Borra el repositorio de GitHub inmediatamente:**
   - Ve al repositorio
   - Settings > Danger Zone > Delete this repository

2. **Regenera TODAS las credenciales comprometidas:**
   - Firebase: Genera nuevas API keys
   - Cualquier otra credencial expuesta

3. **Limpia el repositorio local:**
   ```bash
   # Eliminar historial de Git
   rm -rf .git
   
   # Empezar de nuevo
   git init
   ```

4. **Verifica .gitignore y vuelve a intentar desde el paso 3**

---

## 📝 Después de Subir

### 1. Agregar Información al Repositorio

En GitHub, edita:

**A. About (descripción corta):**
- Click en ⚙️ junto a "About"
- Description: "Demo web de sistema de votación - React + TypeScript + Firebase"
- Topics: `react`, `typescript`, `firebase`, `tailwind`, `voting-system`, `university-project`
- ✅ Marca "Include in the home page"

**B. README badges:**

Edita `README.md` y reemplaza los badges con tu información:
```markdown
![GitHub stars](https://img.shields.io/github/stars/tu-usuario/vote-app-web)
![GitHub forks](https://img.shields.io/github/forks/tu-usuario/vote-app-web)
![GitHub issues](https://img.shields.io/github/issues/tu-usuario/vote-app-web)
```

### 2. Configurar GitHub Pages (Opcional)

Si quieres que tu demo sea accesible online:

```bash
# Instalar gh-pages
npm install --save-dev gh-pages

# Agregar scripts a package.json
```

Edita `package.json`:
```json
{
  "scripts": {
    "predeploy": "npm run build",
    "deploy": "gh-pages -d dist"
  },
  "homepage": "https://tu-usuario.github.io/vote-app-web"
}
```

Despliega:
```bash
npm run deploy
```

En GitHub: Settings > Pages > Source: `gh-pages` branch

⚠️ **NOTA:** GitHub Pages es público. No uses si tu repositorio es privado y quieres mantenerlo así.

### 3. Proteger la Rama Main

En GitHub:
1. Settings > Branches
2. Add branch protection rule
3. Branch name pattern: `main`
4. Marca:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass
5. Save changes

---

## 🔄 Trabajar con el Repositorio

### Hacer Cambios

```bash
# 1. Ver estado
git status

# 2. Agregar cambios
git add .

# 3. Commit
git commit -m "Descripción del cambio"

# 4. Subir a GitHub
git push
```

### Descargar en Otra Computadora

```bash
# Clonar
git clone https://github.com/tu-usuario/vote-app-web.git

# Entrar al directorio
cd vote-app-web

# Instalar dependencias
npm install

# Crear .env con tus credenciales
cp .env.example .env
# Edita .env con tus valores

# Ejecutar
npm run dev
```

---

## 📋 Checklist Final

Antes de compartir tu repositorio, verifica:

### Seguridad
- [ ] `.env` NO está en el repositorio
- [ ] `.gitignore` incluye `.env`
- [ ] `.env.example` tiene valores de ejemplo (no reales)
- [ ] No hay credenciales en `services/firebase.service.ts`
- [ ] No hay API keys hardcodeadas

### Documentación
- [ ] README.md está completo y actualizado
- [ ] QUICKSTART.md tiene instrucciones claras
- [ ] Todos los archivos .md están incluidos
- [ ] LICENSE está presente

### Código
- [ ] El código compila sin errores (`npm run build`)
- [ ] No hay `console.log` innecesarios
- [ ] Comentarios están en español/inglés consistente
- [ ] Estructura de carpetas es clara

### GitHub
- [ ] Repository tiene descripción
- [ ] Topics/tags están agregados
- [ ] README se ve bien en GitHub
- [ ] No hay archivos sensibles visibles

---

## 🎓 Para Entregar el Proyecto

Si necesitas entregar el repositorio a tu profesor:

### Opción 1: Repositorio Público
1. Comparte el link: `https://github.com/tu-usuario/vote-app-web`
2. Incluye instrucciones de instalación (QUICKSTART.md)

### Opción 2: Repositorio Privado
1. Ve a Settings > Collaborators
2. Add people
3. Ingresa el username de GitHub de tu profesor
4. Role: Read

### Opción 3: Exportar como ZIP
1. En GitHub, click en "Code" > "Download ZIP"
2. O localmente:
   ```bash
   git archive --format=zip --output=vote-app-web.zip main
   ```

---

## 💡 Tips Adicionales

### Para Tu README

Actualiza estas secciones con tu información:

```markdown
## 📞 Contacto

**Estudiante:** Tu Nombre Completo
**RUT/ID:** 12.345.678-9
**Email:** tu.email@universidad.cl
**Carrera:** Ingeniería en Informática
**Universidad:** Universidad XYZ
**Curso:** Desarrollo de Aplicaciones Móviles
**Profesor:** Nombre del Profesor
**Semestre:** 2025-1
```

### Para el Informe

Incluye en tu informe final:

```markdown
## Repositorio GitHub

- **URL:** https://github.com/tu-usuario/vote-app-web
- **Commits:** [Número total de commits]
- **Última actualización:** [Fecha]
- **Demo online:** [Si tienes GitHub Pages configurado]
```

### Para Presentaciones

Crea screenshots profesionales:
```bash
# Desde la carpeta del proyecto
mkdir -p docs/screenshots

# Toma screenshots y guárdalos ahí
# Luego súbelos:
git add docs/screenshots/
git commit -m "docs: agregar screenshots"
git push
```

---

## ❓ Preguntas Frecuentes

### ¿Puedo subir node_modules?
**No.** Está en `.gitignore` y es muy pesado. Cualquiera que clone tu repo hará `npm install`.

### ¿Debo subir el archivo .env?
**¡NO!** NUNCA. Solo `.env.example` con valores de ejemplo.

### ¿Qué hago si olvidé mi token de acceso?
Genera uno nuevo en GitHub Settings > Developer settings > Personal access tokens.

### ¿Puedo cambiar de público a privado después?
Sí. Settings > General > Danger Zone > Change visibility.

### ¿Cómo elimino un archivo del historial?
```bash
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch ruta/al/archivo" \
  --prune-empty --tag-name-filter cat -- --all
```

Pero es más fácil empezar de nuevo si subiste algo sensible.

---

## 🎉 ¡Listo!

Si seguiste todos los pasos, tu proyecto está:
- ✅ Subido a GitHub
- ✅ Sin credenciales expuestas
- ✅ Con documentación completa
- ✅ Listo para compartir

**Próximos pasos:**
1. Comparte el link con tu profesor
2. Continúa desarrollando con Git
3. Haz commits frecuentes
4. Documenta tus cambios

---

¿Necesitas ayuda? Revisa [CONTRIBUTING.md](CONTRIBUTING.md) o abre un Issue.

**¡Éxito con tu proyecto universitario! 🎓**
