#!/bin/bash

read -p "Enter the dir path to find the list all the files:" dir_path

for i in $dir_path/*; do 
    basename=$(basename "$i")
    echo "$basename"    
    if [ "$basename" = STOP ]; then
        echo "File STOP found exiting"
        break
    fi
done

