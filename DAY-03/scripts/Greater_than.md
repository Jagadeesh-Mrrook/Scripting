#!/bin/bash

#Ask user to enter a number

read -p "Enter any number:" num

if [ "$num" -gt 10 ]; then

    echo "the number $num is greater than 10"

else

    echo "the number $num is less than or equal to 10"

fi