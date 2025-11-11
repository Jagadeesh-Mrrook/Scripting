#!/bin/bash

echo "starting the script"

printf "printf is used to print \n"

ls /tmp >/dev/null 2>&1

echo "exit status of ls:" $?

exit 1


