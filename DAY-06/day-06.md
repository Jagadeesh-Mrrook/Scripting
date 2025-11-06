# 🐚 Day 6: Introduction to String Manipulation & Arrays

## 🔹 Concept / What

String Manipulation and Arrays are two core concepts in shell scripting used to handle and organize text and data efficiently.

* **String Manipulation** helps you modify, extract, or analyze text.
* **Arrays** store multiple values in a single variable, useful for batch operations or grouped data.

---

## 🔹 Why / Purpose / Use Case

* **String Manipulation:** Used for formatting logs, validating input, parsing filenames, or extracting information.
* **Arrays:** Useful for storing lists like filenames, server names, or configuration parameters that you can iterate through easily.

---

## 🔹 How it Works / Steps / Syntax

### 🧩 **Array Basics**

#### 1. **Defining an Array**

You can define an array in multiple ways:

```bash
# Method 1: Direct assignment
numbers=(10 20 30 40 50)

# Method 2: Using 'declare'
declare -a numbers=(10 20 30 40 50)

# Method 3: Assign individually
numbers[0]=10
numbers[1]=20
numbers[2]=30
```

#### 2. **Accessing Elements**

```bash
echo ${numbers[0]}    # Access first element (10)
echo ${numbers[2]}    # Access third element (30)
```

#### 3. **Accessing All Elements**

```bash
echo ${numbers[@]}    # Lists all elements separated by space
```

Output:

```
10 20 30 40 50
```

👉 `${numbers[@]}` gives **all elements one by one** (useful for loops).

#### 4. **Accessing Array as a Single String**

If you want all elements **as a single string**, you can use:

```bash
echo "${numbers[*]}"
```

Both `@` and `*` are similar, but:

* `@` → Treats elements **individually** (used in loops)
* `*` → Treats elements as **one single string** (space-separated)

#### 5. **Getting Array Length**

```bash
echo ${#numbers[@]}   # Output: 5 (number of elements)
```

#### 6. **Iterating Through Arrays (One by One)**

```bash
for num in "${numbers[@]}"; do
  echo $num
done
```

Output:

```
10
20
30
40
50
```

#### 7. **Accessing Specific Ranges (Subsets)**

```bash
echo ${numbers[@]:1:3}   # Prints 3 elements starting from index 1 → 20 30 40
```

---

## 🔹 Common Issues / Errors

| Issue              | Reason                                           |
| ------------------ | ------------------------------------------------ |
| `bad substitution` | Using unsupported syntax in older shells         |
| Empty output       | Array not initialized or incorrect variable name |
| Wrong index        | Using index greater than array length            |

---

## 🔹 Troubleshooting / Fixes

* Always check array initialization before use.
* Use `declare -p varname` to print full array structure.
* Use `set -x` in debugging to trace array expansion.

---

## 🔹 Best Practices / Tips

* Always quote variables like `"${array[@]}"` to prevent word splitting.
* Prefer `${array[@]}` in loops and `${array[*]}` for combined string output.
* Use meaningful array names like `servers`, `ids`, `files`.

---

## 🔹 Example Script

```bash
#!/bin/bash

# Define an array of numbers
numbers=(10 20 30 40 50)

echo "All elements (space-separated): ${numbers[@]}"
echo "Array as a single string: ${numbers[*]}"
echo "First element: ${numbers[0]}"
echo "Total elements: ${#numbers[@]}"

echo "\nIterating through array:"
for num in "${numbers[@]}"; do
  echo $num
done

echo "\nSubset (from index 1, 3 elements): ${numbers[@]:1:3}"
```

---

This example script covers:

* Declaring arrays
* Accessing single/multiple elements
* Iterating through arrays
* Getting array length
* Extracting subsets

---
---


# 🧩 Concatenate Strings

## 🔹 Concept / What

String concatenation means joining two or more strings together into one continuous string. Shell scripting doesn’t need a special operator — you can directly place strings or variables next to each other.

---

## 🔹 Why / Purpose / Use Case

* Creating dynamic file names or paths
* Combining user input with fixed text
* Formatting log messages
* Building URLs or commands dynamically

**Examples:**

* `backup_${date}.tar.gz`
* `https://${domain}/api`

---

## 🔹 How it Works / Steps / Syntax

### 1. **Direct Concatenation**

```bash
str1="Hello"
str2="World"
result="$str1$str2"
echo "$result"
```

**Output:**

```
HelloWorld
```

---

### 2. **Adding a Space Between Strings**

```bash
str1="Hello"
str2="World"
result="$str1 $str2"
echo "$result"
```

**Output:**

```
Hello World
```

---

### 3. **Appending Text Using `+=`**

```bash
msg="Learning"
msg+=" Shell Scripting"
echo "$msg"
```

**Output:**

```
Learning Shell Scripting
```

---

### 4. **Concatenating with Command Output**

```bash
today=$(date +%A)
message="Today is $today."
echo "$message"
```

**Sample Output:**

