# Guía Rápida de Inicio

Esta guía te ayudará a poner en marcha la aplicación en pocos minutos.

## ⚡ ¡Quiero probar YA!

**Opción A: Con API Real**

Si la API https://api.sebastian.cl/vote está funcionando:

1. **Verificar que la API funciona:**
   ```bash
   # Abre test-api.html en tu navegador
   # O ejecuta en la consola del navegador:
   ```
   ```javascript
   fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1')
     .then(r => r.json())
     .then(console.log)
     .catch(console.error);
   ```
   
   📖 Ver instrucciones completas en `API_TEST_INSTRUCTIONS.md`

2. **Si la API funciona, continúa con la configuración normal** (ver abajo)

**Opción B: Con Datos Mock (Sin API)**

Si la API NO está disponible o quieres probar sin configurar nada:

1. ```bash
   npm install
   npm run dev
   ```

2. **Abre http://localhost:5173**

3. **Cuando veas el error de API:**
   - Click en **"Usar Datos de Prueba (Mock)"**
   - ¡Listo! Explora la app con datos de ejemplo

4. **Puedes probar TODAS las funcionalidades:**
   - ✅ Ver votaciones
   - ✅ Buscar y filtrar
   - ✅ Ver detalles
   - ✅ Votar (sin autenticación)
   - ✅ Ver historial

📖 Más información en `MOCK_MODE.md`

### 1. Instalar Dependencias
```bash
npm install
```

### 2. Configurar Firebase

#### Opción A: Usar credenciales de prueba (solo para desarrollo local)
La aplicación ya tiene valores de fallback en `services/firebase.service.ts` que permitirán que compile, pero **no funcionará la autenticación** hasta que configures Firebase correctamente.

#### Opción B: Configurar Firebase completo (recomendado)

1. **Crear proyecto en Firebase:**
   - Ve a https://console.firebase.google.com
   - Crea un nuevo proyecto
   - Nombre sugerido: "vote-app" o "sistema-votacion"

2. **Habilitar autenticación con Google:**
   - En Firebase Console, ve a **Authentication**
   - Click en "Get started"
   - En la pestaña **Sign-in method**, habilita "Google"
   - Configura el email de soporte del proyecto

3. **Obtener credenciales:**
   - Ve a **Project Settings** (ícono de engranaje)
   - En la sección **General**, baja hasta "Your apps"
   - Si no hay una app web, click en el ícono `</>`
   - Registra la app con el nombre "vote-app-web"
   - Copia las credenciales del objeto `firebaseConfig`

4. **Configurar variables de entorno:**
   ```bash
   cp .env.example .env
   ```

5. **Editar `.env` con tus credenciales:**
   ```env
   VITE_FIREBASE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXX
   VITE_FIREBASE_AUTH_DOMAIN=tu-proyecto.firebaseapp.com
   VITE_FIREBASE_PROJECT_ID=tu-proyecto
   VITE_FIREBASE_STORAGE_BUCKET=tu-proyecto.appspot.com
   VITE_FIREBASE_MESSAGING_SENDER_ID=123456789012
   VITE_FIREBASE_APP_ID=1:123456789012:web:abcdef123456
   ```

### 3. Ejecutar la Aplicación
```bash
npm run dev
```

La aplicación estará disponible en `http://localhost:5173`

## 🔍 Verificar que Funciona

### Sin Autenticación (Funcionalidad Pública)
✅ Deberías poder:
- Ver la lista de procesos de votación
- Buscar y filtrar votaciones
- Ver el detalle de cada votación
- Ver los resultados parciales

### Con Autenticación (Requiere Firebase configurado)
✅ Deberías poder:
- Iniciar sesión con Google
- Votar en procesos activos
- Ver tu perfil
- Ver tu historial de votaciones

## ❌ Solución de Problemas

### Error: "Failed to load module"
```bash
# Elimina node_modules y reinstala
rm -rf node_modules package-lock.json
npm install
```

### Error: "Firebase: Error (auth/configuration-not-found)"
- Verifica que el archivo `.env` existe en la raíz del proyecto
- Verifica que las variables tienen el prefijo `VITE_`
- Reinicia el servidor de desarrollo (`Ctrl+C` y luego `npm run dev`)

### Error: "API request failed"
- La API `https://api.sebastian.cl/vote` debe estar disponible
- Verifica tu conexión a internet
- Intenta acceder a https://api.sebastian.cl/vote/swagger-ui/index.html
- **NUEVO:** La app ahora incluye un diagnóstico automático de API
- Consulta `TROUBLESHOOTING_API.md` para diagnóstico detallado

### No puedo iniciar sesión con Google
- Verifica que Firebase Authentication esté habilitado
- Verifica que el proveedor de Google esté activado
- Verifica que las credenciales en `.env` sean correctas
- Asegúrate de que el dominio esté autorizado en Firebase Console

## 📚 Próximos Pasos

1. Explora el código en `/components` para ver los componentes
2. Revisa `/services` para entender cómo se consume la API
3. Mira `/hooks` para ver la lógica de negocio
4. Lee el `README.md` completo para más detalles
5. Consulta el `TECHNICAL_REPORT.md` para documentación técnica

## 🆘 Necesitas Ayuda

- Revisa el archivo `README.md` para documentación completa
- Consulta `TECHNICAL_REPORT.md` para detalles técnicos
- Verifica la documentación de la API: https://api.sebastian.cl/vote/swagger-ui/index.html
- Revisa la consola del navegador para ver errores específicos

## 🎯 Estructura del Proyecto

```
/
├── .env                 # Variables de entorno (crear desde .env.example)
├── .env.example         # Plantilla de variables de entorno
├── App.tsx              # Componente principal
├── components/          # Componentes de UI
├── hooks/              # Custom hooks (lógica de negocio)
├── services/           # Servicios (API, Firebase)
├── types/              # Definiciones TypeScript
└── styles/             # Estilos globales
```

---

**¡Listo!** Si configuraste Firebase correctamente, deberías poder usar todas las funcionalidades de la aplicación.