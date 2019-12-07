#!/bin/bash

if [ $1 == "kafka-server" ]; then
    echo "Starting Server"

    echo "Create ENVS"
    python3 /parse_envs.py

    echo "Server Configurations"
    echo $KAFKA_HOME/config/server-generated.properties
    cat $KAFKA_HOME/config/server-generated.properties
    sh $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-generated.properties
else
    exec $@
fi