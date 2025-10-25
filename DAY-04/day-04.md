### Day 4: Loops - Introduction

#### Concept / What:

Loops in shell scripting allow you to **execute a block of code repeatedly** based on a condition or a sequence. They help automate repetitive tasks, reduce code duplication, and handle multiple items efficiently.

#### Why / Purpose / Use Case:

* Automate repetitive tasks without rewriting code multiple times.
* Process multiple files, numbers, or inputs sequentially.
* Practical examples:

  * Print numbers from 1 to 100.
  * Read all files in a directory and perform operations on each.
  * Continuously check system status until a condition is met.

#### How it Works / Steps / Syntax:

* A loop generally has:

  1. **Initialization** (optional)
  2. **Condition** (when to continue looping)
  3. **Body** (commands to execute each iteration)
  4. **Increment / Decrement** (for counting loops)

* Three main types of loops in Bash:

  1. `for` loop → iterate over a sequence or list.
  2. `while` loop → repeat while a condition is true.
  3. `until` loop → repeat until a condition becomes true.

#### Common Issues / Errors:

* Infinite loops due to wrong conditions.
* Syntax errors with `do` and `done`.
* Forgetting to update counters in `while` loops (causes infinite loops).

#### Troubleshooting / Fixes:

* Always check your loop condition carefully.
* Use `break` to exit loops when needed.
* Use `echo` inside loops to debug iterations.

#### Best Practices / Tips:

* Keep loops simple and readable.
* Prefer `for` loops for fixed sequences and `while/until` for conditional loops.
* Use indentation to clearly separate loop body.

#### Example Script:

```bash
#!/bin/bash
# Print numbers from 1 to 5
for i in {1..5}; do
    echo "Number: $i"
done
```

---
---

### Day 4: Loops - For Loop

#### Concept / What:

The `for` loop in shell scripting is used to iterate over a **predefined list of items** or a **known numeric range**. It allows executing a block of commands repeatedly for each item or number in the list.

#### Why / Purpose / Use Case:

* Automates repetitive tasks when the number of iterations or items is known beforehand.
* Useful for iterating over numbers, strings, files, directories, or command outputs.
* Examples:

  * Iterating over files in a directory.
  * Running commands multiple times for a known number of iterations.
  * Processing a list of users, hosts, or predefined values.

#### How it Works / Steps / Syntax:

1. **Basic list iteration:**

```bash
for var in item1 item2 item3; do
    commands
done
```

2. **Range iteration:**

```bash
for var in {1..5}; do
    commands
done
```

3. **Command substitution (iterating over command output):**

```bash
for file in $(ls /path/to/dir); do
    commands
done
```

4. **C-style loop (numeric, arithmetic increments/decrements):**

```bash
for ((i=1; i<=10; i++)); do
    commands
done
```

* Increment can be adjusted:

  * Add 2: `i+=2`
  * Subtract 3: `i-=3`
* Complex arithmetic expressions can be used in the increment/decrement part.

#### Common Issues / Errors:

* Forgetting `do` and `done` keywords.
* Missing spaces around `in` or in `{ }` ranges.
* Using unquoted variables when iterating over strings with spaces.
* Using command substitution incorrectly (forgetting `$()`).

#### Troubleshooting / Fixes:

* Always quote variables when necessary: `for file in "$files"; do ...`.
* Check loop syntax carefully: `for var in ...; do ... done`.
* For C-style loops, ensure proper syntax with `(( ))` and valid arithmetic expressions.

#### Best Practices / Tips:

* Use `for` loop when the **number of iterations is known** before starting the loop.
* Prefer `while` loop when the number of iterations is unknown.
* Keep loop body simple and readable.
* Use meaningful variable names instead of `i` when iterating over strings or files.
* Combine with `if` statements for more complex logic.

## 🔁 Rule: Condition and Increment/Decrement Must Be Opposite

In a `for` loop, the **condition** and the **increment/decrement** must always work in **opposite directions** to avoid infinite loops.

### 💡 Concept

* The **condition** determines when the loop should **stop**.
* The **increment/decrement** moves the loop variable toward making that condition **false**.

