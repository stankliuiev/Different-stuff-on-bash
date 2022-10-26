#!/bin/bash
#set -x
# this script is collecting time/stat iformation about last backup made by backup_script and paste it to /tmp/backup.txt, which can be read by nrpe, which deside
# to give an alert or not based on age of backup in seconds.
  

latest_backup_date=$(ls -td -- /var/lib/pgsql/12/backups/* | head -n 1);
current=$(date +%s);
last_modified=$(stat -c "%Y" $latest_backup_date);
echo $((current - last_modified)) > /tmp/backup.txt
