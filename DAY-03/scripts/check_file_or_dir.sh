#!/bin/bash

#Ask user to enter file or dir name

read -p "Enter file or dir name to find what it is file or dir:" name

if [ -f "$name" ]; then
    echo "$name is a file"
elif [ -d "$name" ]; then
    echo "$name is a dir"
else
    echo "$name is neither a file nor dir"
fi


