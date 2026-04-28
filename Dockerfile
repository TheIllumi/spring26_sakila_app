# Use slim variant — much smaller than full python:3.9
FROM python:3.9-slim

# Labels for documentation
LABEL maintainer="your.email@example.com"
LABEL version="1.0"
LABEL description="Sakila Flask Application"

WORKDIR /app

# IMPORTANT: Copy requirements BEFORE source code
# This lets Docker cache the pip install layer separately
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Now copy application code (cache only invalidated if code changes)
COPY . .

# Create and switch to a non-root user for security
RUN useradd -m -r appuser && chown -R appuser:appuser /app
USER appuser

# Only expose the port this app actually uses
EXPOSE 5000

# Healthcheck so Docker/Compose knows when app is ready
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/')" || exit 1

CMD ["python", "app.py"]