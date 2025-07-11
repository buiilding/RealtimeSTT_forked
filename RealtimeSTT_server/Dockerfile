FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    libasound2-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the RealtimeSTT library
COPY ../RealtimeSTT /app/RealtimeSTT/

# Copy the server code
COPY . /app/RealtimeSTT_server/

# Set Python path
ENV PYTHONPATH="${PYTHONPATH}:/app"

# Expose ports
EXPOSE 8011 8012

# Run the server
CMD ["python3", "-m", "RealtimeSTT_server.stt_server", "--model", "base.en", "--language", "en"] 