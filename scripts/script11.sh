#!/bin/bash

path="$1"

# Check if argument missing
if [ -z "$path" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

# Check file type using Day-03 file tests
if [ -f "$path" ]; then
    echo "'$path' is a regular file."
elif [ -d "$path" ]; then
    echo "'$path' is a directory."
elif [ -L "$path" ]; then
    echo "'$path' is a symbolic link."
else
    echo "'$path' is not a regular file, directory, or symlink."
fi

