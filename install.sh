#!/bin/sh
#
# Author Radoslaw Cieciwa <radekcieciwa@gmail.com>
# 
# Script to install or remove custom.
# 

THISSCRIPT=`basename $0`

_install() {
	ln -s -f $1 "/usr/local/bin/$2"
}

_uninstall() {
	rm "/usr/local/bin/$1"
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

if [ "$1" = "--help" -o "$1" = "-help" -o "$1" = "-h" ]; then
	_print_help
else 
	if [ "$1" = "-r" ]; then
		_uninstall qsync
	elif [ "$1" = "-l" ]; then
		ls -l /usr/local/bin/ | grep "\->"
	else
		_install "`pwd`/qsync.sh" qsync
	fi
fi 
