## 🗂️ Concept 1: Check File Existence and Type (`-f`, `-d`, `-L`, etc.)

### **Concept / What**

In shell scripting, **file test operators** are used to verify whether a file or directory exists and to determine its **type** (regular file, directory, symbolic link, etc.). These are mainly used inside conditional statements like `if`.

---

### **Why / Purpose / Use Case**

* Prevents script failures by checking files before accessing them.
* Used in automation scripts, deployment setups, and housekeeping jobs.
* Ensures safe operations (e.g., don’t overwrite or delete files blindly).
* Commonly used before read/write/copy/delete commands.

---

### **How it Works / Steps / Syntax**

#### **Basic Syntax**

```bash
if [ -f filename ]; then
   echo "File exists and is a regular file"
fi
```

#### **Common File Test Options**

| Flag | Description                                           |
| ---- | ----------------------------------------------------- |
| `-e` | True if file **exists** (any type)                    |
| `-f` | True if file **exists and is a regular file**         |
| `-d` | True if it’s a **directory**                          |
| `-L` | True if it’s a **symbolic link**                      |
| `-r` | True if file is **readable**                          |
| `-w` | True if file is **writable**                          |
| `-x` | True if file is **executable**                        |
| `!`  | Negation — e.g., `[ ! -f file ]` → file doesn’t exist |

#### **Example**

```bash
#!/bin/bash

FILE="/etc/passwd"

if [ -e "$FILE" ]; then
    echo "$FILE exists"
    if [ -f "$FILE" ]; then
        echo "It is a regular file"
    elif [ -d "$FILE" ]; then
        echo "It is a directory"
    elif [ -L "$FILE" ]; then
        echo "It is a symbolic link"
    fi
else
    echo "$FILE does not exist"
fi
```

---

### **Common Issues / Errors**

| Issue                     | Cause                             |
| ------------------------- | --------------------------------- |
| `[: missing ']'`          | Missing or misplaced bracket.     |
| `unary operator expected` | Variable not quoted and is empty. |
| “File not found”          | Typo or wrong working directory.  |

---

### **Troubleshooting / Fixes**

* Always **quote variables** (`"$FILE"`) to avoid empty variable errors.
* Use **absolute paths** instead of relative ones.
* Debug with `set -x` to trace script execution.
* Verify path with `pwd` or `ls` before running script.

---

### **Best Practices / Tips**

* Use `[[ ... ]]` instead of `[ ... ]` for more robust checks in Bash.
* Combine multiple conditions for safety:

  ```bash
  if [[ -f "$FILE" && -r "$FILE" ]]; then
      echo "File exists and is readable"
  fi
  ```
* Always check before performing file operations like `cat`, `rm`, or `cp`.

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: check_file_type.sh
# Purpose: Check if a given path exists and determine its type

read -p "Enter a file or directory path: " PATH_TO_CHECK

if [[ -e "$PATH_TO_CHECK" ]]; then
    echo "✅ $PATH_TO_CHECK exists."
    if [[ -f "$PATH_TO_CHECK" ]]; then
        echo "📄 It is a regular file."
    elif [[ -d "$PATH_TO_CHECK" ]]; then
        echo "📁 It is a directory."
    elif [[ -L "$PATH_TO_CHECK" ]]; then
        echo "🔗 It is a symbolic link."
    else
        echo "❓ It exists but is another type (socket, device, etc.)."
    fi
else
    echo "❌ $PATH_TO_CHECK does not exist."
fi
```

---
---

## 🗂️ Concept 2: Read from Files Line-by-Line

### **Concept / What**

Reading a file **line-by-line** in shell scripting means processing each line sequentially — often using loops — without loading the entire file into memory. It’s an efficient way to handle text files safely and flexibly.

---

### **Why / Purpose / Use Case**

* To process logs, configuration files, or text data line-by-line.
* Useful for parsing, filtering, or transforming file content.
* Common in automation scripts for reading usernames, IPs, or values one by one.
* Helps avoid memory issues with large files.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Basic Syntax**

```bash
while read line; do
   echo "$line"
