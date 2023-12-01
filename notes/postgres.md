# Setting up a new machine

1. Download `postgresql` from the AUR `paru -S postgresql`
2. Change the password of the postgres user `sudo passwd postgres`
3. Change user to postgres `su - postgres`
4. Init the db `initdb -D /var/lib/postgres/data`
5. Start the postgres service `systemctl start postgresql`
6. Add postgres to startup `systemctl enable postgresql`

# Changing the password of the postgres user

Sometimes a command like `su - postgres` will have an Authentication failure
after a new install. To solve we can change the password:

```
sudo passwd postgres
```

Then sign in as normal and `initdb`
