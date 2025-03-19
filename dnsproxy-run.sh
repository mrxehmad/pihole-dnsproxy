#!/bin/sh

# Start dnsproxy and log output
exec /usr/local/bin/dnsproxy --config-path /etc/dnsproxy/dnsproxy.conf & # >> /var/log/dnsproxy.log 

exec /start.sh &

wait