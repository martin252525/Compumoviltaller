# ⚡ Solución Rápida - API No Disponible

## 🎯 El Problema

Ves estos errores en la consola:
```
[API] Request failed: TypeError: Failed to fetch
[Health Check] Request failed
```

## ✅ La Solución (30 segundos)

### Paso 1: Espera a que Cargue la App

La aplicación mostrará un error de red y un componente de diagnóstico.

### Paso 2: Click en el Botón

Busca el botón que dice:
```
🗄️ Usar Datos de Prueba (Mock)
```

### Paso 3: Listo

La página se recargará y verás **12 procesos de votación de ejemplo**.

Ahora puedes:
- ✅ Ver votaciones
- ✅ Buscar y filtrar
- ✅ Ver detalles
- ✅ Votar (sin autenticación)
- ✅ Explorar toda la app

## 🎨 Vista del Componente

Cuando la API falla, verás algo como:

```
╔═══════════════════════════════════════════╗
║  ⚠️ Error de red                          ║
║                                           ║
║  No se pudo conectar a la API.            ║
║  Verifica tu conexión a internet.         ║
║                                           ║
║  [🔄 Reintentar]                          ║
╚═══════════════════════════════════════════╝

╔═══════════════════════════════════════════╗
║  Estado de la API                         ║
║  https://api.sebastian.cl/vote            ║
║                                           ║
║  ❌ API no disponible                     ║
║                                           ║
║  🔌 No se pudo conectar a la API          ║
║                                           ║
║  Posibles causas:                         ║
║  1. ❌ La API está caída                  ║
║  2. 🌐 Sin conexión a internet            ║
║  3. 🚫 Problema de CORS                   ║
║  4. 🔥 Firewall bloqueando                ║
║  5. 🔒 Proxy bloqueando                   ║
║                                           ║
║  💡 Solución Rápida:                      ║
║  Si la API no está disponible, puedes     ║
║  usar datos de prueba para explorar       ║
║  la aplicación.                           ║
║                                           ║
║  [🗄️ Usar Datos de Prueba (Mock)]        ║
╚═══════════════════════════════════════════╝
```

## 🔄 Volver a la API Real

Si después la API funciona, puedes volver:

1. Busca el componente "Estado de la API"
2. Click en "Volver a API Real"
3. La página se recarga con la API real

## 🎯 Alternativas

### Opción A: Desde la Consola

```javascript
// En la consola del navegador (F12)
localStorage.setItem('useMockApi', 'true');
location.reload();
```

### Opción B: Editar el Código

En `/services/api.service.ts`:

```typescript
// Línea ~11, cambia:
let USE_MOCK = false;

// Por:
let USE_MOCK = true;
```

Luego:
```bash
npm run dev
```

## ✅ ¿Funcionó?

Deberías ver:

1. **En la consola:**
   ```
   [API] Using API: mock
   [Mock API] Fetching vote processes...
   ```

2. **En la UI:**
   ```
   Estado de la API
   Usando datos de prueba (MOCK)
   
   🗄️ Modo Desarrollo (Mock)
   ```

3. **En la lista:**
   - Proceso de Votación 1
   - Proceso de Votación 2
   - ... (12 procesos en total)

## 🎓 Para Tu Proyecto

Esto es una **CARACTERÍSTICA**, no un bug:

> "La aplicación detecta automáticamente cuando la API externa no está disponible y ofrece al usuario cambiar a un modo de desarrollo con datos de prueba, garantizando que la aplicación sea utilizable incluso ante fallos de servicios externos."

## 📚 Más Información

- `ERRORES_API_NORMALES.md` - Explicación detallada
- `MOCK_MODE.md` - Documentación del modo Mock
- `TROUBLESHOOTING_API.md` - Guía de problemas de API

---

**¿Sigue sin funcionar?** Lee `ERRORES_API_NORMALES.md` para más detalles.
