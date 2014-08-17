#!/bin/bash

export BASE_DIR=$HOME/accumulo_home

export ACCUMULO_HOME=$BASE_DIR/bin/accumulo
export HADOOP_PREFIX=$BASE_DIR/bin/hadoop
export ZOOKEEPER_HOME=$BASE_DIR/bin/zookeeper

if [ -d /usr/lib/jvm/java-6-openjdk ];
then
  # Ubuntu 10.04 (and perhaps others)
  JAVA_HOME=/usr/lib/jvm/java-6-openjdk
  echo "$0: Set java home to java 6 openjdk"
fi
if [ -d /usr/lib/jvm/java-6-openjdk-i386 ];
then
  JAVA_HOME=/usr/lib/jvm/java-6-openjdk-i386
  echo "$0: Set java home to java 6 openjdk-i386"
fi
if [ -d /usr/lib/jvm/java-7-openjdk-amd64 ];
then
  JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
  echo "$0: Set java home to java 7 openjdk"
fi
if [ "$JAVA_HOME" == "" ];
then
  echo "$0: UNABLE TO SET JAVA_HOME!"
  exit 1
fi

export HADOOP_VERSION=hadoop-1.0.4
export ZOOKEEPER_VERSION=zookeeper-3.4.3
export LOGFILE=$HOME/build.log
export PASSWORD=`openssl passwd -1 password`

pathmunge () {
        if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              PATH=$PATH:$1
           else
              PATH=$1:$PATH
           fi
        fi
}
pathmunge $JAVA_HOME/bin
pathmunge $HADOOP_HOME/bin
pathmunge $ZOOKEEPER_HOME/bin
pathmunge $ACCUMULO_HOME/bin

mkdir -p $BASE_DIR/software $BASE_DIR/data $BASE_DIR/bin
