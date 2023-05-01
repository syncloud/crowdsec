#!/bin/bash -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )
LIBS=$(echo ${DIR}/lib/*-linux-gnu*)
LIBS=$LIBS:$(echo ${DIR}/opt/java/openjdk/lib)
${DIR}/lib/*-linux*/ld-*.so* --library-path $LIBS ${DIR}/opt/java/openjdk/bin/java "$@"