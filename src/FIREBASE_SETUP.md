# Guía Detallada de Configuración de Firebase

Esta guía te llevará paso a paso por el proceso de configuración de Firebase para la aplicación de votación.

## 📋 Prerrequisitos

- Cuenta de Google
- Navegador web
- Acceso a internet

## 🚀 Pasos de Configuración

### Paso 1: Acceder a Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com)
2. Inicia sesión con tu cuenta de Google
3. Acepta los términos y condiciones si es necesario

### Paso 2: Crear un Nuevo Proyecto

1. Click en **"Agregar proyecto"** o **"Add project"**
2. Nombre del proyecto: `sistema-votacion` (o el nombre que prefieras)
3. Click en **"Continuar"**
4. **Google Analytics**: Puedes deshabilitarlo para este proyecto de demostración
   - Si lo habilitas, acepta los términos y selecciona una cuenta
5. Click en **"Crear proyecto"**
6. Espera a que Firebase configure el proyecto (puede tomar 30-60 segundos)
7. Click en **"Continuar"**

### Paso 3: Registrar una Aplicación Web

1. En la pantalla de inicio del proyecto, busca el ícono `</>` (código web)
2. Click en el ícono `</>` para agregar una app web
3. **Nombre de la app**: `vote-app-web`
4. **NO** marques "Also set up Firebase Hosting" (no es necesario para desarrollo local)
5. Click en **"Registrar app"**
6. **Importante:** Aparecerá un código de configuración. **¡Guárdalo!**
   - Verás algo como:
   ```javascript
   const firebaseConfig = {
     apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXX",
     authDomain: "tu-proyecto.firebaseapp.com",
     projectId: "tu-proyecto",
     storageBucket: "tu-proyecto.appspot.com",
     messagingSenderId: "123456789012",
     appId: "1:123456789012:web:abcdef123456"
   };
   ```
7. Click en **"Continuar a la consola"**

### Paso 4: Habilitar Authentication

1. En el menú lateral izquierdo, busca **"Authentication"** o **"Autenticación"**
2. Click en **"Get started"** o **"Comenzar"**
3. En la pestaña **"Sign-in method"** o **"Método de inicio de sesión"**
4. Busca **"Google"** en la lista de proveedores
5. Click en **"Google"**
6. Activa el toggle para **habilitar** Google como proveedor
7. **Nombre público del proyecto**: Déjalo como está o personalízalo
8. **Correo electrónico de asistencia del proyecto**: 
   - Selecciona tu correo electrónico de la lista desplegable
9. Click en **"Guardar"**

### Paso 5: Verificar Dominios Autorizados

1. Aún en **Authentication > Sign-in method**
2. Baja hasta la sección **"Authorized domains"** o **"Dominios autorizados"**
3. Verifica que `localhost` esté en la lista
4. Si no está, agrégalo:
   - Click en **"Add domain"** o **"Agregar dominio"**
   - Escribe: `localhost`
   - Click en **"Agregar"**

### Paso 6: Copiar Credenciales

1. Ve a **Configuración del proyecto** (ícono de engranaje ⚙️ > Project settings)
2. Baja hasta la sección **"Your apps"** o **"Tus apps"**
3. Deberías ver tu app web registrada anteriormente
4. Si no ves el código de configuración, click en **"Config"** o **"Configuración"**
5. Copia los valores de `firebaseConfig`

### Paso 7: Configurar Variables de Entorno en el Proyecto

1. En tu terminal, navega a la raíz del proyecto
2. Crea el archivo `.env` desde la plantilla:
   ```bash
   cp .env.example .env
   ```

3. Abre el archivo `.env` con tu editor de texto favorito
4. Reemplaza los valores con los de tu configuración de Firebase:
   ```env
   VITE_FIREBASE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXX
   VITE_FIREBASE_AUTH_DOMAIN=tu-proyecto.firebaseapp.com
   VITE_FIREBASE_PROJECT_ID=tu-proyecto
   VITE_FIREBASE_STORAGE_BUCKET=tu-proyecto.appspot.com
   VITE_FIREBASE_MESSAGING_SENDER_ID=123456789012
   VITE_FIREBASE_APP_ID=1:123456789012:web:abcdef123456
   ```

5. **Importante:** 
   - ✅ Asegúrate de que cada línea tenga el prefijo `VITE_`
   - ✅ No agregues espacios antes o después del `=`
   - ✅ No uses comillas alrededor de los valores
   - ✅ Reemplaza TODOS los valores con los tuyos

### Paso 8: Verificar la Configuración

