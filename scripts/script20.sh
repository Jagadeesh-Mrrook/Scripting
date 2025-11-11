#!/bin/bash

read -p "Emter first number:"  a
read -p "Emter second number:" b

echo "Choose the number:"
echo "1 - check if first number is greater than second"
echo "2 - check if second is greater than the first"
echo "3 - check if first and second are equal"

read -p "Enter the number:" choice


case $choice in 
	1)
		if [[ "$a" -gt "$b" ]]; then
			echo "$a is greater than $b"
		else
			echo "$a is not greater than $b"
		fi
		;;
	2)
		if [[ "$b" -gt "$a" ]]; then
			echo "$b is greater than $a"
		else
			echo "$b is not greater than $a"
		fi
		;;
	3)
		if [[ "$a" -eq "$b" ]]; then
			echo "$a is equal to $b"
		else
			echo "$a is not equal to $b"
		fi
		;;
	*)
		echo "Invalid selection"
		;;
esac

