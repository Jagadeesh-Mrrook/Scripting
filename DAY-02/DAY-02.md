## Concept 1: Create and Use Variables

### Concept / What:

A **variable** is a named storage in the shell that holds a value (string, number, etc.). You can use it to store data and reuse it in commands or scripts.

There are two types of variables:

1. **Shell (local) variables**: Defined and used within the script or shell session. Not visible to child processes.
2. **Environment variables**: Exported using `export` keyword and available to the shell **and all child processes**.

### Why / Purpose / Use Case:

* Store user input, file names, paths, or counters.
* Make scripts dynamic instead of hardcoding values.
* Environment variables configure the shell or programs globally (e.g., PATH, HOME).
* Simplifies maintenance and readability.

### How it Works / Steps / Syntax:

1. **Create a shell variable:**

```bash
variable_name="value"
```

> No spaces around `=`.

2. **Access a variable:**

```bash
echo $variable_name
```

3. **Export as environment variable:**

```bash
export MYENV="DevOps"
```

* Child process example:

```bash
bash -c 'echo $MYENV'
```

4. **Example usage in commands:**

```bash
filename="logfile.txt"
echo "Processing $filename"
cat $filename
```

### Common Issues / Errors:

* Using spaces around `=`: `var = "value"` → **Error**.
* Accessing without `$`: `echo variable_name` prints literal name.
* Overwriting variables unintentionally.
* Forgetting `export` when environment variable is needed in child processes.

### Troubleshooting / Fixes:

* Ensure no spaces around `=`.
* Use `$` when referencing.
* Use descriptive names to avoid accidental overwrites.
* Use `export` for variables that need to be global.
* List environment variables using `printenv` or `env`.

### Best Practices / Tips:

* Lowercase for local variables, UPPERCASE for environment variables.
* Quote strings with spaces or special characters: `name="Jagga DevOps"`.
* Avoid overwriting important system environment variables unless intended.

### Example Script:

```bash
#!/bin/bash

# Local variable
username="Jagga"
echo "Local variable username: $username"

# Environment variable
export APP_ENV="Production"
echo "Environment variable APP_ENV: $APP_ENV"

# Demonstrate child process access
bash -c 'echo "Child process sees APP_ENV as: $APP_ENV"'
bash -c 'echo "Child process sees username as: $username"'

# Variable in command
filename="myfile.txt"
echo "Creating file $filename..."
touch "$filename"
echo "File $filename created successfully.""
```
---

## Concept 2: Understand Variable Types (Strings, Numbers)

### Concept / What:

Variables in shell can hold different types of data:

1. **Strings** – sequence of characters, letters, numbers, or symbols.
2. **Numbers** – integer or floating-point values used for calculations.

> Note: Bash doesn’t enforce variable types. All variables are treated as strings by default. Numeric operations are interpreted when used in arithmetic contexts.

### Why / Purpose / Use Case:

* **Strings:** Store names, messages, file paths, or textual data.
* **Numbers:** Perform arithmetic calculations, counters, loop indices.
* Enables scripts to handle dynamic data efficiently.

### How it Works / Steps / Syntax:

1. **String variable:**

```bash
name="Jagga"
greeting="Hello"
echo "$greeting, $name!"
```

2. **Integer variable (arithmetic context):**

```bash
num1=10
num2=5
sum=$((num1 + num2))
echo "Sum is: $sum"
```

3. **Floating-point numbers** (requires `bc` since Bash doesn’t support floats natively):

```bash
num1=10.5
num2=2.3
result=$(echo "$num1 + $num2" | bc)
echo "Result: $result"
```

> `bc` stands for **Basic Calculator**, a command-line utility for precise arithmetic, including floating-point operations.

4. **Check if variable is number:**

```bash
var="123"
if [[ $var =~ ^[0-9]+$ ]]; then
    echo "$var is a number"
else
    echo "$var is not a number"
fi
```

### Common Issues / Errors:

* Performing arithmetic on non-numeric values → unexpected results.
* Floating-point numbers require `bc` – native `$(( ))` works only for integers.
* Forgetting quotes around strings with spaces → splitting issues.

