# Day 1: Shell Basics and Script Setup

## Concept 1: Purpose of Shell Scripting

### Concept / What

Shell scripting is writing a series of commands in a file to be executed by the shell (like Bash). It automates repetitive tasks, simplifies system administration, and allows you to combine multiple commands into a single executable file.

### Why / Purpose / Use Case

* Automate repetitive tasks like backups, file management, or deployments.
* Perform complex sequences of commands with a single script.
* Schedule tasks using `cron` or systemd timers.
* Ensure consistency and reduce manual errors.
* Useful in DevOps for CI/CD pipelines, server provisioning, and monitoring.

**Practical Scenarios**

* Automating log cleanup every week.
* Deploying applications to multiple servers with one command.
* Generating reports from system logs daily.

### How it Works / Steps / Syntax

1. Create a plain text file with commands you want to execute.
2. Make the file executable.
3. Run the script via the shell.

No special syntax is required for the purpose itself — the commands inside define what it does.

### Common Issues / Errors

* Running a script without execute permissions.
* Forgetting the shebang line (script may not run with the intended shell).
* Mixing shell syntaxes (e.g., Bash vs sh) — commands may fail.

### Troubleshooting / Fixes

* Use `chmod +x script.sh` to add execute permission.
* Include a proper shebang line: `#!/bin/bash`.
* Test scripts with `bash -x script.sh` for debugging.

### Best Practices / Tips

* Keep scripts modular and readable.
* Comment your code for clarity.
* Test commands individually before adding them to the script.
* Use meaningful filenames and follow a consistent naming convention.

### Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate the use of shell scripting

echo "This is a simple shell script."
echo "Shell scripts help automate tasks and save time."
```

### How to Run

1. Save this file as `purpose_demo.sh`
2. Make it executable: `chmod +x purpose_demo.sh`
3. Execute it: `./purpose_demo.sh`

---

## Concept 2: Shebang (`#!/bin/bash`) and Script Execution

### Concept / What

The **shebang** (`#!`) is the very first line in a shell script, followed by the path to the interpreter (e.g., `/bin/bash`).
It tells the system which program should interpret and run the script.

### Why / Purpose / Use Case

* Ensures your script always runs with the intended shell (e.g., Bash, Python, Perl).
* Prevents compatibility issues when multiple shells exist on a system.
* Makes scripts portable across different environments.

**Practical Scenarios**

* Running a script on a system where `/bin/sh` defaults to `dash`, but you want Bash-specific syntax.
* Writing cross-environment automation scripts that rely on consistent behavior.

### How it Works / Steps / Syntax

1. Place the shebang at the top of the script file:

   ```bash
   #!/bin/bash
   ```
2. Add your shell commands below it.
3. Make the script executable using `chmod +x`.
4. Execute the script normally with `./script.sh`.

### Common Issues / Errors

* **Error:** `bad interpreter: No such file or directory`

  * Cause: Wrong or missing path after `#!`.
* **Error:** Script runs differently than expected.

  * Cause: Using `/bin/sh` when the script uses Bash features.

### Troubleshooting / Fixes

* Verify interpreter path with `which bash`.
* Use environment-based shebang for portability:

  ```bash
  #!/usr/bin/env bash
  ```
* Ensure the shebang is the **first line** of the script (no blank lines above).

### Best Practices / Tips

* Always include a shebang in your scripts.
* Prefer `#!/usr/bin/env bash` for portability across different systems.
* Be consistent — use the same shell for all your scripts in a project.

### Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate use of shebang line

