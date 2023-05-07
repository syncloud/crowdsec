#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

MB_DB_TYPE=h2
MB_DB_FILE=/var/snap/crowdsec/current/metabase.db
MB_LDAP_ENABLED=true
MB_LDAP_HOST=localhost
MB_LDAP_BIND_DN="cn=admin,dc=syncloud,dc=org"
MB_LDAP_PASSWORD=syncloud
MB_LDAP_USER_BASE="ou=users,dc=syncloud,dc=org"
MB_LDAP_USER_FILTER="(&(objectClass=inetOrgPerson)(cn={login}))"
export PATH=$PATH:${DIR}/java/bin
exec ${DIR}/java/bin/java -jar /snap/crowdsec/current/metabase/metabase.jar