### Troubleshooting / Fixes:

* Validate numbers before arithmetic.
* Quote string variables in commands to handle spaces.
* Use `bc` or `awk` for floating-point operations.

### Best Practices / Tips:

* Use descriptive names: `count`, `username`, `total_amount`.
* Keep numeric and string variables separate where possible.
* Always quote strings with spaces: `"Hello World"`.

### Example Script:

```bash
#!/bin/bash

# String variable
name="Jagga"
greeting="Hello"
echo "$greeting, $name!"

# Integer variables
num1=10
num2=5
sum=$((num1 + num2))
echo "Sum of $num1 and $num2 is $sum"

# Floating-point calculation
num1=10.5
num2=2.3
result=$(echo "$num1 + $num2" | bc)
echo "Floating-point sum: $result"

# Check if a variable is number
var="123"
if [[ $var =~ ^[0-9]+$ ]]; then
    echo "$var is a number"
else
    echo "$var is not a number"
fi
```

---

## Concept 3: Take User Input Using `read`

### Concept / What:

The `read` command allows a Bash script to **pause and accept input from the user** during execution. The input is stored in a variable for later use.

### Why / Purpose / Use Case:

* Make scripts **interactive**.
* Accept user-provided values like filenames, numbers, options, or confirmation.
* Useful for dynamic scripts where values are **not known beforehand**.

### How it Works / Steps / Syntax:

1. **Single variable read:**

```bash
read -p "Enter your favorite fruit: " fruit
echo "You chose: $fruit"
```

* All input (single or multiple words) goes into one variable.
* Example input: `Mango` → Output: `You chose: Mango`

2. **Multiple variables read:**

```bash
read -p "Enter your first and second favorite fruits separated by space: " fruit1 fruit2
echo "First fruit: $fruit1"
echo "Second fruit: $fruit2"
```

* Input is split by spaces.
* Example input: `Apple Banana` → `fruit1=Apple`, `fruit2=Banana`
* If more words entered: `Apple Banana Mango` → `fruit1=Apple`, `fruit2=Banana Mango`

3. **Preserving spaces with quotes:**

```bash
read -p "Enter your favorite fruit combination (e.g., Apple Mango): " combo
echo "You entered: $combo"
```

* Quotes allow multiple words to be treated as **one string**.
* Example input: `"Apple Mango"` → Output: `You entered: Apple Mango`

4. **Using IFS and `-r` for raw input:**

```bash
IFS= read -r description
echo "You typed exactly: $description"
```

* `IFS=` disables word splitting.
* `-r` prevents backslash interpretation.
* Example input: `Apple & Banana \ Mango` → Output: `Apple & Banana \ Mango` (exact input preserved)

### Common Issues / Errors:

* Without `-r`, backslashes are interpreted, e.g., `\n` becomes a newline.
* Without `IFS=`, spaces may be split across multiple variables unexpectedly.
* Forgetting prompts can confuse users.

### Troubleshooting / Fixes:

* Use `-p` for user-friendly prompts.
* Quote variables when using them: `echo "$var"`
* Use `IFS= read -r` to preserve exact user input.
* For multiple variables, consider how spaces will split the input.

### Best Practices / Tips:

* Use descriptive variable names (`username`, `filename`, `choice`).
* Use `-s` for sensitive input (e.g., passwords).
* Validate input after reading.
* Combine with loops for repeated input validation.
* Use quotes or `IFS= read -r` when expecting spaces or special characters.

### Example Scripts

**Script 9: Single Variable Read** → `09_single_variable_read.sh`

```bash
#!/bin/bash
read -p "Enter your favorite fruit: " fruit
echo "You chose: $fruit"
```

**Script 10: Multiple Variables Read** → `10_multiple_variables_read.sh`

```bash
#!/bin/bash
read -p "Enter your first and second favorite fruits separated by space: " fruit1 fruit2
echo "First fruit: $fruit1"
echo "Second fruit: $fruit2"
```

