#!/bin/bash

if [ $# -eq 1 ]; then
	if [ $1 == 'list' ]; then
		kotlinc -script liba.kts list
	fi

	if [ $1 == 'help' ]; then
		kotlinc -script liba.kts help 
	fi
elif [ $# -eq 2 ]; then
	if [ $1 == 'present' ]; then
		start chrome $2
	fi

	if [ $1 == 'tree' ]; then
		kotlinc -script liba.kts tree $2 
	fi
else
	echo "try add command like list/help/tree xxx/present xxx"
fi
