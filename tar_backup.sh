# tar_backup.sh
# The contents of this file are released under the GNU General Public License.
# Feel free to reuse the contents of this work, as long as the resultant works
# give proper attribution and are made publicly available under the GNU General
# Public License.
# Originally By Arun Sori <arunsori94@gmail.com>
# Modified By Matthew Bluteau <matthew.bluteau@gmail.com>

# TODO make this into a cron job so it is done on a weekly basis (and remove
# any previous backups if they are present?)

# Purpose: For taking backup of the desired directory and store it locally
#
# Usage: When run for the first time, this will generate a full backup. All
# subsequent runs will be incremental and constantly increasing in backup
# "level". The idea then is to have a few of these incremental backups between
# full backups. A full backup (i.e. a checkpoint) is forced with
# `--full-backup`. 

# current user executing script
cuser="$USER"

#timestamp
time_stamp=`date`

#Source DIR , change it according to your need
sdir="$HOME"

#destination DIR
ddir="$HOME/backups/"

#backup file name 
#Added date and Hostname on the filename 
bfile="$ddir$(date +%F).$HOSTNAME.tar.gz"

# excluded directories
exdir="--exclude=backups --exclude=.cache --exclude=linux_home "
exdir=$exdir" --exclude=linux_work --exclude=linux_jintrac_common "
exdir=$exdir" --exclude=anaconda3"

#snapshot file name(with path)...change it according to machine
snap="$HOME/backups/backup.snap"


echo "Taking Backup From $HOSTNAME at $time_stamp"

if [[ $1 == "--full-backup" || ! -e $snap ]]
then
	echo "Performing a full (level-0) backup"
	if [[ -e $snap ]]
	then
		echo "Archiving previous snapshot file to $snap-1"
		mv $snap "$snap-1"
	fi
	bfile="${ddir}full-$(date +%F).$HOSTNAME.tar.gz"
fi

# Takes the incremental backup if snapshot exists or full backup if not 
sudo tar $exdir --exclude-caches --listed-incremental=$snap -cvpz -f $bfile \
	$sdir 2> "$ddir/err.log"

sudo chown $cuser:$cuser $bfile