1. Guarda el archivo `.env`
2. Si el servidor de desarrollo está corriendo, deténlo (`Ctrl+C`)
3. Inicia el servidor nuevamente:
   ```bash
   npm run dev
   ```
4. Abre el navegador en `http://localhost:5173`
5. Intenta iniciar sesión con Google
   - Deberías ver el popup de autenticación de Google
   - Selecciona tu cuenta
   - Acepta los permisos
   - Deberías ser redirigido a la aplicación autenticado

## ✅ Verificación de la Configuración

### Prueba 1: Autenticación
1. Abre la aplicación
2. Click en **"Continuar con Google"**
3. Completa el flujo de autenticación
4. ✅ Deberías ver tu perfil en la esquina superior derecha

### Prueba 2: Navegación
1. Click en **"Mi Perfil"**
2. ✅ Deberías ver tu información de Google (nombre, email, foto)

### Prueba 3: Votación (si hay procesos activos)
1. Navega a **"Votaciones"**
2. Selecciona un proceso con estado "Activo"
3. Selecciona una opción
4. Click en **"Confirmar Voto"**
5. ✅ Deberías ver un mensaje de éxito

### Prueba 4: Historial
1. Ve a **"Mi Perfil"** > pestaña **"Historial"**
2. ✅ Deberías ver la lista de tus votos anteriores

## 🐛 Solución de Problemas

### Error: "Firebase: Error (auth/configuration-not-found)"

**Causa:** Las variables de entorno no se están cargando correctamente.

**Solución:**
1. Verifica que el archivo `.env` existe en la raíz del proyecto:
   ```bash
   ls -la .env
   ```
2. Verifica que todas las variables tienen el prefijo `VITE_`
3. Reinicia el servidor de desarrollo:
   ```bash
   # Ctrl+C para detener
   npm run dev
   ```

### Error: "Firebase: Error (auth/invalid-api-key)"

**Causa:** La API key es incorrecta.

**Solución:**
1. Ve a Firebase Console > Configuración del proyecto
2. Verifica que copiaste correctamente el `apiKey`
3. Actualiza el valor en `.env`
4. Reinicia el servidor

### Error: "Firebase: Error (auth/unauthorized-domain)"

**Causa:** El dominio `localhost` no está autorizado.

**Solución:**
1. Ve a Firebase Console > Authentication > Sign-in method
2. Baja hasta "Authorized domains"
3. Agrega `localhost` si no está en la lista

### No aparece el popup de Google Sign-In

**Causa:** El navegador está bloqueando popups.

**Solución:**
1. Permite popups para `localhost` en tu navegador
2. Generalmente hay un ícono en la barra de direcciones
3. Click en él y permite popups para este sitio

### Error: "Firebase: Error (auth/popup-closed-by-user)"

**Causa:** El usuario cerró el popup antes de completar la autenticación.

**Solución:**
1. Esto no es un error real, es esperado
2. Simplemente intenta iniciar sesión nuevamente

## 📝 Notas Importantes

### Seguridad

- ✅ El archivo `.env` está en `.gitignore` y NO se subirá a Git
- ✅ Nunca compartas tu archivo `.env` públicamente
- ✅ Firebase tiene reglas de seguridad del lado del servidor
- ⚠️ La API key de Firebase es pública, pero está protegida por reglas de seguridad

### Desarrollo vs Producción

Esta configuración es para **desarrollo local**. Para producción:

1. Configura variables de entorno en tu plataforma de hosting
2. Configura dominios autorizados en Firebase
3. Implementa reglas de seguridad más estrictas
4. Considera usar Firebase App Check

### Límites de Firebase (Plan Spark/Free)

- **Authentication:** 10,000 verificaciones de teléfono/mes (Google Auth es ilimitado)
- **Firestore:** 50,000 lecturas/día, 20,000 escrituras/día (no usado en este proyecto)
- **Storage:** 1GB (no usado en este proyecto)

Para este proyecto de demostración, el plan gratuito es más que suficiente.

## 🎯 Próximos Pasos

Una vez que Firebase esté configurado:

1. ✅ Explora la aplicación
2. ✅ Prueba todas las funcionalidades
3. ✅ Revisa el código para entender la arquitectura
4. ✅ Úsalo como referencia para tu proyecto Flutter

## 🆘 ¿Necesitas Más Ayuda?

- 📚 [Documentación oficial de Firebase](https://firebase.google.com/docs)
- 📚 [Guía de Firebase Authentication](https://firebase.google.com/docs/auth)
- 📧 Consulta con el profesor del curso
- 💬 Pregunta a tus compañeros de clase

---

**¡Listo!** Con Firebase configurado, tu aplicación está 100% funcional. 🎉
