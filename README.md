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

El segundo comando debe mostrar un usuario distinto de `root`. El último comprueba que el proceso no puede escribir en `/app` mientras usa `read_only: true`. El contenedor no publica puertos en el host.

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


