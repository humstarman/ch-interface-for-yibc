#!/bin/bash
IP=${1:-127.0.0.1}
if [ ! -x "$(command -v ip)" ]; then
  echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - [ERROR] - no ip command found !!!"
  exit 1
fi
INTERFACE=$(ip addr | grep $IP)
INTERFACE=${INTERFACE##*' '}
SED=/etc/systemd/system/flanneld.service.sed
SVC=/etc/systemd/system/flanneld.service
yes | cp $SED $SVC
sed -i s?"{{.interface}}"?"${INTERFACE}"?g $SVC 
