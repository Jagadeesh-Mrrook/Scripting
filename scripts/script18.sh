#!/bin/bash

read -p  "Enter first number:"  a 
read -p  "Enter second number" b

echo "Select a number to do the operation"
echo "1 - Add"
echo "2 - subtract"
echo "3 - Multiply"
echo "4 - Division"

read choice

case $choice in 

	1) echo "sum = $(( a + b ))"
	;;

	2) echo "difference = $(( a - b ))"
	;;

	3) echo "Product = $(( a * b ))"
	;;

	4) echo "Division = $(( a / b ))"
	;;

	*) echo "Invalid choice"
	;;
esac


