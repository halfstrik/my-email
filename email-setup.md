# Setting up personal email
Links:
 * (middle of) https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/

## Set up DKIM (DNS continuation)
```
doas mkdir /etc/mail/dkim
doas openssl genrsa -out /etc/mail/dkim/sergeypetrunin.com.key 1024
doas openssl rsa -in /etc/mail/dkim/sergeypetrunin.com.key -pubout -out /etc/mail/dkim/sergeypetrunin.com.pub

cat /etc/mail/dkim/sergeypetrunin.com.pub
```
Copy this public key to TXT DNS record `yearMMdd._domainkey` like so:
```
"v=DKIM1;k=rsa;p=<key-no-spaces>;"
```

Test:
```
$ dig -t TXT yearMMdd._domainkey.sergeypetrunin.com +short
"v=DKIM1;k=rsa;p=<key-no-spaces>;"
```

## Set up mail users
We are using real OS users for mail
```
doas useradd -m me
doas passwd me

doas useradd -m master
doas passwd master

doas useradd -m spam
doas passwd spam
```

## TSL certificate
### Configure httpd
```
doas cp /etc/examples/httpd.conf /etc
```
and replace `example.com` with `mail-[1,2].sergeypetrunin.com`
```
doas rcctl -f start httpd
```

### Configure acme-client
```
doas cp /etc/examples/acme-client.conf /etc
```
and replace `example.com` with `mail-1.sergeypetrunin.com`

Generate certificates:
```
doas acme-client -v mail-1.sergeypetrunin.com
```
Results:
```
/etc/ssl/mail-1.sergeypetrunin.com.fullchain.pem
/etc/ssl/private/mail-1.sergeypetrunin.com.key
```

### Configure crontab
```
doas crontab -e
...
~       *       *       *       *       acme-client mail-1.sergeypetrunin.com && rcctl reload httpd && rcctl restart smtpd && rcctl reload dovecot
```

## Configure Rspamd
```
doas pkg_add redis rspamd opensmtpd-filter-rspamd opensmtpd-filter-senderscore
```
For DKIM signing create `/etc/rspamd/local.d/dkim_signing.conf`
IMPORTANT: Change group to `_rspamd` for `/etc/mail/dkim/sergeypetrunin.com.key`:
```
doas chown :_rspamd /etc/mail/dkim/sergeypetrunin.com.key
```

Run on boot:
```
doas rcctl enable redis
doas rcctl enable rspamd

doas rcctl start redis
doas rcctl start rspamd
```

## Configure OpenSMTPd
See `/etc/mail/smtpd.conf` and `/etc/mail/aliases`
Check configuration:
```
doas smtpd -n
configuration OK
```
Note: may check that no error in `doas smtpd -dv`

## Configuring Dovecot
```
doas pkg_add dovecot
```
Update descriptors on `/etc/login.conf` (OR check that `/etc/login.conf.d/dovecot` is created)
Update certs in `/etc/dovecot/conf.d/10-ssl.conf`
Update `mail_location` in `/etc/dovecot/conf.d/10-mail.conf` (TODO: make it work with LMTP)
```
doas rcctl enable dovecot
doas rcctl start dovecot
```
