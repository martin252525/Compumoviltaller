# Modo Mock - Datos de Prueba

## 🎯 ¿Qué es el Modo Mock?

El **Modo Mock** te permite usar la aplicación con datos de prueba cuando la API externa no está disponible. Es perfecto para:

- ✅ Desarrollo local sin depender de la API externa
- ✅ Demostraciones cuando no hay conexión
- ✅ Pruebas de la interfaz sin consumir la API real
- ✅ Explorar todas las funcionalidades de la aplicación

## 🚀 Cómo Activar el Modo Mock

### Opción 1: Desde el Diagnóstico de API (Recomendado)

1. **Abre la aplicación** en tu navegador
2. Si la API no está disponible, verás un error de conexión
3. **Aparecerá automáticamente** una tarjeta de "Estado de la API"
4. Click en el botón **"Usar Datos de Prueba (Mock)"**
5. La página se recargará y estarás usando datos mock

### Opción 2: Manualmente desde la Consola

Si prefieres activarlo manualmente, abre la consola del navegador (F12) y ejecuta:

```javascript
// Para activar el modo mock
localStorage.setItem('useMockApi', 'true');
location.reload();

// Para desactivar el modo mock
localStorage.removeItem('useMockApi');
location.reload();
```

## 📊 Datos de Prueba Incluidos

El modo mock incluye **5 procesos de votación** de ejemplo:

### 1. Elección de Delegado de Curso 2025
- **Estado:** ACTIVE (Activo)
- **Opciones:** 3 candidatos
- **Votos totales:** 110
- **Descripción:** Votación para representante estudiantil

### 2. Mejora de Espacios Comunes
- **Estado:** ACTIVE (Activo)
- **Opciones:** Biblioteca, Cafetería, Zona exterior
- **Votos totales:** 210
- **Descripción:** Decisión sobre renovaciones del campus

### 3. Horario de Exámenes Finales
- **Estado:** FINISHED (Finalizado)
- **Opciones:** Una semana concentrada vs. Dos semanas distribuidas
- **Votos totales:** 215
- **Descripción:** Formato de exámenes (ya finalizada)

### 4. Actividades Extracurriculares 2026
- **Estado:** PENDING (Pendiente)
- **Opciones:** 4 talleres diferentes
- **Votos totales:** 0
- **Descripción:** Votación que aún no ha comenzado

### 5. Elección de Tema para Hackathon
- **Estado:** ACTIVE (Activo)
- **Opciones:** Sostenibilidad, Educación, Salud
- **Votos totales:** 73
- **Descripción:** Selección del tema del hackathon

## ✨ Funcionalidades Disponibles en Modo Mock

### ✅ Lo que SÍ funciona:

- Ver todos los procesos de votación
- Buscar y filtrar votaciones
- Ver detalles de cada proceso
- Ver resultados y gráficas
- **Votar en procesos activos** (se guarda en memoria)
- Ver historial de votos (1 voto pre-existente)
- Paginación
- Estados: Activos, Finalizados, Pendientes
- Prevención de voto duplicado

### ⚠️ Limitaciones:

- Los datos NO se persisten (se pierden al recargar la página)
- No se requiere autenticación Firebase para votar
- Los datos son locales (no compartidos entre usuarios)
- No hay sincronización con el servidor

## 🔄 Cómo Volver a la API Real

Cuando la API externa esté disponible:

1. **Desde la interfaz:**
   - Abre la tarjeta "Estado de la API"
   - Click en **"Volver a API Real"**
   - La página se recargará

2. **Manualmente:**
   ```javascript
   localStorage.removeItem('useMockApi');
   location.reload();
   ```

## 🎨 Indicadores Visuales

Cuando estás en modo mock, verás:

- 🔵 **Badge "Mock"** en el header de la aplicación
- 📊 **"Modo Desarrollo (Mock)"** en la tarjeta de Estado de la API
- 💻 Mensaje explicativo sobre los datos de prueba

## 🧪 Casos de Uso

### Para Desarrollo

```bash
# 1. Activa el modo mock
# 2. Desarrolla tu funcionalidad
# 3. Prueba sin preocuparte por la API
# 4. Cuando termines, vuelve a API real para probar integración
```

