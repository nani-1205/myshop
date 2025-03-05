FROM python:3.9-alpine3.19

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install system dependencies (required for psycopg2 and Pillow)
RUN apk update && apk add --no-cache postgresql-dev gcc musl-dev python3-dev libjpeg-turbo-dev zlib-dev

# Copy project files
COPY myshop /app/myshop
COPY shop /app/shop
COPY users /app/users
COPY orders /app/orders
COPY static /app/static
COPY templates /app/templates
COPY manage.py /app/manage.py
COPY requirements.txt /app/requirements.txt
COPY Dockerfile /app/Dockerfile
COPY Jenkinsfile /app/Jenkinsfile

# Install Python dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Apply database migrations
RUN python /app/manage.py makemigrations users
RUN python /app/manage.py migrate

EXPOSE 8000

CMD ["gunicorn", "myshop.wsgi:application", "--bind", "0.0.0.0:8000"]