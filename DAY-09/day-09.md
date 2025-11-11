# Day 9: Debugging and Error Handling

## 🧩 Concept 1: Using `set -x`, `set -v`, `set -e` for Debugging

### **Concept / What**

The `set` command enables or disables special shell options to control how a script behaves.

* `set -x`: Shows each command and its arguments before execution.
* `set -v`: Prints script lines as they are read (before execution).
* `set -e`: Exits the script immediately if a command fails.

---

### **Why / Purpose / Use Case**

Used for:

* Debugging and tracing execution flow.
* Catching failing commands automatically (`set -e`).
* Understanding variable expansion and loops (`set -x` / `set -v`).
* Preventing long-running scripts from continuing after an error.

---

### **How it Works / Steps / Syntax**

**Syntax:**

```bash
set -x   # Enable command tracing
set +x   # Disable command tracing

set -v   # Verbose mode: prints each command as read
set +v   # Disable verbose mode

set -e   # Exit immediately on any non-zero exit status
set +e   # Disable exit-on-error
```

---

### **Example Script**

```bash
#!/bin/bash
# debug_example.sh
# Demonstrates set -x, -v, -e usage

set -e   # Exit immediately if a command fails
set -x   # Print commands before execution

echo "Starting deployment simulation..."
mkdir /tmp/demo_dir

# Intentional failure (this directory already exists on rerun)
mkdir /tmp/demo_dir   # This will fail if rerun without deleting

echo "This line won't execute if mkdir fails."

set +x
echo "Script completed."
```

---

### **Sample Output (First Run)**

```bash
$ bash debug_example.sh
+ echo 'Starting deployment simulation...'
Starting deployment simulation...
+ mkdir /tmp/demo_dir
+ mkdir /tmp/demo_dir
+ echo 'This line won'\''t execute if mkdir fails.'
This line won't execute if mkdir fails.
+ set +x
Script completed.
```

---

### **Sample Output (Second Run)**

```bash
$ bash debug_example.sh
+ echo 'Starting deployment simulation...'
Starting deployment simulation...
+ mkdir /tmp/demo_dir
mkdir: cannot create directory ‘/tmp/demo_dir’: File exists
```

**Explanation:**

* The second `mkdir` fails (exit code `1`).
* Because of `set -e`, the script **terminates immediately**.
* The line `echo "This line won't execute..."` never runs.
* `set -x` clearly shows which command failed.

---

### **Common Issues / Errors**

* Too much debug output when using `set -x` in long scripts.
* Script stops unexpectedly if `set -e` is enabled and a non-critical command fails.
* Sensitive data (like passwords) may appear in debug logs.

---

### **Troubleshooting / Fixes**

* Ignore specific failures:

  ```bash
  mkdir /tmp/demo_dir || true
  ```
* Redirect debug output:

  ```bash
  exec 2>debug.log
  set -x
  ```
* Temporarily disable tracing:

  ```bash
  set +x
  # do sensitive work
  set -x
  ```

---

### **Best Practices / Tips**

✅ Use `set -e` and `set -x` during development.
✅ Disable tracing around confidential info.
✅ Avoid `set -v` in CI/CD — it clutters logs.
✅ Always disable debug mode before production use.

---
---


# Day 9: Debugging and Error Handling

## 🧩 Concept 2: Check Exit Status with `$?`

### **Concept / What**

`$?` is a special shell variable that stores the **exit status** (return code) of the **last executed command**.

* `0` → command executed **successfully**
* Non-zero → command **failed** (value depends on type of error)

---

### **Why / Purpose / Use Case**

The exit status helps determine **whether the previous command ran successfully** or failed — useful for conditional logic and error handling in scripts.

✅ **Practical Use Cases:**

* To stop or continue execution based on command success/failure.
* To print custom error messages.
* To implement retry mechanisms or logs for failed commands.

---

### **How it Works / Steps / Syntax**

**Syntax:**

```bash
command
echo $?
```

**Example Commands:**

```bash
ls /tmp           # valid directory
echo $?            # prints 0 (success)

ls /invalidpath    # invalid directory
echo $?            # prints 2 (failure)
```

**Usage in Script:**

```bash
#!/bin/bash

echo "Checking directory existence..."
ls /tmp
echo "Exit status: $?"

ls /invalidpath
echo "Exit status: $?"
```

---

### **Sample Output**

```bash
$ bash exit_status.sh
Checking directory existence...
bin  cache  demo_dir
Exit status: 0
ls: cannot access '/invalidpath': No such file or directory
Exit status: 2
```