### Para Demostración

```bash
# Perfecto para mostrar la aplicación cuando:
- No hay conexión a internet
- La API está en mantenimiento
- Quieres mostrar datos específicos
- Presentaciones o evaluaciones
```

### Para Testing Manual

```bash
# Prueba escenarios específicos:
- Votar en diferentes procesos
- Ver cómo se muestran los resultados
- Probar filtros y búsqueda
- Verificar estados (activo, finalizado, pendiente)
```

## 📝 Personalizar Datos Mock

Si necesitas modificar los datos de prueba, edita el archivo:

```
/services/mock-api.service.ts
```

Puedes:
- Agregar más procesos de votación
- Cambiar los títulos y descripciones
- Modificar las opciones de voto
- Ajustar las fechas
- Cambiar los estados

Ejemplo de cómo agregar un nuevo proceso:

```typescript
{
  id: '6',
  title: 'Tu Nuevo Proceso',
  description: 'Descripción personalizada',
  startDate: '2025-11-01T00:00:00Z',
  endDate: '2025-11-30T23:59:59Z',
  status: 'ACTIVE',
  createdAt: '2025-10-30T00:00:00Z',
  updatedAt: '2025-10-30T00:00:00Z',
  options: [
    {
      id: '16',
      voteProcessId: '6',
      optionText: 'Opción 1',
      votes: 0,
      createdAt: '2025-10-30T00:00:00Z',
    },
    // Agrega más opciones...
  ],
}
```

## 🔍 Debugging en Modo Mock

Los mensajes de log en la consola incluyen el prefijo `[Mock API]`:

```
[Mock API] Getting vote processes: { page: 0, size: 10, search: '', status: '' }
[Mock API] Submitting vote: { voteProcessId: '1', optionId: '1' }
[Mock API] Getting user votes: { page: 0, size: 10 }
```

Esto te ayuda a identificar cuándo estás usando datos mock vs. la API real.

## 🎓 Para el Proyecto Universitario

El modo mock es especialmente útil para:

1. **Desarrollo sin dependencias:** No necesitas que la API esté siempre disponible
2. **Demostraciones:** Puedes mostrar tu proyecto incluso sin internet
3. **Testing:** Prueba todos los casos de uso con datos controlados
4. **Documentación:** Genera capturas de pantalla con datos consistentes
5. **Presentaciones:** Evita problemas de conectividad durante evaluaciones

## ⚡ Tips y Trucos

### Tip 1: Datos Frescos
Cada vez que recargues la página en modo mock, los votos se resetean a los valores iniciales.

### Tip 2: Combinar con Firebase
Puedes tener Firebase configurado y usar modo mock. La autenticación seguirá funcionando.

### Tip 3: Simular Latencia
El servicio mock incluye delays realistas (200-400ms) para simular peticiones de red.

### Tip 4: Validaciones
El mock replica las validaciones de la API real:
- No puedes votar dos veces en el mismo proceso
- Solo puedes votar en procesos activos
- Verifica que las opciones existan

## 🆘 Problemas Comunes

### "No aparece el botón para activar Mock"

**Solución:** El botón solo aparece cuando hay un error de conexión a la API. Si la API funciona, no necesitas el modo mock.

### "Perdí mis votos al recargar"

**Esperado:** El modo mock no persiste datos. Es solo para pruebas temporales.

### "El badge Mock no desaparece"

**Solución:** Limpia el localStorage:
```javascript
localStorage.clear();
location.reload();
```

### "Quiero datos diferentes"

**Solución:** Edita `/services/mock-api.service.ts` con los datos que necesites.

## 📚 Recursos Relacionados

- **README.md** - Documentación principal
- **QUICKSTART.md** - Guía de inicio rápido
- **TROUBLESHOOTING_API.md** - Solución de problemas de API
- **TECHNICAL_REPORT.md** - Documentación técnica completa

---

**Nota:** El modo mock es una herramienta de desarrollo. Para producción, siempre debes usar la API real con autenticación y validaciones del servidor.
