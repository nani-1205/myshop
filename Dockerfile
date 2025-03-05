# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory inside the container
WORKDIR /app

# Copy the application source code
COPY myshop /app/myshop
COPY shop /app/shop
COPY users /app/users
COPY orders /app/orders
COPY static /app/static
COPY templates /app/templates

# Explicitly copy important top-level files
COPY manage.py /app/manage.py
COPY requirements.txt /app/requirements.txt
COPY Jenkinsfile /app/Jenkinsfile

# Debugging step: List contents of /app
RUN ls -l /app

# Install dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Run database migrations
RUN python /app/manage.py migrate

# Expose the application port
EXPOSE 8000

# Run the application using Gunicorn
CMD ["gunicorn", "myshop.wsgi:application", "--bind", "0.0.0.0:8000"]
