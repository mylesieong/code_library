#!/bin/bash

if [ $1 == 'list' ]; then
	kotlinc -script liba.kts list
fi

if [ $1 == 'help' ]; then
	kotlinc -script liba.kts help 
fi

if [ $1 == 'present' ]; then
	start chrome $2
fi
