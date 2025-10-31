# 🧪 Instrucciones para Probar la API

## Método 1: Usar el Verificador HTML (Más Simple)

He creado un archivo HTML especial que prueba la API automáticamente.

### Pasos:

1. **Abre el archivo `test-api.html`** en tu navegador
   - Opción A: Doble click en el archivo
   - Opción B: Arrastra el archivo a tu navegador
   - Opción C: En VSCode, click derecho → "Open with Live Server"

2. **Los tests se ejecutarán automáticamente** después de 1 segundo

3. **Revisa los resultados:**
   - ✅ Verde = Test exitoso (API funciona)
   - ❌ Rojo = Test fallido (API no disponible)
   - ⚠️ Amarillo = Test omitido

4. **Interpreta los resultados:**

   **Si todos los tests están en VERDE:**
   ```
   ✅ La API está funcionando correctamente
   → Puedes usar la aplicación sin problemas
   → No necesitas el modo Mock
   ```

   **Si todos los tests están en ROJO:**
   ```
   ❌ La API NO está disponible
   → Usa el modo Mock para probar la aplicación
   → Verifica tu conexión a internet
   → Consulta TROUBLESHOOTING_API.md
   ```

## Método 2: Usar la Consola del Navegador

### Opción A: Prueba Rápida

1. Abre la consola del navegador (F12)
2. Pega este código:

```javascript
fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1')
  .then(response => {
    console.log('✅ API Status:', response.status);
    return response.json();
  })
  .then(data => {
    console.log('✅ API funcionando!');
    console.log('📊 Total de procesos:', data.totalElements);
    console.log('📄 Datos:', data);
  })
  .catch(error => {
    console.error('❌ API no disponible');
    console.error('Error:', error.message);
  });
```

### Opción B: Prueba Completa

```javascript
async function testAPI() {
  const tests = [
    { name: 'Listar procesos', url: '/api/vote-processes?page=0&size=5' },
    { name: 'Filtro ACTIVE', url: '/api/vote-processes?status=ACTIVE' },
    { name: 'Búsqueda', url: '/api/vote-processes?search=test' }
  ];
  
  const baseURL = 'https://api.sebastian.cl/vote';
  
  for (const test of tests) {
    console.log(`\n🧪 Test: ${test.name}`);
    try {
      const response = await fetch(baseURL + test.url);
      if (response.ok) {
        const data = await response.json();
        console.log(`✅ ${test.name}: OK (${data.totalElements || 0} elementos)`);
      } else {
        console.log(`❌ ${test.name}: Error ${response.status}`);
      }
    } catch (error) {
      console.log(`❌ ${test.name}: ${error.message}`);
    }
  }
}

testAPI();
```

## Método 3: Usar cURL (Terminal)

### En Windows (PowerShell):

```powershell
curl -Uri "https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1" -Method Get -ContentType "application/json"
```

### En Mac/Linux:

```bash
curl -X GET "https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1" \
  -H "Content-Type: application/json"
```

### Resultado esperado si funciona:

```json
{
  "content": [
    {
      "id": "...",
      "title": "...",
      "description": "...",
      ...
    }
  ],
  "totalElements": 10,
  "totalPages": 1,
  ...
}
```

### Si NO funciona:

```
curl: (6) Could not resolve host: api.sebastian.cl
```
O
```
curl: (7) Failed to connect to api.sebastian.cl
```

## Método 4: Dentro de la Aplicación React

1. **Inicia la aplicación:**
   ```bash
   npm run dev
   ```

2. **Abre http://localhost:5173**

3. **Abre la consola del navegador (F12)**

4. **Busca mensajes que digan:**
   ```
   [Health Check] Testing API connection to: https://api.sebastian.cl/vote
   [Health Check] Status: 200
   ✅ API en línea
   ```

5. **Si ves el componente "Estado de la API":**
   - Click en "Verificar" para probar
   - Lee el resultado en la tarjeta

## 📊 Interpretación de Resultados

### ✅ API Funcionando

**Señales:**
- Status code: 200
- Respuesta JSON válida
- `totalElements` existe en la respuesta
- Tiempo de respuesta < 2000ms

**Qué hacer:**
1. ✅ Puedes usar la aplicación normalmente
2. ✅ No necesitas activar el modo Mock
3. ✅ Todos los endpoints deberían funcionar

### ❌ API No Disponible

**Señales:**
- Error: "Failed to fetch"
- Error: "Network error"
- Timeout después de 15 segundos
- Status code: 500, 502, 503, 504

**Qué hacer:**
1. 🔍 Verifica tu conexión a internet
2. 🌐 Intenta abrir https://api.sebastian.cl/vote/swagger-ui/index.html
3. 🔄 Espera unos minutos e intenta de nuevo
4. 💻 Activa el modo Mock para continuar trabajando

### ⚠️ API con Errores Parciales

**Señales:**
- Status code: 400, 401, 403, 404
- Respuesta del servidor pero con error

**Qué hacer:**
1. 📖 Revisa la documentación en Swagger
2. 🔍 Verifica que estás usando los endpoints correctos
3. 🔑 Para endpoints protegidos, verifica la autenticación

## 🔍 Debugging Avanzado

### Ver Headers de la Respuesta

```javascript
fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1')
  .then(response => {
    console.log('Headers:', Object.fromEntries(response.headers.entries()));
    return response.json();
  })
  .then(console.log);
```

### Medir Tiempo de Respuesta

```javascript
const start = Date.now();
fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1')
  .then(response => {
    console.log(`⏱️ Tiempo: ${Date.now() - start}ms`);
    return response.json();
  })
  .then(console.log);
```

### Probar con Timeout

```javascript
const controller = new AbortController();
setTimeout(() => controller.abort(), 5000); // 5 segundos

fetch('https://api.sebastian.cl/vote/api/vote-processes?page=0&size=1', {
  signal: controller.signal
})
  .then(response => response.json())
  .then(data => console.log('✅ Respuesta dentro de 5s:', data))
  .catch(error => console.error('❌ Timeout o error:', error.message));
```

## 🎯 Checklist Rápido

Usa esta lista para verificar paso a paso:

- [ ] Mi internet funciona (otras páginas cargan)
- [ ] El Swagger UI carga (https://api.sebastian.cl/vote/swagger-ui/index.html)
- [ ] `test-api.html` muestra resultados verdes
- [ ] La consola del navegador no muestra errores de CORS
- [ ] cURL desde terminal funciona
- [ ] La aplicación React muestra "API en línea"

Si TODOS están marcados: ✅ La API funciona perfectamente
Si NINGUNO está marcado: ❌ Usa el modo Mock

## 📞 Reportar Problema

Si la API no funciona, recopila esta información antes de reportar:

1. **Sistema:**
   - OS: Windows/Mac/Linux
   - Navegador: Chrome/Firefox/Safari + versión
   - Red: Casa/Universidad/Datos móviles

2. **Resultados de tests:**
   - ¿test-api.html? (Verde/Rojo)
   - ¿Swagger UI carga? (Sí/No)
   - ¿cURL funciona? (Sí/No)
   - ¿Otra computadora funciona? (Sí/No)

3. **Error exacto:**
   - Mensaje de error completo
   - Captura de pantalla de la consola
   - Código de estado HTTP (si aplica)

4. **Fecha y hora:**
   - Cuándo detectaste el problema
   - ¿Funcionaba antes?

---

**💡 Tip:** En la mayoría de los casos, si el Swagger UI carga correctamente en tu navegador, la API está funcionando y el problema está en la configuración local (CORS, firewall, etc.).
