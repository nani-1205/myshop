# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy the entrypoint script and preserve execution permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# (Optional) If your script requires specific dependencies, install them
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Default command (can be overridden)
CMD ["bash"]
