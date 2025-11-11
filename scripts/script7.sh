#!/bin/bash

echo "Argument processing started..."

# Check if exactly two arguments are passed
if [ $# -ne 2 ]; then
    echo "Please pass exactly 2 numbers."
    echo "Usage: ./script.sh num1 num2"
    exit 1
fi

num1=$1
num2=$2

echo
echo "You passed: $num1 and $num2"
echo

# Basic arithmetic operations
sum=$(( num1 + num2 ))
diff=$(( num1 - num2 ))

echo "Sum        : $sum"
echo "Difference : $diff"

echo
echo "All arguments: $@"
echo "Total count  : $#"

