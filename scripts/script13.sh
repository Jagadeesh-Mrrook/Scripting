#!/bin/bash

attempt=1

while [ $attempt -le 3 ]; do
    read -p "Enter password: " pass

    if [ "$pass" = "devops" ]; then
        echo "Access Granted"
        break
    else
        echo "Wrong password"
    fi

    attempt=$((attempt + 1))
done

if [ $attempt -gt 3 ]; then
    echo "Account locked due to 3 failed attempts"
fi

