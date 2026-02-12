# Stage 1: Build Tailwind CSS
FROM node:20-slim AS builder-css

WORKDIR /app
COPY theme/static_src /app/theme/static_src
COPY theme/apps.py /app/theme/apps.py
COPY theme/__init__.py /app/theme/__init__.py

WORKDIR /app/theme/static_src
RUN npm install
RUN npm run build

# Stage 2: Final image
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    libpq-dev \
    gcc \
    gettext \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/

# Copy built CSS from builder-css stage
COPY --from=builder-css /app/theme/static/css/dist/styles.css /app/theme/static/css/dist/styles.css

# Run collectstatic
# We need dummy values for env vars during build if settings.py requires them
RUN DJANGO_SECRET_KEY=dummy DJANGO_DEBUG=False DJANGO_ALLOWED_HOSTS=localhost python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Start Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "config.wsgi:application"]
