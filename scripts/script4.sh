#!/bin/bash

#simple deployment script

echo "Starting the deployment"
echo ""
echo""

#check if the config.txt exist or not

if [ -f "config.txt" ]; then
    echo "config.txt found reading it"
else
    echo "config file missing!"
    echo "Exiting the script"
    exit 1
fi

#Using variables  and quoting
service_name="payment_service"
echo "Deploying \"$service_name\""

#simulate deployment command

false && echo "Deployment success" || echo "Deployment failed"

#show exit code of the last command
 
echo "Last exit code:" $?

echo "Deployment script completed"
