#!/bin/bash

for i in {1..30}; do
	if [ $(( $i % 3 )) -eq 0 ]; then
		echo -n "Fizz "
	elif [ $(( $i % 5 )) -eq 0 ]; then
		echo -n "Buzz "
	elif [ $(( $i % 3 )) ] && [ $(( $i % 5)) -eq 0 ]; then
		echo -n "Fizzbuzz "
	else
		echo -n "$i "
	fi
done
echo
