#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
BUILD_DIR=${DIR}/../build/snap/nginx
mkdir -p ${BUILD_DIR}
cp -a /bin ${BUILD_DIR}/
cp -a /etc ${BUILD_DIR}/
cp -a /lib ${BUILD_DIR}/
cp -a /usr ${BUILD_DIR}/
cp ${DIR}/nginx.sh ${BUILD_DIR}/bin/
