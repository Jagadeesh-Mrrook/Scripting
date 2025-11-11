#!/bin/bash

echo "Gathering environment details..."

# Show current system user
current_user=$(whoami)
echo "Current User: $current_user"

# Show user's UID and GID
echo "User Details: $(id)"

echo

# Print important environment variables
echo "HOME directory: $HOME"
echo "PATH variable  : $PATH"

echo

# Set and export a custom variable
app_env="DEV"
export app_env

echo "Custom variable exported: app_env=$app_env"

# Use it in a command
printf "Running in \"%s\" environment\n" "$app_env"
echo