**Explanation:**

* The first `ls` succeeded → exit code `0`.
* The second `ls` failed → exit code `2`.
* `$?` immediately reflects the exit code of the **most recent** command.

---

### **Common Issues / Errors**

* `$?` only stores the exit status of the **last executed command** — running another command before checking it overwrites the value.
* Forgetting to check `$?` right after a command may return incorrect results.
* Not all programs use the same exit code convention (e.g., 1, 2, 127).

---

### **Troubleshooting / Fixes**

* Always check `$?` **immediately** after the command you want to validate.
* Use `set -e` for automatic failure exit if `$?` ≠ 0.
* Combine with `if` conditions:

  ```bash
  if command; then
      echo "Command succeeded"
  else
      echo "Command failed with code $?"
  fi
  ```

---

### **Best Practices / Tips**

✅ Check `$?` right after critical commands only.
✅ Avoid unnecessary `$?` checks for non-impactful commands.
✅ Use meaningful messages for better debugging.
✅ Pair `$?` with `||` or `&&` for compact syntax:

```bash
command && echo "Success" || echo "Failed"
```

---

### **Example Script**

```bash
#!/bin/bash
# exit_status_example.sh
# Demonstrates use of $? for checking command success or failure

echo "Attempting to create directory..."
mkdir /tmp/exit_demo
if [ $? -eq 0 ]; then
    echo "Directory created successfully!"
else
    echo "Failed to create directory!"
fi

echo "Trying to remove non-existent directory..."
rmdir /tmp/non_existing_dir
if [ $? -ne 0 ]; then
    echo "Error: Directory does not exist!"
fi
```

---

### **Sample Output**

```bash
$ bash exit_status_example.sh
Attempting to create directory...
Directory created successfully!
Trying to remove non-existent directory...
rmdir: failed to remove '/tmp/non_existing_dir': No such file or directory
Error: Directory does not exist!
```

---
---

# Day 9: Debugging and Error Handling

## 🧩 Concept 3: Conditional Execution (`&&`, `||`)

### **Concept / What**

`&&` and `||` are **logical operators** used to control the flow of shell script execution based on the **success or failure** of commands.

* `&&` → Executes the next command **only if the previous one succeeds** (`exit status = 0`)
* `||` → Executes the next command **only if the previous one fails** (`exit status ≠ 0`)

They act like **if-else shortcuts** in shell scripting.

---

### **Why / Purpose / Use Case**

These operators are used to create **compact conditional statements** without writing full `if` blocks.

✅ **Common Use Cases:**

* Run a cleanup command only if a task succeeds.
* Print error messages when something fails.
* Chain multiple dependent commands efficiently.
* Simplify CI/CD steps, automation, or health-check scripts.

---

### **How it Works / Steps / Syntax**

**Syntax:**

```bash
command1 && command2     # Run command2 if command1 succeeds
command1 || command2     # Run command2 if command1 fails
```

**Combined Use:**

```bash
command1 && echo "Success" || echo "Failed"
```

> Works like: if `command1` succeeds, print *Success*, else print *Failed*.

---

### **Example Script**

```bash
#!/bin/bash
# conditional_execution.sh

echo "Checking directory..."
ls /tmp && echo "Directory exists!" || echo "Directory missing!"

echo
echo "Trying invalid directory..."
ls /invalidpath && echo "Found!" || echo "Error: Directory not found!"
```

---

### **Sample Output**

```bash
$ bash conditional_execution.sh
Checking directory...
bin  cache  demo_dir
Directory exists!

Trying invalid directory...
ls: cannot access '/invalidpath': No such file or directory
Error: Directory not found!
```

**Explanation:**

* The first `ls /tmp` succeeds → exit code `0` → `&&` executes → prints “Directory exists!”
* The second `ls /invalidpath` fails → exit code non-zero → `||` executes → prints “Error: Directory not found!”

---

### **Common Issues / Errors**

* Forgetting that both operators are evaluated **left to right**.
* Using both together without proper grouping can cause unexpected behavior if the first command returns a non-zero but still valid output.
* Long chained conditions can be hard to debug.

---

### **Troubleshooting / Fixes**

* Use parentheses for clarity in complex conditions:

  ```bash
  (command1 && command2) || command3
  ```
* Add `set -e` to automatically stop execution on failures instead of using long chains.
* Always verify each command’s exit status manually when debugging.

---

### **Best Practices / Tips**

