#!/bin/bash

# Script: Preserve Spaces and Quotes Example
# Purpose: Demonstrates how Bash handles spaces in user input and how using quotes affects output.

# Step 1: Read user input into a single variable 'combo'
# - The '-p' option shows a prompt message before input
# - All words typed by the user (including spaces) are stored in 'combo'
read -p "Enter your favorite fruit combination (e.g., Apple Mango): " combo

# Step 2: Display the input WITHOUT quotes
# - When you do not use quotes around a variable, Bash collapses multiple spaces into a single space
# Example:
#   User input: Apple   Mango  Banana
#   echo $combo
#   Output: Apple Mango Banana
echo "Without quotes: $combo"

# Step 3: Display the input WITH quotes
# - Using quotes preserves **all spaces exactly as typed**
# - Any multiple spaces, tabs, or special characters are kept intact
# Example:
#   User input: Apple   Mango  Banana
#   echo "$combo"
#   Output: Apple   Mango  Banana  (all spaces preserved)
echo "With quotes: \"$combo\""

