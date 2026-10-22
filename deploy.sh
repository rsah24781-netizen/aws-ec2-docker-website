#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="aws-ec2-website:v1"
CONTAINER_NAME="aws-ec2-website"
HOST_PORT="${HOST_PORT:-8080}"

echo "==> Building Docker image..."
docker build -t "$IMAGE_NAME" .

echo "==> Removing old container if it exists..."
if docker ps -a --format '{{.Names}}' | grep -qx "$CONTAINER_NAME"; then
  docker rm -f "$CONTAINER_NAME"
fi

echo "==> Starting website container..."
docker run -d --restart unless-stopped \
  --name "$CONTAINER_NAME" \
  -p "${HOST_PORT}:80" \
  "$IMAGE_NAME"

echo "==> Container status:"
docker ps --filter "name=$CONTAINER_NAME"

echo "==> Local HTTP test:"
curl --fail --show-error "http://localhost:${HOST_PORT}/" >/dev/null
echo "Website responded successfully on port ${HOST_PORT}."
