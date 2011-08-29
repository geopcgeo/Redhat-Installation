#!/bin/sh
#This script is used to edit default DocumentRoot path
#var1=/var/www
application_apache_default_documentroot=$1
application_apache_current_documentroot=$2
virtualhostconf=$3
#var2=/var/www/html/edge.devl.medigy.com/medigy-drupal/public_site/
sed -i "s%${application_apache_default_documentroot}%${application_apache_current_documentroot}%" %$virtualhostconf
echo Result: $?
