#!/bin/bash

source ./setup.sh
source ./stop-all.sh

export MY_ACCUMULO_VERSION=1.6.0

rm -rf $BASE_DIR/software/accumulo-$MY_ACCUMULO_VERSION
rm -rf $BASE_DIR/bin/accumulo-$MY_ACCUMULO_VERSION

echo "Connecting to apache.org. Please be patient..."

# Accumulo is downloaded into a software directory and then installed
# into a bin directory.

LOCAL_TAR=/tmp/accumulo-$MY_ACCUMULO_VERSION.tar.gz
wget http://apache.mirrors.tds.net/accumulo/1.6.0/accumulo-1.6.0-bin.tar.gz $LOCAL_TAR
pushd $BASE_DIR/bin; tar xzf $LOCAL_TAR; rm $LOCAL_TAR popd

# remove symbolic link and then create it.
rm -rf $BASE_DIR/bin/accumulo
ln -s $BASE_DIR/bin/accumulo-$MY_ACCUMULO_VERSION $BASE_DIR/bin/accumulo

mkdir -p $BASE_DIR/bin/accumulo/lib/ext
mkdir -p $BASE_DIR/bin/accumulo/logs
mkdir -p $BASE_DIR/bin/accumulo/walogs

echo "Created ext, logs, and walogs directory."

cp $BASE_DIR/bin/accumulo/conf/examples/512MB/standalone/* $BASE_DIR/bin/accumulo/conf
cp accumulo-site.xml $BASE_DIR/bin/accumulo/conf/accumulo-site.xml
cp accumulo-env.sh $BASE_DIR/bin/accumulo/conf/accumulo-env.sh
hostname -f > $BASE_DIR/bin/accumulo/conf/gc
hostname -f > $BASE_DIR/bin/accumulo/conf/masters
hostname -f > $BASE_DIR/bin/accumulo/conf/monitor
hostname -f > $BASE_DIR/bin/accumulo/conf/slaves
hostname -f > $BASE_DIR/bin/accumulo/conf/tracers

./start-hadoop.sh
./start-zookeeper.sh

echo "Pausing 60 seconds to give Hadoop time to come out of safe mode."
sleep 60

echo "initializing accumulo"
$BASE_DIR/bin/hadoop/bin/hadoop fs -rmr /user/accumulo/accumulo
$BASE_DIR/bin/accumulo/bin/accumulo init 

./stop-hadoop.sh
./stop-zookeeper.sh
