#!/bin/bash
# Purpose: Demonstrate setting execute permissions

echo "Before changing permission:"
ls -l chmod_permissions.sh

# Set execute permission
chmod +x chmod_permissions.sh

echo "After setting execute permission:"
ls -l chmod_permissions.sh

