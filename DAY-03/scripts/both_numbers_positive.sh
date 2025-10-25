#!/bin/bash

# Ask the user to enter two numbers

read -p "Enter first number:" n1
read -p "Enter second number:" n2

if [ "$n1" -gt 0 ] && [ "$n2" -gt 0 ]; then
    echo "Both numbers are positive"
else 
    echo "at least one number is zero or negative"
fi

