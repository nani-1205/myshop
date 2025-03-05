# Use official Python image as base
FROM python:3.10

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=myshop.settings

# Set the working directory
WORKDIR /app

# Copy all project files into the container
COPY . /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose the Django port
EXPOSE 8080

# Start the Django application
CMD ["sh", "entrypoint.sh"]
