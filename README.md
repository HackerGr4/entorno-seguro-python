# Entorno seguro de Python con Docker: demo educativa

Esta demo ejecuta `app.py` en un contenedor. El programa imprime el valor de `MENSAJE_BIENVENIDA` y luego permanece activo. Sirve para practicar una configuración básica de Docker; no publica un servicio web ni constituye un despliegue listo para producción o para Azure.

## Requisitos

- Docker Engine o Docker Desktop con contenedores Linux.
- Docker Compose v2 (`docker compose`).

## Ponerlo en marcha

1. Obtén este proyecto y entra en su carpeta.
2. Crea tu archivo local de configuración a partir del ejemplo:

   ```powershell
   # PowerShell
   Copy-Item .env.example .env
   ```

   ```sh
   # macOS o Linux
   cp .env.example .env
   ```

3. Comprueba la configuración y ejecuta la demo:

   ```sh
   docker compose config --quiet
   docker compose up --build
   ```

Deberías ver el mensaje de bienvenida una vez. Pulsa `Ctrl+C` para detener la ejecución. Si la dejaste en segundo plano, usa `docker compose down`.

## Comprobaciones rápidas

Con la demo activa, en otra terminal:

```sh
docker compose ps
docker compose exec app id
docker compose exec app sh -c 'test ! -w /app && echo "Directorio de la aplicación: solo lectura"'
```

El segundo comando debe mostrar un usuario distinto de `root`. El último comprueba que el proceso no puede escribir en `/app` mientras usa `read_only: true`. El contenedor no publica puertos en el host. La red de tipo `bridge` no lo deja sin conexión ni bloquea por sí sola las conexiones salientes.

## Validación automática

El flujo [Validate Python container demo](.github/workflows/validate.yml) se ejecuta en los pull requests y en los cambios enviados a `main` y `kit-seguridad-python`. Comprueba:

- La sintaxis de `app.py`.
- La configuración de Docker Compose, la construcción de la imagen y el arranque.
- Que el proceso no use el UID `0` y que no pueda escribir en `/app`.
- Que los registros contengan el mensaje de bienvenida del ejemplo.

Estos controles verifican el funcionamiento básico de la demo. No son una auditoría de seguridad ni un análisis de vulnerabilidades. Puedes consultar los resultados de cada ejecución en [GitHub Actions](https://github.com/HackerGr4/entorno-seguro-python/actions).

## Qué protecciones demuestra

- El proceso corre con un usuario sin privilegios de administrador.
- La raíz del sistema de archivos es de solo lectura; `/tmp` es temporal.
- Se eliminan las capacidades Linux del contenedor y se impide obtener nuevos privilegios.
- Se fijan límites de CPU, memoria y número de procesos.
- `.dockerignore` excluye `.env` del contexto de construcción y `.gitignore` evita añadir nuevos archivos de entorno por accidente.
- La construcción falla si falla la instalación de dependencias; no se ocultan errores con `|| true`.

Estas medidas reducen riesgos concretos, pero no garantizan aislamiento total. El anfitrión, Docker, la imagen base y cualquier dependencia también requieren mantenimiento. La imagen `python:3.12-slim` usa una etiqueta móvil; para un despliegue reproducible habría que fijar una versión o un digest y actualizarlo regularmente.

## Datos de configuración y secretos

El archivo `.env.example` contiene solo un mensaje de ejemplo. No pongas contraseñas, tokens ni claves reales en él. El repositorio original tenía `.env` versionado; esta versión lo retira del seguimiento y `.gitignore` evita volver a añadirlo por accidente. Su contenido coincidía con el ejemplo y no parecía contener secretos. Si alguna versión anterior incluyó un secreto real, hay que revocarlo o rotarlo: eliminar el archivo no borra el historial.

## Límites de esta demo

No incluye autenticación, HTTPS, servicio de red, gestión de secretos, análisis automático de vulnerabilidades, copia de seguridad ni despliegue en Azure. Consulta [SECURITY_CHECKLIST.md](SECURITY_CHECKLIST.md) antes de adaptar el ejemplo a una aplicación real.

`requirements.txt` está vacío porque `app.py` solo usa la biblioteca estándar de Python. Añade y fija las dependencias que necesite una aplicación real; revisa y actualiza esas versiones periódicamente.

## Apoyo voluntario

Este proyecto educativo y su documentación están disponibles sin cobro. Su objetivo es facilitar el aprendizaje de Python y de las medidas básicas de protección de un contenedor Docker.

Los aportes económicos, cuando se habilite un canal verificado, serán completamente voluntarios. Su finalidad será apoyar el mantenimiento y la mejora de este material educativo. No serán necesarios para acceder al repositorio ni comprarán soporte, servicios, funciones exclusivas o compromisos de entrega. No constituyen una inversión ni ofrecen rentabilidad o ingresos garantizados.

**Canal de aportes pendiente de verificación.** Por ahora no se publica un enlace de pago. Antes de habilitarlo se confirmarán la URL y la titularidad del destinatario con la persona responsable del proyecto.

También puedes apoyar sin aportar dinero: compartir el enlace del repositorio, darle una estrella o [comunicar errores y sugerencias](https://github.com/HackerGr4/entorno-seguro-python/issues). Evita publicar credenciales o datos personales en los reportes.

## Licencia y reutilización

Este repositorio todavía no incluye un archivo `LICENSE`. Que sea público y no tenga un precio de acceso no significa que se conceda una licencia abierta para modificar, redistribuir o incorporar su contenido a otros proyectos. GitHub permite ver y hacer un fork de un repositorio público conforme a sus términos; eso no sustituye una licencia de reutilización.

La persona titular debe elegir y publicar la licencia antes de ofrecer el proyecto para su reutilización general, y comprobar que tiene los derechos necesarios sobre el material incluido. Un aporte voluntario no concede derechos adicionales sobre el código. Consulta la [guía de licencias de GitHub](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository).