```
Today is Saturday.
```

---

### 5. **Dynamic File Naming Example**

```bash
file_name="backup_$(date +%F).tar.gz"
echo "Backup file name: $file_name"
```

**Output:**

```
Backup file name: backup_2025-11-01.tar.gz
```

---

## 🔹 Common Issues / Errors

| Issue                  | Reason                                   |
| ---------------------- | ---------------------------------------- |
| Missing quotes         | Causes words with spaces to split        |
| Unset variables        | Variables not initialized before use     |
| No space between words | You must manually add spaces when needed |

---

## 🔹 Troubleshooting / Fixes

* Always use quotes around variable expansions (`"$var"`).
* Use `echo` to verify variable values before concatenation.
* If command output contains `\n`, remove it using `tr -d '\n'` before joining.

---

## 🔹 Best Practices / Tips

* Quote everything to preserve spaces.
* Use `+=` for appending inside loops or logs.
* Prefer `$(...)` over backticks for command substitution.
* Use descriptive variable names like `file_path`, `username`, `backup_date`.

---

## 🔹 Example Scripts

### 🧩 Example 1: Basic Concatenation

```bash
#!/bin/bash
str1="Hello"
str2="World"
result="$str1$str2"
echo "$result"
```

**Output:**

```
HelloWorld
```

---

### 🧩 Example 2: Adding a Space Between Strings

```bash
#!/bin/bash
str1="Hello"
str2="World"
result="$str1 $str2"
echo "$result"
```

**Output:**

```
Hello World
```

---

### 🧩 Example 3: Appending Text Using `+=`

```bash
#!/bin/bash
msg="Learning"
msg+=" Shell Scripting"
echo "$msg"
```

**Output:**

```
Learning Shell Scripting
```

---

### 🧩 Example 4: Concatenating with Command Output

```bash
#!/bin/bash
today=$(date +%A)
message="Today is $today."
echo "$message"
```

**Output:**

```
Today is Saturday.
```

---

### 🧩 Example 5: Dynamic File Naming

```bash
#!/bin/bash
file_name="backup_$(date +%F).tar.gz"
echo "Backup file name: $file_name"
```

**Output:**

```
Backup file name: backup_2025-11-01.tar.gz
```
---
---

## 🧩 Concept: Find String Length

### **Concept / What:**

String length refers to the total number of characters (including spaces and special characters) present in a string variable.

---

### **Why / Purpose / Use Case:**

* To validate user input (e.g., password length, username length)
* To manipulate or trim strings based on length
* Useful in automation scripts where string size matters (like filenames, log parsing, etc.)

---

### **How it Works / Steps / Syntax:**

There are multiple ways to find string length in shell scripting:

#### **1. Using `${#var}` (Most Common Method)**

```bash
str="Hello World"
echo "Length of string is: ${#str}"
```

📤 **Output:**

```
Length of string is: 11
```

#### **2. Using `expr length` Command**

```bash
str="BashScript"
echo "Length of string is: $(expr length "$str")"
```

📤 **Output:**

```
Length of string is: 10
```

#### **3. Using `awk` (Alternative Method)**

```bash
echo "ShellScripting" | awk '{print length}'
```

📤 **Output:**

```
14
```

---

### **Common Issues / Errors:**

| Issue               | Cause                                   | Example                             |
| ------------------- | --------------------------------------- | ----------------------------------- |
| `bad substitution`  | Using `${#}` incorrectly or missing `$` | `${#}` instead of `${#var}`         |
| Empty string output | Variable not defined                    | Using `${#undefined_var}` gives `0` |

---

### **Troubleshooting / Fixes:**

* Ensure variable is defined before checking length.
* Use quotes around variable to avoid word splitting (e.g., `"$str"`).
* For portable scripts, prefer `${#var}` as it works in all modern shells.

---

### **Best Practices / Tips:**

* Always use `${#var}` — it’s the simplest and fastest.
* Avoid `expr` unless working on legacy systems.
* When checking string length for conditions:

  ```bash
  if [ ${#str} -gt 5 ]; then
      echo "String is long"
  fi
  ```

---

### **Example Script:**

```bash
#!/bin/bash

# Example: Find the length of a given string
read -p "Enter any string: " str

# Method 1: Using ${#var}
length=${#str}
echo "Using \${#var} method: Length = $length"

# Method 2: Using expr
length2=$(expr length "$str")
echo "Using expr method: Length = $length2"

# Method 3: Using awk
echo "$str" | awk '{print "Using awk method: Length = " length}'
```

📤 **Sample Output:**

```
Enter any string: DevOps
Using ${#var} method: Length = 6
Using expr method: Length = 6
Using awk method: Length = 6
```

---
---

## 🌀 Concept: Reverse Strings

### **Concept / What:**

Reversing a string means rearranging its characters in the opposite order.

Example:
`"hello"` → `"olleh"`

---

### **Why / Purpose / Use Case:**

