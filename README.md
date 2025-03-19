# Docker Pi-hole with DNSProxy

This project builds a custom Docker image that integrates [Pi-hole](https://pi-hole.net/) with [AdGuard DNSProxy](https://github.com/AdguardTeam/dnsproxy). It supports multi-architecture builds for **x86, x64, and ARM**, and automatically updates based on version changes in `versions.json`.

## Features
- **Pi-hole + DNSProxy** for enhanced DNS filtering and forwarding.
- **Multi-architecture support** (x86, x64, ARM64, ARMv7).
- **Automated versioning** with `versions.json`.
- **CI/CD with GitHub Actions** to build and push Docker images to Docker Hub.
- **Automated GitHub Releases** when versions are updated.

## Usage
### 1. Clone the Repository
```bash
git clone https://github.com/mrxehmad/pihole-dnsproxy.git
cd pihole-dnsproxy
```

### 2. Modify Versions
Update `versions.json` to change the versions of Pi-hole and DNSProxy.

```json
{
  "dnsproxy": "0.75.1",
  "pihole": "2025.03.0"
}
```


### 3. Build and Run
#### Local Build
```bash
./build.sh
```
#### Run the Container
```bash
docker run -d --name pihole-dnsproxy -p 53:53/udp -p 80:80/tcp overkill5234/pihole-dnsproxy:latest
```

### 4. Automated CI/CD
When you push changes to `versions.json`, GitHub Actions will:
- Build images for all supported architectures.
- Push the images to Docker Hub.
- Create a new GitHub Release with the updated version.

## Docker Hub
The built images are available on [Docker Hub](https://hub.docker.com/r/overkill5234/pihole-dnsproxy).

## GitHub Actions Setup
1. Generate a [Docker Hub Access Token](https://hub.docker.com/settings/security).
2. Add these secrets to your GitHub repository:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username.
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token.

## License
This project is licensed under the MIT License.

---

**Maintainer:** [Ehmad](https://github.com/mrxehmad)