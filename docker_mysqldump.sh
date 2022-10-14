
#!/bin/sh
#simple mysqldump backup script to backup databases from docker container

DUMPDIR=/your/dump/directory/
mysql="docker exec -t mariadb mysql -uroot --password=yourpass"
mysqldump="docker exec -t mariadb mysqldump -uroot --password=yourpass"
log="/var/dxm.mysqldump/docker_mysqldump.log"

echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log"
cd $DUMPDIR
find "$DUMPDIR" -name '*.sql.gz' -delete
while read line; do $mysqldump --opt --quote-names $line | gzip -c > $line.`date +%F`.sql.gz ; done < $DUMPDIR/databases_to_backup
echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log"
echo "*****************" >> "$log"
exit 0
