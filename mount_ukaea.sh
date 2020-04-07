#!/usr/bin/env bash
 
USERNAME=$USER
CLUSTER=freia
MOUNT_OPTIONS=auto_cache,reconnect,no_readahead,StrictHostKeyChecking=no
MOUNT_BASE=$HOME
SSH_HOST=$(gimme ${CLUSTER})
 
sshfs ${USERNAME}@${SSH_HOST}: ${MOUNT_BASE}/linux_home -o ${MOUNT_OPTIONS}
sshfs ${USERNAME}@${SSH_HOST}:/work/${USERNAME} ${MOUNT_BASE}/linux_work -o ${MOUNT_OPTIONS}
