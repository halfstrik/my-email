# Multi-node setup

## Moving messages from one node to the next

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
to sync make file `~/syncmail.sh` - copy from `/home/<user>/`
```
crontab -e
*/15       *       *       *       *       sh /home/$USER/syncmail.sh
```

Repeat for each user except `master`

## Detecting failures and notify `master`

TODO
