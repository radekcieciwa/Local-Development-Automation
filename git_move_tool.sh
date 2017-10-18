#!/bin/sh
#
# Author Radoslaw Cieciwa <radekcieciwa@gmail.com>
# 
# Moving file in git repository with history
# 

THISSCRIPT=`basename $0`

_print_help() {
	cat << EOF
Usage: $THISSCRIPT [ current-file-directory-path ] [ file-name ] [ new-path ]
Warning: Do not use / on the end of directory

Examples:
  	$THISSCRIPT ./current-path file ./new-path
	$THISSCRIPT ./current-path file ./new-path >> history.log

To log the file use:
	$THISSCRIPT [ current-file-directory-path ] [ file-name ] [ new-path ] >> [ log-file ]

Where:
	[ log-file ] can be recreated with this script as entry, or sanitized with sanitize check

To rerun (reproduce) log file use:
	bash [ log-file ]

EOF
}

# Expected arguments
# $1 - old file directory path
# $2 - filename
# $3 - new file directory path
_move() {
	# create missing directories
	mkdir -p $3
	# move files
	mv "$1/$2" "$3/$2"
	# try to stage the both changes to perceive rename
	git add "$3/$2"
	git add "$1/$2"
	# print a feedback for log
	echo $THISSCRIPT $1 $2 $3
}

### MAIN BODY
if [ "$1" = "--help" -o "$1" = "-help" -o "$1" = "-h" -o "$#" -ne 3 ]; then
	_print_help
else
	OLD_FILE_DIRECTORY_PATH=$1
	FILE_NAME=$2
	NEW_FILE_DIRECTORY_PATH=$3
	_move $OLD_FILE_DIRECTORY_PATH $FILE_NAME $NEW_FILE_DIRECTORY_PATH

	# echo "$OLD_FILE_DIRECTORY_PATH/$FILE_NAME"
	# echo "$NEW_FILE_DIRECTORY_PATH/$FILE_NAME"
fi

# TESTING
# func commitsCount() {
# 	COUNT=`git log --oneline --follow ./SupportingFiles/Badoo_Prefix.pch | wc -l | awk '{print $1}'`
# }
