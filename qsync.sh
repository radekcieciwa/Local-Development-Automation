#!/bin/sh
#
# Author Radoslaw Cieciwa <radekcieciwa@gmail.com>
# 
# Script to update and quickly merge or rebase custom branch to our branch.
# 

THISSCRIPT=`basename $0`

_print_help() {
	cat << EOF
Usage: $THISSCRIPT <merge|rebase> [ branch-name ]
Where:
  merge  	will use merge to integrate custom branch to current branch
  rebase	will use merge to integrate custom branch to current branch
  
Examples:
  $THISSCRIPT merge dev
  $THISSCRIPT rebase master
EOF
}

_qcurrent_branch() {
	git branch | grep "*" | sed 's/* //'
}

_qsync_check_out_branch_and_return_to_current_branch() {
	if [ $# -ne 1 ]; then
		echo "_qsync_check_out_branch_and_return_to_current_branch:Error: add only 1 argument"
		exit 1
	fi	

	CURRENT=`_qcurrent_branch`
	echo $CURRENT
	git checkout $1
	git pull
	echo "=== UPDATED $1 ==="
	git checkout $CURRENT
	echo "=== CURRENT `_qcurrent_branch` ==="
}

if [ "$1" = "--help" -o "$1" = "-help" -o "$1" = "-h" ]; then
	_print_help
else 
	# TODO: Add check for correctness of arguments
	if [ "$1" = "merge" ]; then
		_qsync_check_out_branch_and_return_to_current_branch $2
		git merge $2 --no-edit
		_qcurrent_branch
	elif [ "$1" = "rebase" ]; then
		_qsync_check_out_branch_and_return_to_current_branch $2
		git rebase $2
		_qcurrent_branch
	fi 
fi