echo "Script is running with Bash as the interpreter."
```

### How to Run

1. Save this file as `shebang_demo.sh`
2. Make it executable: `chmod +x shebang_demo.sh`
3. Execute it: `./shebang_demo.sh`

---

## Concept 3: Setting Script Permissions with `chmod +x`

### Concept / What

By default, a newly created script file may not have execute permissions.
The `chmod +x` command is used to make a script file executable so that it can be run directly from the terminal.

### Why / Purpose / Use Case

* Required to run scripts without explicitly calling an interpreter (`bash script.sh`).
* Ensures security by controlling who can execute a file.
* Makes automation and scheduling (cron jobs, pipelines) easier.

**Practical Scenarios**

* You create `backup.sh` and want to run it directly with `./backup.sh`.
* Deploying scripts on multiple servers where execution permission must be granted.

### How it Works / Steps / Syntax

1. Create a script file, e.g., `script.sh`.
2. Check current permissions:

   ```bash
   ls -l script.sh
   ```

   Example output:

   ```
   -rw-r--r-- 1 user user  50 Oct  2 15:30 script.sh
   ```

   (`x` is missing → not executable)
3. Add execute permission:

   ```bash
   chmod +x script.sh
   ```
4. Verify again:

   ```
   -rwxr-xr-x 1 user user  50 Oct  2 15:30 script.sh
   ```

   (Now it’s executable)

### Common Issues / Errors

* **Error:** `Permission denied` → The file is not executable.
* **Error:** Trying to run with `./script.sh` but permissions not set.

### Troubleshooting / Fixes

* Use `chmod +x filename` to add execute permission.
* Run with `bash script.sh` as a workaround (interpreter explicitly called).
* Ensure correct ownership (`chown user:user script.sh`) if running as another user.

### Best Practices / Tips

* Only give execute permission to trusted scripts.
* Avoid using `chmod 777` (insecure). Instead use `chmod 755` or `chmod 700`.
* Use version control (e.g., Git) to track which files should be executable.

### Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate script permissions

echo "If you are seeing this message, the script has execute permissions!"
```

### How to Run

1. Save this file as `permission_demo.sh`
2. Add execute permission: `chmod +x permission_demo.sh`
3. Run the script: `./permission_demo.sh`

---

## Concept 4: Running a Shell Script from the Terminal

### Concept / What

Running a shell script means executing the commands written in a `.sh` file directly through the terminal. This can be done in multiple ways depending on permissions and interpreter usage.

### Why / Purpose / Use Case

* To execute automation tasks without typing commands one by one.
* To ensure the same sequence of commands is reproducible anytime.
* To simplify daily operations and scheduled jobs.

**Practical Scenarios**

* Running a daily backup script (`./backup.sh`).
* Executing a script as part of a deployment pipeline.
* Testing automation before scheduling it in `cron`.

### How it Works / Steps / Syntax

There are 4 common ways to run a shell script:

1. **Direct execution (requires execute permission):**

   ```bash
   ./script.sh
   ```

2. **Calling interpreter explicitly (no execute permission needed):**

   ```bash
   bash script.sh
   sh script.sh
   ```

3. **Absolute or relative path:**

   * Relative: `./myscripts/script.sh`
   * Absolute: `/home/user/myscripts/script.sh`

4. **Adding the script directory to `$PATH` to run by name:**

   * Place your scripts in a folder, e.g., `~/scripts/`.
   * Edit `.bashrc` and add:

     ```bash
     export PATH="$HOME/scripts:$PATH"
     ```
   * Reload `.bashrc`:

     ```bash
     source ~/.bashrc
     ```
   * Now you can run the script anywhere by typing its name: `example.sh`

### Explanation of `export PATH="$HOME/scripts:$PATH"`

* **`export`**: Makes the variable available to all child processes.
* **`PATH=`**: Assigns a new value to the PATH variable.
* **`$HOME/scripts`**: Your custom scripts folder.
* **`:$PATH`**: Appends the old PATH (existing system directories) so nothing is lost.

**Summary:**

* Right-hand `$PATH` is the current system PATH variable.
* Left-hand `PATH=` is the new variable we are creating.
* After exporting, the shell searches your folder first, then the old directories.

### Common Issues / Errors

* **Error:** `Permission denied` → script doesn’t have execute permission.
* **Error:** `command not found` → missing `./` prefix or wrong path.
* **Error:** `bad interpreter` → wrong shebang line.

### Troubleshooting / Fixes

* Use `chmod +x script.sh` to add execute permissions.
* Always prefix with `./` if running from the current directory.
* Verify script path with `ls` or `pwd`.

### Best Practices / Tips

* Use execute permissions and run as `./script.sh` for consistency.
* Keep scripts in a dedicated `~/scripts/` directory and add it to `$PATH`.
* Test with `bash script.sh` if unsure about permissions.

### Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate different ways of running a shell script

