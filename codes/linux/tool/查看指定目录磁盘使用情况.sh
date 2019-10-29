#!/usr/bin/env bash

#DIRS="/var/log /home /opt"

#DATE=$(date '+%m%d%y')
#exec > disk_space_${DATE}.log

echo "Top Ten Disk Space Usage"
echo "for ${DIRS} Directories"
for DIR in ${DIRS}
do
	echo ""
	echo "The ${DIR} Directory:"
	du -S ${DIR} 2> /dev/null |
	sort -rn |
	sed '{11,$D; =}' |
	sed 'N; s/\n/ /' |
	gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
done
