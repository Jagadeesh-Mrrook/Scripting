#!/bin/bash

#Ask user to enter a number

read -p "Enter a number:" num

if (( "$num" -gt 0 )); then
    if (( "$num" % 2 )); then
        echo "then number $num is positive and even"
    else
        echo "then number is positive but odd"
    fi
else
    echo "the number is zero or negative"
fi

