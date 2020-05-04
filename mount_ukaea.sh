#!/usr/bin/env bash
 
USERNAME=$USER
CLUSTER=freia
MOUNT_OPTIONS=auto_cache,reconnect,no_readahead,StrictHostKeyChecking=no
MOUNT_BASE=$HOME
 
if [ $# -ge 1 ]
then
	if [ $1 == "unmount" ]
	then
		for i in linux_home linux_work linux_jintrac_common
		do
			fusermount -u ${MOUNT_BASE}/$i
		done
	fi
else
	SSH_HOST=$(gimme ${CLUSTER})
	sshfs ${USERNAME}@${SSH_HOST}: ${MOUNT_BASE}/linux_home -o \
		${MOUNT_OPTIONS}
	sshfs ${USERNAME}@${SSH_HOST}:/work/${USERNAME} \
		${MOUNT_BASE}/linux_work -o ${MOUNT_OPTIONS}
	sshfs ${USERNAME}@${SSH_HOST}:/common/cmg/${USER} \
		${MOUNT_BASE}/linux_jintrac_common -o ${MOUNT_OPTIONS}
fi
