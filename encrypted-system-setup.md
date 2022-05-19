# Setting up encrypted disk VPS
Links:
 * https://poolp.org/posts/2018-01-29/install-openbsd-on-dedibox-with-full-disk-encryption/
 * https://github.com/poolpOrg/poolp.org/blob/master/content/posts/2018-01-29/index.md

## Creating encrypted disk

After boot select:
```
(I)nstall, (U)pgrade, (A)utoinstall or (S)hell? s
# cd /dev
# sh ./MAKEDEV sd0
# fdisk -iy sd0
# disklabel -E sd0
> p M
> z
> p M
> a
  <enter>
  <enter>
  14846M
  RAID
> a
  <enter>
  <enter>
  <enter>
  <enter>
> p M
> w
> q
# bioctl -c C -r auto -l /dev/sd0a softraid0
<passphrashe>
# install
```

## Installation continue

14848M
/ - 12.5G
/var - 1.5G
/tmp - rest

Keyboard layout: default

Hostname: mail-<#>.sergeypetrunin.com (also set up an A-record in DNS)

Networking - IPv4 and IPv6 autoconf.

No X Windows apps.

Setting root account password, but only using SSH key.

Setting normal user.

Timezone: US/Eastern

Root disk - sd1.
Disk partitioning - total 15G

| Size  | Mount         |
|-------|---------------|
| 12.5G | /    (on sd1) |
| 1.5G  | /var          |
| rest  | /tmp          |
| 0.5G  | swap (on sd0) |

```
# sd1
> p M
> z
> p M
> a
  <enter>
  <enter>
  12.5G
  <enter>
  /
> a
  <enter>
  <enter>
  1.5G
  4.2BSD
  /var
> a
  <enter>
  <enter>
  <enter>
  /tmp
> p M
> w
> q
```

Sets: -game* and -x* (assuming OpenSMTPd won't need that)

## Post installation - Setup swap

Add to `/etc/fstab`:
```
/dev/sd0b none swap sw
```

## Post installation - Disable password auth SSHD

Copy your key to `<user>/.ssh/authorized_keys`

Disable password auth `/etc/ssh/sshd_config` by setting `PasswordAuthentication no`

Reload SSHD by `rcctl reload sshd`

## Post installation - Enable `doas`
```
su -
cp /etc/examples/doas.conf /etc/
```

## Post installation - Disable `root` login

```
usermod -p'*' root
```
