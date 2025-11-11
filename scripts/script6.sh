#!/bin/bash

# Prompt user in a single line using read -p
read -r -p "Enter your first and last name: " fullname

# Split the name into two parts using IFS
IFS=' ' read -r first last <<< "$fullname"

echo
echo "First Name : $first"
echo "Last Name  : $last"
echo

printf "Welcome \"%s %s\"\n" "$first" "$last"

