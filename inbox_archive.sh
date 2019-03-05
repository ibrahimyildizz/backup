#!/bin/bash

export MAILUSER='mail_adresi_buraya_gelecek'
export LASTYEAR='2018'
export THISYEAR='2019'

#mail alımını ve gönderimini durduruyoruz.
systemctl stop postfix

#dovecot ile yeni bir inbox olusturuyoruz. bu yıl icin
doveadm mailbox create -u ${MAILUSER} archive.${THISYEAR}

#Hesap mailboxlarını listeletiyoruz. Gelmesini bekliyoruz.

export MAILBOXES=`doveadm mailbox list -u ${MAILUSER} 'INBOX.*' | awk -F '.' '{print $2}'`
echo $MAILBOXES

#ilk olarak eski inbox ın adını değiştiriyoruz.
#mailbox ın arşivini yeni inbox a bağlıyoruz.
#sonra aynı mail kutusunu tekrar oluşturuyoruz.
for MAILBOX in ${MAILBOXES}
do
    doveadm mailbox rename -u ${MAILUSER} INBOX.${MAILBOX} archive.${LASTYEAR}.${MAILBOX}
    doveadm mailbox subscribe -u ${MAILUSER} archive.${LASTYEAR}.${MAILBOX}
    doveadm mailbox create -u ${MAILUSER} INBOX.${MAILBOX}
done

#mail kutularını listeliyoruz.
doveadm mailbox list -u ${MAILUSER}

systemctl start postfix