done < filename
```

* The `while` loop runs until all lines in the file are processed.
* The `read` command reads one line at a time into the variable `line`.
* `< filename` redirects file content as input to the loop.

#### **2️⃣ Safer Version (Recommended)**

```bash
while IFS= read -r line; do
   echo "$line"
done < filename
```

* `IFS=` → Preserves spaces and tabs.
* `-r` → Prevents backslash (`\\`) interpretation.

#### **3️⃣ Example with Counter**

```bash
FILE="users.txt"

if [[ -f "$FILE" && -r "$FILE" ]]; then
    echo "Reading lines from $FILE..."
    line_num=1
    while IFS= read -r line; do
        echo "Line $line_num: $line"
        ((line_num++))
    done < "$FILE"
else
    echo "Error: $FILE not found or not readable."
fi
```

---

### **Explanation of `< "$FILE"`**

* `<` is **input redirection** — it tells the shell to feed the file’s content to the loop as input.
* Without it, `read` waits for manual input from the keyboard.
* With it, the loop automatically reads each line from the file sequentially.

📘 Example:

```
File: names.txt
Jagga
Ravi
Manish
```

Output:

```
Name: Jagga
Name: Ravi
Name: Manish
```

---

### **Common Issues / Errors**

| Issue                     | Cause                               |                              |
| ------------------------- | ----------------------------------- | ---------------------------- |
| Empty or missing lines    | Not using `IFS=` or `-r` correctly. |                              |
| Variables lost after loop | Using `cat file                     | while ...` creates subshell. |
| File not found            | Wrong file path or permission.      |                              |

---

### **Troubleshooting / Fixes**

* Always use `IFS=` and `-r` for accurate reading.
* Quote variable names (`"$line"`) to preserve spaces.
* Use `set -x` to debug input or file path.
* Check permissions with `ls -l` or `[ -r "$FILE" ]`.

---

### **Best Practices / Tips**

* Prefer `< file` input redirection over `cat file | while ...`.
* Use absolute paths for reliability.
* Use clear variable names like `line` or `record`.
* For large-scale processing, prefer `awk` or `sed`.

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: read_file_line_by_line.sh
# Purpose: Read a file line-by-line and print line numbers

FILE="users.txt"

if [[ -f "$FILE" && -r "$FILE" ]]; then
    echo "Reading lines from $FILE..."
    line_num=1
    while IFS= read -r line; do
        echo "Line $line_num: $line"
        ((line_num++))
    done < "$FILE"
else
    echo "Error: $FILE not found or not readable."
fi
```

---

### **Summary Table**

| Concept          | Description                       |
| ---------------- | --------------------------------- |
| `read line`      | Reads one line from input         |
| `< file`         | Redirects file as input to loop   |
| `IFS=`           | Preserves whitespace              |
| `-r`             | Prevents backslash interpretation |
| `((line_num++))` | Increments counter                |

---
---

## 🗂️ Concept 4: Count Lines, Words, and Characters

### **Concept / What**

In shell scripting, the **`wc` (word count)** command is used to count the **number of lines, words, characters, or bytes** in a file or from command output. It’s a simple yet powerful tool for analyzing text files.

---

### **Why / Purpose / Use Case**

* To **analyze file contents** such as logs, configs, or reports.
* Used in **automation scripts** to validate file generation (e.g., number of processed entries).
* Helps during **monitoring and debugging** to check if expected lines or data exist.
* Commonly used in **DevOps reporting scripts** to generate file statistics.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Basic Usage**

```bash
wc filename
```

Output example:

```
10  25  180  filename
```

Meaning: **10 lines**, **25 words**, **180 characters**.

#### **2️⃣ Specific Options**