**Script 11: Preserve Spaces with Quotes** → `11_preserve_spaces_quotes.sh`

```bash
#!/bin/bash
read -p "Enter your favorite fruit combination (e.g., Apple Mango): " combo
echo "You entered: $combo"
```

**Script 12: Raw Input with IFS and -r** → `12_raw_input_ifs_r.sh`

```bash
#!/bin/bash
IFS= read -r description
echo "You typed exactly: $description"
```

---
---

# Day 2: Variables, Input, Command-Line Arguments, and Environment

## Concept 1: Variable Scopes and Environment Variables

### Local / Shell Variables

**Concept / What:**
Variables defined **without `export`** are **local to the current shell or script**. They are **not available to child processes**.

**Why / Purpose / Use Case:**

* Store temporary data for a script or session.
* Prevent cluttering environment with unnecessary variables.
* Useful for script-local calculations or temporary filenames.

**How it Works / Steps / Syntax:**

```bash
local_var="I exist only in this shell"
echo "Local variable: $local_var"
```

* **Child processes** cannot see this variable:

```bash
bash -c 'echo $local_var'  # Will print nothing
```

**Common Issues / Errors:**

* Expecting a non-exported variable to be available in child processes → prints empty.

**Troubleshooting / Fixes:**

* Use `export` if you want it visible in child processes.

**Best Practices / Tips:**

* Use local variables for temporary calculations or script-specific data.
* Avoid overwriting important environment variables accidentally.

**Example Script 1: Local Variable → `01_local_variable.sh`**

```bash
#!/bin/bash
# Demonstrates local variable scope

local_var="I exist only in this shell"
echo "Local variable in current shell: $local_var"

# Child process cannot access local_var
bash -c 'echo "Child process sees: $local_var"'
```

---

### Session-Specific / Exported Environment Variables

**Concept / What:**
Variables defined with `export` are **environment variables**, visible to **current session and child processes**. They disappear after the terminal is closed.

**Why / Purpose / Use Case:**

* Share configuration or data with child processes temporarily.
* Useful for scripts calling other scripts or programs that rely on certain variables.

**How it Works / Steps / Syntax:**

```bash
export SESSION_VAR="I am visible in child processes"
echo "SESSION_VAR in current shell: $SESSION_VAR"
bash -c 'echo "Child process sees: $SESSION_VAR"'
```

* Closes terminal → variable disappears.

**Common Issues / Errors:**

* Forgetting `export` → child processes cannot access the variable.

**Troubleshooting / Fixes:**

* Always use `export VAR=value` when the child process needs it.

**Best Practices / Tips:**

* Use session-specific variables for temporary configuration.
* Avoid naming conflicts with existing environment variables.

**Example Script 2: Session Environment Variable → `02_session_variable.sh`**

```bash
#!/bin/bash
# Demonstrates session-specific exported environment variable

export SESSION_VAR="I exist in this shell and child processes"
echo "SESSION_VAR in current shell: $SESSION_VAR"

# Child process can access SESSION_VAR
bash -c 'echo "Child process sees: $SESSION_VAR"'
```

---

### Persistent / Across Sessions Environment Variables

**Concept / What:**
Variables stored in **startup files** like `~/.bashrc` or `/etc/environment` persist across terminal sessions.

**Why / Purpose / Use Case:**

* Useful for variables that should always be available, like PATH additions or custom configuration flags.

**How it Works / Steps / Syntax:**

1. Add to `~/.bashrc`:

```bash
# ~/.bashrc
export PERSIST_VAR="I survive across sessions"
MY_LOCAL_VAR="I exist every new terminal but not in child processes"
```

2. Apply changes immediately:

```bash
source ~/.bashrc
```

3. Test:

```bash
echo $PERSIST_VAR       # Accessible in all new sessions
echo $MY_LOCAL_VAR      # Available in all new sessions (shell only)
```

**Common Issues / Errors:**

* Forgetting `source ~/.bashrc` → changes not applied immediately.
* Not using `export` for variables that need to be accessed in child processes.

**Troubleshooting / Fixes:**

