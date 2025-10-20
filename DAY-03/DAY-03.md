### Day 3: Conditionals - Introduction

#### Concept / What:

Conditionals in shell scripting allow you to make decisions in your scripts. They let the script execute certain commands only if specific conditions are true, controlling the flow of execution based on logical tests like numbers, strings, files, or command success.

#### Why / Purpose / Use Case:

* Automate decision-making in scripts.
* Run commands only when certain conditions are met.
* Validate user input or system states before proceeding.
* Practical examples:

  * Check if a directory exists before creating it.
  * Verify if a user has write permission before writing a file.
  * Perform actions based on the result of a previous command.

#### How it Works / Steps / Syntax:

1. Basic structure:

```bash
if [ condition ]; then
    # commands to execute if condition is true
fi
```
### Arithmetic Operations in if Conditions

#### Concept / What:

* To perform **arithmetic operations** (like +, -, *, /, %) inside an if condition in Bash, you **must use (( ))**.
* `[ ]` cannot handle arithmetic expressions such as modulo or addition.

#### Why / Purpose / Use Case:

* `[ ]` (test command) is for simple numeric comparisons using operators like `-eq`, `-lt`, `-gt`.
* `(( ))` allows evaluating arithmetic expressions directly in conditions.
* Use cases: checking even/odd numbers, calculating remainders, performing arithmetic checks.

#### How it Works / Syntax:

```bash
num=5

# Check if positive
if (( num > 0 )); then
    echo "Positive number"
fi

# Check if even
if (( num % 2 == 0 )); then
    echo "Even number"
fi
```

#### Common Issues / Errors:

* Using `%` or other arithmetic operators inside `[ ]` → syntax error.
* Forgetting `==` or other comparison operator inside `(( ))`.

#### Troubleshooting / Fixes:

* Replace `[ ]` with `(( ))` when doing arithmetic.
* Quoting variables inside `(( ))` is optional; usually safe to leave unquoted.

#### Best Practices / Tips:

* Use `[ ]` for simple numeric comparisons (`-eq`, `-lt`, `-gt`).
* Use `(( ))` for modulo, addition, multiplication, or complex arithmetic expressions.

#### Example Script:

```bash
#!/bin/bash
read -p "Enter a number: " num

if (( num > 0 )); then
    if (( num % 2 == 0 )); then
        echo "The number $num is positive and even"
    else
        echo "The number $num is positive but odd"
    fi
else
    echo "The number $num is zero or negative"
fi
```


2. Key points:

   * Condition is inside `[ ]` (test command).
   * Each `then` block runs only if the condition evaluates to true.
   * Commands outside the `if` block execute regardless of the condition.
3. Example:

```bash
#!/bin/bash
echo "Enter a number:"
read num

if [ $num -gt 10 ]; then
    echo "The number is greater than 10."
fi
```

* If user enters `15`, prints the message. Otherwise, nothing prints.

#### Common Issues / Errors:

* Forgetting spaces around `[ ]` → `[ $num-gt 10 ]` fails.
* Using `=` for numeric comparison (should use `-eq`, `-gt`, etc.).
* Not closing `if` with `fi`.

#### Troubleshooting / Fixes:

* Ensure spaces around `[ ]`.
* Use correct operator for data type (numeric vs string).
* Close all conditional blocks with `fi`.

#### Best Practices / Tips:

* Quote variables inside `[ ]` to avoid errors with empty values: `[ "$var" -gt 10 ]`
* Keep conditions simple and readable.
* Use indentation for clarity.

#### Example Script:

```bash
#!/bin/bash
# Check if a number is positive

echo "Enter a number:"
read num

if [ "$num" -gt 0 ]; then
    echo "You entered a positive number: $num"
fi

echo "Script finished."
```

---
---

### If-Else Statement

#### Concept / What:

**if-else statement** allows you to execute one block of commands if a condition is true, and another block if the condition is false. It provides an alternative path in scripts.

#### Why / Purpose / Use Case:

* Run different commands based on a condition.
* Handle situations where a default action is needed if the main condition is not met.
* Practical examples:

  * Check if a user is root; if not, print an error.
  * Validate file existence: if exists, process it; else, create it.

#### How it Works / Steps / Syntax:

1. Structure:

```bash
if [ condition ]; then
    # commands if condition is true
else
    # commands if condition is false
fi
```

