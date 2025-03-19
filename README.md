Here’s the updated `README.md` with added details about DNSProxy's support for **DoH (DNS-over-HTTPS)**, **DoT (DNS-over-TLS)**, **DNSCrypt**, and other advanced DNS protocols. I’ve also emphasized these features in the description and usage sections.

---

# Docker Pi-hole with DNSProxy

This project builds a custom Docker image that integrates [Pi-hole](https://pi-hole.net/) with [AdGuard DNSProxy](https://github.com/AdguardTeam/dnsProxy). It supports **multi-architecture builds** for **x86, x64, ARM64, and ARMv7**, and automatically updates based on version changes in `versions.json`.

DNSProxy enhances Pi-hole by adding support for modern DNS protocols like **DoH (DNS-over-HTTPS)**, **DoT (DNS-over-TLS)**, **DNSCrypt**, and more, ensuring secure and private DNS resolution while maintaining Pi-hole's ad-blocking capabilities.

## Features
- **Pi-hole + DNSProxy Integration**: Block ads and trackers while leveraging advanced DNS protocols.
- **Support for Modern DNS Protocols**:
  - **DoH (DNS-over-HTTPS)**: Secure DNS queries over HTTPS.
  - **DoT (DNS-over-TLS)**: Encrypt DNS traffic using TLS.
  - **DNSCrypt**: Prevent DNS spoofing and ensure privacy.
  - **Custom Upstream Servers**: Route DNS queries to trusted upstream servers.
- **Multi-architecture Support**: Built for **x86, x64, ARM64, and ARMv7** architectures.
- **Automated Versioning**: Update Pi-hole and DNSProxy versions via `versions.json`.
- **CI/CD with GitHub Actions**: Automatically build and push Docker images to Docker Hub.
- **Automated GitHub Releases**: Create new releases when versions are updated.

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
Build the Docker image locally using the provided script:
```bash
./build.sh
```

#### Run the Container
Run the container with the necessary ports and environment variables:
```bash
docker run -d \
  --name pihole-dnsproxy \
  -p 53:53/udp -p 53:53/tcp \
  -p 443:443/tcp -p 443:443/udp \
  -e FTLCONF_webserver_api_password="YourPassword" \
  -e FTLCONF_dns_upstreams="127.0.0.1#5053" \
  overkill5234/pihole-dnsproxy:latest
```

> [!NOTE]  
> Ensure you set the upstream DNS in Pi-hole to point to DNSProxy (default: `127.0.0.1#5053` or the port configured in `dnsproxy.conf`).

### 4. Configure DNSProxy
Edit the `dnsproxy.conf` file to customize DNSProxy settings, such as enabling **DoH**, **DoT**, or **DNSCrypt**. Example configuration:
```ini
listen=0.0.0.0:5053
upstream=https://dns.google/dns-query # DoH
upstream=tls://dns.quad9.net # DoT
dnscrypt=sdns://example-dnscrypt-server
```

> [!TIP]  
> You can mount `dnsproxy.conf` to the host to make it persistent and tailored to your needs:
```bash
-v /path/to/dnsproxy.conf:/etc/dnsproxy/dnsproxy.conf:ro
```

### 5. Advanced DNS Features
DNSProxy supports the following advanced DNS protocols:
- **DoH (DNS-over-HTTPS)**: Encrypt DNS queries over HTTPS using upstream servers like Cloudflare (`https://cloudflare-dns.com/dns-query`) or Google (`https://dns.google/dns-query`).
- **DoT (DNS-over-TLS)**: Secure DNS queries using TLS with upstream servers like Quad9 (`tls://dns.quad9.net`).
- **DNSCrypt**: Protect against DNS spoofing and eavesdropping with DNSCrypt-enabled servers.
- **Fallback Servers**: Configure multiple upstream servers for redundancy and reliability.

Example `dnsproxy.conf` for advanced use cases:
```ini
listen=0.0.0.0:5053
upstream=https://cloudflare-dns.com/dns-query # DoH
upstream=tls://dns.quad9.net # DoT
dnscrypt=sdns://example-dnscrypt-server
fallback=https://dns.google/dns-query
```

### 6. Automated CI/CD
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