* Always `source` after editing `.bashrc`.
* Verify variable scope using `echo $VAR` and `bash -c 'echo $VAR'`.

**Best Practices / Tips:**

* Use uppercase for persistent variables.
* Keep `.bashrc` organized; avoid overwriting important system variables.

**Example Script 3: Persistent Variable Demo → `03_persistent_variable.sh`**

```bash
#!/bin/bash
# Demonstrates instructions for persistent variables

echo "To make a variable persistent, add to ~/.bashrc:"
echo 'export PERSIST_VAR="I survive across sessions"'
echo 'MY_LOCAL_VAR="I exist every new terminal but not in child processes"'
echo "Then run: source ~/.bashrc"
echo "Example check: echo \$PERSIST_VAR"
```

---

These 3 scripts together fully illustrate: local variables, session-specific environment variables, and persistent environment variables across sessions.

---
---

# Command-Line Arguments

## Concept / What

Command-line arguments allow a script to accept **input values at runtime**, making scripts dynamic. These inputs are passed when invoking the script and accessed via special variables like `$1`, `$2`, `$@`, `$*`, and `$#`.

## Why / Purpose / Use Case

* Makes scripts flexible without hardcoding values.
* Accept file names, options, or configuration at runtime.
* Enables reusable scripts across different scenarios.
* Useful in automation pipelines, batch processing, and parameterized scripts.

**Practical Scenarios**

* A backup script that accepts the **directory path** as an argument.
* A deployment script where the **environment name** (`dev`, `prod`) is passed.
* A script that processes **multiple filenames** at once.

## How it Works / Steps / Syntax

1. `$1`, `$2`, ... → First, second, etc., argument.
2. `$@` → All arguments as **separate words**.
3. `$*` → All arguments as **a single string**.
4. `$#` → Total number of arguments passed.
5. `$0` → Name of the script or Path used to run the script.

**Accessing Arguments Example:**

```bash
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

5. Pass arguments while running the script:

```
./script.sh arg1 arg2 arg3
```

## Common Issues / Errors

* Forgetting to provide required arguments → script may fail.
* Using `$1` without checking → can get empty values.
* Mixing `$*` and `$@` in loops → may produce unexpected results.

## Troubleshooting / Fixes

* Validate the number of arguments using `$#`.
* Provide default values if an argument is missing.
* Quote variables when using them to preserve spaces.

## Best Practices / Tips

* Always check if required arguments are provided.
* Use meaningful variable names for `$1`, `$2`, etc.
* Prefer `$@` in loops to handle each argument safely.
* Combine with `shift` to process arguments iteratively.

## Example Scripts

**Script 1: Access First and Second Arguments → `01_arguments_basic.sh`**

```bash
#!/bin/bash
# Demonstrates $1 and $2

echo "First argument (name): $1"
echo "Second argument (age): $2"
```

**Usage:**

```
./01_arguments_basic.sh Jagga 25
```

**Output:**

```
First argument (name): Jagga
Second argument (age): 25
```

---

**Script 2: Loop Through All Arguments with $@ → `02_arguments_loop.sh`**

```bash
#!/bin/bash
# Demonstrates $@ to loop through all arguments

echo "All arguments individually:"
for arg in "$@"; do
  echo "$arg"
done
```

**Usage:**

```
./02_arguments_loop.sh apple banana cherry
```

**Output:**

```
All arguments individually:
apple
banana
cherry
```

---

**Script 3: Combine Arguments as a Single String with $* → `03_arguments_combined.sh`**

```bash
#!/bin/bash
# Demonstrates $* as a single string

echo "All arguments as a single string:"
echo "$*"
```

**Usage:**

```
./03_arguments_combined.sh apple banana cherry
```

**Output:**

```
All arguments as a single string:
apple banana cherry
```

---

**Script 4: Check Number of Arguments → `04_arguments_count.sh`**

```bash
#!/bin/bash
# Demonstrates $# for argument count

echo "Number of arguments passed: $#"

if [ $# -lt 2 ]; then
  echo "Error: At least 2 arguments are required"
  exit 1
fi
```

