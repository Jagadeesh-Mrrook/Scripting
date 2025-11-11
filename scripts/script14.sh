#!/bin/bash

path="$1"

if [ -z "$path" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

if [ ! -d "$path" ]; then
    echo "Directory not found"
    exit 1
fi

echo "Files with write permission:"
for item in "$path"/*; do
    if [ -f "$item" ] && [ -w "$item" ]; then
        echo "$item"
    fi
done

echo "Files without write permission:"
for item in "$path"/*; do
    if [ -f "$item" ] && [ ! -w "$item" ]; then
        echo "$item"
    fi
done

