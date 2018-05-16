# Rsync Inotify Watch

A little script that demonstrates the use of inotifywatch + rsync for watching a specific directory for changes (i.e. newly created, modified, deleted, moved, or close-written files) and syncing with a target directory. The process described here can easily be extended/automated using a configuration management tool like Ansible or Puppet.

### Install requirements

>inotify-tools and rsync are the only requirements

```shell
$ sudo apt install inotify-tools
$ sudo apt install rsync
```

### Download dir-watch.sh script

```shell
$ wget https://github.com/pam79/rsync-inotify-watch/raw/master/dir-watch.sh
```

### Move script into your PATH

```shell
$ sudo mv dir-watch.sh /usr/bin/dir-watch
```

### Make script executable

```shell
$ sudo chmod +x /usr/bin/dir-watch
```

### Make script execute without password

>We are doing this because our cron requires it

```shell
$ sudo visudo
```

### add the following below "%sudo ALL=(ALL:ALL) ALL" line:

>Replace `pam79` with your own user

    pam79 ALL=(ALL) NOPASSWD: /usr/bin/dir-watch

### Test the script to make sure it is working properly

>It takes `source` and `destination` as input parameters

```shell
$ mkdir Test /media/storage1/Test
$ dir-watch "/home/$(whoami)/Test/" "/media/storage1/Test/"
```

### Create or delete a file in user space and check status

```shell
$ touch Test/file.txt
$ ls -la /media/storage1/Test
```

### Create a cron job in `/etc/crontab` and have it run each time your system is rebooted

```shell
$ sudo vim /etc/crontab
```

### Add this line to the crontab

>Replace src and dest with your own paths.

    @reboot   root   dir-watch "/home/pam79/Projects/" "/media/storage1/Projects/" 2>&1 | logger -t dir-watch

### Finally,  reboot your system for changes to take effect

Now after every 5min (i.e. 300s) your system will watch for changes made in the specified source directory and synchronize with the target or destination directory.