**Usage:**

```
./04_arguments_count.sh apple
```

**Output:**

```
Number of arguments passed: 1
Error: At least 2 arguments are required
```

---

**Script 5: Realistic Scenario - File Processing → `05_arguments_files.sh`**

```bash
#!/bin/bash
# Script to process filenames passed as arguments

if [ $# -lt 1 ]; then
  echo "Usage: $0 <file1> [file2 ...]"
  exit 1
fi

for file in "$@"; do
  if [ -f "$file" ]; then
    echo "Processing $file..."
    # Example command: count lines
    lines=$(wc -l < "$file")
    echo "$file has $lines lines"
  else
    echo "File $file does not exist"
  fi
 done
```

**Usage:**

```
./05_arguments_files.sh file1.txt file2.txt
```

**Output Example:**

```
Processing file1.txt...
file1.txt has 20 lines
File file2.txt does not exi
```

---
---

# Validate Arguments and Handle Missing Arguments

### Concept

Before using command-line arguments in a script, **validate them** to ensure the user provides the required inputs. This prevents errors and improves script usability.

---

### Why / Purpose / Use Case

* Avoid script failures due to missing or incorrect input.
* Guide the user with proper usage instructions.
* Makes scripts more robust and professional.

**Practical Scenarios:**

* Script expects at least one filename.
* Script expects numeric values for arithmetic.
* Script requires an option flag (`-h`, `-v`, etc.).

---

### How it Works / Steps / Syntax

1. **Check number of arguments using `$#`:**

```bash
if [ $# -lt 1 ]; then
    echo "Error: At least one argument required"
    echo "Usage: $0 <arg1> [arg2 ...]"
    exit 1
fi
```

2. **Check if argument is empty:**

```bash
if [ -z "$1" ]; then
    echo "Error: First argument cannot be empty"
    exit 1
fi
```

3. **Check file existence for file arguments:**

```bash
if [ ! -f "$1" ]; then
    echo "Error: File $1 does not exist"
    exit 1
fi
```

4. **Loop through multiple arguments and validate each:**

```bash
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Error: $file not found"
        exit 1
    fi
done
```

---

### Common Issues / Errors

* Forgetting to check `$#` → script may access `$1` or `$2` when missing.
* Using `$*` instead of `$@` in a loop → multiple arguments treated as a single string.
* Not providing meaningful error messages → user confused about script usage.

---

### Troubleshooting / Fixes

* Always validate number of arguments first.
* Use `-z` to check empty values.
* Use `-f` to check file existence.
* Provide clear usage instructions to the user.

---

### Best Practices / Tips

* Always include a usage message showing expected arguments.
* Validate each argument individually if required.
* Exit the script with a non-zero status (`exit 1`) when validation fails.
* Use `$0` to display the script name in usage instructions.

---

### Example Script

```bash
#!/bin/bash
# Script to process filenames passed as arguments

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Error: At least one filename is required"
    echo "Usage: $0 <file1> [file2 ...]"
    exit 1
fi

# Loop through all arguments
for file in "$@"; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        lines=$(wc -l < "$file")
        echo "$file has $lines lines"
    else
        echo "File $file does not exist"
    fi
done
```

---
---

---

# Arithmetic Operations: +, -, *, /, %

### Concept / What:

Arithmetic operations in shell scripting allow you to perform **mathematical calculations** on integer (and sometimes floating-point) variables. Common operations include addition (`+`), subtraction (`-`), multiplication (`*`), division (`/`), and modulo (`%`).

---

### Why / Purpose / Use Case:

* Perform calculations like totals, counts, or increments in scripts.
* Useful in loops, counters, or processing numerical data.
* Supports dynamic behavior in scripts based on arithmetic results.

**Practical Scenarios:**

* Counting files or lines in multiple files.
* Calculating disk usage or percentages.
* Performing simple finance or resource calculations in scripts.

---

### How it Works / Steps / Syntax:

1. **Basic integer arithmetic using `$(( ))`:**