2. Example:

```bash
#!/bin/bash
echo "Enter a number:"
read num

if [ "$num" -gt 10 ]; then
    echo "Number is greater than 10."
else
    echo "Number is 10 or less."
fi
```

* Input `15` → prints: Number is greater than 10.
* Input `5` → prints: Number is 10 or less.

#### Common Issues / Errors:

* Forgetting `else` keyword.
* Misplacing `fi` at the end.
* Not quoting variables, which may cause errors with empty input.

#### Troubleshooting / Fixes:

* Always close the block with `fi`.
* Quote variables: `[ "$num" -gt 10 ]`.
* Check indentation and syntax carefully.

#### Best Practices / Tips:

* Keep `if` and `else` blocks short for readability.
* Use meaningful messages in `echo` to indicate the condition.
* Avoid complex conditions in a single line; split if needed.

#### Doubt / Explanation Added:

* **Condition vs Statement:**

  * Condition: the logical test `[ "$num" -gt 0 ]` that evaluates true or false.
  * Statement: the full `if ... else ... fi` block that executes commands based on the condition.
  * Both are part of the `if-else` concept; the condition is inside the statement.

#### Example Script:

```bash
#!/bin/bash
# Check if a number is positive or non-positive

echo "Enter a number:"
read num

if [ "$num" -gt 0 ]; then
    echo "You entered a positive number: $num"
else
    echo "You entered zero or a negative number: $num"
fi
```

---
---

### If-Elif-Else Statement (Ladder If)

#### Concept / What:

The **if-elif-else statement** allows multiple conditions to be tested sequentially. The first true condition executes its block, and the rest are skipped. It is also called a **ladder if** because the conditions are checked from top to bottom.

#### Why / Purpose / Use Case:

* Handle multiple possible scenarios in a script.
* Avoid nested `if` statements for readability.
* Practical examples:

  * Grading system: assign grades based on score ranges.
  * User input validation with multiple valid options.
  * System checks: take different actions based on multiple conditions (e.g., disk usage levels).

#### How it Works / Steps / Syntax:

1. Structure:

```bash
if [ condition1 ]; then
    # commands if condition1 is true
elif [ condition2 ]; then
    # commands if condition2 is true
elif [ condition3 ]; then
    # commands if condition3 is true
else
    # commands if none of the above conditions are true
fi
```

2. Example:

```bash
#!/bin/bash
echo "Enter your score:"
read score

if [ "$score" -ge 90 ]; then
    echo "Grade: A"
elif [ "$score" -ge 75 ]; then
    echo "Grade: B"
elif [ "$score" -ge 50 ]; then
    echo "Grade: C"
else
    echo "Grade: F"
fi
```

* Input `92` → prints `Grade: A`.
* Input `78` → prints `Grade: B`.
* Input `45` → prints `Grade: F`.

#### Key Concept / Understanding:

* **Execution order matters**: Conditions are checked top to bottom. The **first true condition executes**, and the rest are skipped.
* **Place more specific or higher conditions first**; broader conditions later. The `else` block should always be at the end.
* If a broad condition is placed first, it may catch inputs that were supposed to match more specific conditions, preventing them from executing.

#### Example of incorrect order:

```bash
#!/bin/bash
score=92

if [ "$score" -ge 50 ]; then
    echo "Grade: C"  # too broad, catches 92
elif [ "$score" -ge 75 ]; then
    echo "Grade: B"
elif [ "$score" -ge 90 ]; then
    echo "Grade: A"
else
    echo "Grade: F"
fi
```

**Output:**

```
Grade: C
```

* Correct order ensures proper grading.

#### Common Issues / Errors:

* Forgetting `elif` or `else`.
* Misplacing `fi` at the end.
* Using overlapping conditions incorrectly (order matters).
* Not quoting variables.

#### Troubleshooting / Fixes:

* Ensure the ladder order is correct: higher/more specific conditions first.
* Quote all variables: `[ "$score" -ge 90 ]`.
* Always close the block with `fi`.

#### Best Practices / Tips:

* Use ladder if for readability instead of nested `if-else`.
* Keep conditions mutually exclusive when possible.
* Add comments to indicate which range each condition covers.

#### Example Script:

```bash
#!/bin/bash
# Grading system using if-elif-else

echo "Enter your score:"
read score

if [ "$score" -ge 90 ]; then
    echo "Grade: A"
elif [ "$score" -ge 75 ]; then
    echo "Grade: B"
elif [ "$score" -ge 50 ]; then
    echo "Grade: C"
else
    echo "Grade: F"
fi
```

---
---

### Nested If Statements

#### Concept / What:

A **nested if statement** is an `if` (or `if-else` / `if-elif-else`) statement placed **inside another if statement**. It allows you to test additional conditions **only if the outer condition is true**.

#### Why / Purpose / Use Case:

* Handle complex decision-making where one condition depends on another.
* Avoid evaluating inner conditions unless the outer condition is satisfied.
* Practical examples:

  * Checking user input first, then validating its range.
  * File existence check, then checking permissions.
  * Multi-step validations: e.g., check if user is logged in, then check role.

#### How it Works / Steps / Syntax:

1. Nested **Simple If**:

```bash
if [ condition1 ]; then
    # commands if condition1 is true
    if [ condition2 ]; then
        # commands if condition2 is true
    fi
fi
```

* Inner `if` executes **only if outer condition is true**.

2. Nested **If-Else**:

```bash
if [ condition1 ]; then
    # commands if condition1 is true
    if [ condition2 ]; then
        # commands if condition2 is true
    else
        # commands if condition2 is false
    fi
else
    # commands if condition1 is false
fi
```

* Inner `if-else` executes only when outer condition path is active.

3. Nested **If-Elif-Else**:

```bash
if [ condition1 ]; then
    # commands if condition1 is true
    if [ condition2 ]; then
        # commands if condition2 is true
    elif [ condition3 ]; then
        # commands if condition3 is true
    else
        # commands if none of the inner conditions are true
    fi
else
    # commands if outer condition1 is false
fi
```

* Inner `if-elif-else` allows multiple possibilities **after outer condition is true**.

#### Example Scripts:

**Nested Simple If:**

```bash
#!/bin/bash
# Nested simple if example

age=20
if [ "$age" -ge 18 ]; then
    echo "Adult"
    if [ "$age" -lt 30 ]; then
        echo "Young adult"
    fi
fi
```

**Nested If-Else:**

```bash
#!/bin/bash
# Nested if-else example

age=20
if [ "$age" -ge 18 ]; then
    echo "Adult"
    if [ "$age" -ge 25 ]; then
        echo "Above 25"
    else
        echo "Below 25"
    fi
else
    echo "Minor"
fi
```

**Nested If-Elif-Else:**

```bash
#!/bin/bash
# Nested if-elif-else example

age=20
if [ "$age" -ge 18 ]; then
    echo "Adult"
    country="IN"
    if [ "$country" = "IN" ]; then
        echo "Vote in India"
    elif [ "$country" = "US" ]; then
        echo "Vote in US"
    else
        echo "Other country"
    fi
else
    echo "Minor"
fi
```

#### Common Issues / Errors:

* Forgetting to close inner `if` with `fi`.
* Confusing inner and outer `fi` closures.
* Not indenting properly → reduces readability.
* Quoting variables incorrectly.

#### Troubleshooting / Fixes:

* Always match each `if` with a corresponding `fi`.
* Use proper indentation for clarity.
* Quote variables: `[ "$var" = "value" ]`.

#### Best Practices / Tips:

* Keep nesting shallow (max 2–3 levels) for readability.
* Consider `elif` or separate functions if nesting becomes too deep.
* Use comments to indicate which `if` is being closed.
* You can use any conditional type (if, if-else, if-elif-else) inside a nested if depending on your logic.
* Use `if-elif-else` to simplify multiple mutually exclusive conditions instead of deep nesting.
* Remember, inner conditions execute **only if the outer condition path is active**.

---
---

### Numeric Comparisons

#### Concept / What:

Numeric comparisons allow you to compare **integer values** in shell scripts. They are used inside conditional statements (`if`, `if-else`, `if-elif-else`) to test equality, inequality, or relative magnitude of numbers.

#### Why / Purpose / Use Case:

* Determine program flow based on numeric values.
* Validate input, perform calculations, or check system metrics.
* Practical examples:

  * Check if a number is positive, negative, or zero.
  * Compare user input against thresholds.
  * Automate actions based on disk usage, memory, or CPU metrics.

#### How it Works / Steps / Syntax:

