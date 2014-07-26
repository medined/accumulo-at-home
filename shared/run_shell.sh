#!/bin/bash
sudo DOCKER_HOST=$DOCKER_HOST docker run --name A --volumes-from=accumulo-at-home.shared -i -t ubuntu:14.04 /bin/bash
