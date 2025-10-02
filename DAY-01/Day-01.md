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

