# Lista de seguridad para adaptar la demo

Marca cada punto después de comprobarlo en **tu** aplicación. Esta lista no certifica que un sistema sea seguro.

## Antes de publicar el repositorio

- [ ] Comprobar que `.env` no aparece al ejecutar `git ls-files .env` y que `git status` no lo muestra para añadir.
- [ ] Verificar que `.env.example` contiene solo valores ficticios.
- [ ] Revisar el historial del repositorio en busca de claves; revocar o rotar las que se hayan expuesto.
- [ ] Confirmar que `.dockerignore` excluye archivos locales y datos sensibles del contexto de construcción.
- [ ] Revisar el código y las instrucciones para eliminar afirmaciones de seguridad que no se hayan probado.
- [ ] Elegir una licencia de distribución si otras personas deben reutilizar el proyecto. El repositorio de origen no tenía una licencia declarada.

## Dependencias e imagen

- [ ] Fijar versiones de paquetes de la aplicación y revisar sus avisos de seguridad.
- [ ] Actualizar la imagen base y, para despliegues reproducibles, fijarla por digest.
- [ ] Confirmar que `docker compose build` se detiene cuando falla una instalación.
- [ ] Revisar la procedencia de imágenes y dependencias; no instalar paquetes innecesarios.

## Contenedor y configuración

- [ ] Comprobar que `docker compose exec app id` muestra un usuario sin privilegios.
- [ ] Mantener `read_only`, `cap_drop`, `no-new-privileges` y límites de recursos, salvo una necesidad concreta y documentada.
- [ ] Evitar `privileged: true`, montaje de `/var/run/docker.sock` y puertos públicos innecesarios.
- [ ] Guardar secretos fuera de la imagen y del repositorio; evaluar un gestor de secretos para producción.
- [ ] Configurar políticas de registro y supervisión acordes con la aplicación real.

## Si se convierte en un servicio de producción

- [ ] Diseñar autenticación, autorización y HTTPS antes de exponer una interfaz.
- [ ] Definir copias de seguridad, restauración y respuesta ante incidentes si procesa datos persistentes.
- [ ] Probar la aplicación y revisar permisos de red, almacenamiento y cuentas del anfitrión.
- [ ] Configurar actualizaciones y alertas de vulnerabilidades con un proceso de mantenimiento.
- [ ] Validar el despliegue en el proveedor elegido. Este proyecto no configura Azure.

