other_host=$(head -n 1 /etc/otherhost)

if [ -e /tmp/mail_failures_me ]
then
    if [ ! -e /tmp/mail_failures_master ]
    then
        touch /tmp/mail_failures_master
        sendmail "master@sergeypetrunin.com" <<EOF
subject: Sync failed with ${other_host}
from:master@sergeypetrunin.com

Sync failed with ${other_host}
EOF
    fi
else
    if [ -e /tmp/mail_failures_master ]
    then
        rm /tmp/mail_failures_master
        sendmail "master@sergeypetrunin.com" <<EOF
subject: Sync now works with ${other_host}
from:master@sergeypetrunin.com

Sync now works with ${other_host}
EOF
    fi
fi