**Numeric Comparison Operators:**

| Operator | Meaning                  | Example             |
| -------- | ------------------------ | ------------------- |
| `-eq`    | equal to                 | `[ "$a" -eq "$b" ]` |
| `-ne`    | not equal to             | `[ "$a" -ne "$b" ]` |
| `-lt`    | less than                | `[ "$a" -lt "$b" ]` |
| `-le`    | less than or equal to    | `[ "$a" -le "$b" ]` |
| `-gt`    | greater than             | `[ "$a" -gt "$b" ]` |
| `-ge`    | greater than or equal to | `[ "$a" -ge "$b" ]` |

**Example: Integer Comparison:**

```bash
#!/bin/bash
echo "Enter a number:"
read num

if [ "$num" -gt 0 ]; then
    echo "Positive number"
elif [ "$num" -lt 0 ]; then
    echo "Negative number"
else
    echo "Zero"
fi
```

**Floating-point Comparison using `bc`:**

```bash
#!/bin/bash
echo "Enter first number:"
read num1
echo "Enter second number:"
read num2

if (( $(echo "$num1 > $num2" | bc -l) )); then
    echo "$num1 is greater than $num2"
elif (( $(echo "$num1 < $num2" | bc -l) )); then
    echo "$num1 is less than $num2"
else
    echo "$num1 is equal to $num2"
fi
```

* `bc` is simpler and more readable for floating-point comparisons compared to `awk`.

**Floating-point Comparison using `awk` (less simple):**

```bash
awk -v a="$num1" -v b="$num2" 'BEGIN { if (a > b) print "a is greater"; else print "b is greater or equal"}'
```

#### Validating Numeric Input Using Regex:

* Ensure user input is numeric before performing comparisons.
* Example: Validate integer input:

```bash
if [[ "$num" =~ ^-?[0-9]+$ ]]; then
    echo "Valid integer"
else
    echo "Not a valid integer"
fi
```

* Example: Validate floating-point input:

```bash
if [[ "$num" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Valid float"
fi
```

* Explanation of Regex components:

  * `^` → start of string
  * `-?` → optional minus sign
  * `[0-9]+` → one or more digits
  * `(\.[0-9]+)?` → optional decimal part
  * `$` → end of string

**Tip:** You don’t need to memorize the regex; understand the components and structure so you can reconstruct it for integers or floats as needed.

#### Common Issues / Errors:

* Using `=` instead of `-eq` for integers.
* Forgetting spaces around `[ ]`.
* Quoting variables incorrectly.
* Bash integer comparisons cannot handle decimals. Use `bc` or `awk`.

#### Troubleshooting / Fixes:

* Use the correct numeric operators (`-eq`, `-ne`, `-lt`, etc.).
* Ensure spaces around `[ ]`.
* Quote variables to handle empty input.
* Validate input using regex before comparing.

#### Best Practices / Tips:

* Quote variables to avoid errors with empty input.
* Validate that input is numeric using regex.
* For floating-point comparisons, prefer `bc` over `awk` for simplicity.
* Use `if-elif-else` for multiple numeric ranges.

#### Example Script (Integer validation + comparison):

```bash
#!/bin/bash
echo "Enter an integer number:"
read num

if [[ "$num" =~ ^-?[0-9]+$ ]]; then
    if [ "$num" -gt 0 ]; then
        echo "Positive number"
    elif [ "$num" -lt 0 ]; then
        echo "Negative number"
    else
        echo "Zero"
    fi
else
    echo "Invalid input: not a numeric value"
fi
```

---
---

### String Comparisons

#### Concept / What

String comparisons allow you to check equality, inequality, or whether a string is empty/non-empty in shell scripts. Operators include `=`, `!=`, `-z`, `-n`.

#### Why / Purpose / Use Case

* Validate user input or commands.
* Compare variable values or filenames.
* Control flow based on textual data.
* Examples: checking usernames, verifying commands, or checking if a variable is empty.

#### How it Works / Steps / Syntax

* `[ "$a" = "$b" ]` → checks equality.
* `[ "$a" != "$b" ]` → checks inequality.
* `[ -z "$a" ]` → true if string is empty.
* `[ -n "$a" ]` → true if string is not empty.
* Bash-specific: `[[ "$a" == "$b" ]]` supports pattern matching.