* Used in palindrome checking (to compare a string with its reverse)
* Helpful in text manipulation or transformation tasks
* Common in interview problems to test logic and loops in shell scripting

---

### **How it Works / Steps / Syntax:**

#### **1. Using `rev` Command (Simplest Way)**

```bash
str="DevOps"
echo "$str" | rev
```

📤 **Output:**

```
spOveD
```

#### **2. Using Shell Loop (Without External Commands)**

```bash
str="Shell"
reverse=""
for (( i=${#str}-1; i>=0; i-- )); do
    reverse="$reverse${str:$i:1}"
done
echo "$reverse"
```

📤 **Output:**

```
llehS
```

#### **3. Using `awk` (Alternative Method)**

```bash
echo "Linux" | awk '{for(i=length;i!=0;i--)x=x substr($0,i,1);print x;x=""}'
```

📤 **Output:**

```
xuniL
```

---

### **Common Issues / Errors:**

| Issue                    | Cause                                  | Example                       |
| ------------------------ | -------------------------------------- | ----------------------------- |
| `rev: command not found` | `rev` not installed on minimal systems | Use loop or awk instead       |
| Empty output             | Variable unset or empty                | `$str` not defined before use |

---

### **Troubleshooting / Fixes:**

* If `rev` is missing, install it with: `sudo apt install util-linux`
* Always use quotes around variables (`"$str"`) to preserve spaces.

---

### **Best Practices / Tips:**

* Prefer `rev` command for simplicity and speed.
* Use loop or `awk` when working in restricted environments (no external commands allowed).
* Always validate input before processing.

---

### **Example Script:**

```bash
#!/bin/bash

# Script: Reverse a given string
read -p "Enter a string to reverse: " str

# Method 1: Using rev
echo "Using rev: $(echo "$str" | rev)"

# Method 2: Using loop
reverse=""
for (( i=${#str}-1; i>=0; i-- )); do
    reverse="$reverse${str:$i:1}"
done
echo "Using loop: $reverse"

# Method 3: Using awk
echo "$str" | awk '{for(i=length;i!=0;i--)x=x substr($0,i,1);print "Using awk: "x;x=""}'
```

📤 **Sample Output:**

```
Enter a string to reverse: DevOps
Using rev: spOveD
Using loop: spOveD
Using awk: spOveD
```

---
---

# 🧠 Check Palindrome in Shell Scripting

---

## 📘 What is a Palindrome?

A **palindrome** is a word, phrase, or number that reads the same backward as forward.

Example:

```
Word: level → palindrome
Word: hello → not palindrome
Number: 121 → palindrome
Number: 123 → not palindrome
```

---

## 🧩 Example 1: Palindrome Check for a String

```bash
#!/bin/bash

read -p "Enter a string: " str
rev_str=$(echo "$str" | rev)

if [ "$str" == "$rev_str" ]; then
  echo "$str is a palindrome"
else
  echo "$str is not a palindrome"
fi
```

### ✅ Output Example:

```
Enter a string: level
level is a palindrome
```

```
Enter a string: hello
hello is not a palindrome
```

---

## 🧮 Example 2: Palindrome Check for a Number

```bash
#!/bin/bash

read -p "Enter a number: " num
rev_num=$(echo "$num" | rev)

if [ "$num" -eq "$rev_num" ]; then
  echo "$num is a palindrome number"
else
  echo "$num is not a palindrome number"
fi
```

### ✅ Output Example:

```
Enter a number: 121
121 is a palindrome number
```

```
Enter a number: 123
123 is not a palindrome number
```

---

## 💡 Real-world Usage

In real-world shell scripts, checking palindromes isn’t common, but the logic of **string comparison** and **command substitution (`$(...)`)** is often used for validation or text processing.

---

## ⚙️ Best Practice

Use the **`rev` command** for reversing strings/numbers — it's **simple, reliable, and efficient**.

The manual loop method (using `for ((i=...))`) is fine for practice but not needed in production.

---
---

# 🧩 Shell Scripting – Variable Substitution

---

## 🔹 What is Variable Substitution?

Variable substitution allows you to **modify the value of variables dynamically** without using external commands.

It’s a powerful feature used in **string manipulation, setting defaults, and trimming prefixes/suffixes**.

---

## 🔸 Basic Substitution

```bash
name="Jagga"
echo "Hello $name"
# or

echo "Hello ${name}"
```

✅ `${var}` form is safer when you’re appending something next to the variable.

```bash
echo "Hello ${name}123"   # Correct
echo "Hello $name123"    # Incorrect (shell looks for variable name123)
```

---

## 🔸 Default Value Substitution

```bash
# Syntax: ${var:-default}
name=""
echo ${name:-"Guest"}   # Output: Guest
```

👉 If `name` is **unset or empty**, it substitutes with the default value.

Another variant:

```bash
# ${var:=default}
# Assigns default value if variable is unset or empty
username=${user:="admin"}
echo $username   # Output: admin
```

---

## 🔸 Prefix Removal

