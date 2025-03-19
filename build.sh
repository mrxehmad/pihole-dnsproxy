# Read versions from versions.json
VERSION=$(jq -r '.version' versions.json)
DNSPROXY_VERSION=$(jq -r '.dnsproxy' versions.json)
PIHOLE_VERSION=$(jq -r '.pihole' versions.json)

# Build and push for multiple architectures
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --tag xehmad/pihole-dnsproxy:$VERSION \
  --build-arg DNSPROXY_VERSION=$DNSPROXY_VERSION \
  --build-arg PIHOLE_VERSION=$PIHOLE_VERSION \
  --push .