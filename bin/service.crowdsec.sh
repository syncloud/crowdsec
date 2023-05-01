#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

/bin/rm -f /var/snap/crowdsec/common/web.socket
exec ${DIR}/crowdsec/usr/local/bin/crowdsec -c /var/snap/crowdsec/current/config/crowdsec.yaml
