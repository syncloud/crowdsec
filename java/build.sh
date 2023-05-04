#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
ARCH=$1
BUILD_DIR=${DIR}/../build/snap
wget https://github.com/adoptium/temurin19-binaries/releases/download/jdk-19.0.2%2B7/OpenJDK19U-jre_${ARCH}_linux_hotspot_19.0.2_7.tar.gz -O jre.tar.gz
tar xf jre.tar.gz
mkdir -p ${BUILD_DIR}
mv jdk* ${BUILD_DIR}/java
