#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
VERSION=$1
BUILD_DIR=${DIR}/../build/snap/java
while ! docker create --name=java eclipse-temurin:$VERSION-jre; do
  sleep 1
  echo "retry docker"
done
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
docker export java -o app.tar
tar xf app.tar
rm -rf app.tar
cp ${DIR}/java.sh ${BUILD_DIR}/bin/
