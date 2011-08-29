#!/bin/sh
#This script is used to change the ownership of a folder recursively
username=$1
sudo chown -R %$username /var/www/html/edge.devl.medigy.com/