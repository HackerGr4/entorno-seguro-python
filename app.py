import time
import os

mensaje = os.getenv('MENSAJE_BIENVENIDA', 'Entorno activo')
print(mensaje, flush=True)

while True:
    time.sleep(10)
