#!/bin/bash

set -e

# create replication user

mysql_net=$(ip route | awk '$1=="default" {print $3}' | sed "s/\.[0-9]\+$/.%/g")

mysql -u root -p${MYSQL_ROOT_PASSWORD} \
-e "GRANT REPLICATION SLAVE ON *.* TO 'backup'@'${mysql_net}' IDENTIFIED BY 'mytest';"
