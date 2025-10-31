## Guías internas de contribución

Este documento contiene pautas breves para que los colaboradores mantengan coherencia en el proyecto.

Principios generales

- Escribe código claro y legible. Prefiere funciones pequeñas y componentes reutilizables.
- Mantén la separación por capas (presentación, dominio, datos).
- No incluyas credenciales ni secretos en el repositorio. Usa `.env` y `.env.example`.

Estilo y componentes

- Sigue los patrones y estilos establecidos en los componentes del proyecto.
- Prioriza accesibilidad y responsividad (uso razonable de flexbox/grid).

Commits y PRs

- Mensajes de commit descriptivos: tipo: resumen (ej: feat: agregar autenticación con Google).
- Incluye pruebas cuando modifiques lógica del dominio o consumo de API.

Errores y manejo de estados

- Representa claramente estados: carga, vacío, éxito y error.
- Diferencia errores de red, errores de negocio (4xx) y errores de servidor (5xx). Proporciona acciones de reintento cuando proceda.

Si necesitas agregar secciones más específicas, crea subsecciones con ejemplos concretos para el equipo.
For example:
