#!/bin/bash
#wrote by Stan Kliuiev 2022.10.14
#the owner:group of this file must be postgres 
#set -x
#Replace pgsql_DATADIR  with your actual psql datadir location

PIDFILE=/tmp/backup.pid
#DIR=`date +%F_%H-%M`;
DIR=`date +%F`;

if [ -f $PIDFILE ]; then
                if pgrep -F $PIDFILE &>/dev/null; then
                        exit 1
                        else echo $$ > $PIDFILE
                fi
        else echo $$ > $PIDFILE
fi

#simple rotation part, it will remove directories with backups that are older than 10 days.
/usr/bin/find /var/lib/pgsql/12/backup/ -type d -ctime +4 -exec rm -rf {} \;

mkdir /var/lib/pgsql/backups/$DIR;

pg_basebackup -Ft -z -v -D /var/lib/pgsql_DATADIR/backups/$DIR

#Syn to remote host or vault
#rsync -av /var/lib/pgsql/backups/ backupnode:/backups/ --bwlimit=5M

#backups list for nrpe check
ls -lAt /var/lib/pgsql/12/backups/ | awk '{print $9}'|grep -v '^$' | grep ^20 > /tmp/backup.txt


rm -f $PIDFILE
