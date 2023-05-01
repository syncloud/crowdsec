#!/bin/bash -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}

DOWNLOAD_URL=https://github.com/syncloud/3rdparty/releases/download/
VERSION=$1

BUILD_DIR=${DIR}/../build/snap/metabase
mkdir -p $BUILD_DIR

cd ${BUILD_DIR}
wget https://downloads.metabase.com/v$VERSION/metabase.jar

wget https://crowdsec-statics-assets.s3-eu-west-1.amazonaws.com/metabase_sqlite.zip
unzip metabase_sqlite.zip
rm metabase_sqlite.zip