```bash
filename="backup_2025.tar.gz"
echo ${filename#backup_}   # Removes shortest match of prefix → 2025.tar.gz
echo ${filename##backup_}  # Removes longest match of prefix → 2025.tar.gz (same result here)
```

👉 Use `#` (single) for **shortest** match, `##` for **longest** match from the beginning.

---

## 🔸 Suffix Removal

```bash
filename="backup_2025.tar.gz"
echo ${filename%.gz}   # Removes shortest suffix match → backup_2025.tar
echo ${filename%%.tar.gz}  # Removes longest suffix match → backup_2025.tar.gz (example case)
```

👉 Use `%` (single) for **shortest** match, `%%` for **longest** match from the end.

---

## 🔸 Examples – With and Without `*`

```bash
str="abcdef"
echo ${str#a*c}   # Removes 'a' to first 'c' → def
echo ${str#abc}   # Removes exact prefix 'abc' → def
```

* `*` acts as a **wildcard** for pattern matching.
* Without `*`, shell looks for the **exact string match**.

---

## 🧠 Quick Summary

| Syntax            | Description                   | Example          | Output          |
| ----------------- | ----------------------------- | ---------------- | --------------- |
| `${var}`          | Substitute variable           | `${name}`        | Jagga           |
| `${var:-default}` | Use default if unset/empty    | `${user:-guest}` | guest           |
| `${var:=default}` | Assign default if unset/empty | `${user:=guest}` | guest           |
| `${var#pattern}`  | Remove shortest prefix        | `${file#*/}`     | after first `/` |
| `${var##pattern}` | Remove longest prefix         | `${file##*/}`    | filename only   |
| `${var%pattern}`  | Remove shortest suffix        | `${file%.txt}`   | removes `.txt`  |
| `${var%%pattern}` | Remove longest suffix         | `${path%%/*}`    | first directory |

---

## 🧾 Output Example

```bash
filename="project_backup_2025.tar.gz"
echo ${filename#project_}  # Output: backup_2025.tar.gz
echo ${filename%.gz}       # Output: project_backup_2025.tar
echo ${filename##*_}       # Output: 2025.tar.gz
echo ${filename%%_*}       # Output: project
```
---
---

## 🧩 Concept: Simple `sed` Usage (Substitution)

---

### **Concept / What**

`sed` (Stream Editor) is a command-line tool used to **find and replace text**, **delete lines**, or **modify content** in files or text streams **without opening them manually**. The most common usage is **substitution** — replacing one string with another.

---

### **Why / Purpose / Use Case**

Used for:

* Replacing values in config or script files during deployments.
* Bulk text edits in logs or outputs.
* Automating file updates in CI/CD or shell scripts.

**Examples:**

* Updating environment variables (dev → prod).
* Replacing URLs or IPs in config templates.
* Cleaning or formatting logs.

---

### **How it Works / Steps / Syntax**

**Basic substitution:**

```bash
sed 's/old_text/new_text/' filename
```

* `s` → substitute command
* `old_text` → search pattern
* `new_text` → replacement text
* Replaces **first match per line** by default

#### 🧠 Common Flags

| Flag | Meaning                                  | Example                                       |
| ---- | ---------------------------------------- | --------------------------------------------- |
| `g`  | Replace **all** occurrences in each line | `sed 's/dev/prod/g' file.txt`                 |
| `i`  | Case-insensitive replace                 | `sed 's/DEV/dev/i' file.txt`                  |
| `-i` | Edit file **in-place**                   | `sed -i 's/localhost/127.0.0.1/g' config.txt` |
| `p`  | Print changed lines                      | `sed -n 's/error/fixed/p' logs.txt`           |

---

### **Understanding `-i` Behavior**

| Command                             | Effect                                                                |
| ----------------------------------- | --------------------------------------------------------------------- |
| `sed 's/dev/prod/' file.txt`        | Shows updated text **only on screen (stdout)** — file stays unchanged |
| `sed -i 's/dev/prod/' file.txt`     | Changes text **inside the file (in-place)**                           |
| `sed -i.bak 's/dev/prod/' file.txt` | Edits file **and creates backup** as `file.txt.bak`                   |

**Example:**

```bash
echo "Environment: dev" > env.txt
sed 's/dev/prod/' env.txt       # only prints to stdout
sed -i 's/dev/prod/' env.txt    # saves inside the file
sed -i.bak 's/prod/stage/' env.txt  # changes + creates backup
```

---

### **Examples**

**1️⃣ Replace text in file**

```bash
#!/bin/bash

echo "Environment: dev" > env.txt

echo "Before change:"
cat env.txt

sed -i 's/dev/prod/' env.txt

echo -e "\nAfter change:"
cat env.txt
```

**Output:**

```
Before change:
Environment: dev

After change:
Environment: prod
```

**2️⃣ Replace all occurrences**

```bash
#!/bin/bash

echo -e "app=dev\nurl=dev.example.com\ndeployment=dev" > config.txt
sed -i 's/dev/prod/g' config.txt
cat config.txt
```

