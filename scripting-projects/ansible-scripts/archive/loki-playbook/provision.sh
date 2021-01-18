#!/bin/bash

# Manage Debian/ Ubuntu environments
elif [ -f /etc/debian_version ] ; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt isntall -y python python-apt
fi