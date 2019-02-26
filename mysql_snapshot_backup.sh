#!/bin/bash
#ÇAĞRI ERSEN DEN ARAKTIR :)) 
(
  echo "FLUSH TABLES WITH READ LOCK;"
  /sbin/lvcreate -l100%FREE -s -n mysql-yedek /dev/vgdrbd/lvmysql >&2
  echo "UNLOCK tables;"
) | mysql -u r$USER -$PASS

mkdir /yedekler
mount /dev/vg_backup/mysql-yedek /yedekler
tar zcvf - /yedekler | ssh $USER@$HOST "cat > /home/mysqldata.tgz"
umount /yedekler
lvremove -f /dev/vg_backup/mysql-yedek
