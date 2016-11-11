#!/bin/bash

# Don't continue after errors
set -exuo pipefail

# Set proper globbing to ensure hidden files get moved as well
shopt -s dotglob

# Use config from package management if we dont have one already
if [[ ! "$(ls -A $PERSISTENT_CONFIG)" ]]; then
  echo "Importing configuration from package management"
  mv -Z $TMP_CONFIG/* $PERSISTENT_CONFIG
  rm -rf $TMP_CONFIG
fi

# Use directroy structure from package management if we dont have any
if [[ ! "$(ls -A $PERSISTENT_DATA)" ]]; then
  echo "Imorting user directory structure from package management"
  mv -Z $TMP_DATA/* $PERSISTENT_DATA
  rm -rf $TMP_DATA
  echo "Creating a ssh keypair"
  ssh-keygen -N '' -f $PERSISTENT_DATA/.ssh/id_rsa
fi

# Set proper permissions
echo "Setting permissions"
find $PERSISTENT_CONFIG ! -user backuppc -o ! -group backuppc -exec chown backuppc:backuppc {} \;
find $PERSISTENT_DATA ! -user backuppc -o ! -group backuppc -exec chown backuppc:backuppc {} \;
chmod -R 0600 $PERSISTENT_DATA/.ssh/*

# Start supervisord
echo "Starting supervisord"
exec /usr/bin/supervisord
