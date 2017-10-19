#!/bin/sh
#
# Author Radoslaw Cieciwa <radekcieciwa@gmail.com>
# 
# Script to install or remove custom.
# 

THISSCRIPT=`basename $0`
VERBOSE=true
TOOL_BIN_PATH="/usr/local/bin"

_install() {
	ln -s -f $1 "$TOOL_BIN_PATH/$2"
	if [ $VERBOSE == true ]; then
		echo "Linked: $1 ==> $TOOL_BIN_PATH/$2"
	fi
}

_uninstall() {
	rm "$TOOL_BIN_PATH/$1"
	if [ $VERBOSE == true ]; then
		echo "Removed: $1"
	fi
}

_print_help() {
	cat << EOF
Usage: $THISSCRIPT [ -r|-l]
Where:
  -r  	will remove symbolic links 
  -l  	will list all symbolic links in /usr/local/bin directory
  
Examples:
  $THISSCRIPT 
  $THISSCRIPT -r 
EOF
}

# to define new tool to install, please add
# new entry in array following format:
# "tool-name:tool-path"
# tool-name - your tool name, can be anything
# tool-path - absolute path to tooling that will be linked in /usr/local/bin
TOOLS_DEFINITION=( "qsync:`pwd`/qsync.sh" 
	"git_move:`pwd`/git_move_tool.sh" 
	"prepare_for_git_move:`pwd`/prepare_for_git_move.sh"
	"check_targets:`pwd`/targets_for_file.rb"
	)

if [ "$1" = "--help" -o "$1" = "-help" -o "$1" = "-h" ]; then
	_print_help
else 
	if [ "$1" = "-r" ]; then
		for entry in "${TOOLS_DEFINITION[@]}"; do
    		BIN="${entry%%:*}"
    		_uninstall $BIN
		done
	elif [ "$1" = "-l" ]; then
		ls -l /usr/local/bin/ | grep "\->"
	else
		for entry in "${TOOLS_DEFINITION[@]}"
		do
    		BIN="${entry%%:*}"
    		DIR="${entry#*:}"
    		_install $DIR $BIN 
		done
		if [ $VERBOSE == true ]; then
			echo "=== CAUTION ==="
			echo "To uninstall use -r option"
		fi
	fi
fi 
