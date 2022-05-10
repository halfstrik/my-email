# Set up some emails into a "folder"

For now decided instead of folders within one email, do different OS users for specific subscriptions.
```
doas useradd -m something
doas passwd something
```
and then use `something@sergeypetrunin.com` for the subscription.

This should mostly be used for many-emails-per-day subscriptions, e.g. OpenBSD mailing list.

Setting up Sieve to do that within main email is hard and in my opinion not worth it.

NOTE: We might need to set user's login shell to `/sbin/nologin` to prevent login into ssh.
