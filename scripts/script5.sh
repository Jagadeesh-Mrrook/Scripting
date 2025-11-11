#!/bin/bash

#ask user for their department
read -p "Enter your department:" dept

#current user for the syseterm

current_user=$(whoami)

echo "The User \"$current_user\" belongs to this \"$dept\" department."

printf 'User and his department has been identified.\n'


