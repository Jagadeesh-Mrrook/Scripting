#!/bin/bash

#Ask use to enter dir name and user name

read -p "Enter dir name:" dir


if [ -d "$dir" ] && [ -x "$dir" ]; then
    echo "can acces the $dir"
else
    echo "cant access the $dir"
fi

