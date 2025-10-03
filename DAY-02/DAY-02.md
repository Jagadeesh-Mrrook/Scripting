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


