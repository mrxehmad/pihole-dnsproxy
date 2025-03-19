# Use dynamic Pi-hole version
ARG PIHOLE_VERSION=latest
FROM pihole/pihole:${PIHOLE_VERSION}

# Use dynamic DNSProxy version
ARG DNSPROXY_VERSION=v0.75.1

# Install required packages
RUN apk add --no-cache wget tar \
    && wget -O /tmp/dnsproxy.tar.gz https://github.com/AdguardTeam/dnsproxy/releases/download/${DNSPROXY_VERSION}/dnsproxy-linux-amd64-${DNSPROXY_VERSION}.tar.gz \
    && tar -xzf /tmp/dnsproxy.tar.gz -C /tmp/ \
    && mv /tmp/linux-amd64/dnsproxy /usr/local/bin/dnsproxy \
    && rm -f /tmp/dnsproxy.tar.gz \
    && chmod +x /usr/local/bin/dnsproxy

# Download Pi-hole start script
RUN wget -O /start.sh https://raw.githubusercontent.com/pi-hole/docker-pi-hole/refs/heads/master/src/start.sh

# Create directory for dnsproxy config
RUN mkdir -p /etc/dnsproxy

# Copy configuration files
COPY dnsproxy.conf /etc/dnsproxy/dnsproxy.conf
COPY dnsproxy-run.sh /dnsproxy-run.sh
RUN chmod +x /dnsproxy-run.sh /start.sh

# Clean up unnecessary packages
RUN apk del wget tar

# Entrypoint
ENTRYPOINT ["/dnsproxy-run.sh"]