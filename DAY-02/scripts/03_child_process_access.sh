#!/bin/bash

# Demonstrate child process access
export APP_ENV="Production"
username="Jagga"

bash -c 'echo "Child process sees APP_ENV as: $APP_ENV"'
bash -c 'echo "Child process sees username as: $username"'

