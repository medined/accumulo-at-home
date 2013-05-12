#!/bin/bash

source ./setup.sh
source ./stop-accumulo.sh

export MY_ACCUMULO_VERSION=1.4.3

# Do not delete the code in $BASE_DIR/software/accumulo; that's where you made changes.

# Do not delete the binary directory, we'll just overlay new files on top so 
# configuration, lib/ext, and walogs are not affected.

# Do not connect to apache and download code. We'll use the code that we have.

# Accumulo is downloaded into a software directory and then installed
# into a bin directory.

pushd $BASE_DIR/software/accumulo-$MY_ACCUMULO_VERSION; mvn -DskipTests package && mvn assembly:single -N; popd
echo "Compiled accumulo"

tar xfz $BASE_DIR/software/accumulo-$MY_ACCUMULO_VERSION/target/accumulo-$MY_ACCUMULO_VERSION-dist.tar.gz -C $BASE_DIR/bin

# Do not compile the native libraries that has probably already been done.

# No need to futz with the symbolic link

# lib/ext, logs, and walogs already exist.

# The configurations are unchanged.

# We are not re-initializing.

