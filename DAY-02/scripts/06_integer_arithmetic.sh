#!/bin/bash

# Floating-point calculation using bc
# Note: Bash arithmetic $(( )) supports only integers.
#       For decimals/floating-point, we use 'bc'.
#       echo is used to create the expression string and pipe it to bc.
# Integer variables
num1=10
num2=5

# bc evaluates the arithmetic expression
sum=$((num1 + num2))
echo "Sum of $num1 and $num2 is $sum"

