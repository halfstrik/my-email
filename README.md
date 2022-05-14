# my-email
Notes for setting up Email on OpenBSD 7.1

## Useful links and documentation

* https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/
* https://github.com/poolpOrg/poolp.org/blob/master/content/posts/2019-09-14/index.md

## Installation
Use [cd71.iso](https://cdn.openbsd.org/pub/OpenBSD/7.1/amd64/cd71.iso)

Keyboard layout: default

Hostname: mail-openbsd-71.sergeypetrunin.com (also set up an A-record in DNS)

No X Windows apps, default net config.

Setting root account password (to be able to access via console), but only using SSH key.

Setting normal user.

Timezone: US/Eastern

Disk partitioning - total 15G

| Size | Mount |
| ---- | ----- |
| 12G | / |
| 0.5G | swap |
| 2.5G | /var/log |

TODO: Isolate other folders to avoid disk overflow. We need to find out where all mail is stored.

Sets: -game* and -x* (assuming OpenSMTPd won't need that)

## Post installation - SSHD

Copy your key to `<user>/.ssh/authorized_keys`

Disable password auth `/etc/ssh/sshd_config` by setting `PasswordAuthentication no`

Reload SSHD by `rcctl reload sshd`
