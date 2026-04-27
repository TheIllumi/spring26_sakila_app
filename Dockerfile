FROM python:3.9-slim

LABEL maintainer="your.email@example.com"
LABEL version="1.0"
LABEL description="Sakila Flask Application"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD python -c "import requests; requests.get('http://localhost:5000/')" || exit 1

CMD ["python", "app.py"]