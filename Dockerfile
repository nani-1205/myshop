# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Copy project files to the container
COPY . /app/

# Install system dependencies (if needed)
# Example:
# RUN apt-get update && apt-get install -y --no-install-recommends libpq-dev

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy static files (after installing dependencies)
# This assumes you've run collectstatic
# COPY ./static /app/staticfiles/

# Run database migrations
RUN python manage.py migrate

# Collect static files (if not copied earlier)
# RUN python manage.py collectstatic --noinput

# Expose port 8000 (or your preferred port)
EXPOSE 8000

# Define the command to run the application
CMD ["gunicorn", "myshop.wsgi:application", "--bind", "0.0.0.0:8000"]