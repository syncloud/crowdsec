#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

export MB_DB_TYPE=h2
export MB_DB_FILE=/var/snap/crowdsec/current/metabase.db
export MB_LDAP_ENABLED=true
export MB_LDAP_HOST=localhost
export MB_LDAP_BIND_DN="cn=admin,dc=syncloud,dc=org"
export MB_LDAP_PASSWORD=syncloud
export MB_LDAP_USER_BASE="ou=users,dc=syncloud,dc=org"
export MB_LDAP_USER_FILTER="(&(objectClass=inetOrgPerson)(cn={login}))"
export MB_JETTY_PORT=3001
export PATH=$PATH:${DIR}/java/bin
exec ${DIR}/java/bin/java -jar /snap/crowdsec/current/metabase/metabase.jar