echo "Script executed successfully!"
```

### How to Run

1. Save this file as `run_demo.sh`
2. Method 1: Add execute permission → `chmod +x run_demo.sh` → Run: `./run_demo.sh`
3. Method 2: Run directly with interpreter → `bash run_demo.sh`
4. Method 3: Use absolute path → `/full/path/to/run_demo.sh`
5. Method 4: Add script folder to `$PATH` and run by name → `example.sh`


---

## Concept 5: Using `echo` to Print Messages

### Concept / What

The `echo` command in shell scripting is used to **display text or variables** to the terminal. It’s commonly used for output and debugging.

### Why / Purpose / Use Case

* Display messages to the user during script execution.
* Debug scripts by printing variable values or messages.
* Create simple logs or status outputs.

**Practical Scenarios**

* Informing the user that a backup completed successfully:
  `echo "Backup completed!"`
* Printing variable values for debugging:
  `echo "Today is $DATE"`
* Showing progress of a script:
  `echo "Processing file $FILENAME..."`

### How it Works / Steps / Syntax

1. Basic syntax:
   `echo [options] [text or variables]`
2. Common options:

   * `-n` → Do not append a newline at the end.
   * `-e` → Enable interpretation of backslash escapes (`\n`, `\t`, etc.).
3. Examples:

   ```bash
   echo "Hello, World!"           # prints message with newline
   echo -n "Hello, World!"        # prints without newline
   echo -e "Line1\nLine2"        # prints multiple lines
   echo "User: $USER"             # prints variable value
   ```

### Common Issues / Errors

* Variables not printing correctly → missing `$` before variable name.
* Special characters interpreted literally → forgot `-e` for escape sequences.

### Troubleshooting / Fixes

* Always prefix variables with `$`.
* Use `-e` when you want to interpret escape sequences.
* Check for typos or spaces in variable names.

### Best Practices / Tips

* Use `echo` for simple status messages or debugging.
* For advanced output formatting, consider `printf`.
* Avoid excessive `echo` statements in production scripts; use logging instead.

### Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate echo command

NAME="Jagga"
echo "Hello, $NAME!"          # Prints variable
echo -n "Loading..."          # Prints without newline
echo -e "\nTask completed!"   # Prints on a new line with -e
```

### Output

```
Hello, Jagga!
Loading...
Task completed!
```

### How to Run

1. Save this file as `echo_demo.sh`
2. Make it executable: `chmod +x echo_demo.sh`
3. Execute it: `./echo_demo.sh`

---

# Shell Scripting: printf Command

## Concept / What

`printf` is a built-in command in shell scripting used to print formatted output. Unlike `echo`, it does not automatically add a newline and allows precise formatting using format specifiers.

## Why / Purpose / Use Case

* Print text with custom formatting.
* Align columns, pad spaces, display decimal places.
* Print multiple values in a single statement.
* Useful in automation scripts, reports, and logs.

**Example use cases:**

* Display a table of usernames and IDs.
* Print floating-point numbers with a fixed number of decimals.
* Avoid automatic newlines in loops or repeated outputs.

## How it Works / Steps / Syntax

**Syntax:**

```bash
printf FORMAT [ARGUMENTS...]
```

**Format Specifiers:**

| Specifier | Meaning               |
| --------- | --------------------- |
| `%s`      | String                |
| `%d`      | Integer (decimal)     |
| `%f`      | Floating-point number |
| `%x`      | Hexadecimal           |
| `%o`      | Octal                 |

**Examples:**

1. **Simple string output**

```bash
printf "Hello, %s!\n" "Alice"
# Output: Hello, Alice!
```

2. **Integer output**

```bash
age=25
printf "Your age is %d\n" "$age"
# Output: Your age is 25
```

3. **Floating-point with precision**

```bash
pi=3.14159
printf "Pi: %.2f\n" "$pi"
# Output: Pi: 3.14
```

4. **Multiple values**

```bash
name="Bob"
age=30
printf "Name: %s, Age: %d\n" "$name" "$age"
# Output: Name: Bob, Age: 30
```

5. **No newline (same line printing)**

```bash
printf "Loading... "
printf "Done!\n"
# Output: Loading... Done!
```

## Common Issues / Errors

* Forgetting `\n` → output stays on the same line.
* Mismatched format specifiers and arguments → prints garbage or errors.
* Not quoting variables → word splitting or unexpected behavior with spaces.

## Troubleshooting / Fixes

* Always quote variables: `printf "%s" "$var"`
* Match the number of arguments with the number of specifiers.
* Include `\n` at the end if you want a newline.
* Use correct type for `%d`, `%f`, `%s`.

## Best Practices / Tips

* Prefer `printf` over `echo` for precise output formatting.
* Use `%s` for strings, `%d` for integers, `%f` for floating numbers.
* For loops or repeated outputs, `printf` avoids multiple newlines.
* Combine multiple specifiers in one statement for clean, readable output.

