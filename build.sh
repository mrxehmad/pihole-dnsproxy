#!/bin/bash
set -e

# Load versions from JSON
DNSPROXY_VERSION=$(jq -r '.dnsproxy' versions.json)
PIHOLE_VERSION=$(jq -r '.pihole' versions.json)

# Define Docker image name
DOCKER_USER="overkill5234"
IMAGE_NAME="pihole-dnsproxy"

# Buildx setup for multi-arch builds
docker buildx create --use || true
docker buildx inspect --bootstrap

# Build and push multi-arch images
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --build-arg DNSPROXY_VERSION=$DNSPROXY_VERSION \
  --build-arg PIHOLE_VERSION=$PIHOLE_VERSION \
  -t $DOCKER_USER/$IMAGE_NAME:$DNSPROXY_VERSION-$PIHOLE_VERSION \
  -t $DOCKER_USER/$IMAGE_NAME:latest \
  --push .
