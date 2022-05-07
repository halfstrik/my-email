# Quick notes on frequent OpenBSD management tasks

## Enable `doas`
```
su -
cp /etc/examples/doas.conf /etc/
```

## Install latest patches
```
doas syspatch
```