## Example Scripts

**Script 13: Simple String Output → `13_printf_string.sh`**

```bash
#!/bin/bash
name="Alice"
printf "Hello, %s!\n" "$name"
```

**Script 14: Integer Output → `14_printf_integer.sh`**

```bash
#!/bin/bash
age=25
printf "Your age is %d\n" "$age"
```

**Script 15: Floating-point Output → `15_printf_float.sh`**

```bash
#!/bin/bash
pi=3.14159
printf "Pi: %.2f\n" "$pi"
```

**Script 16: Multiple Values → `16_printf_multiple.sh`**

```bash
#!/bin/bash
name="Bob"
age=30
printf "Name: %s, Age: %d\n" "$name" "$age"
```

**Script 17: Same-line Output → `17_printf_same_line.sh`**

```bash
#!/bin/bash
printf "Loading... "
printf "Done!\n"
```
---


## Concept 6: Using Comments (`#`) Effectively in Scripts

### Concept / What

Comments in shell scripts start with `#` and are **ignored by the shell during execution**. They are used to explain code, improve readability, and provide documentation.

### Why / Purpose / Use Case

* Helps anyone reading the script understand what the script does.
* Useful for temporarily disabling lines of code during testing.
* Important for maintaining scripts in production or shared environments.

**Practical Scenarios**

* Explaining the purpose of a script or function.
* Annotating complex logic.
* Disabling commands temporarily without deleting them.

### How it Works / Steps / Syntax

1. Single-line comment:

   ```bash
   # This is a comment
   echo "Hello, World!"  # This prints a message
   ```
2. Inline comments:

   ```bash
   echo "Processing..."  # Inform the user
   ```
3. Multi-line comments (Bash workaround):

   ```bash
   : '
   This is a multi-line comment
   spanning multiple lines
   '
   ```

### Common Issues / Errors

* Forgetting `#` → shell tries to execute text and fails.
* Using comment syntax incorrectly for multi-line blocks.

### Troubleshooting / Fixes

* Always start comments with `#` for single lines.
* For multi-line notes, use the `: '` trick or prefix each line with `#`.

### Best Practices / Tips

* Write meaningful comments, not obvious ones.
* Keep comments updated when changing code.
* Use comments to explain **why** a command is used, not **what** it does if it’s obvious.

### Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate use of comments

# This script prints greetings
NAME="Jagga"

# Print greeting
echo "Hello, $NAME!"  # Output the greeting to terminal

: '
Multi-line comment example:
The following lines could be added in future
for additional messages or logging
'
```

### How to Run

1. Save this file as `comments_demo.sh`
2. Make it executable: `chmod +x comments_demo.sh`
3. Run it: `./comments_demo.sh`

---
---

# Check Exit Status of Commands Using `$?`

## Concept / What

Every command executed in Linux returns an **exit status** (integer) indicating success or failure.

* `0` → Success
* Non-zero → Failure
  The special variable `$?` stores the exit status of the **last executed command**.

## Why / Purpose / Use Case

* Determine if a command succeeded before taking further action.
* Essential for **error handling** in scripts.
* Useful in **automation, CI/CD pipelines, and system administration**.
* Practical Scenarios:

  * Verify backup completion before deleting old files.
  * Check if a service started successfully before running dependent tasks.
  * Ensure a file exists before copying/moving it.

## How it Works / Steps / Syntax

1. Run a command.
2. Immediately after, check `$?`:

```bash
ls /home
echo $?    # 0 if success
```

```bash
ls /nonexistent/path
echo $?    # Non-zero if failure
```

**In scripts (simple example):**

```bash
#!/bin/bash
ls /etc/passwd
if [ $? -eq 0 ]; then
  echo "File exists."
else
  echo "File does not exist."
fi
```

## Common Issues / Errors

* `$?` always returns 0 → another command ran before checking `$?`.
* Misinterpreting non-zero exit codes → just need to check success/failure, not exact number.
* Pipelines only capture the last command’s exit code → use `set -o pipefail` for full check.

## Troubleshooting / Fixes

* Check `$?` **immediately** after the command.
* Use `set -o pipefail` for pipelines to detect any command failure.
* Use `echo $?` for debugging exit status.

## Best Practices / Tips

* Handle exit codes for critical commands (backups, deployments, etc.).
* Combine with `&&` or `||` for simpler control flow.
* Avoid ignoring non-zero codes in production scripts — log or exit.
* Use `set -e` to automatically exit on non-zero status if appropriate.

## Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate use of $? to check exit status

ls /etc/passwd
if [ $? -eq 0 ]; then
  echo "File found!"
else
  echo "File not found!"
fi

ls /notfound
if [ $? -ne 0 ]; then
  echo "Error occurred."
fi
```

