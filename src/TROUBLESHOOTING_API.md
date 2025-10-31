# Guía de Solución de Problemas - API

Si estás experimentando el error "Error de conexión a internet", sigue estos pasos para diagnosticar el problema.

## 🔍 Diagnóstico Rápido

### Paso 1: Verificar Conectividad Básica

1. **Verifica tu conexión a internet:**
   - Abre otra página web (como google.com)
   - ✅ Si carga: Tu internet funciona
   - ❌ Si no carga: Problema de conexión

2. **Verifica que la API esté disponible:**
   - Abre en tu navegador: https://api.sebastian.cl/vote/swagger-ui/index.html
   - ✅ Si carga: La API está en línea
   - ❌ Si no carga: La API podría estar caída

### Paso 2: Usar el Diagnóstico Integrado

La aplicación ahora incluye un **diagnóstico automático** que aparece cuando hay errores de red:

1. Abre la aplicación
2. Si ves el error de conexión, verás una tarjeta adicional: **"Estado de la API"**
3. Click en el botón **"Verificar"** para probar la conexión
4. Revisa los resultados:
   - 🟢 **API en línea**: La API funciona, el problema está en otro lado
   - 🔴 **API no disponible**: Sigue los pasos de esta guía

### Paso 3: Revisar la Consola del Navegador

1. Abre las **Herramientas de Desarrollador**:
   - Chrome/Edge: `F12` o `Ctrl+Shift+I`
   - Firefox: `F12` o `Ctrl+Shift+K`
   - Safari: `Cmd+Option+I`

2. Ve a la pestaña **Console**

3. Busca mensajes que comiencen con `[API]`:
   ```
   [API] Making request to: https://api.sebastian.cl/vote/api/vote-processes...
   [API] Response status: 200
   ```

4. Anota cualquier error que veas

## 🔧 Soluciones Comunes

### Problema 1: CORS Error

**Error en consola:**
```
Access to fetch at 'https://api.sebastian.cl/vote/...' from origin 'http://localhost:5173' 
has been blocked by CORS policy
```

**Causa:** El servidor API no está permitiendo peticiones desde tu dominio.

**Solución:**
1. ⚠️ Este es un problema del lado del servidor, no puedes resolverlo tú
2. Contacta al administrador de la API (Profesor Sebastián Salazar)
3. Mientras tanto, puedes usar datos mock (ver sección "Modo Desarrollo")

### Problema 2: Failed to fetch

**Error en consola:**
```
TypeError: Failed to fetch
```

**Posibles causas y soluciones:**

#### A. Firewall/Antivirus bloqueando
- Desactiva temporalmente tu antivirus/firewall
- Intenta desde otra red (datos móviles, otra WiFi)

#### B. Extensiones del navegador
- Desactiva extensiones como:
  - Ad blockers
  - Privacy extensions
  - VPN extensions
- Prueba en modo incógnito/privado

#### C. Configuración de red
```bash
# Windows: Limpiar caché DNS
ipconfig /flushdns

# Mac/Linux: Limpiar caché DNS
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

#### D. Proxy corporativo
- Si estás en una red corporativa/universitaria
- Verifica con IT si bloquean dominios externos
- Intenta desde una red personal

### Problema 3: Timeout Error

**Error:** "La solicitud tardó demasiado tiempo"

**Soluciones:**
1. Verifica la velocidad de tu conexión
2. El timeout ahora es de 30 segundos (aumentado desde 10s)
3. Si persiste, la API podría estar lenta
4. Intenta en otro momento

### Problema 4: 404 Not Found

**Error:** "API respondió con código de error: 404"

**Soluciones:**
1. Verifica que la URL sea correcta: `https://api.sebastian.cl/vote`
2. El endpoint podría haber cambiado
3. Contacta al administrador de la API

### Problema 5: 500 Server Error

**Error:** "API respondió con código de error: 500"

**Causa:** Error interno del servidor

**Solución:**
1. ⚠️ No puedes resolverlo tú
2. Espera unos minutos e intenta de nuevo
3. Si persiste, contacta al administrador

## 🧪 Pruebas Manuales

### Prueba 1: cURL desde Terminal

Abre tu terminal y ejecuta:

```bash
curl -X GET "https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1" \
  -H "Content-Type: application/json"
```

**Resultado esperado:**
```json
{
  "content": [...],
  "totalElements": 10,
  ...
}
```

**Si funciona:** El problema está en el navegador/aplicación
**Si falla:** El problema está en la red/API

### Prueba 2: Fetch desde Consola del Navegador

En la consola del navegador, ejecuta:

```javascript
fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1')
  .then(r => r.json())
  .then(console.log)
  .catch(console.error);
```

**Si funciona:** El problema está en el código de la aplicación
**Si falla:** Revisa el error específico

