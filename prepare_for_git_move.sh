#!/bin/sh
#
# Author Radoslaw Cieciwa <radekcieciwa@gmail.com>
# 
# 
# 

THISSCRIPT=`basename $0`

_print_help() {
	cat << EOF
Usage: $THISSCRIPT [ tool-name ] [ destination-directory ] [ file-list ]

This tool will swap absolute part of path to relative one according to current path (`pwd`).

Examples:
  	$THISSCRIPT git_move ./Source /Users/radoslawcieciwa/Development/test_1.png [ next-file ]

EOF
}

PWD=`pwd`

### MAIN BODY
if [ "$1" = "--help" -o "$1" = "-help" -o "$1" = "-h" -o "$#" -lt 3 ]; then
	_print_help
else
	# skip first 2 arguments by slicing the array
	for var in ${@:3}
	do
		# swap absolute to repative path
		SUBSTITUTED="${var/$PWD/.}"
		# take last / and extract filename
		FILE_NAME="${SUBSTITUTED##*/}"
		# take everything before last / and extract path
		CURRENT_PATH="${SUBSTITUTED%/*}"
		echo "$1 $CURRENT_PATH $FILE_NAME $2"
	done
fi
