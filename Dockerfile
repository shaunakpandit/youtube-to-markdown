# Use a lightweight Python image
FROM python:3.9-slim

# Set environment variables to avoid prompts during builds
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /app

# Install system dependencies required to build PyQt5
# qmake and other build tools come with `qtbase5-dev` and `build-essential`
RUN apt-get update && apt-get install -y --no-install-recommends \
    qtbase5-dev \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the application files to the container
COPY . /app

# Upgrade pip and ensure wheel is installed, then install Python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Expose a port (optional, for future purposes)
EXPOSE 8080

# Set the default command to run the application
CMD ["python", "main.py"]
