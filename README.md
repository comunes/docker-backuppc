# docker-backuppc

## Synopsis

A simple docker container for running Backuppc based in `alvaroaleman/backuppc` adding a nagios monitoring plugin

## Description

This container installs Backuppc from Debian Jessie sources. On startup it
checks if the provides volumes for data and configuration are emppty and
if yes, move the configuration from packaging into it.

### Default settings

* No authentication
* SSH host key checking **disabled**
* If the data volume is empty, a new SSH keypair gets generated at startup

### Volumes

* ``/var/lib/backuppc``: Persistent data for backuppc, including ssh key
* ``/etc/backuppc``: Configuration for backuppc

### Ports

* ``80``: Webinterface

### Monitor

You can check externally the status of your backups with something like:
```
docker exec -i -u backuppc -t NAME /usr/lib/nagios/plugins/check_backuppc
```

## License

AGPLv3

## Author information

Alvaro Aleman

* Nagios plugin added by Vicente J. Ruiz Jurado (vjrj)
