#!/bin/bash

# Check if a variable is number
var="123"
if [[ $var =~ ^[0-9]+$ ]]; then
    echo "$var is a number"
else
    echo "$var is not a number"
fi

