# my-email
Notes for setting up Email on OpenBSD 7.1

## Useful links and documentation

* https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/
* https://github.com/poolpOrg/poolp.org/blob/master/content/posts/2019-09-14/index.md

## Installation
Use [cd71.iso](https://cdn.openbsd.org/pub/OpenBSD/7.1/amd64/cd71.iso)

Follow [encrypted-system-setup.md](./encrypted-system-setup.md) to install new system

See [system-management.md](./system-management.md) for recurrent tasks

Follow [email-setup.md](./email-setup.md) for OpenSMTPd, Rspamd and Dovecot setup

Follow [multi-node-setup.md](./multi-node-setup.md) for enable sync mails between nodes

## Set up some emails into a "folder"

For now decided instead of folders within one email, do different OS users for specific subscriptions.
and then use `something@sergeypetrunin.com` for the subscription.

This should mostly be used for many-emails-per-day subscriptions, e.g. OpenBSD mailing list.

Setting up Sieve to do that within main email is hard and in my opinion not worth it, but we can try it later.

## Advanced setup for filtering spam
Links:
 * (end of) https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/

TODO: Setup Sieve with Dovecot and Rspamd to handle spam
