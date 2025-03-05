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

# List Contents
RUN ls -l /app

RUN pip install --no-cache-dir -r requirements.txt

RUN python manage.py migrate

EXPOSE 8000

CMD ["gunicorn", "myshop.wsgi:application", "--bind", "0.0.0.0:8000"]