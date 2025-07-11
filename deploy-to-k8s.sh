#!/bin/bash

# RealtimeSTT Kubernetes Deployment Script
# This script helps deploy the RealtimeSTT server to Kubernetes

set -e

echo "🚀 Deploying RealtimeSTT Server to Kubernetes..."

# Configuration
IMAGE_NAME="realtimestt-server"
IMAGE_TAG="latest"
REGISTRY=""  # Set your container registry here (e.g., "your-registry.com/")

# Build the Docker image
echo "📦 Building Docker image..."
docker build -f RealtimeSTT_server/Dockerfile -t ${REGISTRY}${IMAGE_NAME}:${IMAGE_TAG} .

# If you have a container registry, push the image
if [ ! -z "$REGISTRY" ]; then
    echo "📤 Pushing image to registry..."
    docker push ${REGISTRY}${IMAGE_NAME}:${IMAGE_TAG}
fi

# Update the Kubernetes deployment with the correct image name
echo "🔧 Updating Kubernetes configuration..."
sed -i "s|image: realtimestt:latest|image: ${REGISTRY}${IMAGE_NAME}:${IMAGE_TAG}|g" k8s-deployment.yaml

# Apply the Kubernetes configuration
echo "⚙️  Applying Kubernetes configuration..."
kubectl apply -f k8s-deployment.yaml

# Wait for deployment to be ready
echo "⏳ Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/realtimestt-server

# Get the service information
echo "📋 Service information:"
kubectl get service realtimestt-service

# Get the pod information
echo "📋 Pod information:"
kubectl get pods -l app=realtimestt-server

echo "✅ Deployment complete!"
echo ""
echo "🔗 To access the service:"
echo "   - Control WebSocket: ws://your-cluster-ip:8011"
echo "   - Data WebSocket: ws://your-cluster-ip:8012"
echo ""
echo "🌐 To expose the service externally, you can:"
echo "   1. Use kubectl port-forward:"
echo "      kubectl port-forward service/realtimestt-service 8011:8011 8012:8012"
echo "   2. Or configure an Ingress with WebSocket support"
echo ""
echo "📱 Use the k8s-client.html file to connect to your server" 