### Prueba 3: Postman/Insomnia

1. Descarga [Postman](https://www.postman.com/) o [Insomnia](https://insomnia.rest/)
2. Crea una nueva petición:
   - **Método:** GET
   - **URL:** `https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1`
   - **Header:** `Content-Type: application/json`
3. Envía la petición

**Si funciona:** El problema está en el navegador
**Si falla:** Problema de red o API

## 🔄 Modo Desarrollo (Datos Mock)

Si la API no está disponible y necesitas continuar desarrollando, puedes usar datos de prueba.

### Opción 1: Crear un Mock Service

1. Crea el archivo `/services/mock-api.service.ts`:

```typescript
import { VoteProcess, PaginatedResponse } from '../types/vote.types';

const mockVoteProcesses: VoteProcess[] = [
  {
    id: '1',
    title: 'Elección de Delegado de Curso',
    description: 'Votación para elegir al nuevo delegado del curso 2025',
    startDate: '2025-10-01T00:00:00Z',
    endDate: '2025-10-31T23:59:59Z',
    status: 'ACTIVE',
    createdAt: '2025-09-15T00:00:00Z',
    updatedAt: '2025-09-15T00:00:00Z',
    options: [
      {
        id: '1',
        voteProcessId: '1',
        optionText: 'Candidato A',
        votes: 15,
        createdAt: '2025-09-15T00:00:00Z',
      },
      {
        id: '2',
        voteProcessId: '1',
        optionText: 'Candidato B',
        votes: 23,
        createdAt: '2025-09-15T00:00:00Z',
      },
    ],
  },
  // Agrega más datos mock según necesites
];

export const mockApiService = {
  async getVoteProcesses(): Promise<PaginatedResponse<VoteProcess>> {
    return {
      content: mockVoteProcesses,
      totalElements: mockVoteProcesses.length,
      totalPages: 1,
      size: 10,
      number: 0,
      first: true,
      last: true,
    };
  },
};
```

2. En `/services/api.service.ts`, agrega una variable de configuración:

```typescript
const USE_MOCK_DATA = false; // Cambia a true para usar datos mock
```

### Opción 2: JSON Server

1. Instala json-server:
```bash
npm install -D json-server
```

2. Crea `db.json` con datos de prueba

3. Ejecuta:
```bash
npx json-server --watch db.json --port 3001
```

4. Cambia la URL base a `http://localhost:3001`

## 📊 Logs Detallados

La aplicación ahora incluye logs detallados en la consola. Para verlos:

1. Abre la consola del navegador (F12)
2. Recarga la página
3. Busca mensajes que comiencen con:
   - `[API]` - Peticiones a la API
   - `[Health Check]` - Verificación de salud
   - `[Firebase]` - Autenticación

Ejemplo de logs normales:
```
[API] Making request to: https://api.sebastian.cl/vote/api/vote-processes?page=0&size=10
[API] Response status: 200
```

Ejemplo de logs con error:
```
[API] Making request to: https://api.sebastian.cl/vote/api/vote-processes?page=0&size=10
[API] Request failed: TypeError: Failed to fetch
```

## 🆘 Contactar Soporte

Si ninguna solución funciona, recopila esta información:

1. **Sistema Operativo:** (Windows/Mac/Linux)
2. **Navegador y versión:** (Chrome 120, Firefox 121, etc.)
3. **Red:** (WiFi casa/Universidad/Datos móviles)
4. **Error exacto de la consola:** (captura de pantalla)
5. **Resultado de las pruebas:**
   - ¿La API Swagger carga? (Sí/No)
   - ¿cURL funciona? (Sí/No)
   - ¿Postman funciona? (Sí/No)

Contacta:
- Profesor: Sebastián Salazar Molina
- Compañeros de clase
- Foro del curso

## 📝 Checklist de Diagnóstico

Usa esta lista para verificar todos los pasos:

- [ ] Mi conexión a internet funciona (otras páginas cargan)
- [ ] La API Swagger está disponible (https://api.sebastian.cl/vote/swagger-ui/index.html)
- [ ] He revisado la consola del navegador
- [ ] He probado en modo incógnito
- [ ] He desactivado extensiones del navegador
- [ ] He probado desde otra red
- [ ] He limpiado el caché DNS
- [ ] He probado con cURL
- [ ] He revisado el diagnóstico integrado de la app
- [ ] He verificado que no hay firewall bloqueando

## 🔗 URLs Útiles

- **API Base:** https://api.sebastian.cl/vote
- **API Swagger:** https://api.sebastian.cl/vote/swagger-ui/index.html
- **Test endpoint:** https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1

---

**Nota:** La mayoría de los problemas de API son temporales o de configuración de red. Si la API funciona para otros compañeros pero no para ti, probablemente sea un problema local que puedes resolver siguiendo esta guía.
