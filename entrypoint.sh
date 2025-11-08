#!/bin/bash
set -e

# Create nginx temp directories at runtime
mkdir -p /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp

cd /home/quakejs/www

sed -i "s/'quakejs:/window.location.hostname + ':/g" index.html
sed -i "s/':80'/':${HTTP_PORT:-8080}'/g" index.html

# Start Nginx web server
echo "Starting web server on port 8080..."
nginx -c /etc/nginx/nginx.conf

# Give nginx time to start
sleep 1

# Verify nginx started by checking if it's listening on port 8080
if ! nc -z localhost 8080 2>/dev/null && ! curl -s http://localhost:8080 >/dev/null 2>&1; then
    echo "ERROR: Web server failed to start!"
    exit 1
fi

cd /quakejs

echo "Starting QuakeJS server..."
exec node build/ioq3ded.js +set fs_game baseq3 +set dedicated 1 +exec server.cfg
