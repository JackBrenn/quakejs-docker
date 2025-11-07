#!/bin/sh

cd /var/www/html

sed -i "s/'quakejs:/window.location.hostname + ':/g" index.html
sed -i "s/':80'/':${HTTP_PORT}'/g" index.html

# Start Apache in the background as non-root user
/usr/sbin/apache2ctl -D FOREGROUND &

cd /quakejs

# Start the Quake server
node build/ioq3ded.js +set fs_game baseq3 +set dedicated 1 +exec server.cfg