# Setting up VPS
Deiced to only use one unencrypted VPS - simple maintenance, no need to remember extra password

## Installation continue
Keyboard layout: default

Hostname: mail.sergeypetrunin.com (also set up an A-record in DNS)

Networking - IPv4 and IPv6 autoconf.

No X Windows apps.

Setting root account password, but only using SSH key.

Setting normal user.

Timezone: US/Eastern

Root disk - sd0.
Disk partitioning - total 15G

| Size  | Mount |
|-------|-------|
| 12.5G | /     |
| 0.5G  | swap  |
| 1.5G  | /var  |
| rest  | /tmp  |


```
(W)hole
(C)ustom
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
  0.5G
  swap
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

Location of sets: http
Sets: -game* and -x* (assuming OpenSMTPd won't need that)

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
