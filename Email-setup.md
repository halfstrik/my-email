# Setting up personal email
Links:
 * https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/

## Set up DKIM
```
doas mkdir /etc/mail/dkim
doas openssl genrsa -out /etc/mail/dkim/<domain>.key 1024
doas openssl rsa -in /etc/mail/dkim/<domain>.key -pubout -out /etc/mail/dkim/<domain>.pub

cat /etc/mail/dkim/<domain>.pub
```
Copy this public key to TXT DNS record `yearMMdd._domainkey` like so:
```
"v=DKIM1;k=rsa;p=<key>;"
```

## TSL certificate
### Configure httpd
```
doas cp /etc/examples/httpd.conf /etc
```
and replace `example.com` with `mail-new.<domain>`
```
doas rcctl -f start httpd
```
### Configure acme-client
```
doas cp /etc/examples/acme-client.conf /etc
```
and replace `example.com` with `mail-new.<domain>`

Generate certificates:
```
doas acme-client -v mail-new.<domain>
```
Results:
```
/etc/ssl/mail-new.<domain>.fullchain.pem
/etc/ssl/private/mail-new.<domain>.key
```
---> TODO: add acme-client into CRON to re-new automatically

## Configure Rspamd
```
doas pkg_add redis rspamd opensmtpd-filter-rspamd
```
For DKIM signing create `/etc/rspamd/local.d/dkim_signing.conf`
IMPORTANT: Change group to `_rspamd` for `/etc/mail/dkim/<domain>.key`:
```
doas chown :_rspamd /etc/mail/dkim/<domain>.key
```

Run on boot:
```
doas rcctl enable redis
doas rcctl enable rspamd

doas rcctl start redis
doas rcctl start rspamd
```
