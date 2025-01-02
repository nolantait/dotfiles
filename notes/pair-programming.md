# Setup

https://ryanlue.com/posts/2018-01-13-pair-programming-over-ssh

1. Point a domain to a VPS
2. Install `openssh`
3. Open `/etc/ssh/sshd_config` and disable password auth by adding these lines/remove existing:
```
PasswordAuthentication no
ChallengeResponseAuthentication no
AllowTcpForwarding yes
GatewayPorts yes
```
4. Install `wemux`
5. Add a new `pair` user:
```
$ sudo useradd -m pair
$ sudo passwd pair
```
6. Ensure you can `ssh pair@localhost` which means everything worked
7. Add your mates keys to the `/home/pair/.ssh/authorized_keys` file an easy way
   to find them is go to https://github.com/their-username.keys
8. Ensure only you can start wemux sessions:
```
# /usr/local/etc/wemux.conf

host_list=(YOUR_USERNAME_HERE)
```
9. Restart ssh service
```
$ sudo service ssh restart
$ sudo ufw allow 2269
```

## Starting a pair programming session

First start a session on the host machine

```
wemux
```

This is short for `wemux --start` and will create a new session.

```

```
