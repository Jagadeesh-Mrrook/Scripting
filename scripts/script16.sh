#!/bin/bash

#SCritp to read the file line by line and make decisions
while IFS= -r line
do
    
    if [ "$line" = orders ]; then
        continue
    elif [ "$line" = shipping ]; then
        break
    fi
    echo "service:$line"
done < config.txt


