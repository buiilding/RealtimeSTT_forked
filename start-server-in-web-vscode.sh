#!/bin/bash

# Start RealtimeSTT Server in Web VS Code Environment
# This script runs the server and exposes it via port forwarding

echo "🚀 Starting RealtimeSTT Server in Web VS Code..."

# Install dependencies if needed
echo "📦 Installing dependencies..."
pip install -r requirements.txt

# Start the server with external binding
echo "🔧 Starting server on 0.0.0.0:8011 and 0.0.0.0:8012..."
python3 -m RealtimeSTT_server.stt_server \
    --model base.en \
    --language en \
    --control 8011 \
    --data 8012 \
    --device cpu

echo "✅ Server started!"
echo ""
echo "📋 Your server is now running on:"
echo "   - Control WebSocket: ws://0.0.0.0:8011"
echo "   - Data WebSocket: ws://0.0.0.0:8012"
echo ""
echo "🔗 In your web VS Code, you should see port forwarding options for:"
echo "   - Port 8011 (Control)"
echo "   - Port 8012 (Data)"
echo ""
echo "📱 Use the k8s-client.html file on your laptop to connect!" 