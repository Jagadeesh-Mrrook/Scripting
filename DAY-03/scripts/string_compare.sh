#!/bin/bash

#ask the user to enter a word

read -p "enter a word:" word

#Compare the word with hello

if [ "$word" = hello ]; then
    echo "Hi there!"
else
    echo "You did'nt say hello"
fi

