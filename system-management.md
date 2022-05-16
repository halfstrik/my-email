# Quick notes on frequent OpenBSD management tasks

## Install latest patches
```
doas syspatch

(optional, if kernel updated)
doas reboot
```

## Install packages update

```
doas pkg_add -u
```