### How to Run

1. Save as `exit_status_demo.sh`
2. Add execute permission:

```bash
chmod +x exit_status_demo.sh
```

3. Run:

```bash
./exit_status_demo.sh
```

---
---

# Use `exit` to Terminate Scripts

## Concept / What

The `exit` command is used to **terminate a shell script immediately** and optionally return a status code to the calling environment.

* `exit 0` → Success
* `exit 1` (or any non-zero) → Failure or error

## Why / Purpose / Use Case

* Stop script execution when a critical error occurs.
* Communicate success or failure to other scripts or automation pipelines.
* Useful for **error handling** and **conditional exits**.

**Practical Scenarios:**

* Stop a script if a required file is missing.
* Exit a deployment script if a service fails to start.
* Signal a failure in a CI/CD pipeline by returning a non-zero code.

## How it Works / Steps / Syntax

1. Use `exit` at the point you want to terminate the script.
2. Optionally provide a numeric exit code:

   ```bash
   exit 0   # success
   exit 1   # failure
   ```
3. Once `exit` is executed, no further commands in the script run.

**Simple Example:**

```bash
#!/bin/bash
# Check if a file exists, exit if not

FILE=/tmp/demo.txt
if [ ! -f "$FILE" ]; then
  echo "File not found. Exiting script."
  exit 1
fi

echo "File exists. Continuing script..."
```

## Common Issues / Errors

* Forgetting `exit` in error conditions → script continues unexpectedly.
* Using `exit` without understanding impact → stops entire script immediately.
* Confusing shell exit codes with command exit codes.

## Troubleshooting / Fixes

* Use `echo` before `exit` to log messages.
* Test scripts with and without error conditions.
* Combine with `$?` to exit based on previous command status.

**Example with `$?`:**

```bash
#!/bin/bash
cp /tmp/file1 /backup/
if [ $? -ne 0 ]; then
  echo "Copy failed. Exiting."
  exit 1
fi

echo "Copy successful."
```

## Best Practices / Tips

* Use meaningful exit codes (`0` for success, `1` for general error, other numbers for specific cases if needed).
* Keep scripts readable; don’t overuse `exit` in non-critical places.
* Combine with `$?` for robust error handling.
* Use logging or messages before `exit` for clarity.

## Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate use of exit command

echo "Starting script..."

ls /notfound
if [ $? -ne 0 ]; then
  echo "Critical file missing. Exiting script."
  exit 1
fi

echo "This will not be printed if exit occurs above."
```

### How to Run

1. Save as `exit_demo.sh`
2. Add execute permission:

```bash
chmod +x exit_demo.sh
```

3. Run:

```bash
./exit_demo.sh
```

---
---

# Quoting & Escaping in Shell Scripts

## Concept / What

Quoting and escaping are ways to control how the shell interprets **special characters** and **spaces** in strings or commands:

* **Single quotes `'...'`**: Preserve literal value of all characters inside.
* **Double quotes `"..."`**: Preserve most characters, but allow **variable and command substitution**.
* **Backslash `\`**: Escape a single character to prevent special interpretation.

## Why / Purpose / Use Case

* Prevent word splitting or globbing when dealing with filenames or strings.
* Safely use variables containing spaces or special characters.
* Avoid syntax errors caused by special shell characters.

**Practical Scenarios:**

* File paths with spaces: `/home/user/My Files/file.txt`
* Printing variables containing `$` or `*`
* Passing arguments to commands safely

## How it Works / Steps / Syntax

**Single quotes:**

```bash
echo 'Hello $USER *'
# Output: Hello $USER *
```

* Everything inside single quotes is literal.

**Double quotes:**

```bash
NAME="Alice"
echo "Hello $NAME"
# Output: Hello Alice
```

* Variables (`$NAME`) and command substitution (`$(...)`) are expanded.

**Backslash escaping:**

```bash
echo Hello\ World
# Output: Hello World

