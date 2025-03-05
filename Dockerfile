# Use an official Python image as a parent image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the application files into the container
COPY . /app/

# Install any necessary dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose necessary ports
EXPOSE 8080 9090 3306

# Run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
