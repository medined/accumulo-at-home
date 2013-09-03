[![Clone in Koding](http://kbutton.org/clone.png)](http://kbutton.org/user/project)

accumulo-at-home
================

Installs hadoop, zookeeper, and accumulo to $HOME/accumulo_home/bin on Ubuntu 10.04

Simply run:

  driver-1.4.2.sh

There are several steps to getting Accumulo working. This set of scripts is my attempt to provide a working accumulo environment in my home directory. This lets you play with any aspect of the software without needing sudo to change configurations or futzing with different accounts.

The script uses 'jps' to kill existing processes. So, a word of caution. This set of scripts has only been used inside an Ubuntu 10.04 virtual machine with a single user.