```bash
num1=10
num2=5

sum=$((num1 + num2))
diff=$((num1 - num2))
prod=$((num1 * num2))
quot=$((num1 / num2))
rem=$((num1 % num2))

echo "Sum: $sum"
echo "Difference: $diff"
echo "Product: $prod"
echo "Quotient: $quot"
echo "Remainder: $rem"
```

2. **Floating-point arithmetic** requires `bc`:

```bash
num1=10.5
num2=2.3
result=$(echo "$num1 / $num2" | bc -l)
echo "Division result: $result"
```

---

### Common Issues / Errors:

* Using `/` with integers gives integer division (fraction truncated).
* `%` only works with integers.
* Floating-point numbers cannot be used directly with `$(( ))`.
* Forgetting to quote variables in expressions with spaces or special characters.

---

### Best Practices / Tips:

* Use `$(( ))` for integers and `bc` for floating-point calculations.
* Always validate numeric input before arithmetic.
* Use descriptive variable names for clarity.
* Quote variables when using them in commands to avoid unexpected behavior.

---

### Example Script:

```bash
#!/bin/bash

# Integer arithmetic
num1=17
num2=4

echo "Addition: $((num1 + num2))"
echo "Subtraction: $((num1 - num2))"
echo "Multiplication: $((num1 * num2))"
echo "Division: $((num1 / num2))"
echo "Modulo: $((num1 % num2))"

# Floating-point arithmetic
float1=17.5
float2=4.2
result=$(echo "$float1 / $float2" | bc -l)
echo "Floating-point Division: $result"
```

---
---

# Assignment Operators (`=`)

### Concept / What

The **assignment operator `=`** in shell scripting is used to **assign a value to a variable**. It is the fundamental way to store data (strings, numbers, command outputs) in shell variables for later use.

> Note: There should **not be spaces** around `=`.

---

### Why / Purpose / Use Case

* Store data that will be reused multiple times.
* Make scripts dynamic and flexible.
* Capture results of commands or arithmetic operations.
* Useful for counters, file paths, user inputs, and more.

**Practical Scenarios**

* Storing a filename or directory path for reuse:

```bash
dir="/home/jagga/projects"
```

* Counting iterations in a loop:

```bash
count=0
```

* Storing output of a command:

```bash
date_today=$(date +%Y-%m-%d)
```

---

### How it Works / Steps / Syntax

1. **Basic assignment:**

```bash
variable_name="value"
```

*Example:*

```bash
name="Jagga"
```

2. **Using command substitution:**

```bash
current_user=$(whoami)
```

*Stores the output of `whoami` into variable `current_user`.*

3. **Using arithmetic assignment:**

```bash
count=$((count + 1))
```

*Increments the value of `count` by 1.*

---

### Common Issues / Errors

* Spaces around `=` → `var = 10` → **Error**.
* Using uninitialized variables → empty output if referenced before assignment.
* Forgetting `$` when referencing the variable → prints the name literally.

---

### Troubleshooting / Fixes

* Ensure no spaces on either side of `=`.
* Quote strings if they contain spaces or special characters:

```bash
greeting="Hello World"
```

* Use `$variable_name` when accessing the value.

---

### Best Practices / Tips

* Use lowercase for local variables, uppercase for environment variables.
* Keep variable names descriptive (`count`, `filename`, `user_name`).
* Always quote values that may contain spaces or special characters.
* For numeric operations, prefer arithmetic expansion `$(( ))`.

---

### Example Scripts

**Script 1: Basic Assignment → `18_assignment_basic.sh`**

```bash
#!/bin/bash
# Assign a string value to a variable
name="Jagga"
echo "Hello, $name!"
```

**Script 2: Command Substitution → `19_assignment_command.sh`**

```bash
#!/bin/bash
# Assign the output of a command to a variable
current_user=$(whoami)
echo "Current user: $current_user"
```

**Script 3: Arithmetic Assignment → `20_assignment_arithmetic.sh`**

```bash
#!/bin/bash
# Assign and increment numbers
count=0
count=$((count + 1))
echo "Count is now: $count"
```

---
---

