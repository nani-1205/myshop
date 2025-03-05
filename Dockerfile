FROM python:3.9-alpine3.19

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install system dependencies (only necessary ones)
RUN apk add --no-cache libjpeg-turbo-dev zlib-dev

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy project files
COPY . /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set proper permissions
RUN chown -R appuser:appgroup /app
USER appuser

# Expose port
EXPOSE 8000

# Use entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
