openrsync --archive --rsync-path 'openrsync' mail-openbsd-71.sergeypetrunin.com:/home/$USER/Maildir /home/$USER/
case "$?" in
 0) [ -e /tmp/mail_failures_$USER ] && rm /tmp/mail_failures_$USER ;;
 *) echo 'Failed' >> /tmp/mail_failures_$USER ;;
esac
