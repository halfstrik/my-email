# Transfer files to a new node

## Moving messages from one node to the next

For each user in: `me`, `spam`, `job`...

On machine mail74.sergeypetrunin.com
```
doas useradd -m me
doas passwd me

su - me
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
```

On machine mail.sergeypetrunin.com
```
su - me
vi .ssh/authorized_keys
```
append generated key for root

On machine mail74.sergeypetrunin.com
```
ssh mail.sergeypetrunin.com
> yes
exit
```

Copy files **for each user**:
```
openrsync --archive --rsync-path 'openrsync' mail.sergeypetrunin.com:/home/$USER/Maildir /home/$USER/
```

## Sunsetting old server

Turn off old mail.sergeypetrunin.com

## Apple Mac Mail app

!!! IMPORTANT !!!
After new email is set up - on laptop need to delete and re-create accounts, otherwise will say "Incorrect username/password"
