#!/bin/bash
set -e

## Set root password as env. variable ROOT_PASSWORD
## If env variable is not set, set root password as 'admin'
ROOT_PASSWORD=${ROOT_PASSWORD:-admin}
echo "root:$ROOT_PASSWORD" | chpasswd

DATA_BIND=/data/bind
DATA_WEBMIN=/data/webmin

# Create directory /var/run/named
mkdir -m 0775 -p /var/run/named
chown root:users /var/run/named

# Create Bind data directory
mkdir -p ${DATA_BIND}
chmod -R 0775 ${DATA_BIND}
chown -R root:root ${DATA_BIND}

if [ ! -d ${DATA_BIND}/etc ]; then
  mv /etc/bind ${DATA_BIND}/etc
fi
if [ ! -d ${DATA_BIND}/lib ]; then
  mkdir -p ${DATA_BIND}/lib
  chown root:root ${DATA_BIND}/lib
fi

rm -rf /etc/bind
rm -rf /var/lib/bind
ln -sf ${DATA_BIND}/etc /etc/bind
ln -sf ${DATA_BIND}/lib /var/lib/bind

# create bind cache directory
mkdir -p /var/cache/bind
chmod -R 0775 /var/cache/bind
chown root:users /var/cache/bind

# create Webmin data directory
mkdir -p ${DATA_WEBMIN}
chmod -R 0755 ${DATA_WEBMIN}
chown -R root:root ${DATA_WEBMIN}

if [ ! -d ${DATA_WEBMIN}/etc ]; then
  mv /etc/webmin ${DATA_WEBMIN}/etc
fi
rm /etc/webmin -rf
ln -sf ${DATA_WEBMIN}/etc /etc/webmin

# Start bind server
service bind9 start

# Start webmin service
/usr/sbin/service webmin start