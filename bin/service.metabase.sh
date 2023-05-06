#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

export MB_DB_TYPE=h2
export MB_DB_FILE=/var/snap/crowdsec/current/metabase.db
export PATH=$PATH:${DIR}/java/bin
exec ${DIR}/java/bin/java -jar /snap/crowdsec/current/metabase/metabase.jar