If both move in the same direction, the loop may **never end**.

---

### ✅ Correct Examples

**Increasing Loop:**

```bash
for ((i=1; i<=5; i++)); do
    echo $i
done
```

➡️ Runs 1 → 5 and stops when `i` becomes 6.

**Decreasing Loop:**

```bash
for ((i=5; i>=1; i--)); do
    echo $i
done
```

➡️ Runs 5 → 1 and stops when `i` becomes 0.

---

### ❌ Wrong Example (Infinite Loop)

```bash
for ((i=5; i<=5; i--)); do
    echo $i
done
```

Here, both the condition (`i<=5`) and the update (`i--`) move in the same direction. The condition always stays true → infinite loop.

---

### 🧠 Summary Rule

> ✅ Always make sure that your condition and increment/decrement work in **opposite directions** so that the condition eventually becomes **false** and the loop exits safely.

#### Example Scripts:

1. **Iterate over a list of strings:**

```bash
#!/bin/bash
for fruit in apple banana mango; do
    echo "Fruit: $fruit"
done
```

2. **Iterate over a numeric range:**

```bash
#!/bin/bash
for i in {1..5}; do
    echo "Number: $i"
done
```

3. **C-style loop with arithmetic increments:**

```bash
#!/bin/bash
for ((i=1; i<=10; i+=2)); do
    echo "Odd Number: $i"
done
```

4. **C-style loop with decrement:**

```bash
#!/bin/bash
for ((i=10; i>0; i-=3)); do
    echo "Count: $i"
done
```

5. **Using command substitution:**

```bash
#!/bin/bash
for file in $(ls /tmp); do
    echo "File: $file"
done
```

#### When to Use For Loop:

* Use `for` loop **only when the number of items or iterations is known**.
* Examples: iterating over known lists, numeric ranges, or predictable command outputs.
* For unknown iterations, use `while` loop instead.

---
---

# Shell Scripting — While Loop Notes

## 🔹 Overview

The **`while` loop** in shell scripting executes a set of commands repeatedly **as long as the given condition is true**.

---

## 🔹 Syntax

```bash
while [ condition ]
do
   # commands
   ...
done
```

### Example:

```bash
count=1
while [ $count -le 5 ]
do
  echo "Count is $count"
  count=$((count + 1))
done
```

---

## 🔹 Key Behavior

* The loop continues **while** the condition returns an **exit status of 0 (true)**.
* When the condition returns a **non-zero value (false)**, the loop stops.
* The **exit status** is what decides the continuation — not necessarily a comparison operator. Any command can act as a condition.

---

## 🔹 Types of `while` Loops

### 1️⃣ Counter-Based While Loop

Used when you want to repeat an operation a fixed number of times.

```bash
count=1
while [ $count -le 5 ]
do
  echo "Iteration $count"
  ((count++))  # or count=$((count + 1))
done
```

You can use other arithmetic operations like `count--`, `count*=2`, etc.

---

### 2️⃣ Command-Based While Loop

The condition is a **command** whose success/failure controls the loop.

```bash
while ping -c1 google.com &> /dev/null
do
  echo "Internet is up"
  sleep 5
done
```

Here, `ping` acts as the condition. The loop runs **as long as** `ping` returns 0 (success).

---

### 3️⃣ File Line-Based While Loop

Used to read a file line by line.

```bash
while IFS= read -r line
do
  echo "$line"
done < sample.txt
```

#### 🔸 Explanation:

