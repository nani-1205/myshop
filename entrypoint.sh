#!/bin/sh
set -e

# Apply database migrations at runtime
python manage.py migrate

# Start Gunicorn server
exec gunicorn myshop.wsgi:application --bind 0.0.0.0:8000
