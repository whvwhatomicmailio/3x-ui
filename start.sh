#!/bin/bash
set -e
export PORT=${PORT:-8080}
DOMAIN=${RAILWAY_PUBLIC_DOMAIN:-localhost}

echo "🚀 Starting 3x-ui v2.9.0 on $DOMAIN:$PORT"
mkdir -p /etc/x-ui

cat > /etc/x-ui/config.json <<EOF
{
  "webPort": $PORT,
  "webBasePath": "/",
  "webListen": "0.0.0.0"
}
EOF

cd /usr/local/x-ui
./x-ui > /tmp/x-ui.log 2>&1 &
PID=$!
sleep 6

echo "Setting login to 2053 / 2053..."
./x-ui setting -username 2053 -password 2053 > /dev/null 2>&1 || true

if [ -f /etc/x-ui/x-ui.db ]; then
  sqlite3 /etc/x-ui/x-ui.db "UPDATE settings SET value='https://$DOMAIN' WHERE key='subDomain';" || true
  sqlite3 /etc/x-ui/x-ui.db "UPDATE settings SET value='/sub/' WHERE key='subURI';" || true
  sqlite3 /etc/x-ui/x-ui.db "UPDATE settings SET value='' WHERE key='subPort';" || true
  sqlite3 /etc/x-ui/x-ui.db "UPDATE settings SET value='1' WHERE key='subEnable';" || true
fi

kill $PID
sleep 2
exec ./x-ui
