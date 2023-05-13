#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

exec ${DIR}/crowdsec/usr/local/bin/crowdsec -c /var/snap/crowdsec/current/config/crowdsec/config.yaml