* `IFS=` → Preserves leading/trailing spaces in the line.
* `-r` → Prevents backslash (`\`) from being treated as escape characters.
* `< sample.txt` → Redirects the file content to the while loop.

This loop ends when the **`read` command** fails (returns non-zero) at **end of file (EOF)**.

#### 🔸 Why `read` works as a condition:

* Like any other Linux command, `read` returns an exit status.
* It returns **0 (true)** when it successfully reads a line.
* It returns **non-zero (false)** when it reaches the **end of file**, causing the loop to stop.

#### 🔸 Why no brackets `[ ]` are used here:

* Because the **command itself (read)** acts as the condition. You don’t need a test expression like `[ condition ]`.

---

### 4️⃣ Infinite While Loop

Used when you need the loop to run forever (until manually stopped).

```bash
while true
do
  echo "Running..."
  sleep 2
done
```

Or equivalently:

```bash
while :
do
  echo "Running..."
  sleep 2
done
```

---

## 🔹 Summary Points

* Every Linux command returns an **exit status** — 0 for success, non-zero for failure.
* The **while** loop continues as long as the condition/command returns 0.
* The **`read`** command is often used as a condition in file-reading loops.
* Using `IFS=` and `-r` ensures the line content is read exactly as it appears.
* When EOF is reached, `read` returns non-zero, stopping the loop.
* Brackets `[ ]` are not mandatory — only required for test-based conditions.

---

✅ **Practical Summary:**

| Type            | Use Case                      | Condition Example     |
| --------------- | ----------------------------- | --------------------- |
| Counter-Based   | Loop with numeric condition   | `[ $i -le 5 ]`        |
| Command-Based   | Loop based on command success | `ping -c1 google.com` |
| File Line-Based | Read file line by line        | `IFS= read -r line`   |
| Infinite Loop   | Continuous loop               | `true` or `:`         |

---
---

### Concept / What: Until Loops

**Definition:**
An `until` loop repeatedly executes a block of commands until a specified condition becomes true. It is the opposite of a `while` loop, which runs while a condition is true.

---

### Why / Purpose / Use Case

* Used when you want to keep executing commands while a condition is false.
* Common scenarios:

  * Retrying operations until success (e.g., pinging a host)
  * Waiting for a file to exist
  * Polling a resource periodically until it reaches a certain state

---

### How it Works / Steps / Syntax

**Syntax:**

```bash
until [ condition ]
do
    # commands to execute
done
```

* Condition is evaluated before each iteration.
* Loop continues while the condition is false.
* Once the condition becomes true, the loop exits.

**Example 1: Simple Counter**

```bash
#!/bin/bash
count=1
until [ $count -gt 5 ]
do
  echo "Count is $count"
  ((count++))
done
```

**Example 2: Wait for a File**

```bash
#!/bin/bash
until [ -f "/tmp/myfile.txt" ]
do
  echo "Waiting for /tmp/myfile.txt to appear..."
  sleep 2
done
echo "File found!"
```

**Example 3: Retry Ping Until Host Reachable**

```bash
#!/bin/bash
host="google.com"
count=1
until ping -c 1 $host &> /dev/null
do
  echo "Attempt $count: $host is not reachable. Retrying..."
  ((count++))
  sleep 3
done

echo "$host is reachable after $count attempts."
```

---

### Variations / Types

1. **Variable-based condition**

```bash
until [ $count -gt 5 ]; do ...
```

2. **Command-based condition**

```bash
until ping -c 1 google.com &> /dev/null; do ...
```

3. **Inline single command**

```bash
until mkdir /tmp/mydir 2>/dev/null; do :; done
```

4. **Nested loops / combined with conditionals**

```bash
count=1
until [ $count -gt 3 ]; do
  for i in a b c; do
    echo "$count - $i"
  done
  ((count++))
done
```

---

### Common Issues / Errors

* Infinite loop if the condition never becomes true.
* Syntax errors: missing `do` or `done`.
* Incorrect condition logic (wrong operators or forgetting variable updates).

---

### Troubleshooting / Fixes

* Ensure the condition can eventually become true.
* Verify variables are updated inside the loop.
* Add debug `echo` statements.
* Use a maximum attempt counter to prevent infinite loops.

---

### Best Practices / Tips

* Use `until` only when the loop should continue while condition is false.
* Prefer `while` loops for "execute while true" scenarios.
* Avoid infinite loops; add timeouts or max attempt limits.
* Keep loops simple and readable.

---

### Example Script

```bash
#!/bin/bash
# Retry ping until host is reachable
host="google.com"
count=1
until ping -c 1 $host &> /dev/null
do
  echo "Attempt $count: $host is not reachable. Retrying..."
  ((count++))
  sleep 3
done

echo "$host is reachable after $count attempts."
```

**Output Example:**

```
Attempt 1: google.com is not reachable. Retrying...
Attempt 2: google.com is not reachable. Retrying...
...
google.com is reachable after 4 attempts.
```

---
---

# Shell Scripting: Nested Loops and Star Patterns

### Concept / What

A **nested loop** is a loop inside another loop. The inner loop executes completely for each iteration of the outer loop. Nested loops can be created using any combination of `for`, `while`, or `until` loops.

---

### Why / Purpose / Use Case

* Used when working with **multi-level data structures** or **hierarchical operations**.
* Common use cases:

  * Printing patterns (like stars or numbers)
  * Iterating through **rows and columns** of a matrix
  * Looping over **files within directories**
  * Combining multiple arrays or datasets

---

### How It Works / Syntax

```bash
for outer in 1 2 3; do
    for inner in a b; do
        echo "Outer: $outer, Inner: $inner"
    done
done
```

The inner loop runs for each iteration of the outer loop.

---

### Example 1: Simple Nested For Loop

```bash
#!/bin/bash
for i in 1 2 3; do
    for j in a b; do
        echo "Outer: $i, Inner: $j"
    done
done
```

**Output:**

```
Outer: 1, Inner: a
Outer: 1, Inner: b
Outer: 2, Inner: a
Outer: 2, Inner: b
Outer: 3, Inner: a
Outer: 3, Inner: b
```

---

### Example 2: Nested While Loops

```bash
#!/bin/bash
count1=1
while [ $count1 -le 2 ]; do
    count2=1
    while [ $count2 -le 3 ]; do
        echo "Outer: $count1, Inner: $count2"
        ((count2++))
    done
    ((count1++))
done
```

**Output:**

```
Outer: 1, Inner: 1
Outer: 1, Inner: 2
Outer: 1, Inner: 3
Outer: 2, Inner: 1
Outer: 2, Inner: 2
Outer: 2, Inner: 3
```

---

### Example 3: Nested Loops with Arrays

```bash
#!/bin/bash
arr1=(1 2)
arr2=(a b c)
for i in "${arr1[@]}"; do
    for j in "${arr2[@]}"; do
        echo "$i - $j"
    done
done
```

**Output:**

```
1 - a
1 - b
1 - c
2 - a
2 - b
2 - c
```

---

### Star Pattern Examples Using Nested Loops

#### 1️⃣ Decreasing Triangle

```bash
#!/bin/bash
rows=5
for ((i=rows; i>=1; i--)); do
    for ((j=1; j<=i; j++)); do
        echo -n "*"
    done
    echo
done
```

**Output:**

```
*****
****
***
**
*
```

---

#### 2️⃣ Increasing Triangle

```bash
#!/bin/bash
rows=5
for ((i=1; i<=rows; i++)); do
    for ((j=1; j<=i; j++)); do
        echo -n "*"
    done
    echo
done
```

**Output:**

```
*
**
***
****
*****
```

---

#### 3️⃣ Right-Aligned Triangle

```bash
#!/bin/bash
rows=5
for ((i=1; i<=rows; i++)); do
    for ((j=i; j<rows; j++)); do
        echo -n " "
    done
    for ((k=1; k<=i; k++)); do
        echo -n "*"
    done
    echo
done
```

**Output:**

```
    *
   **
  ***
 ****
*****
```

---

#### 4️⃣ Pyramid / Centered Triangle

```bash
#!/bin/bash
rows=5
for ((i=1; i<=rows; i++)); do
    for ((j=i; j<rows; j++)); do
        echo -n " "
    done
    for ((k=1; k<=2*i-1; k++)); do
        echo -n "*"
    done
    echo
done
```

**Output:**

```
    *
   ***
  *****
 *******
*********
```

---

#### 5️⃣ Square Pattern

```bash
#!/bin/bash
rows=5
for ((i=1; i<=rows; i++)); do
    for ((j=1; j<=rows; j++)); do
        echo -n "*"
    done
    echo
done
```

**Output:**

```
*****
*****
*****
*****
*****
```

---

### Common Issues / Errors

* Infinite loops when counters or conditions are incorrect.
* Variable name conflicts between inner and outer loops.
* Output formatting issues when using `echo` without `-n`.

---

### Troubleshooting / Fixes

* Always initialize and increment loop counters correctly.
* Use distinct variable names for each loop.
* Use `echo -n` carefully to avoid unwanted newlines.

---

### Best Practices / Tips

* Avoid deep nesting (>2 levels) for readability.
* Use comments to clarify which loop does what.
* For performance-heavy tasks, prefer `awk`, `xargs`, or array operations.

---

**End of Nested Loops Notes**

---
---

## Shell Scripting: Arrays, Files, and Directories with Loops

### Concept / What

An **array** in Bash is a variable that can hold **multiple values**, each with an **index** starting from 0. Arrays allow grouping related items and iterating over them.

Looping over **files and directories** means using loops to process multiple files or directories dynamically, instead of manually specifying each one.

---

### Why / Purpose / Use Case

* **Arrays:**

  * Store multiple related values in a single variable.
  * Useful for iterating over items like filenames, usernames, or fruits.
  * Performing operations on each element.

* **Files/Directories:**

  * Automate processing of multiple files (e.g., reading, copying, renaming).
  * Traverse directories recursively or perform batch operations.
  * Avoid hardcoding filenames, making scripts scalable.
## How to Define an Array in Bash

**Syntax:**

```bash
array_name=(item1 item2 item3 ...)
```

**Example:**

```bash
fruits=(apple banana cherry)  # Defines an array named 'fruits' with three elements
```


## Bash Array Basics with Example

* **Access single element:** Use `${array[index]}` to get a specific element. For example, `fruits=(apple banana cherry); echo ${fruits[1]}` prints `banana`.

* **Access all elements:** `${array[@]}` gives all elements separately, while `${array[*]}` treats them as a single string. Example: `echo "${fruits[@]}"` outputs `apple banana cherry`.

* **Number of elements:** `${#array[@]}` returns the total elements. Example: `echo ${#fruits[@]}` outputs `3`.

* **Length of an element:** `${#array[index]}` gives the character count of that element. Example: `echo ${#fruits[0]}` outputs `5` for `apple`.

---

### How It Works / Syntax

**Arrays:**

```bash
fruits=(apple banana cherry)
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

* `fruit` is the loop variable holding the current element.
* `"${fruits[@]}"` expands all elements.

**Sum of characters in array elements:**

```bash
total_chars=0
for fruit in "${fruits[@]}"; do
    total_chars=$((total_chars + ${#fruit}))
done
echo "Total characters: $total_chars"
```

**Looping over files in a directory:**

```bash
for file in /path/to/directory/*; do
    if [ -f "$file" ]; then
        echo "File: $file"
    fi
done
```

**Looping over directories:**

```bash
for dir in /path/to/directory/*; do
    if [ -d "$dir" ]; then
        echo "Directory: $dir"
    fi
done
```

* `*` expands all items in the path.
* `[ -f ]` checks if it’s a file, `[ -d ]` checks if it’s a directory.
* Loop variable (`file` or `dir`) temporarily holds each item.

---

### Common Issues / Errors

* Forgetting quotes around `"${array[@]}"` breaks elements with spaces.
* Confusing **element count** (`${#array[@]}`) with **character length** (`${#array[index]}`).
* Using wrong test conditions (`-f` vs `-d`) when looping through paths.
* Infinite loops if counters or conditions are wrong.

---

### Troubleshooting / Fixes

* Quote array expansions: `"${array[@]}"`.
* Initialize accumulator variables before loops.
* Use distinct loop variable names to avoid conflicts.
* Test file and directory checks to prevent errors when unexpected types exist.

---

### Best Practices / Tips

* Use descriptive names for arrays, loop variables, and paths.
* Loop variables are temporary and independent from the array or path.
* For total sums or accumulations, initialize variables first and update inside the loop.
* Prefer `"${array[@]}"` for elements with spaces.
* Use checks `[ -f ]` and `[ -d ]` to differentiate files and directories.

---

### Example Scripts

**1️⃣ Array iteration:**

```bash
fruits=(apple banana cherry)
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

**2️⃣ Total characters in array elements:**

```bash
total_chars=0
for fruit in "${fruits[@]}"; do
    total_chars=$((total_chars + ${#fruit}))
done
echo "Total characters: $total_chars"
```

**3️⃣ Loop through files:**

```bash
for file in /tmp/*; do
    if [ -f "$file" ]; then
        echo "File: $file"
    fi
done
```

**4️⃣ Loop through directories:**

```bash
for dir in /tmp/*; do
    if [ -d "$dir" ]; then
        echo "Directory: $dir"
    fi
done
```

---

**End of Arrays, Files, and Directories Looping Notes**

---
---

# Concept: Use `break` and `continue` inside loops

---

### Concept / What

`break` and `continue` are loop control statements used to alter the normal flow of execution in loops.

* `break` → Immediately terminates the loop.
* `continue` → Skips the current iteration and moves to the next one.

They work only inside loops (`for`, `while`, `until`) but are commonly paired with conditionals like `if` to control when to trigger them.

---

### Why / Purpose / Use Case

Used to make loops smarter and more efficient by controlling how and when iterations occur.

**Use Cases:**

* Exit a loop early when a target is found (`break`).
* Skip invalid data or unwanted entries (`continue`).
* Stop retries once success is achieved.
* Improve performance by avoiding unnecessary iterations.

---

### How it Works / Steps / Syntax

#### Syntax

```bash
break       # exits the loop completely
continue    # skips to the next iteration
```

#### Example 1: Using `break`

```bash
#!/bin/bash
for fruit in apple banana mango orange grape; do
  echo "Checking: $fruit"
  if [[ "$fruit" == "mango" ]]; then
    echo "Found mango, exiting loop."
    break
  fi
done

echo "Loop terminated."
```

#### Example 2: Using `continue`

```bash
#!/bin/bash
for num in {1..5}; do
  if [[ $num -eq 3 ]]; then
    echo "Skipping number 3"
    continue
  fi
  echo "Processing number: $num"
done
```

#### Example 3: Using both `break` and `continue` in the same loop

```bash
#!/bin/bash
for i in {1..10}; do
  if (( i == 3 )); then
    echo "Skipping $i"
    continue
  fi
  if (( i == 7 )); then
    echo "Found $i — exiting loop"
    break
  fi
  echo "Processing $i"
done

echo "Loop finished."
```

#### Example 4: Nested loops with `break` and `continue`

```bash
#!/bin/bash
for user in "alice" "bob"; do
  echo "Checking files for user: $user"
  for file in "report.txt" "notes.txt" "error.log" "todo.txt"; do
    if [[ "$file" == *".bak" ]]; then
      echo "Skipping backup file: $file"
      continue
    fi
    echo "Inspecting $file ..."
    if [[ "$file" == "error.log" ]]; then
      echo "Found critical file (error.log)! Stopping inner loop."
      break
    fi
  done
  echo "Completed scan for $user"
  echo "----------------------------"
done

echo "All user checks done!"
```

---

### Common Issues / Errors

| Issue                                  | Cause                                               |
| -------------------------------------- | --------------------------------------------------- |
| `break: only meaningful in a loop`     | Using break or continue outside a loop.             |
| Loop doesn’t exit even after condition | Condition logic or comparison operator mistake.     |
| Unexpected skip                        | `continue` used before important code in iteration. |

---

### Troubleshooting / Fixes

* Check loop boundaries and condition logic.
* Use `echo` for debugging — print values before break or continue to confirm flow.
* Ensure correct comparison syntax (`==` for strings, `-eq` for numbers).

---

### Best Practices / Tips

* Use `break` only when early exit is truly needed.
* For nested loops, `break N` can exit multiple levels (e.g., `break 2`).
* Keep `continue` usage clear; comment when skipping logic is non-obvious.
* Prefer descriptive conditions for readability.

---
---


