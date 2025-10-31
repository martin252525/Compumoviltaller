
  # Mobile Voting App

  Especificación del proyecto (21 de octubre de 2025)

  Descripción

  Aplicación móvil para gestión y participación en procesos de votación. Permite a los usuarios explorar listados de votaciones, aplicar filtros y búsquedas, ver detalles completos de cada proceso y, cuando estén autenticados, participar realizando su voto. La aplicación prioriza manejo claro de estados (carga, vacío, éxito, error) y una separación por capas para facilitar mantenimiento y escalabilidad.

  Requisitos funcionales principales

  - Autenticación segura con Firebase Authentication (soportar al menos inicio de sesión con Google). Persistencia de sesión y opción de cierre de sesión.
  - Consumo de la API disponible en https://api.sebastian.cl/vote; respetar el contrato OpenAPI publicado en https://api.sebastian.cl/vote/swagger-ui/index.html.
  - Listado dinámico de procesos de votación con paginación o desplazamiento infinito, búsquedas y filtros en la lista.
  - Vistas de detalle de cada proceso (título, descripción, fechas, estado, opciones). Las vistas públicas deben poder consultarse sin autenticación; los endpoints con datos sensibles y la acción de votar requieren autenticación.
  - Flujo de votación seguro: validaciones de cliente y servidor, y manejo claro de errores de negocio (4xx) y servidor (5xx).
  - Perfil de usuario con información básica y acceso al historial de votaciones realizadas.

  Requisitos técnicos y de arquitectura

  - Arquitectura por capas (presentación, dominio y datos). Uso recomendado de un gestor de estado moderno (Riverpod o Bloc en Flutter). Código organizado y modular.
  - Consumo de la API conforme al OpenAPI: generación automática de cliente (opcional) o uso de una librería HTTP como Dio con interceptores para encabezados, timeouts y manejo centralizado de errores.
  - Mapeo de modelos y serialización estricta según los esquemas de la especificación OpenAPI.

  Pruebas y CI

  - Pruebas automatizadas: pruebas unitarias y de widgets (o equivalentes) con cobertura razonable en capas de dominio y datos.
  - Configurar un flujo de integración continua que ejecute análisis estático, pruebas y compilación en modo debug.

  Seguridad y buenas prácticas

  - No incluir credenciales en el código. Gestionar variables de entorno correctamente y proporcionar un `.env.example`.
  - Protección de datos privados del usuario y tratamiento seguro de tokens.

  Entregables

  - Repositorio con código fuente y documentación.
  - `README.md` con instrucciones de instalación y uso.
  - Resumen de endpoints utilizados (parámetros y modelos de entrada/salida) y un breve informe técnico que describa la arquitectura, mapeo de modelos, manejo de errores y medidas de seguridad.

  Cómo ejecutar el proyecto (desarrollo)

  1. Instalar dependencias:

  ```powershell
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  npm install
  ```

  2. Iniciar servidor de desarrollo (Vite):

  ```powershell
  npm run dev
  ```

  El servidor suele quedar disponible en http://localhost:5173

  Notas finales

  Este repositorio contiene una interfaz web de referencia y ejemplos de datos para facilitar el desarrollo de la aplicación móvil. Los documentos en la carpeta `src/` y los archivos `FIREBASE_SETUP.md`, `TECHNICAL_REPORT.md` y `API_TEST_INSTRUCTIONS.md` aportan detalles para la integración con Firebase y el consumo de la API.
  