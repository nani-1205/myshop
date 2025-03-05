# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy the entrypoint script and preserve execution permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install necessary dependencies including Python
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create a symlink so that 'python' command works
RUN ln -s /usr/bin/python3 /usr/bin/python

# Expose required ports (modify as needed)
EXPOSE 8080 9090 3306

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Default command (can be overridden)
CMD ["bash"]
