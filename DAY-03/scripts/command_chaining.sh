#!/bin/bash

# Ask user to enter directory name
read -p "Enter directory name to create: " dir

# Create directory and handle success/failure in one line
mkdir "$dir" && echo "Directory '$dir' created successfully" || echo "Failed to create directory '$dir'"