✅ Use `&&` and `||` for short, simple conditionals.
✅ Avoid mixing both in a single line unless you clearly understand operator precedence.
✅ Prefer `if` statements for multi-step logic or when readability matters.
✅ Great for compact one-liners like:

```bash
mkdir /tmp/logs && echo "Logs directory created" || echo "Failed to create logs directory"
```

---

### **Example Script 2 (Real-world Use Case)**

```bash
#!/bin/bash
# backup_script.sh
# Demonstrates && and || in real scenario

tar -czf /tmp/backup.tar.gz /etc && echo "Backup created successfully!" || echo "Backup failed!"
```

**Sample Output:**

```bash
$ bash backup_script.sh
Backup created successfully!
```

*(If the `/etc` directory or permission fails → "Backup failed!" will print instead.)*

---
---

# Day 9: Debugging and Error Handling

## 🧩 Concept 4: Using `exit` for Error Handling

### **Concept / What**

The `exit` command is used in shell scripts to **terminate execution** and optionally **return an exit status code** to the calling environment (like the shell or CI/CD pipeline).

* `exit 0` → successful termination
* `exit 1` or any non-zero → indicates an error or failure condition

---

### **Why / Purpose / Use Case**

Used to:

* Stop the script immediately when a critical error occurs.
* Return meaningful exit codes to other scripts, pipelines, or monitoring systems.
* Control script flow in case of invalid inputs or failed commands.

✅ **Practical Scenarios:**

* Aborting a deployment if configuration files are missing.
* Exiting with a failure code when an external dependency is unreachable.
* Returning specific error codes for automated tools to detect issues.

---

### **How it Works / Steps / Syntax**

**Syntax:**

```bash
exit [status_code]
```

* If no code is provided, the script exits with the **status of the last command** (`$?`).
* Common exit codes:

  * `0` → Success
  * `1` → General error
  * `2` → Misuse of shell builtins
  * `127` → Command not found
  * `130` → Script terminated by Ctrl+C

---

### **Example Script**

```bash
#!/bin/bash
# exit_handling.sh

echo "Checking for config file..."
if [ ! -f /tmp/config.cfg ]; then
    echo "Error: config.cfg not found!"
    exit 1
fi

echo "Configuration file found. Proceeding..."
# Simulate successful completion
exit 0
```

---

### **Sample Output (when config file missing)**

```bash
$ bash exit_handling.sh
Checking for config file...
Error: config.cfg not found!
```

**Exit Status Check:**

```bash
$ echo $?
1
```

---

### **Sample Output (when config file present)**

```bash
$ touch /tmp/config.cfg
$ bash exit_handling.sh
Checking for config file...
Configuration file found. Proceeding...
$ echo $?
0
```

**Explanation:**

* When `/tmp/config.cfg` is missing, script prints error and exits with code `1`.
* When the file exists, it exits cleanly with code `0`.
* `$?` confirms the script’s exit code after execution.

---

### **Common Issues / Errors**

* Forgetting to use a non-zero exit code for failure — makes debugging hard.
* Exiting prematurely inside loops or functions without cleanup.
* Not informing the user before exiting (missing error message).

---

### **Troubleshooting / Fixes**

* Always print an informative message before `exit`.
* Use traps (`trap 'cleanup' EXIT`) to handle cleanup before termination.
* If using multiple exits, use different codes to indicate different failure points.

---

### **Best Practices / Tips**

✅ Use descriptive exit codes for clarity.
✅ Always provide an error message before exiting.
✅ Use `exit 1` for generic failures, `exit 2` for argument issues, etc.
✅ In large scripts, define constants for readability:

```bash
SUCCESS=0
ERR_FILE_NOT_FOUND=1
ERR_INVALID_INPUT=2
```

✅ For functions, use `return` instead of `exit` unless you want to terminate the entire script.

---

### **Example Script 2 (With Cleanup)**

```bash
#!/bin/bash
# exit_with_cleanup.sh

cleanup() {
    echo "Cleaning up temporary files..."
    rm -f /tmp/tempfile.txt
}
trap cleanup EXIT

echo "Starting process..."
touch /tmp/tempfile.txt
echo "Simulating error..."
exit 2
```

**Sample Output:**

```bash
$ bash exit_with_cleanup.sh
Starting process...
Simulating error...
Cleaning up temporary files...
```
---
---

# Day 9: Debugging and Error Handling

## 🧩 Concept: Trap Command and Signal Handling

### **Concept / What**

