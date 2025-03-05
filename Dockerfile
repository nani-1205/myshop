FROM python:3.9-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY . /app/  # Copy all files from the project root

RUN pip install --no-cache-dir -r requirements.txt

RUN ls -l /app   #<---Add temporarily to verify the contents of the /app directory

RUN python manage.py migrate

EXPOSE 8000

CMD ["gunicorn", "myshop.wsgi:application", "--bind", "0.0.0.0:8000"]