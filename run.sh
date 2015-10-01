#!/bin/bash

if [ -n "${CASSANDRA_PORT_9160_TCP_ADDR}" ]; then
  cat >> ${TITAN_PROPERTIES} <<EOL
storage.backend=cassandra
storage.hostname=${CASSANDRA_PORT_9160_TCP_ADDR}
EOL

if [ -n "${ELASTICSEARCH_PORT_9300_TCP_ADDR}" ]; then
  cat >> ${TITAN_PROPERTIES} <<EOL
index.search.backend=elasticsearch
index.search.elasticsearch.client-only=true
index.search.hostname=${ELASTICSEARCH_PORT_9300_TCP_ADDR}
EOL

cat > ${TITAN_HOME}/init.groovy <<EOL
g = TitanFactory.open("${TITAN_PROPERITES}")
println "The graph g was opened using ${TITAN_PROPERTIES}"
EOL

exec ${TITAN_HOME}/bin/gremlin.sh ${TITAN_HOME}/init.groovy

