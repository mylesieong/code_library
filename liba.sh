#!/bin/bash

if [ $# -eq 1 ]; then
	if [ $1 == 'list' ]; then
		# kotlinc -script ~/Documents/code_library/liba.kts list
		python ~/Documents/code_library/liba.py list

	elif [ $1 == 'help' ]; then
		echo "try add command like list/help/tree xxx/present xxx"

	else
		start chrome $1

	fi
elif [ $# -eq 2 ]; then
	if [ $1 == 'tree' ]; then
		# kotlinc -script ~/Documents/code_library/liba.kts tree $2
		python ~/Documents/code_library/liba.py tree $2 
	fi
else
	echo "try add command like list/help/tree xxx/present xxx"
fi