**Output:**

```
app=prod
url=prod.example.com
deployment=prod
```

**3️⃣ Case-insensitive substitution**

```bash
#!/bin/bash

echo -e "Server=DEV\nServer=Dev\nServer=dev" > servers.txt
sed -i 's/dev/prod/gi' servers.txt
cat servers.txt
```

**Output:**

```
Server=prod
Server=prod
Server=prod
```

---

### **Common Issues / Errors**

| Problem                    | Cause              | Fix                                  |
| -------------------------- | ------------------ | ------------------------------------ |
| `sed: command not found`   | Missing package    | Install with `sudo apt install sed`  |
| `unterminated 's' command` | Missing `'` or `/` | Ensure proper syntax `'s/old/new/'`  |
| Replacement not working    | Pattern mismatch   | Use `i` for case-insensitive matches |

---

### **Troubleshooting / Fixes**

* Always test **without `-i`** first to preview.
* For patterns with `/` (e.g., URLs), use alternate delimiter like `#`:

  ```bash
  sed -i 's#http://dev#https://prod#g' urls.txt
  ```
* Use backups before modifying important files:

  ```bash
  sed -i.bak 's/dev/prod/g' config.txt
  ```

---

### **Best Practices / Tips**

✅ Quote entire `sed` expression `'s/old/new/'`
✅ Use `-i.bak` for safe file edits
✅ Use alternate delimiters for URLs (`#`, `|`, etc.)
✅ Avoid using `-i` on system files unless sure
✅ Always preview output before applying changes

---

### **Example Script (Runnable)**

```bash
#!/bin/bash
# simple_sed_demo.sh

file="demo.txt"
echo -e "This is dev environment.\nDev team will deploy soon." > "$file"

echo "Before:"
cat "$file"

# Replace dev → prod globally (case-insensitive)
sed -i 's/dev/prod/gi' "$file"

echo -e "\nAfter:"
cat "$file"
```

**Output:**

```
Before:
This is dev environment.
Dev team will deploy soon.

After:
This is prod environment.
prod team will deploy soon.
```

---
---

# 🧠 Simple `awk` Usage (Field Extraction)

---

### **Concept / What**

`awk` is a powerful command-line utility used for text processing — it reads input line by line, splits each line into fields (based on a delimiter like space or comma), and lets you perform actions on those fields.

---

### **Why / Purpose / Use Case**

* Extract specific columns from logs, CSVs, or configuration files
* Filter data dynamically during automation
* Process reports without modifying the original file
* Often used in DevOps to parse logs, Kubernetes outputs, and system command results

Example use cases:

* Extract usernames from `/etc/passwd`
* Fetch 2nd column (status) from a space-separated log file
* Filter pods and their namespaces from `kubectl get pods -A` output

---

### **How it Works / Steps / Syntax**

**Basic syntax:**

```bash
awk 'pattern {action}' filename
```

**Key points:**

* `$0` → refers to the entire line
* `$1`, `$2`, `$3`, etc. → refer to individual fields (columns)
* `NF` → built-in variable that gives total number of fields
* `FS` → field separator (default is space or tab)

**Examples:**

```bash
# Print entire file
awk '{print $0}' file.txt

# Print first field (column)
awk '{print $1}' file.txt

# Print first and third field
awk '{print $1, $3}' file.txt

# Use a comma as a delimiter
awk -F',' '{print $2}' data.csv

# Print last field of each line
awk '{print $NF}' file.txt
```

---

### **Common Issues / Errors**

| Issue                    | Description                                                                       |
| ------------------------ | --------------------------------------------------------------------------------- |
| `awk: command not found` | AWK not installed on some minimal systems (install using `sudo apt install gawk`) |
| Wrong delimiter          | Data might use `,` or `:` but script uses default space                           |
| Empty output             | Happens if field numbers don’t exist in the line                                  |

---

### **Troubleshooting / Fixes**

* Use `-F` flag to specify correct field separator
  → Example: `awk -F':' '{print $1}' /etc/passwd`
* Always quote your awk command properly to avoid shell interpretation issues
* Test the command manually before embedding inside scripts

---

### **Best Practices / Tips**

* Always use `-F` for clarity even if default separator works
* Use `{print}` instead of `{ print }` (spaces matter in some shells)
* Combine with other tools like `grep` or `sort` for complex filters
* Use `awk '{print $1}'` instead of hardcoding when column positions can change

---

### **Example Script**

```bash
#!/bin/bash
# Script Name: extract_fields.sh
# Purpose: Demonstrate simple awk field extraction

echo "Username and Shells from /etc/passwd:"
echo "--------------------------------------"
awk -F':' '{print "User:", $1, "Shell:", $7}' /etc/passwd

echo
echo "Extracting 2nd and 4th column from sample.csv (comma-separated):"
awk -F',' '{print $2, $4}' sample.csv
```

**Sample Output:**

