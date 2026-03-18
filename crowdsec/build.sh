#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
BUILD_DIR=${DIR}/../build/snap/crowdsec

ln -sf /staging/etc/crowdsec /etc/crowdsec
mkdir -p /var/snap/crowdsec/current/config
ln -sf /staging/etc/crowdsec /var/snap/crowdsec/current/config/crowdsec
sed -i 's#/etc/crowdsec#/var/snap/crowdsec/current/config/crowdsec#g' /staging/etc/crowdsec/config.yaml
rm -rf /staging/etc/crowdsec/parsers
rm -rf /staging/etc/crowdsec/scenarios
rm -rf /staging/etc/crowdsec/collections
rm -rf /staging/etc/crowdsec/hub/*
cscli hub update
cscli hub upgrade
cscli collections install crowdsecurity/linux
cscli collections install crowdsecurity/dovecot
cscli collections install crowdsecurity/postfix
cscli collections install crowdsecurity/nginx

mkdir -p ${BUILD_DIR}/usr/local
cp -a /staging ${BUILD_DIR}/
cp -a /usr/local/bin ${BUILD_DIR}/usr/local/
cp -a /usr/local/lib ${BUILD_DIR}/usr/local/ 2>/dev/null || true
cp -a /lib ${BUILD_DIR}/ 2>/dev/null || true
cp -a /usr/lib ${BUILD_DIR}/usr/ 2>/dev/null || true

du -sh ${BUILD_DIR}
ls -la ${BUILD_DIR}/staging/etc/crowdsec/collections