## 🧠 Concept: Read User Info (`whoami`, `id`, `$EUID`)

### 🔹 1. `whoami`

* Prints the **current logged-in username**.
* Example:

  ```bash
  whoami
  ```

  Output:

  ```
  ubuntu
  ```
* Use case: Helpful in scripts to check which user is running the script.

---

### 🔹 2. `id`

* Displays **user ID (UID)**, **group ID (GID)**, and **groups**.
* Example:

  ```bash
  id
  ```

  Output:

  ```
  uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),27(sudo)
  ```
* Use case: Commonly used in access validation and troubleshooting permission issues.

---

### 🔹 3. `$EUID` (Effective User ID)

* `$EUID` is a **special shell variable** that holds the **effective user ID** of the user running the script.
* `0` → Root user, any other value → Non-root user.

#### Example:

```bash
#!/bin/bash
# Restrict script to root user only

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
else
  echo "Running as root user."
fi
```

#### Explanation:

* `$EUID`: Represents the user ID of the current process.
* `-ne 0`: Checks if not equal to 0 (not root).
* Helps prevent non-root users from running scripts that require root privileges.

#### Use case:

* Used in system-level automation scripts to ensure required privileges before performing actions like:

  * Editing `/etc/` files
  * Installing packages
  * Changing system configurations

---

### ✅ Quick Summary

| Command/Variable | Purpose                    | Example Output     | Use Case             |
| ---------------- | -------------------------- | ------------------ | -------------------- |
| `whoami`         | Prints current username    | `ubuntu`           | Display current user |
| `id`             | Shows UID, GID, and groups | `uid=1000(ubuntu)` | Permission debugging |
| `$EUID`          | Stores effective user ID   | `0` for root       | Validate root access |

---
---

# Environment Variables (`PATH`, `HOME`, `export`)

## Concept / What

Environment variables are variables available **system-wide or for the current shell session** that store configuration data used by the shell and programs. Common examples include `PATH`, `HOME`, and custom variables exported using the `export` command.

* `PATH` → List of directories where the shell looks for executable commands.
* `HOME` → The current user’s home directory.
* `export` → Makes a variable available to **child processes**.

## Why / Purpose / Use Case

* Share configuration data between the shell and processes.
* Avoid hardcoding paths or settings in scripts.
* Control the environment for commands and scripts.
* Customize shell behavior (e.g., adding directories to `PATH`).

**Practical Scenarios**:

* Adding `/usr/local/bin` to `PATH` so custom scripts can be run without full path.
* Storing a default directory in `HOME` for scripts to reference.
* Exporting a variable so child scripts or programs can access it.

## How it Works / Steps / Syntax

1. **View environment variables**:

```bash
echo $PATH
echo $HOME
printenv
```

2. **Set a local variable (current shell only)**:

```bash
MYVAR="Hello"
echo $MYVAR
```

3. **Export a variable for child processes**:

```bash
export MYVAR="Hello"
bash -c 'echo "Child sees MYVAR as: $MYVAR"'
```

4. **Add a directory to `PATH`**:

```bash
export PATH="$HOME/scripts:$PATH"
echo $PATH
```

5. **Persistent variables**:  Add to `~/.bashrc` or `~/.profile`:

```bash
export MYVAR="PersistentValue"
export PATH="$HOME/scripts:$PATH"
```

* Reload changes with `source ~/.bashrc`

## Common Issues / Errors

* Variable not visible in child processes → not exported.
* Wrong syntax or missing quotes → variable splitting or errors.
* `PATH` incorrectly set → commands not found.
* Changes not persistent → forgot to update `.bashrc` or `.profile`.

## Troubleshooting / Fixes

* Always use `export` for variables needed in child processes.
* Quote variables with spaces: `export VAR="value with spaces"`.
* Check current `PATH` with `echo $PATH`.
* Source `.bashrc` after editing: `source ~/.bashrc`.

## Best Practices / Tips

* Use **uppercase** for environment variables (`MYVAR`) and lowercase for local variables (`myvar`).
* Avoid overwriting important system variables unless necessary.
* Keep persistent variables in `.bashrc` or `.profile` for consistency.
* Use `printenv` or `env` to debug environment variables.
* Export only what is needed to child processes.

