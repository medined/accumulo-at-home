#!/bin/bash
sudo DOCKER_HOST=$DOCKER_HOST docker build --rm=true -t medined/accumulo-at-home.shared .