echo "\$100"
# Output: $100
```

* Use `\` before a special character to treat it literally.

## Common Issues / Errors

* Forgetting quotes around filenames with spaces → command fails.
* Using single quotes when variable expansion is needed → variable not expanded.
* Misplacing backslashes → syntax errors or unexpected output.

## Troubleshooting / Fixes

* Always quote variables with spaces: `"$VAR"`
* Use single quotes when you want literal text.
* Use backslash to escape special characters like `$`, `*`, `?`, `"`, `'`, or `\`.

## Best Practices / Tips

* Prefer double quotes for variables: `echo "$VAR"`
* Use single quotes for fixed strings that should not change.
* Escape only the necessary character, not the whole string.
* Consistently quote variables to avoid surprises in scripts.

## Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate quoting and escaping

NAME="Alice Bob"
FILE="My File.txt"

# Single quotes (literal)
echo 'Hello $NAME *'

# Double quotes (expand variable)
echo "Hello $NAME"

# Backslash escaping
echo Hello\ World
echo "\$100"
```

### How to Run

1. Save as `quoting_demo.sh`
2. Add execute permission:

```bash
chmod +x quoting_demo.sh
```

3. Run:

```bash
./quoting_demo.sh
```

---
---

# Command Chaining Basics: &&, ||, ;, &

## Concept / What

Command chaining allows you to **run multiple commands in a sequence** based on the **success, failure, or unconditionally** of previous commands:

* **`&&`** → run the next command **only if the previous command succeeds** (exit code 0)
* **`||`** → run the next command **only if the previous command fails** (non-zero exit code)
* **`;`** → run the next command **regardless of success or failure**
* **`&`** → run the command **in the background**, immediately returning control to the shell

## Why / Purpose / Use Case

* Combine commands efficiently without writing multiple `if` statements.
* Perform conditional execution based on success or failure.
* Execute commands sequentially or in the background as needed.
* Useful in automation, installation scripts, or deployment pipelines.

**Practical Scenarios:**

* Run a command only if a file exists.
* Execute a backup only if the previous step succeeded.
* Print an error message if a command fails.
* Run independent commands sequentially or in background.

## How it Works / Steps / Syntax

**Using `&&` (AND operator):**

```bash
mkdir /tmp/demo && echo "Directory created successfully"
```

* `echo` runs **only if** `mkdir` succeeds.

**Using `||` (OR operator):**

```bash
mkdir /tmp/demo || echo "Failed to create directory"
```

* `echo` runs **only if** `mkdir` fails.

**Using `;` (semicolon):**

```bash
mkdir /tmp/demo; echo "This runs no matter what"
```

* `echo` runs **regardless** of whether `mkdir` succeeds or fails.

**Using `&` (background execution):**

```bash
sleep 5 &
echo "This prints immediately, while sleep runs in background"
```

* `sleep` runs in the background; the next command executes immediately.

**Combining `&&` and `||`:**

```bash
mkdir /tmp/demo2 && echo "Success" || echo "Failure"
```

* Prints `Success` if `mkdir` works, else prints `Failure`.

## Common Issues / Errors

* Misunderstanding operator precedence → unexpected results.
* Running commands that always succeed/fail → chaining behaves differently.
* Forgetting spaces around operators → syntax error.

## Troubleshooting / Fixes

* Ensure spaces before and after `&&`, `||`, `;`, and `&`.
* Test commands individually before chaining.
* Use parentheses for complex chains to control order.

## Best Practices / Tips

* Use `&&` for dependent commands that must succeed.
* Use `||` for error handling or fallback commands.
* Use `;` for unconditional sequencing.
* Use `&` for background execution of independent commands.
* For readability, break complex chains into multiple lines.
* Combine with `exit` to terminate scripts on failure if needed.

## Example Script

```bash
#!/bin/bash
# Purpose: Demonstrate command chaining with &&, ||, ;, &

# Example with &&
echo "Creating directory..." && mkdir /tmp/demo && echo "Directory created successfully"

# Example with ||
echo "Creating directory again..." || echo "Failed to create directory"

# Example with ;
echo "Running command unconditionally"; mkdir /tmp/demo3; echo "This runs regardless"

# Example with &
sleep 5 &
echo "This prints immediately, while sleep runs in background"

# Combined example
mkdir /tmp/demo4 && echo "Success" || echo "Failure"
```

### How to Run

1. Save as `command_chaining_demo.sh`
2. Add execute permission:

```bash
chmod +x command_chaining_demo.sh
```

3. Run:

```bash
./command_chaining_demo.sh
```

---
---


