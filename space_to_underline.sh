#!/bin/sh

a="-ok-"

until [ "x$a" = "x" ]
do
	echo "----> Please_enter_a_sentence: [ Just_press_enter_to_finish ]"
	read a
	if [ "x$a" != "x" ]; then
		echo " "
		echo "${a}" | sed 's/ /_/g'
		echo " "
	fi
done
echo "----> Thank_you ~~~"