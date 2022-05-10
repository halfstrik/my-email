# Multi-node setup

TODO: Consider is I want multi-node setup in case of outage

# Adding/removing a node from our setup

TODO: Describe actions to transfer emails between nodes or in case of adding a new node

## Moving messages from one node to the next

Set login shell to be able login for the user
`doas usermod -s /bin/ksh me`

Log in to the account on the **new** host:
```
su - me
ssh-keygen
cat ~/.ssh/id_rsa.pub 
```

On the **old** host add this key to `vi ~/.ssh/authorized_keys`

```
scp -rp me@<old>.sergeypetrunin.com:/home/me/Maildir ~/
```
