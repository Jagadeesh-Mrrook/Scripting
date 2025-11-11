#!/bin/bash

echo "Testing Quoting and escaping"

#using double quotes
name="jagga"
echo "Hello $name"

#using single quotes
echo 'Hello $name -- this will not expand'

#using escaping with backslash
echo "this is a quote: \" and this is a backslash: \\"

#command chaining example
mkdir /tmp/test_dir && echo "Directory created!" || echo "Directory creation failed"

echo "exit code of the last command:" $?

exit 0

