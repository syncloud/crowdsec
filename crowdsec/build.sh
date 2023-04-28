#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}

BUILD_DIR=${DIR}/../build/snap/crowdsec
while ! docker create --name=crowdsec docker pull crowdsecurity/crowdsec:v1.5.0-rc5; do
  sleep 1
  echo "retry docker"
done
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
docker export crowdsec -o crowdsec.tar
tar xf crowdsec.tar
rm -rf crowdsec.tar
cp ${DIR}/crowdsec ${BUILD_DIR}/bin/
ls -la ${BUILD_DIR}/bin
rm -rf ${BUILD_DIR}/usr/src
