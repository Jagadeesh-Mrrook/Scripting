#!/bin/bash

#this scripts check the file, if it extiste before executing it

echo "checking if example.sh exists or not"

if [ -f "./example.sh" ]; then
    echo "File found. Running it now..."
    ./example.sh && echo "example.sh ran successful" || echo "example.sh failed to run"
else
    echo "file not found"
fi

echo "script finished with exit code:" $?

