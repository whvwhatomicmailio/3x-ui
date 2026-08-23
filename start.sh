#!/bin/bash
set -e
PORT=${PORT:-8080}

# مخفی کردن کامل کادر وضعیت سرور (CPU,RAM,Swap,Disk)
INDEX=$(find /usr/local/x-ui -name "index.html" | head -n1)
if [ -f "$INDEX" ]; then
  # پاک کردن استایل قبلی اگه بود
  sed -i '/server-status-hide/d' "$INDEX" || true
  # تزریق استایل جدید که کل ردیف اول رو مخفی کنه
  sed -i 's|</head>|<style id="server-status-hide">div.ant-row:first-of-type{display:none!important}</style></head>|' "$INDEX"
fi

mkdir -p /etc/x-ui
/usr/local/x-ui/x-ui setting -port $PORT -username 2053 -password 2053 > /dev/null 2>&1 || true

exec /usr/local/x-ui/x-ui
