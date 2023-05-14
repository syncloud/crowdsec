#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
VERSION=$1
BUILD_DIR=${DIR}/../build/snap/crowdsec
while ! docker version ; do
  sleep 1
  echo "retry docker"
done
docker build --build-arg VERSION=$VERSION -t crowdsec .
docker create --name=crowdsec crowdsec
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
docker export crowdsec -o crowdsec.tar
tar xf crowdsec.tar
rm -rf crowdsec.tar

ls -la /staging/etc/crowdsec/collections