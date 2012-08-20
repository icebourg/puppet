#!/bin/bash

########################################################################
# mysql-archive.sh						       #
########################################################################
# Archive all mysql databases to /sqldumps every night. On Sunday,
# create a weekly copy of the data. We store up to 5 copies of the
# weekly backups.
########################################################################

DATE=`date +'%Y%m%d'`	# YYYYMMDD
DOW=`date +'%w'`	# day of week
WOY=`date +'%W'`	# week of year
DATE=`date +'%d'`	# day of month
WEEKNUM=$(($WOY%5))	# the week that we are backing up
			# beauty of this is that this number rotates
			# 0-4 so you do not need to do any manual deletes
			# of old backups

# do our dump to the /tmp folder so we don't mess up any backups in place
mysqldump --defaults-file=/etc/mysql/debian.cnf --all-databases > /tmp/mysql.dump.${DATE}

# compress our backup, but don't hog too many resources
nice gzip /tmp/mysql.dump.${DATE}

# now replace the existing backup file with mv, this is atomic
# (assuming /tmp and /sqldumps are on the same partition)
mv /tmp/mysql.dump.${DATE}.gz /sqldumps/mysql.daily.${DOW}.gz


# now, if this is a Sunday, take the backup we just made, and 
# make it a weekly

if [[ ${DOW} == 0 ]]; then
	cp -f /sqldumps/mysql.daily.${DOW}.gz /sqldumps/mysql.weekly.${WEEKNUM}.gz
fi
