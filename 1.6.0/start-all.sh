#!/bin/bash

source ./start-hadoop.sh
source ./start-zookeeper.sh

echo "Pausing 60 seconds to give Hadoop time to come out of safe mode."
sleep 60

source ./start-accumulo.sh
