#!/bin/sh
#
# Author Radoslaw Cieciwa <radekcieciwa@gmail.com>
# 
# Script to checkout giyt branch from part of the name. Firsty it checks only local branches, then it checks all remote ones as well.
# 

THISSCRIPT=`basename $0`

_print_help() {
	cat << EOF
Usage: $THISSCRIPT [ branch-name ]

Examples:
  $THISSCRIPT dev
  $THISSCRIPT IOS-434125
EOF
}

if [ "$1" = "--help" -o "$1" = "-help" -o "$1" = "-h" ]; then
	_print_help
else 
	BRANCHES_FOUND=`eval git branch | grep $1`
	NUMBER_OF_BRANCHES_FOUND=`echo -n "$BRANCHES_FOUND" | grep -c '^'`
	
	if [ $NUMBER_OF_BRANCHES_FOUND eq 1 ]; then
		git checkout "$BRANCHES_FOUND"
	elif [ $NUMBER_OF_BRANCHES_FOUND gt 1 ]; then
		
	elif [ $NUMBER_OF_BRANCHES_FOUND lt 1 ]; then
		REMOTE_BRANCHES_FOUND=`eval git branch | grep $1`
	fi

	# # TODO: Add check for correctness of arguments
	# if [ "$1" = "merge" ]; then
	# 	_qsync_check_out_branch_and_return_to_current_branch $2
	# 	git merge $2 --no-edit
	# 	_qcurrent_branch
	# elif [ "$1" = "rebase" ]; then
	# 	_qsync_check_out_branch_and_return_to_current_branch $2
	# 	git rebase $2
	# 	_qcurrent_branch
	# fi 
fi