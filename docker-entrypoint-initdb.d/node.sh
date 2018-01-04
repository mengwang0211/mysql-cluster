#!/bin/bash

set -e

mysql_net=$(ip route | awk '$1=="default" {print $3}' | sed "s/\.[0-9]\+$/.%/g")

# check mysql master run status

until mysql -u root -h mysql_master -pmytest; do
  >&2 echo "MySQL master is unavailable - sleeping"
  sleep 3
done

# get master log File & Position

master_status_info=$(mysql -u root -pmytest -h mysql_master -e "show master status\G")

LOG_FILE=$(echo "${master_status_info}" | awk 'NR!=1 && $1=="File:" {print $2}')

LOG_POS=$(echo "${master_status_info}" | awk 'NR!=1 && $1=="Position:" {print $2}')

# set node master

mysql -u root -pmytest \
-e "CHANGE MASTER TO MASTER_HOST='mysql_master', \
MASTER_USER='backup', \
MASTER_PASSWORD='mytest', \
MASTER_LOG_FILE='${LOG_FILE}', \
MASTER_LOG_POS=${LOG_POS};"

# start slave and show slave status

mysql -u root -pmytest -e "START SLAVE;show slave status\G"
