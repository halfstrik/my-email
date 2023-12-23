# Setting up personal email
Links:
 * (middle of) https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/

Becoming a root
```
doas su -
```

## Set up DKIM (DNS continuation)
```
mkdir /etc/mail/dkim
openssl genrsa -out /etc/mail/dkim/sergeypetrunin.com.key 1024
openssl rsa -in /etc/mail/dkim/sergeypetrunin.com.key -pubout -out /etc/mail/dkim/sergeypetrunin.com.pub

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
useradd -m master
passwd master
```

## TSL certificate
### Configure httpd
```
cp /etc/examples/httpd.conf /etc
vi /etc/httpd.conf
```
and replace `example.com` with `mail74.sergeypetrunin.com`
```
rcctl enable httpd
rcctl -f start httpd
```

### Configure acme-client
```
cp /etc/examples/acme-client.conf /etc
vi /etc/acme-client.conf
```
and replace `example.com` with `mail74.sergeypetrunin.com`

Generate certificates:
```
acme-client -v mail74.sergeypetrunin.com
```
Results:
```
ls /etc/ssl/mail74.sergeypetrunin.com.fullchain.pem
ls /etc/ssl/private/mail74.sergeypetrunin.com.key
```

### Configure crontab
```
crontab -e
...
~       *       *       *       *       acme-client mail74.sergeypetrunin.com && rcctl reload httpd && rcctl restart smtpd && rcctl reload dovecot
```

## Configure Rspamd
```
pkg_add redis rspamd opensmtpd-filter-rspamd opensmtpd-filter-senderscore
```
For DKIM signing create `vi /etc/rspamd/local.d/dkim_signing.conf`
IMPORTANT: Change group to `_rspamd` for `/etc/mail/dkim/sergeypetrunin.com.key`:
```
chown :_rspamd /etc/mail/dkim/sergeypetrunin.com.key
```

Run on boot:
```
rcctl enable redis
rcctl enable rspamd

rcctl start redis
rcctl start rspamd
```

## Configure OpenSMTPd
See `/etc/mail/smtpd.conf` and `/etc/mail/aliases`
Check configuration:
```
smtpd -n
configuration OK
```

## Configuring Dovecot
```
pkg_add dovecot
```
Update descriptors on `/etc/login.conf` (OR check that `/etc/login.conf.d/dovecot` is created)
Update certs in `/etc/dovecot/conf.d/10-ssl.conf`
Update `mail_location` in `/etc/dovecot/conf.d/10-mail.conf` (TODO: make it work with LMTP)
```
rcctl enable dovecot
rcctl start dovecot
```
