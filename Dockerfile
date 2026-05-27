FROM python:3.12-slim

WORKDIR /app

# Crear usuario no root por seguridad
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copiar archivos
COPY requirements.txt .
COPY app.py .

# Instalar dependencias si el archivo no está vacío
RUN pip install --no-cache-dir -r requirements.txt || true

# Cambiar permisos al usuario
RUN chown -R appuser:appuser /app
USER appuser

CMD ["python", "app.py"]
