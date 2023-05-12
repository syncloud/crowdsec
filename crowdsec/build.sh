#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
VERSION=$1
BUILD_DIR=${DIR}/../build/snap/crowdsec
while ! docker build --build-arg VERSION=$VERSION -t crowdsec . ; do
  sleep 1
  echo "retry docker"
done
docker create --name=crowdsec crowdsec
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
docker export crowdsec -o crowdsec.tar
tar xf crowdsec.tar
rm -rf crowdsec.tar
