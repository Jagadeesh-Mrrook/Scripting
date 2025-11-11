#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Enter exactly 2 numbers"
    echo "Usage $0 <num1><num2>"
    exit 3
fi

if [[ ! $1 =~ ^-?[0-9]+$ ]]; then
    echo "Enter a valid number"
    exit 1
fi

if [[ ! $2 =~ ^-?[0-9]+$ ]]; then
    echo "Enter a valid number"
    exit 2
fi