| Option | Description                            |
| ------ | -------------------------------------- |
| `-l`   | Count **lines** only                   |
| `-w`   | Count **words** only                   |
| `-c`   | Count **bytes** (characters)           |
| `-m`   | Count **characters** (multi-byte safe) |
| `-L`   | Show **length of the longest line**    |

**Examples:**

```bash
wc -l myfile.txt     # Count lines
wc -w myfile.txt     # Count words
wc -m myfile.txt     # Count characters
wc -L myfile.txt     # Longest line length
```

#### **3️⃣ Use with Command Output**

```bash
cat /etc/passwd | wc -l
```

Counts total lines in `/etc/passwd`.

```bash
grep "bash" /etc/passwd | wc -l
```

Counts how many users use bash as their shell.

#### **4️⃣ Store Count in Variable**

```bash
line_count=$(wc -l < myfile.txt)
echo "File has $line_count lines."
```

* `<` ensures only the number is stored (not filename).

---

### **Common Issues / Errors**

| Issue                       | Reason                                                             |
| --------------------------- | ------------------------------------------------------------------ |
| `No such file or directory` | Wrong filename or path.                                            |
| Wrong count output          | Used `wc filename` instead of `< filename` (filename printed too). |
| Unexpected result           | File might be binary or unreadable.                                |

---

### **Troubleshooting / Fixes**

* Use **absolute paths** to avoid path confusion.
* Verify readability before using `wc`.
* Use `< filename` to avoid including filenames in output.
* Use `file filename` to confirm it’s a text file.

---

### **Best Practices / Tips**

* Use `wc -l < file` in scripts to get clean numeric output.
* Combine `wc` with other commands for quick data analysis:

  ```bash
  echo "Total errors: $(grep ERROR logfile.log | wc -l)"
  ```
* Use `-m` for accurate character count in UTF-8 files.
* Always check permissions and ensure file readability.

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: count_file_stats.sh
# Purpose: Count lines, words, and characters in a file

read -p "Enter a filename to analyze: " FILE

if [[ -f "$FILE" && -r "$FILE" ]]; then
    echo "Analyzing $FILE..."
    echo "--------------------------------"
    echo "Total Lines      : $(wc -l < "$FILE")"
    echo "Total Words      : $(wc -w < "$FILE")"
    echo "Total Characters : $(wc -m < "$FILE")"
    echo "--------------------------------"
else
    echo "Error: File not found or not readable."
fi
```

---

### **Explanation of Script**

1. Prompts user to enter filename.
2. Checks if the file exists and is readable.
3. Uses input redirection `< "$FILE"` to count cleanly without filename printing.
4. Displays total lines, words, and characters in organized output.

---

### **Example Output**

```
Enter a filename to analyze: users.txt
Analyzing users.txt...
--------------------------------
Total Lines      : 3
Total Words      : 3
Total Characters : 18
--------------------------------
```

---
---

## 🗂️ Concept 5: Log File Output

### **Concept / What**

In shell scripting, **logging** means capturing a script’s execution details — outputs, messages, and errors — into a **log file** for monitoring or troubleshooting. Logging is crucial for production, cron jobs, and automation scripts.

---

### **Why / Purpose / Use Case**

* Record script activity and results for auditing.
* Debug issues when scripts fail silently or run in background.
* Keep history of when tasks ran and what happened.
* Used widely in **DevOps, CI/CD, and maintenance scripts**.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Redirect Output to Log File**

```bash
#!/bin/bash
./deploy.sh > deploy.log 2>&1
```

* `>` redirects **standard output (stdout)**.
* `2>&1` merges **standard error (stderr)** with stdout, so both go to the same log file.

#### **2️⃣ Append Logs**

```bash
./backup.sh >> backup.log 2>&1
```

* `>>` appends new logs without deleting existing content.

#### **3️⃣ Logging Inside a Script**

```bash
#!/bin/bash
LOGFILE="/var/log/myscript.log"

echo "[$(date)] Script started" >> "$LOGFILE"
echo "Performing backup..." >> "$LOGFILE"

