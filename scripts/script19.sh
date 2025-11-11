#!/bin/bash

read -p "Enter a number:" a

echo "Select the choice:"

echo "1 - check for even"
echo "2 - check for odd"

read -p "Enter the coice:" choice

case $choice in 
	1) if [ $(( a % 2 )) -eq 0 ]; then 
		echo "The number is even"
	   else
		echo "The number is not even"
	   fi
	;;

	2) if [ $(( a % 2 )) -ne 0 ]; then
		echo "The number is odd"
	   else
		echo "The number is not odd"
	    fi
	;;

	*) echo "Invalid choice"
	;;
esac
