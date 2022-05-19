# Multi-node setup

## Moving messages from one node to the next

Make file `/usr/local/bin/syncmail.sh`

On machine mail-x
```
su - me
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
```

On machine mail-y
```
su - me
vi .ssh/authorized_keys
```
append generated key for root

On machine mail-x
```
ssh mail-y.sergeypetrunin.com
> yes
exit
```
Set crontab for the user
```
crontab -e
*/15       *       *       *       *       sh /usr/local/bin/syncmail.sh
```

Repeat for each user except `master`

## Detecting failures and notify `master`

Make file `/usr/local/bin/reportfail.sh`
```
su - master
crontab -e
*/5       *       *       *       *       sh /usr/local/bin/reportfail.sh
```
