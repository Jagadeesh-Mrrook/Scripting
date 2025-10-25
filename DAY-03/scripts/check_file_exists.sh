#!/bin/bash

#Ask user to Enter the file name

read -p "Enter any file name:" file

if [ -f "$file" ]; then
    echo "$file exists"
else 
    echo "$file doesnt exists"
fi