`trap` is a **built-in shell command** used to **catch signals or errors** and **run specific commands** (like cleanup tasks) before the script exits. It doesn’t perform cleanup automatically — it only executes the commands you specify when certain events (signals) occur.

---

### **Why / Purpose / Use Case**

`trap` ensures that even if a script fails, is interrupted, or exits unexpectedly, it still performs cleanup tasks or logs important information.

✅ **Use Cases:**

* Remove temporary files before exit.
* Log errors or cleanup after failure.
* Handle user interruption (Ctrl+C).
* Gracefully terminate background processes.

---

### **How it Works / Steps / Syntax**

**Syntax:**

```bash
trap 'commands_to_run' SIGNALS
```

`trap` always works **together with signals** — it needs to know *when* to trigger.

| Signal | When it triggers                        | Typical purpose           |
| ------ | --------------------------------------- | ------------------------- |
| `EXIT` | When the script ends (normal or error)  | Always cleanup temp files |
| `ERR`  | When any command fails (with `set -e`)  | Log errors or safe exit   |
| `INT`  | When user presses Ctrl+C                | Graceful interruption     |
| `TERM` | When script is terminated (kill signal) | Graceful shutdown         |

---

### **Example Script 1 – Basic Cleanup with EXIT**

```bash
#!/bin/bash
# trap_cleanup.sh

cleanup() {
    echo "Cleaning up temporary files..."
    rm -f /tmp/my_temp.txt
}

trap cleanup EXIT   # Run cleanup function on exit

echo "Creating temporary file..."
touch /tmp/my_temp.txt
echo "Doing some work..."
sleep 3
echo "Work done."
```

**Sample Output:**

```bash
$ bash trap_cleanup.sh
Creating temporary file...
Doing some work...
Work done.
Cleaning up temporary files...
```

Even if you press **Ctrl+C**, the cleanup still executes before exit.

---

### **Example Script 2 – Handling Ctrl+C (SIGINT)**

```bash
#!/bin/bash
# trap_interrupt.sh

trap 'echo "⚠️ Script interrupted by user! Cleaning up..."; rm -f /tmp/tempfile' INT

touch /tmp/tempfile
echo "Running an infinite loop... Press Ctrl+C to stop."

while true; do
    sleep 2
done
```

**Output when Ctrl+C pressed:**

```bash
⚠️ Script interrupted by user! Cleaning up...
```

---

### **Example Script 3 – Handling Command Errors (ERR)**

```bash
#!/bin/bash
# trap_error.sh

trap 'echo "[ERROR] A command failed. Exiting safely." >&2' ERR
set -e

echo "Executing commands..."
ls /tmp
ls /nonexistentdir  # triggers trap
echo "This will not print."
```

**Sample Output:**

```bash
Executing commands...
ls: cannot access '/nonexistentdir': No such file or directory
[ERROR] A command failed. Exiting safely.
```

---

### **Trap and Signal Relationship Explained**

`trap` **must** be combined with signals like `EXIT`, `ERR`, `INT`, or `TERM` — otherwise, it won’t know *when* to execute your commands.

**Example:**

```bash
trap "rm -rf /tmp/my_tempfile" EXIT
```

👉 Runs only when script exits.

**Multiple signals:**

```bash
trap "cleanup_function" EXIT INT TERM
```

👉 Runs cleanup when the script exits, is interrupted, or terminated.

**Different actions for different signals:**

```bash
trap "cleanup" EXIT
trap "echo 'Command failed'; exit 1" ERR
trap "echo 'User interrupted'; exit 130" INT
```

---

### **Common Issues / Errors**

* Forgetting to specify a signal (trap never runs).
* Not quoting the commands properly.
* Overwriting an earlier trap unintentionally.
* Complex traps making debugging difficult.

---

### **Troubleshooting / Fixes**

* Check active traps:

  ```bash
  trap -p
  ```
* Disable a trap:

  ```bash
  trap - SIGNAL
  ```

  Example:

  ```bash
  trap - EXIT
  ```

---

### **Best Practices / Tips**

✅ Always combine `trap` with appropriate signals.
✅ Use cleanup functions for multiple commands.
✅ Quote commands in traps (use `'cleanup'` not `cleanup`).
✅ Keep trap logic simple and lightweight.
✅ Use `trap` + `set -e` for robust error-safe scripts.

---

### **Summary Example**

```bash
#!/bin/bash
TMPFILE=$(mktemp)
trap "echo 'Cleaning up...'; rm -f $TMPFILE" EXIT INT ERR TERM

echo "Temporary file: $TMPFILE"
echo "Doing some work..."
sleep 3
echo "Done!"
```

