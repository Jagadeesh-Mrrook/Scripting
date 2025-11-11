#!/bin/bash

dir="$1"

if [ -z "$dir" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

if [ ! -d "$dir" ]; then
    echo "Directory not found"
    exit 1
fi

count=0

for item in "$dir"/*; do
    if [ -f "$item" ]; then
        count=$((count + 1))
    fi
done

echo "Total files: $count"

