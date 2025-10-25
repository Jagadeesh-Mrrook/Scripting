#!/bin/bash

#Ask user to enter 2 numbers

read -p "Enter first number: " num1
read -p "Enter second number: " num2

#Compare the numbers and display which one is greater
if [ "$num1" -gt "$num2" ]; then
    echo "$num1 is greater than num2"
elif [ "$num1" -lt "$num2" ]; then
    echo "$num1 is lesser than $num2"
else
    echo "$num1 is equal to $num2"
fi