if cp /data/* /backup/ 2>>"$LOGFILE"; then
    echo "[$(date)] Backup successful" >> "$LOGFILE"
else
    echo "[$(date)] Backup failed" >> "$LOGFILE"
fi

echo "[$(date)] Script completed" >> "$LOGFILE"
```

#### **4️⃣ View Logs in Real-time**

```bash
tail -f myscript.log
```

Displays new log entries live as they are written.

---

### **Common Issues / Errors**

| Issue                | Reason                                           |
| -------------------- | ------------------------------------------------ |
| `Permission denied`  | No write access to directory (e.g., `/var/log`). |
| Log file overwritten | Used `>` instead of `>>`.                        |
| Log empty            | Redirection incorrect or script failed early.    |

---

### **Troubleshooting / Fixes**

* Ensure correct write permissions (`ls -l logname.log`).
* Always use absolute log paths in cron jobs.
* Include timestamps using `$(date)` for clarity.
* Test log writing manually using `echo "test" >> logfile.log`.

---

### **Best Practices / Tips**

* Always include **timestamps** for each log entry.
* Use `>>` for safe appending.
* Store logs in `/var/log/scripts/` or `/tmp/` for temp logs.
* Rotate large logs periodically (e.g., using `logrotate`).
* Capture both stdout and stderr: `2>&1`.
* Name logs meaningfully: `backup_$(date +%F).log`.

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: log_file_output.sh
# Purpose: Demonstrate logging script output to a file

LOGFILE="/tmp/app_log_$(date +%F).log"

echo "[$(date)] Script execution started." >> "$LOGFILE"

echo "Running updates..." >> "$LOGFILE"
sudo apt update -y >> "$LOGFILE" 2>&1

echo "[$(date)] Checking disk usage..." >> "$LOGFILE"
df -h >> "$LOGFILE" 2>&1

echo "[$(date)] Script execution completed." >> "$LOGFILE"

echo "✅ Logs saved at: $LOGFILE"
```

---

### **Explanation of Script**

1. Creates a timestamped log file in `/tmp/`.
2. Logs status messages and actual command output.
3. Redirects both stdout and stderr into the same file (`2>&1`).
4. Prints a final message with log file location.
5. Mimics real-world deployment or maintenance logging patterns.

---
---

## 🗂️ Concept 6: Basic File Permissions (Read / Write / Execute)

### **Concept / What**

In Linux, **file permissions** define who can read, write, or execute a file or directory. They control access and security at the user, group, and system level.

---

### **Why / Purpose / Use Case**

* To **secure** files from unauthorized access or modification.
* To ensure **only valid users** can run or edit scripts.
* Used in deployments, automation, and CI/CD pipelines to manage script permissions.
* Prevents accidental deletion or execution of sensitive files.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Permission Types**

| Symbol | Meaning | Description                    |
| ------ | ------- | ------------------------------ |
| `r`    | Read    | View or read file content      |
| `w`    | Write   | Modify or delete file          |
| `x`    | Execute | Run file as a script or binary |

#### **2️⃣ Permission Groups**

| Symbol | Category | Applies To              |
| ------ | -------- | ----------------------- |
| `u`    | User     | File owner              |
| `g`    | Group    | Group members           |
| `o`    | Others   | All other users         |
| `a`    | All      | User, group, and others |

#### **3️⃣ View Permissions**

```bash
ls -l script.sh
```

Example output:

```
-rwxr--r-- 1 ubuntu ubuntu 1024 Nov 7 12:30 script.sh
```

Breakdown:

* `rwx` → User has read, write, execute
* `r--` → Group can read only
* `r--` → Others can read only

#### **4️⃣ Change Permissions (chmod)**

**Symbolic Mode:**

```bash
chmod u+x script.sh      # Add execute permission for user
chmod g-w script.sh      # Remove write permission for group
chmod o+r script.sh      # Add read permission for others
chmod a+x script.sh      # Add execute for everyone
```

**Numeric Mode:**

| Number | Permission | Equivalent |
| ------ | ---------- | ---------- |
| 4      | Read       | r--        |
| 2      | Write      | -w-        |
| 1      | Execute    | --x        |
| 0      | None       | ---        |

Each user group (u, g, o) adds up its value.

```
chmod 755 script.sh
```

* 7 = rwx (user)
* 5 = r-x (group)
* 5 = r-x (others)

To give everyone full control:

```bash
chmod 777 script.sh
```

→ rwx for user, group, and others.

#### **5️⃣ Change Ownership (chown)**

```bash
chown ubuntu:devops script.sh
```

Changes file owner and group.

---

### **Common Issues / Errors**

| Issue                     | Cause                                            |
| ------------------------- | ------------------------------------------------ |
| `Permission denied`       | Missing `x` (execute) or `w` (write) permission. |
| `Operation not permitted` | Need root privileges for ownership change.       |
| Script fails to run       | Missing execute permission.                      |

---

### **Troubleshooting / Fixes**

* Add execute permission:

  ```bash
  chmod +x script.sh
  ```
* Use `sudo` for root-owned files.
* Check permissions:

  ```bash
  ls -l filename
  ```
* Fix owner or group:

  ```bash
  sudo chown user:group filename
  ```

---

### **Best Practices / Tips**

* Use `chmod 700` for private scripts (owner only).
* Use `chmod 755` for shared scripts (safe default).
* Use `chmod 644` for readable-only files.
* Avoid `chmod 777` — insecure in production.
* Verify permissions with `ls -l` after changes.

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: file_permission_demo.sh
# Purpose: Demonstrate changing file permissions

FILE="demo_file.txt"

echo "Testing file permissions" > "$FILE"

echo "Before change:"
ls -l "$FILE"

chmod u+x "$FILE"   # Add execute permission for user
chmod g-w "$FILE"   # Remove write permission for group

echo "After change:"
ls -l "$FILE"

chmod 644 "$FILE"    # Restore safe default

echo "Permissions restored to 644 (rw-r--r--)"
```

---

### **Explanation of Script**

1. Creates a file named `demo_file.txt`.
2. Shows default permissions using `ls -l`.
3. Adds execute permission for the owner.
4. Removes write permission for the group.
5. Restores safe permissions (`rw-r--r--`).
6. Displays permission states before and after changes.

---

### **Summary Table**

| Mode  | Meaning   | Example Use                    |
| ----- | --------- | ------------------------------ |
| `644` | rw-r--r-- | Default for regular files      |
| `755` | rwxr-xr-x | Default for executable scripts |
| `700` | rwx------ | Private scripts or keys        |
| `777` | rwxrwxrwx | Full access (use with caution) |

---
---

## 🗂️ Concept 7: Here Documents & Here Strings (`<<EOF`, `<<<`)

### **Concept / What**

**Here Documents (HEREDOCs)** and **Here Strings** are ways to provide **multi-line or inline input** directly within a shell script, without needing a separate file. They are especially useful for feeding content to commands or generating configuration files dynamically.

---

### **Why / Purpose / Use Case**

* To write **multi-line data** into files or commands directly from a script.
* Automate creation of config files, scripts, or service units.
* Pass structured input to commands (e.g., `cat`, `tee`, `ssh`, `grep`).
* Avoid creating temporary files for input.
* Very common in **EC2 User Data scripts** and **infrastructure automation**.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Here Document (`<<EOF`)**

```bash
cat <<EOF
This is line 1
This is line 2
This is line 3
EOF
```

Everything between `<<EOF` and `EOF` is treated as input for the command.

* `EOF` is just a **label** or **delimiter**, not a keyword.
* You can use any word (like `END`, `DATA`, `CONFIG`).
* Shell reads until it finds the same delimiter again.

Example:

```bash
cat <<END
This is a custom delimiter example.
END
```

---

#### **2️⃣ Writing Multi-line Data to a File**

```bash
cat <<EOF > message.txt
Hi Team,
Deployment completed successfully.
Regards,
DevOps Team
EOF
```

✅ Writes the above content directly into `message.txt`.

---

#### **3️⃣ Variable Expansion in HEREDOCs**

By default, variables inside HEREDOCs **expand**:

```bash
NAME="Jagga"
cat <<EOF
Hello $NAME, welcome to the team!
EOF
```

Output:

```
Hello Jagga, welcome to the team!
```

To prevent variable expansion:

```bash
cat <<'EOF'
Hello $NAME, this will not expand.
EOF
```

---

#### **4️⃣ Here String (`<<<`)**

Used for **single-line input**.

```bash
cat <<< "This is one line of input"
```

Example:

```bash
grep "error" <<< "this line contains an error"
```

Equivalent to:

```bash
echo "this line contains an error" | grep "error"
```

---

### **What is `EOF`?**

* `EOF` stands for **End Of File**, but in shell scripts, it’s just a **custom label**.
* It marks the **start and end** of the input section in a HEREDOC.
* You can use any custom word — `EOF` is just a convention.

Example in **EC2 User Data**:

```bash
#!/bin/bash
cat <<EOF > /etc/systemd/system/myapp.service
[Unit]
Description=MyApp Service

[Service]
ExecStart=/usr/local/bin/myapp

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable myapp
systemctl start myapp
```

✅ Writes a full systemd service file dynamically.

---

### **Common Issues / Errors**

| Issue                   | Reason                                        |
| ----------------------- | --------------------------------------------- |
| Syntax error near EOF   | Start and end delimiters don’t match exactly. |
| Variables not expanding | Used `'EOF'` (quoted) intentionally.          |
| File overwritten        | Used `>` instead of `>>` when writing.        |

---

### **Troubleshooting / Fixes**

* Ensure start and end delimiters match exactly (case-sensitive).
* Use `>>` for appending instead of overwriting.
* Quote delimiter (`'EOF'`) if you want literal text (no variable expansion).
* Use `<<-EOF` to strip leading tabs when indentation is used.

---

### **Best Practices / Tips**

* Keep delimiters **uppercase** (e.g., `EOF`, `END`, `DATA`) for readability.
* Quote `EOF` (`'EOF'`) to prevent expansion when inserting raw config text.
* Use `<<-EOF` for indented HEREDOCs.
* Use HEREDOCs for multi-line input; Here Strings for short one-liners.
* Combine HEREDOCs with `tee` for writing system configs:

  ```bash
  sudo tee /etc/app/config.conf <<EOF
  key=value
  mode=prod
  EOF
  ```

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: heredoc_example.sh
# Purpose: Demonstrate Here Document and Here String usage

# Using Here Document
cat <<EOF > welcome.txt
Welcome to the DevOps Team!
Today's date: $(date)
User: $USER
EOF

# Using Here String
grep "DevOps" <<< "Welcome to DevOps learning session" > result.txt

echo "✅ Files created:"
ls -l welcome.txt result.txt
```

---

### **Explanation of Script**

1. The `cat <<EOF > welcome.txt` block writes a formatted multi-line message.
2. Variables like `$(date)` and `$USER` expand automatically.
3. The `<<<` passes a one-line string to `grep` for pattern search.
4. Both outputs (`welcome.txt`, `result.txt`) are generated.
5. Demonstrates multi-line and inline redirection together.

---
---

## 🗂️ Concept 8: Error and Output Redirection (`>`, `>>`, `2>`, `2>&1`)

### **Concept / What**

In shell scripting, **redirection** is used to send command outputs and errors to files or other destinations instead of displaying them on the terminal. This allows you to separate or combine logs, debug scripts, or silence unwanted output.

By default:

* **stdin (0)** → Standard Input
* **stdout (1)** → Standard Output
* **stderr (2)** → Standard Error

---

### **Why / Purpose / Use Case**

* Save command results and errors in log files.
* Separate success and failure logs for better debugging.
* Combine all outputs into one file for recordkeeping.
* Silence unnecessary output in automation or cron jobs.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Redirect Standard Output (stdout)**

```bash
command > output.log
```

Sends normal output to `output.log` and overwrites it if it exists.

Example:

```bash
ls > files.txt
```

✅ Saves directory list to `files.txt`.

---

#### **2️⃣ Append Standard Output**

```bash
command >> output.log
```

Appends output to an existing file instead of overwriting.

Example:

```bash
echo "New line" >> files.txt
```

---

#### **3️⃣ Redirect Errors (stderr)**

```bash
command 2> error.log
```

Sends only error messages to a file.

Example:

```bash
ls /fakepath 2> error.log
```

---

#### **4️⃣ Combine Output and Errors (stdout + stderr)**

```bash
command > combined.log 2>&1
```

Both output and errors go to the same file.

Example:

```bash
ls /etc /fakepath > all.log 2>&1
```

Explanation:

* `> all.log` → Redirects stdout to file.
* `2>&1` → Redirects stderr to where stdout is going.

⚠️ Order matters:
`> file 2>&1` ✅ works correctly.
`2>&1 > file` ❌ doesn’t capture both.

---

#### **5️⃣ Suppress All Output**

```bash
command > /dev/null 2>&1
```

✅ Silences both output and errors. Used for background or silent operations.

---

### **Common Issues / Errors**

| Issue                    | Reason                                    |
| ------------------------ | ----------------------------------------- |
| File not created         | No write permissions or wrong path.       |
| Log overwritten          | Used `>` instead of `>>`.                 |
| Error redirection failed | Wrong order of operators (`2>&1 > file`). |

---

### **Troubleshooting / Fixes**

* Use absolute file paths when logging from cron jobs.
* Verify permissions using `ls -l`.
* Use `>>` when preserving old logs.
* Test using both success and error outputs to confirm behavior.

---

### **Best Practices / Tips**

* Keep separate success and error logs:

  ```bash
  ./deploy.sh > success.log 2> error.log
  ```
* Combine both only when needed:

  ```bash
  ./deploy.sh > combined.log 2>&1
  ```
* Suppress unnecessary output with `/dev/null`.
* Use `set -x` when debugging redirection issues.
* Check file size and timestamps to ensure redirection worked.

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: redirect_output_demo.sh
# Purpose: Demonstrate output and error redirection

OUTPUT_LOG="output.log"
ERROR_LOG="error.log"
COMBINED_LOG="combined.log"

echo "Running directory checks..."

# 1. Redirect stdout
ls /etc > "$OUTPUT_LOG"

# 2. Redirect stderr
ls /fakepath 2> "$ERROR_LOG"

# 3. Redirect both stdout and stderr
ls /etc /fakepath > "$COMBINED_LOG" 2>&1

echo "✅ Logs generated:"
ls -l *.log
```

---

### **Explanation of Script**

1. `ls /etc > output.log` → Saves valid directory output.
2. `ls /fakepath 2> error.log` → Captures only error output.
3. `ls /etc /fakepath > combined.log 2>&1` → Saves both outputs together.
4. Displays all created log files for verification.

---

### **Summary Table**

| Operator    | Description                 | Example                |
| ----------- | --------------------------- | ---------------------- |
| `>`         | Redirect stdout (overwrite) | `echo hi > file`       |
| `>>`        | Append stdout               | `echo hi >> file`      |
| `2>`        | Redirect stderr             | `ls /bad 2> err.log`   |
| `2>>`       | Append stderr               | `ls /bad 2>> err.log`  |
| `2>&1`      | Merge stderr into stdout    | `cmd > file 2>&1`      |
| `/dev/null` | Discard all output          | `cmd > /dev/null 2>&1` |

---
---


