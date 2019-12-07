#!/bin/bash

case $1 in
    "server")
        echo "Starting Server"

        echo "Creating kafka log.dir"
        mkdir -p ${KAFKA_LOG_DIR}

        echo "Create ENVS"
        python3 /parse_envs.py

        echo "Server Configurations"
        echo $KAFKA_HOME/config/server-generated.properties
        cat $KAFKA_HOME/config/server-generated.properties
        sh $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-generated.properties
        ;;
    *)
        exec $@
        ;;
esac
