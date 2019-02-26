Multipath
apt install multipath-tools
##install disk-detect/multipath/enable=true
yum install device-mapper-multipath
systemctl enable multipathd
systemctl start multipathd


###kurulum tamamlandıktan sonra görüntülemek için,
multipath -ll


###Disk eklemek için


multipaths {
        multipath {
                uid 0
                gid 0
                wwid "DISK UID EKLEYECEKSINIZ"
                mode 0600
                alias disk
        }
}
systemctl restart multipathd