**Example:**

```bash
#!/bin/bash
echo "Enter username:"
read user

if [ "$user" = "admin" ]; then
    echo "Welcome, admin!"
elif [ -n "$user" ]; then
    echo "Hello, $user!"
else
    echo "No username entered."
fi
```

#### Common Issues / Errors

* Forgetting quotes around variables → breaks with empty strings.
* Using `==` in POSIX `sh` → syntax error.
* Confusing `-z` and `-n`.

#### Troubleshooting / Fixes

* Always quote variables: `[ "$var" = "value" ]`.
* Use `[[ ]]` in Bash for `==` or pattern matching.
* Validate input to avoid empty strings.

#### Best Practices / Tips

* Quote all string variables.
* Prefer `=` for portability; use `==` only in Bash with `[[ ]]`.
* For pattern matching, use `[[ "$a" == foo* ]]`.

#### Doubts / Extra Explanation

* `=` compares **exact characters**, not number of words or length.
* Case-sensitive: `"Hello"` ≠ `"hello"`.
* Can be used to check palindromes:

```bash
read -p "Enter a string: " str
if [ "$str" = "$(echo "$str" | rev)" ]; then
    echo "Palindrome"
else
    echo "Not a palindrome"
fi
```


---
---

### File Tests in Shell Scripting

#### Concept / What

File tests are conditional checks used to verify the existence, type, and properties of files or directories before performing operations.

#### Why / Purpose / Use Case

* Ensure a file exists before reading/writing.
* Check file type (regular file, directory, symbolic link, etc.).
* Check file permissions (readable, writable, executable).
* Compare modification times between files.
* Examples: Backup only if file exists, execute script only if executable, operate only on directories.

#### How it Works / Steps / Syntax

Common file test operators:

| Operator | Meaning                                   |
| -------- | ----------------------------------------- |
| `-f`     | True if file exists and is a regular file |
| `-d`     | True if directory exists                  |
| `-L`     | True if symbolic link                     |
| `-r`     | True if file is readable                  |
| `-w`     | True if file is writable                  |
| `-x`     | True if file is executable                |
| `-s`     | True if file is not empty (size > 0)      |
| `-b`     | True if file is a block device            |
| `-c`     | True if file is a character device        |
| `-nt`    | True if file1 is newer than file2         |
| `-ot`    | True if file1 is older than file2         |
| `-o`     | True if file exists (similar to `-e`)     |

**Example:**

```bash
#!/bin/bash
file="/etc/passwd"

if [ -f "$file" ]; then
    echo "$file exists and is a regular file."
fi

if [ -r "$file" ]; then
    echo "$file is readable."
fi
```

#### Common Issues / Errors

* Forgetting quotes around file names with spaces.
* Using wrong operator (`-d` vs `-f`).
* Confusing `-nt` and `-ot`.

#### Troubleshooting / Fixes

* Always quote file paths: `[ -f "$file" ]`.
* Double-check file operators.
* Test commands individually if failing.

#### Best Practices / Tips

* Use file tests before reading/writing files.
* Prefer `-e` or `-o` for generic existence check.
* Combine multiple tests with `&&` or `||`.

#### Memorization / How to Remember

**1. Group by purpose:**

* **Existence / Type:** `-e`, `-o`, `-f`, `-d`, `-L`, `-b`, `-c`
* **Permissions:** `-r`, `-w`, `-x`
* **Size / Content:** `-s`
* **Time:** `-nt`, `-ot`

**2. Mnemonics:**

* `f` → file, `d` → directory, `L` → link
* `r, w, x` → standard permissions
* `s` → size > 0
* `nt / ot` → newer than / older than

**3. Practice with scripts:**

```bash
[ -f "$file" ] && echo "file"
[ -d "$file" ] && echo "directory"
[ -r "$file" ] && echo "readable"
```

**4. Flashcards / Quick reference:**

```
-f → file, -d → directory, -L → link, -r → readable, -w → writable, -x → executable
```

**Tip:** Start with common ones (`-f`, `-d`, `-r`, `-w`, `-x`) and add others as you practice.

---
---

### Logical Operators in Shell Scripting

#### Concept / What

Logical operators allow you to combine multiple conditions or negate a condition in shell scripts, making decision-making more powerful and concise.

Operators:

* `&&` → logical AND
* `||` → logical OR
* `!`  → logical NOT (negates a condition)

