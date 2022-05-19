other_host=$(head -n 1 /etc/otherhost)

openrsync --archive --rsync-path 'openrsync' $other_host:/home/$USER/Maildir /home/$USER/
case "$?" in
 0) [ -e /tmp/mail_failures_$USER ] && rm /tmp/mail_failures_$USER ;;
 *) echo 'Failed' >> /tmp/mail_failures_$USER ;;
esac
