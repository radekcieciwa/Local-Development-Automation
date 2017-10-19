#!/bin/sh

# 1 - 1st project, 2 - 2nd project, 3 - file to compare

for var in ${@:3}
do
	TARGETS_A=`check_targets $1 $var`
	TARGETS_B=`check_targets $2 $var`

	if [ $TARGETS_A == $TARGETS_B ]
	then
  		echo "$var: OK\t($TARGETS_A)"
	else
		echo "$var: FAILED\t($TARGETS_A vs $TARGETS_B)"
	fi
done
