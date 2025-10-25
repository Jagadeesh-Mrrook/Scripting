#!/bin/bash

#Ask user to enter a file name

read -p "Enter a file name to check if its readable and writable:" file

if [ -r "$file" ] && [ -w "$file" ]; then
    echo "$file is both readable and writable"
elif [ -r "$file" ]; then
    echo "The file $file is only readable not writable"
elif [ -w "$file" ]; then
    echo "The file $file is ony writable not readable"
else
    echo "The file $file is not readable and writable"
fi

