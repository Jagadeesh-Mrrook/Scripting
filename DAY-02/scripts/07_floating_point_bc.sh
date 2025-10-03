#!/bin/bash

# Floating-point calculation using bc
num1=10.5
num2=2.3
result=$(echo "$num1 + $num2" | bc)
echo "Floating-point sum: $result"

