# Final 10-Day Basic Shell Scripting Plan (Fully Updated)

This plan includes all essential concepts for basic shell scripting, with optional topics clearly marked. It is designed for efficient learning and interview readiness.

---

## Day 1: Shell Basics and Script Setup

* [ ] Understand purpose of shell scripting
* [ ] Learn shebang (`#!/bin/bash`) and script execution
* [ ] Set script permissions (`chmod +x`)
* [ ] Run a shell script from the terminal
* [ ] Use `echo` and `printf` to print messages
* [ ] Use comments (`#`) effectively
* [ ] Check exit status of commands using `$?`
* [ ] Use `exit` to terminate scripts
* [ ] Quoting & escaping: single `'...'`, double `"..."`, backslash `\`
* [ ] Command chaining basics: `&&`, `||`

---

## Day 2: Variables, Input, Command-Line Arguments, and Environment

* [ ] Create and use variables (strings, numbers)
* [ ] Understand variable scopes: local/function, user/session, system/environment
* [ ] Take user input using `read`, `read -p`, `read -r`
* [ ] Command-line arguments: `$1`, `$2`, `$@`, `$*`, `$#`
* [ ] Validate arguments and handle missing arguments
* [ ] Arithmetic operations: `+`, `-`, `*`, `/`, `%`
* [ ] Assignment operators: `=`
* [ ] Read user info using `whoami`, `id`
* [ ] Environment variables: `PATH`, `HOME`, `export` basics *(optional)*

---

## Day 3: Conditionals

* [ ] `if`, `if-else`, `if-elif-else` (ladder if), nested if
* [ ] Numeric comparisons: `-eq`, `-ne`, `-lt`, `-le`, `-gt`, `-ge`
* [ ] String comparisons: `=`, `!=`, `-z`, `-n`
* [ ] File tests: `-f`, `-d`, `-L`, `-r`, `-w`, `-x`, `-s`, `-b`, `-c`, `-nt`, `-ot`, `-o`
* [ ] Logical operators: `&&`, `||`, `!`
* [ ] Conditional execution examples using command chaining

---

## Day 4: Loops

* [ ] `for` loops
* [ ] `while` loops
* [ ] `until` loops
* [ ] Nested loops
* [ ] Looping over arrays, files, directories
* [ ] Use `break` and `continue` inside loops
* [ ] Combine loops with conditionals

---

## Day 5: Case Statements & Basic Arithmetic

* [ ] Implement `case` statements for multi-choice logic
* [ ] Perform arithmetic using `$(( ))` and `expr`
* [ ] Practice number-based scripts (sum, difference, multiplication, division, modulo)
* [ ] Even/odd checks and simple math conditions

---

## Day 6: String Manipulation & Arrays

* [ ] Concatenate strings
* [ ] Find string length
* [ ] Reverse strings
* [ ] Check palindrome
* [ ] Identify vowels and consonants
* [ ] Variable substitution: `${var}`, `${var:-default}`, `${var#prefix}`, `${var%suffix}`
* [ ] Simple `sed` usage (substitution)
* [ ] Simple `awk` usage (field extraction)
* [ ] Indexed arrays: creation, accessing, iterating
* [ ] Adding/removing elements in arrays
* [ ] (Optional) Simple associative arrays

---

## Day 7: Basic File Handling

* [ ] Check file existence and type (`-f`, `-d`, `-L`, etc.)
* [ ] Read from files line-by-line
* [ ] Write to files
* [ ] Count lines, words, characters
* [ ] Log file output
* [ ] Basic file permissions: read/write/execute
* [ ] Here documents & here strings: `<<EOF`, `<<< "string"` *(optional)*
* [ ] Error/output redirection: `>`, `>>`, `2>`, `2>&1`

---

## Day 8: Functions

* [ ] Define and call functions
* [ ] Pass arguments: `$1`, `$2`, `$@`, `$*`
* [ ] Return values from functions
* [ ] Local vs global variables
* [ ] Combine functions with loops, conditionals, and file checks
* [ ] Modularize scripts for reusability
* [ ] Command substitution: `$(command)`, backticks `` `command` ``

---

## Day 9: Debugging and Error Handling

* [ ] Use `set -x`, `set -v`, `set -e` for debugging
* [ ] Check exit status with `$?`
* [ ] Conditional execution (`&&`, `||`)
* [ ] Use `exit` for error handling
* [ ] Print error messages and handle exceptions gracefully
* [ ] Use PS4 prompt for advanced tracing

---

## Day 10: Mini Projects & Cron Jobs

* [ ] Combine scripts learned from previous days
* [ ] Practice with user input, loops, conditionals, arrays, functions
* [ ] Command-line arguments in project scripts
* [ ] File operations and string manipulation in project scripts
* [ ] Schedule a simple cron job to automate a script *(optional)*
* [ ] Test, debug, and ensure correct output
* [ ] Keep scripts modular and reusable

---
---
