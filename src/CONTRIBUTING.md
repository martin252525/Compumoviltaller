# Guía de Contribución

¡Gracias por tu interés en contribuir a este proyecto! Este es un proyecto universitario de demostración para un sistema de votación.

## 🎯 Objetivo del Proyecto

Este proyecto es una **demostración web en React** que sirve como referencia arquitectural para un proyecto universitario en Flutter. No está destinado a ser usado en producción.

## ⚠️ Aviso Importante

**Este proyecto NO debe usarse para:**
- Recopilar información personal identificable (PII)
- Manejar datos sensibles de votaciones reales
- Procesos de votación oficiales o legales
- Almacenar información confidencial

**Solo debe usarse para:**
- Aprendizaje y demostración
- Desarrollo universitario
- Prototipado de arquitectura
- Referencia de implementación

## 🤝 Cómo Contribuir

### Reportar Bugs

Si encuentras un bug, por favor:

1. Verifica que no esté ya reportado en [Issues](../../issues)
2. Crea un nuevo Issue con:
   - Descripción clara del problema
   - Pasos para reproducir
   - Comportamiento esperado vs. comportamiento actual
   - Screenshots si aplica
   - Versión del navegador y sistema operativo

### Sugerir Mejoras

Para sugerir mejoras:

1. Abre un Issue con el tag `enhancement`
2. Describe claramente la mejora propuesta
3. Explica por qué sería útil
4. Si es posible, propón una implementación

### Pull Requests

1. **Fork el repositorio**
2. **Crea una rama** para tu feature:
   ```bash
   git checkout -b feature/nombre-descriptivo
   ```
3. **Haz tus cambios** siguiendo las guías de estilo
4. **Escribe commits claros**:
   ```
   feat: agregar validación de opciones de voto
   fix: corregir error en filtro de búsqueda
   docs: actualizar guía de instalación
   ```
5. **Prueba tus cambios**
6. **Push a tu fork**:
   ```bash
   git push origin feature/nombre-descriptivo
   ```
7. **Abre un Pull Request**

## 📝 Guías de Estilo

### TypeScript/React

- Usa TypeScript para todos los archivos
- Sigue las convenciones de React Hooks
- Componentes funcionales con tipos explícitos
- Usa interfaces para definir tipos
- Evita `any` siempre que sea posible

### Estructura de Archivos

```
/components      # Componentes de UI
/hooks          # Custom hooks
/services       # Lógica de negocio y API
/types          # Definiciones TypeScript
/styles         # Estilos globales
```

### Commits

Sigue [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` Nueva funcionalidad
- `fix:` Corrección de bug
- `docs:` Cambios en documentación
- `style:` Cambios de formato (sin cambio de código)
- `refactor:` Refactorización
- `test:` Agregar o corregir tests
- `chore:` Cambios en build o herramientas

### Documentación

- Documenta funciones complejas
- Actualiza el README si cambias funcionalidades principales
- Agrega comentarios JSDoc para APIs públicas
- Mantén actualizado el TECHNICAL_REPORT.md

## 🧪 Testing

Antes de hacer un PR:

1. Verifica que la app compile sin errores:
   ```bash
   npm run build
   ```

2. Prueba localmente:
   ```bash
   npm run dev
   ```

3. Verifica que funcionan:
   - Modo con API real
   - Modo Mock
   - Autenticación Firebase
   - Búsqueda y filtros
   - Votación

## 🔒 Seguridad

### NO Incluyas en tu PR:

- Credenciales de Firebase
- API keys
- Tokens de acceso
- Información personal
- Archivos `.env`

### SÍ Incluye:

- Actualizaciones a `.env.example` (sin credenciales reales)
- Documentación de nuevas variables de entorno
- Tests que no requieran credenciales

## 📋 Checklist para PRs

Antes de enviar tu PR, verifica:

- [ ] El código compila sin errores
- [ ] No hay credenciales hardcodeadas
- [ ] La documentación está actualizada
- [ ] Los commits siguen Conventional Commits
- [ ] El código sigue las guías de estilo
- [ ] Probaste en modo API y modo Mock
- [ ] No hay console.logs innecesarios
- [ ] Los tipos TypeScript están correctos

## 🎓 Contexto Académico

Este proyecto es parte de un curso universitario. Las contribuciones deben:

- Mantener el propósito educativo
- Ser apropiadas para un contexto académico
- Seguir buenas prácticas de desarrollo
- Servir como referencia para otros estudiantes

## 📞 Preguntas

Si tienes preguntas sobre cómo contribuir:

1. Revisa la documentación en `/docs`
2. Lee el `TECHNICAL_REPORT.md`
3. Abre un Issue con el tag `question`

## 📜 Licencia

Al contribuir, aceptas que tus contribuciones se licencien bajo la misma licencia MIT del proyecto.

---

¡Gracias por contribuir! 🎉
