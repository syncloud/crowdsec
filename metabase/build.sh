#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}

VERSION=$1

BUILD_DIR=${DIR}/../build/snap/metabase
mkdir -p $BUILD_DIR

cd ${BUILD_DIR}
wget https://downloads.metabase.com/v$VERSION/metabase.jar

wget https://crowdsec-statics-assets.s3-eu-west-1.amazonaws.com/metabase_sqlite.zip
unzip metabase_sqlite.zip
rm metabase_sqlite.zip

cd $DIR
H2=1.4.199
wget https://repo1.maven.org/maven2/com/h2database/h2/$H2/h2-$H2.jar
apk add openjdk8
java -jar h2-$H2.jar -webAllowOthers -tcpAllowOthers &
java -cp h2-$H2.jar org.h2.tools.Shell -url "jdbc:h2:tcp://localhost/$BUILD_DIR/metabase.db/metabase.db" -sql "update METABASE_DATABASE set details = '{\"db\":\"/var/snap/crowdsec/current/crowdsec.db\"}'"
kill $(jobs -p)