#### Why / Purpose / Use Case

* Combine multiple conditions in `if` statements.
* Execute commands conditionally without nested `if`s.
* Negate a condition to run commands when a test is false.
* Examples:

  * Run a script only if both files exist (`&&`).
  * Run a command if either condition is true (`||`).
  * Execute something only if a file does not exist (`!`).

#### How it Works / Steps / Syntax

**AND (`&&`)**

```bash
if [ -f file1 ] && [ -r file1 ]; then
    echo "file1 exists and is readable"
fi
```

**OR (`||`)**

```bash
if [ -f file1 ] || [ -f file2 ]; then
    echo "At least one file exists"
fi
```

**NOT (`!`)**

```bash
if [ ! -f file1 ]; then
    echo "file1 does not exist"
fi
```

* `!` reverses the condition: true → false, false → true

**Command chaining**

```bash
mkdir mydir && echo "Directory created" || echo "Failed to create"
```

* `&&` executes next command if previous succeeds
* `||` executes next command if previous fails

#### Common Issues / Errors

* Forgetting spaces around `[ ]` and `!`.
* Mixing `[ ]` and `[[ ]]` with logical operators incorrectly.
* Misunderstanding precedence between `&&` and `||`.

#### Troubleshooting / Fixes

* Always quote variables inside `[ ]`.
* Use parentheses `()` to group conditions if mixing `&&` and `||`.
* Prefer `[[ ]]` in Bash for complex expressions.

#### Best Practices / Tips

* Use logical operators to simplify nested `if` statements.
* Test commands individually first.
* Use parentheses to clarify combined conditions.
* Remember `!` negates a condition, running the block when the condition is false.

#### Example Script

```bash
#!/bin/bash
read -p "Enter a filename: " file1
read -p "Enter another filename: " file2

if [ -f "$file1" ] && [ -r "$file1" ]; then
    echo "$file1 exists and is readable"
fi

if [ -f "$file1" ] || [ -f "$file2" ]; then
    echo "At least one of the files exists"
fi

if [ ! -f "$file2" ]; then
    echo "$file2 does not exist"
fi

# Command chaining
mkdir testdir && echo "Directory created" || echo "Failed to create directory"
```

---
---

### Conditional Execution Using Command Chaining

#### Concept / What

Conditional execution using command chaining lets you run commands depending on the success or failure of a previous command without explicitly writing `if` statements.

* `&&` → run next command if previous succeeds (exit status 0)
* `||` → run next command if previous fails (non-zero exit status)

#### Why / Purpose / Use Case

* Avoid verbose `if-else` blocks for simple tasks.
* Execute commands only when the previous command succeeds or fails.
* Examples:

  * Create a directory and confirm creation: `mkdir mydir && echo "Created"`
  * Run a command only if a file exists: `[ -f file ] && cat file`
  * Fallback action if a command fails: `cp file1 file2 || echo "Copy failed"`

#### How it Works / Steps / Syntax

**1. AND chaining (`&&`):**

```bash
mkdir testdir && echo "Directory created"
```

**2. OR chaining (`||`):**

```bash
mkdir testdir || echo "Failed to create directory"
```

**3. Combining both:**

```bash
mkdir testdir && echo "Created" || echo "Creation failed"
```

**4. Multiple commands:**

```bash
[ -f file.txt ] && echo "File exists" && cat file.txt || echo "File missing"
```

#### Common Issues / Errors

* Misunderstanding `&&` and `||` precedence.
* Forgetting to quote filenames with spaces.
* Using chaining for complex multi-condition logic can become unreadable.

#### Troubleshooting / Fixes

* Use parentheses to group commands: `(cmd1 && cmd2) || cmd3`
* Test individual commands before chaining.
* For complex logic, prefer `if-else` for clarity.

#### Best Practices / Tips

* Use for simple conditional executions, not complex branching.
* Always quote variables or filenames.
* Keep chains short for readability.

#### Example Script

```bash
#!/bin/bash
read -p "Enter filename: " file

# Simple AND
[ -f "$file" ] && echo "$file exists"

# Simple OR
[ -f "$file" ] || echo "$file does not exist"

# Combined
[ -f "$file" ] && echo "$file exists and content:" && cat "$file" || echo "File missing or cannot read"
```

---
---




