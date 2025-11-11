#!/bin/bash

rows=5

for (( i=1; i<=rows; i++ )); do
    for (( j=1; j<=i; j++ )); do
        if (( j == 1 || j == i || i == rows )); then
            echo -n "*"
        else
            echo -n " "
        fi
    done
    echo
done