```
Username and Shells from /etc/passwd:
--------------------------------------
User: root Shell: /bin/bash
User: daemon Shell: /usr/sbin/nologin
...

Extracting 2nd and 4th column from sample.csv (comma-separated):
John 28
Peter 35
...
```
---
---

# 🧩 Indexed Arrays – Creation, Accessing, and Iterating

---

### **Concept / What**

An **Indexed Array** in shell scripting is a variable that stores **multiple values** under a single name, where each value is identified by a **numerical index** (starting from 0).

It’s called *indexed* because each element’s position is represented by a number (index).

---

### **Why / Purpose / Use Case**

* Store multiple related values in one variable (like a list).
* Iterate over several items easily using loops.
* Avoid creating multiple variables (`server1`, `server2`, etc.).
* Commonly used for:

  * Lists of filenames, user names, IP addresses, ports, etc.
  * Batch operations (like restarting multiple services).
  * Automating repetitive tasks on grouped resources.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Creating an Array**

```bash
# Method 1: Direct assignment
fruits=("apple" "banana" "mango")

# Method 2: Using declare
declare -a cities=("Delhi" "Mumbai" "Chennai")

# Method 3: Assigning elements individually
numbers[0]=10
numbers[1]=20
numbers[2]=30
```

---

#### **2️⃣ Accessing Array Elements**

Use `${array[index]}` to access a specific value.

```bash
echo ${fruits[0]}     # apple
echo ${fruits[2]}     # mango
```

> If no index is given, Bash uses 0 by default.

---

#### **3️⃣ Accessing All Elements**

Use `${array[@]}` or `${array[*]}`

```bash
echo ${fruits[@]}     # apple banana mango
echo ${fruits[*]}     # apple banana mango
```

> Both print all elements, but behave differently when quoted.

---

### 🧠 **Understanding `${array[@]}` vs `${array[*]}`**

#### **Case 1: Without Quotes**

When not quoted, both behave the same:

```bash
echo ${fruits[@]}    # apple banana mango
echo ${fruits[*]}    # apple banana mango
```

✅ Output:

```
apple banana mango
```

#### **Case 2: Inside Loops (with Quotes)**

```bash
fruits=("apple" "banana split" "mango")

echo "Using @"
for i in "${fruits[@]}"; do
  echo "$i"
done

echo "Using *"
for i in "${fruits[*]}"; do
  echo "$i"
done
```

🧾 **Output:**

```
Using @
apple
banana split
mango

Using *
apple banana split mango
```

#### ⚙️ **Explanation:**

| Syntax          | How It Expands                                | When to Use                                            |
| --------------- | --------------------------------------------- | ------------------------------------------------------ |
| `"${array[@]}"` | Treats each element as a **separate word**    | ✅ Best for looping through elements                    |
| `"${array[*]}"` | Joins all elements into **one single string** | ⚠️ Rarely used, only when you want one combined string |

💡 **Best Practice:** Always use `"${array[@]}"` in loops.

---

#### **4️⃣ Getting Array Length**

```bash
echo ${#fruits[@]}    # 3 (number of elements)
```

---

#### **5️⃣ Iterating Through Array**

**Method 1: Using `for` loop**

```bash
for item in "${fruits[@]}"
do
  echo "$item"
done
```

**Output:**

```
apple
banana
mango
```

**Method 2: Using numeric index**

```bash
for i in "${!fruits[@]}"
do
  echo "Index $i → ${fruits[$i]}"
done
```

**Output:**

```
Index 0 → apple
Index 1 → banana
Index 2 → mango
```

---

### **Common Issues / Errors**

| Issue              | Cause                                                      |
| ------------------ | ---------------------------------------------------------- |
| `bad substitution` | Using unsupported syntax in older shells                   |
| Empty output       | Variable not initialized                                   |
| Index out of range | Trying to access an element that doesn’t exist             |
| Quoting issue      | Forgetting to use quotes while expanding (`"${array[@]}"`) |

---

### **Troubleshooting / Fixes**

* Verify array creation: `declare -p arrayname`
* Use `"${array[@]}"` in loops to prevent word-splitting issues.
* To debug, print all elements with `echo ${array[@]}` before looping.

---

### **Best Practices / Tips**

✅ Always quote `"${array[@]}"` when looping.
✅ Use meaningful array names (`servers`, `ports`, `fruits`).
✅ Use `"${!array[@]}"` to get indexes dynamically.
✅ Arrays are **zero-indexed** — first element starts from index 0.

---

### **Example Script**

```bash
#!/bin/bash
# indexed_array_demo.sh

# Step 1: Define array
servers=("app-server" "db-server" "cache-server")

# Step 2: Print all elements
echo "All servers: ${servers[@]}"

# Step 3: Print total number of servers
echo "Total servers: ${#servers[@]}"

# Step 4: Iterate one by one
echo "Iterating through array:"
for server in "${servers[@]}"; do
  echo "$server"
done

# Step 5: Print with index
echo "Server details with index:"
for i in "${!servers[@]}"; do
  echo "Index $i: ${servers[$i]}"
done
```

