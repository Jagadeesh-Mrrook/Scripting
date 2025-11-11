#!/bin/bash

file="$1"

# Check if argument missing
if [ -z "$file" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# File validations using Day-3 tests
if [ -f "$file" ]; then
    if [ -r "$file" ] && [ -s "$file" ]; then
        echo "File '$file' exists, is readable, and not empty."
    elif [ ! -s "$file" ]; then
        echo "File '$file' exists but is empty."
    else
        echo "File '$file' exists but is not readable."
    fi
else
    echo "File '$file' does not exist."
fi