**Output:**

```bash
Temporary file: /tmp/tmp.DhF3a9
Doing some work...
Done!
Cleaning up...
```

---
---

# Day 9: Debugging and Error Handling

## 🧩 Concept 6: Using `PS4` Prompt for Advanced Tracing

### **Concept / What**

`PS4` is a **special shell variable** that defines the **prefix** printed in front of each command during **debug mode (`set -x`)**.
By default, `set -x` only shows commands with a simple `+` sign prefix.
You can customize `PS4` to display **timestamps, line numbers, function names**, or **script names** for detailed debugging.

---

### **Why / Purpose / Use Case**

Used to make debugging output **more informative and readable**, especially in large scripts or automation workflows.

✅ **Real-world Use Cases:**

* To trace which line of code caused failure.
* To include timestamps for performance debugging.
* To differentiate logs from multiple scripts.
* To make CI/CD job logs easier to analyze.

---

### **How it Works / Steps / Syntax**

**Default behavior:**

```bash
set -x
```

Every command prints with a `+` prefix:

```bash
+ echo Hello
+ ls
```

**Customizing PS4:**

```bash
export PS4='+ ${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
set -x
```

This shows:

* Script name (`${BASH_SOURCE}`)
* Line number (`${LINENO}`)
* Function name (`${FUNCNAME[0]}`)

---

### **Example Script 1**

```bash
#!/bin/bash
# ps4_debug.sh

export PS4='+ ${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
set -x

say_hello() {
    echo "Hello, $1"
    ls /invalidpath   # Intentional error
}

echo "Starting script..."
say_hello "Jagga"
echo "Script finished!"
set +x
```

**Sample Output:**

```bash
+ ps4_debug.sh:6:: echo 'Starting script...'
Starting script...
+ ps4_debug.sh:7:: say_hello Jagga
+ ps4_debug.sh:3:say_hello: echo 'Hello, Jagga'
Hello, Jagga
+ ps4_debug.sh:4:say_hello: ls /invalidpath
ls: cannot access '/invalidpath': No such file or directory
+ ps4_debug.sh:8:: echo 'Script finished!'
Script finished!
```

**Explanation:**

* `ps4_debug.sh:4:say_hello:` → shows file name, line number, and function name.
* Makes it easy to locate where exactly an error occurred.

---

### **Common Issues / Errors**

* Forgetting to `export PS4` (it won’t apply globally).
* Defining PS4 *after* enabling `set -x` (order matters).
* Overly complex PS4 formats can clutter output.

---

### **Troubleshooting / Fixes**

* Always set `PS4` before `set -x`.
* Use a simpler version for quick debugging:

  ```bash
  export PS4='[${LINENO}] '
  ```
* For multi-script debugging:

  ```bash
  export PS4='[${BASH_SOURCE}:${LINENO}] '
  ```

---

### **Best Practices / Tips**

✅ Use PS4 in long or complex scripts for clarity.
✅ Always include `${LINENO}` for line tracing.
✅ Keep your PS4 format short and consistent.
✅ Disable `set -x` when done debugging to reduce noise.
✅ Combine PS4 + `set -x` + `trap` for production-safe tracing.

---

### **Example Script 2 (With Timestamp and Function Name)**

```bash
#!/bin/bash
# ps4_timestamp.sh

export PS4='[$(date "+%H:%M:%S") ${FUNCNAME[0]}:${LINENO}] '
set -x

greet() {
    echo "Welcome $1!"
}

greet "Jagga"
ls /invalid
set +x
```

**Sample Output:**

```bash
[18:45:20 greet:5] echo 'Welcome Jagga!'
Welcome Jagga!
[18:45:20 greet:6] ls /invalid
ls: cannot access '/invalid': No such file or directory
```

**Explanation:**

* The output shows timestamp, function name, and line number — useful in large production scripts.

---

### **Summary**

| Element          | Meaning                             |
| ---------------- | ----------------------------------- |
| `PS4`            | Prefix for each traced command      |
| `${LINENO}`      | Displays current script line number |
| `${BASH_SOURCE}` | Shows the script name               |
| `${FUNCNAME[0]}` | Displays the current function name  |
| `$(date)`        | Adds timestamps to debug logs       |

---

### **Quick One-Liner Setup**

```bash
export PS4='[${BASH_SOURCE}:${LINENO}] ' && set -x
```

➡️ Use this when you need to debug scripts with full line and file context.

---
---


