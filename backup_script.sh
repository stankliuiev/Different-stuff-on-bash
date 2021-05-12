#!/bin/sh
#backup script for couple config files
TODAY=`date +%Y%m%d%H%M`
DIRLISTTAR="/home/varg/tar"
DESTDIR="/home/varg/Documents/backup_test/"
REMOTE_BACKUP_STORAGE="backup_test_vadzim@212.237.61.100:/home/home/backup_test_vadzim/"

#lets tar this shit
tar --numeric-owner -czpf "$DESTDIR/$TODAY.tgz" --files-from=$DIRLISTTAR 2>&1 >/dev/null

#yay lets go travel with rsync
rsync -avPh -e '-i /home/varg/.ssh/id_rsa' $DESTDIR $REMOTE_BACKUP_STORAGE

#clean tar shit
rm -f $DESTDIR/*
