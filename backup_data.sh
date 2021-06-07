#!/bin/bash
#
# name: backup_data.sh
# purpose: conduct incremental, time-stamped backup of /home/matthew and /etc
# 	using rsync
# author: Matthew Bluteau <matthew.bluteau@gmail.com>

export DISPLAY=":0"
export XAUTHORITY="/home/matthew/.Xauthority"

#Todays date in ISO-8601 format:
DAY0=$(date -I)
 
#The source directories:
SRC1="/etc"
SRC2="/home/matthew"
 
#The base of the target directories:
TRG="/media/matthew/backup-data/ThinkPad-W540/ubuntu-16.04/"

#Get the most recently dated backup from this folder
DAY1=$(ls -r1 --group-directories-first $TRG | head -n1)

#Check if this folder has the same date as today (i.e. a backup has already
#been done) and we can stop
if [ $DAY0 == $DAY1 ] 
then
	/usr/bin/xterm -hold -e echo "Backup has already been done today. Aborting..."
	exit 0
fi

#Create the target directories:
TRG1="$TRG$DAY0/"
TRG2="${TRG1}home/"
mkdir -p $TRG2
 
#The link destination directories:
LNK1="$TRG$DAY1/"
LNK2="$TRG$DAY1/home/"
 
#The rsync options:
EXCLUDE="/home/matthew/configs/rsync_ignorelist"
OPT="-avh --delete --delete-excluded --progress --link-dest="
OPT1="$OPT$LNK1"
OPT2="$OPT$LNK2 --exclude-from=$EXCLUDE"
 
#Execute the backups
/usr/bin/xterm -e sudo rsync $OPT1 $SRC1 $TRG1
/usr/bin/xterm -e rsync $OPT2 $SRC2 $TRG2
# Copy larger files since they are not conducive to an incremental back-up
# (i.e. just keep most recent version of them)
/usr/bin/xterm -e rsync -avh --progress "$SRC2/.safe" "${TRG}../.safe"
/usr/bin/xterm -e rsync -avh --progress "$SRC2/VirtualBox VMs" "${TRG}../VirtualBox VMs"

