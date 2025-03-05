#!/bin/sh

# Run database migrations
python manage.py migrate

# Start Django application
exec python manage.py runserver 0.0.0.0:8080