## Example Scripts

**Script 18: Environment Variable Demonstration → `18_env_vars.sh`**

```bash
#!/bin/bash
# Demonstrate environment variables and export

# Local variable
LOCALVAR="I am local"
echo "Local variable: $LOCALVAR"

# Exported variable
export GLOBALVAR="I am global"
echo "Exported variable: $GLOBALVAR"

# Demonstrate child process access
bash -c 'echo "Child process sees GLOBALVAR as: $GLOBALVAR"'
bash -c 'echo "Child process sees LOCALVAR as: $LOCALVAR"'

# Adding custom directory to PATH
export PATH="$HOME/scripts:$PATH"
echo "Updated PATH: $PATH"
```

**How to Run**:

1. Save as `18_env_vars.sh`
2. Make executable: `chmod +x 18_env_vars.sh`
3. Exec
---
---

# Command Grouping (Subtopic Notes)

## Purpose

Command grouping (`{ ... }`) lets you combine **multiple commands into one unit** so they work correctly with `&&` and `||`.

## Syntax

```
{ command1; command2; }
```

* Commands inside must end with `;`
* Acts as a **single command** in chaining

## Why We Use It

Chaining normally handles only one command:

```
mkdir backup && echo "OK" || echo "FAIL"
```

But when failure needs **multiple actions** (e.g., message + exit), grouping is required.

## Example

```
mkdir backup && echo "Backup directory created" || {
    echo "Backup directory creation failed";
    exit 5;
}
```

* Success → only success message runs
* Failure → entire group runs (message + exit)

---

## Here Document (<<) and Here String (<<<)

### Here Document (<<)

* Used to feed **multi-line input** to a command.
* It acts like typing multiple lines directly into STDIN.
* Commonly used for configs, templates, inline files.

**Syntax:**

```
command << EOF
line1
line2
EOF
```

* `EOF` is a delimiter (can be any word).
* Everything between the two delimiters is treated as input.

### Here String (<<<)

* Used to feed **a single string** as input to a command.
* Perfect for passing variables or short text into commands that read from STDIN.

**Syntax:**

```
command <<< "text"
```

**Example with read:**

```
IFS=' ' read -r first last <<< "$fullname"
```

* Feeds the value of `$fullname` as input to `read`.

### Summary

| Feature    | << (Here-Doc)      | <<< (Here-String)             |
| ---------- | ------------------ | ----------------------------- |
| Purpose    | Multi-line input   | Single-string input           |
| Use Case   | Templates / blocks | Feeding variable to a command |
| Reads From | Inline block       | Inline string                 |
| Example    | cat << EOF         | read x <<< "hello"            |

---
---
#Script

# Q6 String Operations Script (with Comments)

```bash
#!/bin/bash

read -p "Enter any string:" string

if [[ -z $string ]]; then #You can use xargs to ignore spaces, otherwise it is not considered empty if user enters space
  echo "You have to enter a string it cant be empty"
  exit 1
fi

echo "Select an option to continue"
echo "1 - Convert to UPPERCASE"
echo "2 - Convert to lowercase"
echo "3 - Count the number of characters"
echo "4 - Reverse the String"

read -p "Enter your Option:" option

case $option in

  1)
    string=$( echo "$string" | tr '[:lower:]' '[:upper:]') #You can use #upper=${string^^} for converting to uppercase
    echo "Uppercase string: $string"
    ;;

  2)
    string=$(echo "$string" | tr '[:upper:]' '[:lower:]') #You can #uselower=${string,,} for converting to lowercase
    echo "Uppercase string: $string"
    echo "Lowercase string: $string"
    ;;

  3)
    characters=$( echo -n "$string" | wc -c )
    echo "Number of characters: $characters"
    ;;

  4)
    string=$( echo "$string" | rev )
    echo "Reverse string: $string"
    ;;

  *)
    echo "Invalid Choice"
    ;;
esac
```


---
---
---

