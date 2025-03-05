FROM python:3.9-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Explicitly copy each directory
COPY myshop /app/myshop
COPY shop /app/shop
COPY users /app/users
COPY orders /app/orders
COPY static /app/static
COPY templates /app/templates

# Explicitly copy the top-level files
COPY manage.py /app/manage.py
COPY requirements.txt /app/requirements.txt
COPY Dockerfile /app/Dockerfile
COPY Jenkinsfile /app/Jenkinsfile

# Install dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Apply database migrations
RUN python /app/manage.py makemigrations users  # Generate Migrations
RUN python /app/manage.py migrate                   # Apply Migrations


EXPOSE 8000

CMD ["gunicorn", "myshop.wsgi:application", "--bind", "0.0.0.0:8000"]