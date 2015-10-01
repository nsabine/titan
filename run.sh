#!/bin/bash

if [ $(ls /conf|wc -l) = 0 ]; then
  cp -r ${TITAN_HOME}/conf/* /conf
fi

if [ -n "${CASSANDRA_PORT_9160_TCP_ADDR}" ]; then
  cat >> ${TITAN_PROPERTIES} <<END
storage.backend=cassandra
storage.hostname=${CASSANDRA_PORT_9160_TCP_ADDR}
END

if [ -n "${ELASTICSEARCH_PORT_9300_TCP_ADDR}" ]; then
  cat >> ${TITAN_PROPERTIES} <<END
index.search.backend=elasticsearch
index.search.elasticsearch.client-only=true
index.search.hostname=${ELASTICSEARCH_PORT_9300_TCP_ADDR}
END

cat > ${TITAN_HOME}/init.groovy <<END
g = TitanFactory.open("${TITAN_PROPERITES}")
println "The graph \'g\' was opened using ${TITAN_PROPERTIES}"
END

exec ${TITAN_HOME}/bin/gremlin.sh ${TITAN_HOME}/init.groovy"