**Sample Output:**

```
All servers: app-server db-server cache-server
Total servers: 3
Iterating through array:
app-server
db-server
cache-server
Server details with index:
Index 0: app-server
Index 1: db-server
Index 2: cache-server
```

---
---

# 🧩 Adding and Removing Elements in Arrays

---

### **Concept / What**

Arrays in Bash are **dynamic**, meaning elements can be **added or removed** anytime during script execution. Each element is identified by a **numerical index**, starting at 0. Removing an element by its index does **not automatically reindex** the rest of the array.

---

### **Why / Purpose / Use Case**

Used when:

* You need to **add or remove** elements dynamically during script execution.
* You want to manage **lists of resources**, such as servers, files, or IPs.
* Common DevOps use cases include:

  * Adding or removing servers from a deployment list.
  * Managing failed task entries dynamically.
  * Handling dynamic sets of configuration values.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Adding Elements to an Array**

**Method 1: Append a new element**

```bash
fruits=("apple" "banana" "mango")
fruits+=("grape")
echo "${fruits[@]}"
```

✅ Output:

```
apple banana mango grape
```

**Method 2: Add at a specific index**

```bash
fruits[4]="orange"
echo "${fruits[@]}"
```

✅ Output:

```
apple banana mango grape orange
```

**Method 3: Add multiple elements at once**

```bash
fruits+=("pear" "kiwi")
echo "${fruits[@]}"
```

✅ Output:

```
apple banana mango grape orange pear kiwi
```

---

#### **2️⃣ Removing Elements from an Array**

**Remove a specific element by index**

```bash
unset 'fruits[2]'  # removes the element at index 2
echo "${fruits[@]}"
```

✅ Output:

```
apple banana grape orange pear kiwi
```

🧠 **What Actually Happens:**

If you have:

```bash
fruits=("apple" "banana" "grape" "mango")
unset 'fruits[2]'
```

Then:

```bash
declare -p fruits
```

Output:

```
declare -a fruits='([0]="apple" [1]="banana" [3]="mango")'
```

➡️ Notice: index `2` (grape) is removed, but indexes **are not re-shifted**.

Index `3` still holds `mango`.
If you print them:

```bash
for i in "${!fruits[@]}"; do
  echo "Index $i → ${fruits[$i]}"
done
```

Output:

```
Index 0 → apple
Index 1 → banana
Index 3 → mango
```

---

#### **3️⃣ Reindexing Arrays**

To **compact** the array (reset indexes 0,1,2,…):

```bash
fruits=("${fruits[@]}")
```

✅ Output:

```
declare -a fruits='([0]="apple" [1]="banana" [2]="mango")'
```

Now indexes are sequential again.

---

#### **4️⃣ Removing All Elements**

**Method 1:**

```bash
unset fruits
```

Removes the array completely.

**Method 2:**

```bash
fruits=()
```

Clears all elements but keeps the variable defined.

---

### **Common Issues / Errors**

| Issue                        | Cause                          | Fix                                          |
| ---------------------------- | ------------------------------ | -------------------------------------------- |
| Missing values after removal | Removing element leaves gaps   | Reindex with `fruits=("${fruits[@]}")`       |
| `bad substitution`           | Wrong syntax or missing quotes | Use proper quoting: `"${array[@]}"`          |
| Append not working           | Incorrect syntax               | Use `array+=("value")`, not `array+="value"` |

---

### **Troubleshooting / Fixes**

* Check indexes: `echo "${!array[@]}"`
* Debug array: `declare -p arrayname`
* Always reindex after multiple deletions.
* Avoid mixing scalars and arrays of the same name.

---

### **Best Practices / Tips**

✅ Use `+=` for appending new elements.
✅ Always quote `"${array[@]}"` when expanding.
✅ Use `unset 'array[index]'` for specific deletions.
✅ Reindex arrays after deletions for consistent loops.
✅ Use meaningful array names (`servers`, `ports`, `users`).

---

### **Example Script**

```bash
#!/bin/bash
# array_add_remove_demo.sh

# Step 1: Initialize array
servers=("app1" "app2" "db1")

echo "Initial servers: ${servers[@]}"

# Step 2: Add new servers
servers+=("cache1" "proxy1")
echo "After adding: ${servers[@]}"

# Step 3: Remove one server
unset 'servers[1]'
echo "After removing index 1: ${servers[@]}"

# Step 4: Reindex array
servers=("${servers[@]}")
echo "After reindexing: ${servers[@]}"

# Step 5: Clear all elements
servers=()
echo "After clearing: ${servers[@]}"
```

**Sample Output:**

```
Initial servers: app1 app2 db1
After adding: app1 app2 db1 cache1 proxy1
After removing index 1: app1 db1 cache1 proxy1
After reindexing: app1 db1 cache1 proxy1
After clearing:
```

