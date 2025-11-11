#!/bin/bash

num="$1"

if [ -z "$num" ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

# Check if number is positive, negative, or zero
if [ "$num" -gt 0 ]; then
    echo "Number is positive"
elif [ "$num" -lt 0 ]; then
    echo "Number is negative"
else
    echo "Number is zero"
fi

