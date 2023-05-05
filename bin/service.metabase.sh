#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

export MB_DB_TYPE=h2
export MB_DB_FILE=/var/snap/crowdsec/current/metabase.db/metabase.db
exec ${DIR}/java/bin/java -jar metabase.jar