---
---

# 🧩 Simple Associative Arrays

---

### **Concept / What**

An **Associative Array** in shell scripting is a special type of array where **keys are strings instead of numbers**.
Unlike indexed arrays (which use numeric indexes like 0,1,2…), associative arrays use **key-value pairs**, such as:

```bash
server["app"]="10.0.0.1"
```

---

### **Why / Purpose / Use Case**

* To store **key-value pairs** instead of positional elements.
* To make scripts **easier to read and manage**, using meaningful names as keys.
* Common DevOps use cases include:

  * Mapping hostnames to IP addresses.
  * Mapping usernames to roles or IDs.
  * Storing configuration data (e.g., environment → URL).

**Example:**

```bash
server["app"]="10.0.0.1"
server["db"]="10.0.0.2"
```

This helps manage server mappings clearly.

---

### **How it Works / Steps / Syntax**

#### **1️⃣ Creating an Associative Array**

Associative arrays must be **declared explicitly** using `declare -A`:

```bash
declare -A servers
servers["app"]="10.0.0.1"
servers["db"]="10.0.0.2"
servers["cache"]="10.0.0.3"
```

> ⚠️ Without `declare -A`, Bash treats it as an indexed array and ignores string keys.

---

#### **2️⃣ Access Elements**

Access values by key:

```bash
echo "App Server IP: ${servers["app"]}"
```

✅ Output:

```
App Server IP: 10.0.0.1
```

---

#### **3️⃣ Print All Keys or Values**

```bash
echo "All keys: ${!servers[@]}"
echo "All values: ${servers[@]}"
```

✅ Output:

```
All keys: app db cache
All values: 10.0.0.1 10.0.0.2 10.0.0.3
```

---

#### **4️⃣ Iterate Through Key-Value Pairs**

```bash
for key in "${!servers[@]}"; do
  echo "$key → ${servers[$key]}"
done
```

✅ Output:

```
app → 10.0.0.1
db → 10.0.0.2
cache → 10.0.0.3
```

---

#### **5️⃣ Remove Keys or Entire Array**

Remove a specific key:

```bash
unset 'servers["db"]'
```

Remove the whole array:

```bash
unset servers
```

---

### 🧠 **Why `declare -A` is Required**

Regular (indexed) arrays don’t need `declare`, but associative arrays **must** use it.
Without it, Bash treats keys as numeric indexes and doesn’t actually map string keys.

**Example:**

```bash
# ❌ Without declare
servers["app"]="10.0.0.1"
declare -p servers
```

**Output:**

```
declare -a servers='([0]="10.0.0.1")'   # Treated as indexed array
```

✅ **Correct way:**

```bash
declare -A servers
servers["app"]="10.0.0.1"
servers["db"]="10.0.0.2"
declare -p servers
```

**Output:**

```
declare -A servers='([app]="10.0.0.1" [db]="10.0.0.2")'
```

| Array Type        | Needs `declare`?     | Index Type         | Example                     |
| ----------------- | -------------------- | ------------------ | --------------------------- |
| Indexed Array     | ❌ No                 | Numeric            | `fruits=("apple" "banana")` |
| Associative Array | ✅ Yes (`declare -A`) | String (key-value) | `servers["db"]="10.0.0.2"`  |

---

### **Common Issues / Errors**

| Issue           | Cause                            | Fix                                |
| --------------- | -------------------------------- | ---------------------------------- |
| `bad subscript` | Missing quotes around key        | Use `${servers["key"]}`            |
| Empty output    | Array not declared associative   | Use `declare -A` before assignment |
| Wrong order     | Associative arrays are unordered | Don’t rely on sequence             |

---

### **Troubleshooting / Fixes**

* Check the array type: `declare -p arrayname`
* Always quote keys to prevent interpretation errors.
* Ensure Bash version ≥ 4.0 (`bash --version`) since associative arrays are not supported in older versions.

---

### **Best Practices / Tips**

✅ Always use `declare -A` for associative arrays.
✅ Quote keys when expanding: `${servers["key"]}`.
✅ Use `${!array[@]}` to get all keys.
✅ Associative arrays are **unordered** — don’t expect key order consistency.
✅ Great for storing structured data like `key → value` mappings.

---

### **Example Script**

```bash
#!/bin/bash
# associative_array_demo.sh

declare -A servers
servers["app"]="10.0.0.1"
servers["db"]="10.0.0.2"
servers["cache"]="10.0.0.3"

echo "Server List:"
for key in "${!servers[@]}"; do
  echo "$key → ${servers[$key]}"
done

echo "App Server IP: ${servers["app"]}"

unset 'servers["db"]'
echo "After removing DB: ${!servers[@]} → ${servers[@]}"
```

**Output:**

```
Server List:
app → 10.0.0.1
db → 10.0.0.2
cache → 10.0.0.3
App Server IP: 10.0.0.1
After removing DB: app cache → 10.0.0.1 10.0.0.3
```

---
---
---

