#!/bin/bash

# Using variables in a loop
count=3
while [ $count -gt 0 ]; do
    echo "Countdown: $count"
    ((count--))
done

