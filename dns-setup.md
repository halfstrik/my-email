# Setting up DNS for Email server and personal blog
Links:
 * (beginning of) https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/

## Setting up A, AAAA and MX records

mail74.sergeypetrunin.com  A     <IPv4>
mail74.sergeypetrunin.com  AAAA  <IPv6>

sergeypetrunin.com.                 MX   0 mail.sergeypetrunin.com.
                                         10 mail74.sergeypetrunin.com.

mail76.codereimagined.com  A     <IPv4>
mail76.codereimagined.com  AAAA  <IPv6>

codereimagined.com.                 MX   10 mail76.codereimagined.com.

Test:
```
$ host mail74.sergeypetrunin.com
mail.sergeypetrunin.com has address <IPv4>
mail.sergeypetrunin.com has IPv6 address <IPv6>

$ dig -t MX sergeypetrunin.com +short
0 mail.sergeypetrunin.com.

$ host mail76.codereimagined.com
mail76.codereimagined.com has address <IPv4>
mail76.codereimagined.com has IPv6 address <IPv6>

$ dig -t MX codereimagined.com +short
0 mail.sergeypetrunin.com.
```

## Setting up rDNS and FCrDNS

Go to the instance settings in Control Panel and set **Get PTR** to mail.sergeypetrunin.com
To check:
```
$ host <IPv4>
some-ip.in-addr.arpa domain name pointer mail.sergeypetrunin.com.
$ host <IPv6>
some-ip.ip6.arpa domain name pointer mail.sergeypetrunin.com.
```

## Lock who can send mails on our behalf

sergeypetrunin.com.            TXT  "v=spf1 mx -all"

Test:
```
$ dig -t TXT sergeypetrunin.com +short
"v=spf1 mx -all"

$ dig -t TXT codereimagined.com +short
"v=spf1 mx -all"
```

## Set what to do with failures DMARK

_dmarc.sergeypetrunin.com.     TXT  "v=DMARC1;p=quarantine;pct=100;rua=mailto:postmaster@sergeypetrunin.com;"

Test:
```
$ dig -t TXT _dmarc.sergeypetrunin.com +short
"v=DMARC1;p=quarantine;pct=100;rua=mailto:postmaster@sergeypetrunin.com;"

$ dig -t TXT _dmarc.codereimagined.com +short
"v=DMARC1;p=quarantine;pct=100;rua=mailto:postmaster@codereimagined.com;"
```
