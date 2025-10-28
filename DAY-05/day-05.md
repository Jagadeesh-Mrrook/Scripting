# 🧠 Day 5 — Introduction: Case Statements & Basic Arithmetic

### **Concept / What**

Shell scripting provides:

* **Case statements** for handling multiple conditional branches (like switch-case in other languages).
* **Arithmetic operations** for performing basic mathematical calculations (addition, subtraction, multiplication, division, etc.).

Together, they make scripts more dynamic and decision-oriented.

---

### **Why / Purpose / Use Case**

* **Case statements:**
  Used when multiple conditions must be checked against a single variable or input (e.g., menu selections, service controls).
  → Easier to read and maintain than multiple `if-elif` blocks.

* **Arithmetic operations:**
  Used in scripts for performing number calculations like counters, loops, percentages, and validations.
  → Essential in automation tasks involving resource calculations, log analysis, or monitoring.

---

### **How it Works / Steps / Syntax**

**Case Statement Syntax:**

```bash
case <variable> in
  pattern1)
    commands
    ;;
  pattern2)
    commands
    ;;
  *)
    default_commands
    ;;
esac
```

* `case` and `esac` mark the start and end.
* Each `pattern)` represents a condition.
* `;;` ends each block.
* `*` is the default catch-all pattern.

**Arithmetic Syntax Options:**

1. Using **$(( ))**

   ```bash
   sum=$((a + b))
   ```
2. Using **expr** command

   ```bash
   sum=$(expr $a + $b)
   ```

---

### **Common Issues / Errors**

| Issue                 | Cause                                                  |
| --------------------- | ------------------------------------------------------ |
| `expr: syntax error`  | Missing spaces between operands and operator.          |
| `bad substitution`    | Used `$()` incorrectly or forgot `$` before variables. |
| `unexpected operator` | Used arithmetic with strings or unset variables.       |

---

### **Troubleshooting / Fixes**

* Always leave spaces around operators when using `expr`.
* Quote variables if they may be empty to avoid substitution errors.
* Verify numeric input using regex (`[[ $var =~ ^[0-9]+$ ]]`) before arithmetic.
* Use `set -x` to debug calculation or branching logic.

---

### **Best Practices / Tips**

* Prefer `$(( ))` over `expr` — faster and cleaner.
* Always include a `*)` default case.
* Keep each `case` branch short and readable.
* Use comments for clarity in menu-driven or logic-heavy scripts.

---

### **Example Script**

```bash
#!/bin/bash
# Script: intro_case_arithmetic.sh
# Purpose: Demonstrate case statement and arithmetic basics

echo "Enter an operation: add / sub / mul / div"
read choice

echo "Enter two numbers:"
read a b

case $choice in
  add)
    result=$((a + b))
    echo "Sum: $result"
    ;;
  sub)
    result=$((a - b))
    echo "Difference: $result"
    ;;
  mul)
    result=$((a * b))
    echo "Product: $result"
    ;;
  div)
    if [ $b -ne 0 ]; then
      result=$((a / b))
      echo "Quotient: $result"
    else
      echo "Error: Division by zero not allowed."
    fi
    ;;
  *)
    echo "Invalid choice. Please use add/sub/mul/div."
    ;;
esac
```

---
---

### 🧠 Case Statement in Shell Scripting

#### 📌 Introduction

* `case` is used for **multi-choice branching** in shell scripts.
* It’s a cleaner and more readable alternative to multiple `if-elif` conditions.
* It matches a **variable’s value** against a set of patterns and executes the corresponding block.

#### 🧩 Syntax

```bash
case $variable in
  pattern1)
    # Commands
    ;;
  pattern2)
    # Commands
    ;;
  *)
    # Default case (if no match)
    ;;
esac
```

#### ⚙️ Example

```bash
#!/bin/bash
read -p "Enter an action (start/stop/restart): " action
case $action in
  start)
    echo "Starting the service..."
    ;;
  stop)
    echo "Stopping the service..."
    ;;
  restart)
    echo "Restarting the service..."
    ;;
  *)
    echo "Invalid action. Please enter start, stop, or restart."
    ;;
esac
```

#### 🔍 Comparison: `if-elif` vs `case`

| Feature              | if-elif                                   | case                                       |    |                                            |
| -------------------- | ----------------------------------------- | ------------------------------------------ | -- | ------------------------------------------ |
| **Use case**         | Multiple condition checks (complex logic) | Simple value-based matching                |    |                                            |
| **Syntax**           | Long and repetitive                       | Compact and readable                       |    |                                            |
| **Pattern matching** | Limited (uses `[[` or `==` operators)     | Supports wildcards and regex-like patterns |    |                                            |
| **Best for**         | Range checks, compound logic (`&&`, `     |                                            | `) | Menu-driven scripts, static string choices |

#### 💡 Key Points

* `case` is preferred when matching **fixed string options** (like menu choices).
* `if-elif` is better for **logical comparisons or numerical checks**.
* Always end each case block with `;;`.
* Default case (`*`) handles unmatched values safely.

---
---

# ⚙️ Day 5 — Performing Arithmetic Using `$(( ))` and `expr`

### **Concept / What**

Shell scripting allows you to perform **arithmetic operations** directly in scripts using two main methods:

1. **Arithmetic Expansion:** `$(( expression ))` — modern and preferred.
2. **Command:** `expr expression` — older and external command.

These operations handle **integer calculations** (addition, subtraction, multiplication, division, and modulo).

---

### **Why / Purpose / Use Case**

* Required for performing calculations dynamically in scripts.
* Used in loops, condition checks, counters, file processing, or automation scripts (e.g., disk usage, iterations, time calculations).
* Provides logic-building capability beyond static commands.

---

### **How it Works / Syntax**

#### 🧩 Using `$(( ))` (Recommended)

```bash
result=$((num1 + num2))
```

Supported Operators:
`+` (add), `-` (subtract), `*` (multiply), `/` (divide), `%` (modulo)

Example:

```bash
num1=10
num2=3

echo "Sum: $((num1 + num2))"
echo "Difference: $((num1 - num2))"
echo "Product: $((num1 * num2))"
echo "Quotient: $((num1 / num2))"
echo "Remainder: $((num1 % num2))"
```

---

#### 🧩 Using `expr` (Older Method)

```bash
result=$(expr $num1 + $num2)
```

⚠️ **Note:** `*` must be escaped (`\*`) because it’s a shell wildcard.

Example:

```bash
num1=10
num2=3
echo "Sum: $(expr $num1 + $num2)"
echo "Product: $(expr $num1 \* $num2)"
```

---

### **Comparison — `$(( ))` vs `expr`**

| Feature                   | `$(( ))`          | `expr`                        |
| ------------------------- | ----------------- | ----------------------------- |
| Built-in or external      | Built-in (faster) | External command              |
| Syntax                    | Cleaner           | Requires escaping `*`         |
| Supports variables easily | ✅ Yes             | ✅ Yes                         |
| Output capture            | Direct            | Needs command substitution    |
| Modern usage              | ✅ Preferred       | ⚠️ Legacy (for compatibility) |

✅ **Use `$(( ))` in all modern scripts** — `expr` is mainly for backward compatibility.

---

### **Common Issues / Errors**

| Issue                       | Cause                                   | Fix                                          |
| --------------------------- | --------------------------------------- | -------------------------------------------- |
| `expr: syntax error`        | Missing spaces between operands         | `expr 5 + 3` (not `expr 5+3`)                |
| Wrong result / blank output | Variable not expanded or quotes missing | Use `$(( ))` or double quotes                |
| Division by zero            | Invalid math                            | Add check: `if [ $num2 -ne 0 ]; then ... fi` |
| Decimal truncation          | Bash arithmetic only supports integers  | Use `bc` for decimal values                  |

---

### **Troubleshooting / Fixes**

* Always add spaces between operands when using `expr`.
* Check that variables hold numeric values before using them.
* For decimal results, pipe through `bc`:

  ```bash
  echo "scale=2; $num1 / $num2" | bc
  ```

---

### **Best Practices / Tips**

* Always prefer `$(( ))` for arithmetic — it’s built-in, fast, and clean.
* Use `bc` for floating-point math.
* When dividing, always check divisor to avoid runtime errors.
* For debugging, print values before calculation.

---

### **Example Script 1 — Basic Arithmetic**

```bash
#!/bin/bash
# Script: basic_arithmetic.sh

num1=15
num2=4

echo "Sum: $((num1 + num2))"
echo "Difference: $((num1 - num2))"
echo "Product: $((num1 * num2))"
echo "Quotient: $((num1 / num2))"
echo "Remainder: $((num1 % num2))"
```

---

### **Example Script 2 — Using expr**

```bash
#!/bin/bash
# Script: expr_arithmetic.sh

num1=12
num2=3

echo "Sum: $(expr $num1 + $num2)"
echo "Product: $(expr $num1 \* $num2)"
```

---

### **Example Script 3 — Handling Division and Decimal**

```bash
#!/bin/bash
# Script: division_check.sh

read -p "Enter two numbers: " a b

if [ $b -ne 0 ]; then
  echo "Integer Division: $((a / b))"
  echo "Decimal Division: $(echo "scale=2; $a / $b" | bc)"
else
  echo "Error: Division by zero not allowed."
fi
```

---

✅ **Quick Recap:**

* `$(( ))` — modern, preferred, integer only.
* `expr` — legacy, slower, more error-prone.
* `bc` — for decimals.
* Always validate inputs before performing arithmetic.

---
---

# ⚙️ Performing Arithmetic in Shell Scripts

### **Concept / What**

Arithmetic operations in shell scripting allow you to perform mathematical calculations directly within your scripts — such as addition, subtraction, multiplication, division, and modulo. These operations can be done using **`$(( ))`** (modern and preferred) or **`expr`** (older method).

---

### **Why / Purpose / Use Case**

* To perform mathematical calculations like counters, resource tracking, or time computations.
* Useful in loops, conditions, and automation scripts (e.g., checking disk space, user counts, etc.).
* `$(( ))` provides a cleaner, faster, and easier-to-read syntax than `expr`.

---

### **How It Works / Syntax**

#### 1️⃣ Using `$(( ))` (Preferred Modern Method)

```bash
num1=10
num2=5

sum=$(( num1 + num2 ))
diff=$(( num1 - num2 ))
product=$(( num1 * num2 ))
div=$(( num1 / num2 ))
mod=$(( num1 % num2 ))

echo "Sum: $sum"
echo "Difference: $diff"
echo "Product: $product"
echo "Division: $div"
echo "Modulo: $mod"
```

#### 2️⃣ Using `expr` (Older Method)

```bash
num1=10
num2=5

sum=$(expr $num1 + $num2)
echo "Sum: $sum"
```

⚠️ Note: In `expr`, each operator and operand **must be separated by spaces**.

---

### **Common Issues / Errors**

| Issue                                       | Cause                                            |
| ------------------------------------------- | ------------------------------------------------ |
| `syntax error: invalid arithmetic operator` | Missing spaces or unsupported symbols.           |
| Division by zero                            | Attempting to divide by zero without validation. |
| Wrong results in `expr`                     | Forgot to add spaces around operators.           |

---

### **Troubleshooting / Fixes**

* Always validate divisor before dividing (e.g., check if `$num2 -ne 0`).
* Ensure variable expansion syntax is correct: `$(( num + 1 ))`, not `(( num + 1 ))` inside echo.
* For older systems, use `expr` only if `$(( ))` isn’t supported.

---

### **Best Practices / Tips**

* Always use `$(( ))` instead of `expr` for clarity and performance.
* Avoid hardcoding values — use variables.
* When comparing numeric values, use operators like `-eq`, `-ne`, `-lt`, `-le`, `-gt`, and `-ge`.
* Use `bc` for floating-point arithmetic (since `$(( ))` supports only integers).

---

### **Example Script — Basic Arithmetic Operations**

```bash
#!/bin/bash
# Script: arithmetic_ops.sh
# Purpose: Demonstrate performing arithmetic using $(( ))

read -p "Enter first number: " num1
read -p "Enter second number: " num2

echo "\nResults:"
echo "Addition: $(( num1 + num2 ))"
echo "Subtraction: $(( num1 - num2 ))"
echo "Multiplication: $(( num1 * num2 ))"

if [ $num2 -ne 0 ]; then
  echo "Division: $(( num1 / num2 ))"
  echo "Modulo: $(( num1 % num2 ))"
else
  echo "Error: Division by zero is not allowed."
fi
```

---

### **Example Script — Prime Numbers (Using Arithmetic & Conditions)**

```bash
#!/bin/bash
# Script: print_primes_best.sh
# Purpose: Print all prime numbers from 2 to 30
# Logic: 0 = prime, 1 = not prime

for num in {2..30}
do
  is_prime=0  # Assume number is prime initially

  for (( i=2; i*i<=num; i++ ))
  do
    if [ $(( num % i )) -eq 0 ]; then
      is_prime=1  # Not a prime if divisible by i
      break
    fi
  done

  if [ $is_prime -eq 0 ]; then
    echo "$num"
  fi
done
```

---

### **Key Takeaways**

* `$(( ))` is preferred for all integer arithmetic.
* Use `-eq`, `-ne`, `-lt`, etc. for numeric comparisons in conditions.
* For performance and clarity, stop checking divisibility once `i*i > num` while finding primes.
* Always validate divisors to avoid runtime errors.

---
---

# 🔢 Number-Based Scripts in Shell Scripting

## **Concept / What**

Number-based scripts are shell programs that perform operations and calculations using numbers — like arithmetic, number sequences, prime checks, factorials, etc. They often use loops, conditionals, and arithmetic expansion.

---

## **Why / Purpose / Use Case**

* Automate numeric computations (e.g., sums, averages, factorials).
* Useful in monitoring, reporting, or generating numeric sequences.
* Helps understand how shell handles arithmetic and loops.
* Common interview/practice question category.

**Example Use Cases:**

* Checking prime numbers or factorials.
* Generating Fibonacci sequences.
* Finding even/odd numbers.
* Summing digits of a number.

---

## **How it Works / Steps / Syntax**

1. **Input and Variables** — Store numbers using `read` or fixed loops.
2. **Arithmetic Evaluation** — Use `$((expression))` or `expr` for operations.
3. **Loops** — Iterate using `for`, `while`, or `until` loops.
4. **Conditionals** — Apply `[ condition ]` or `(( condition ))` for logic.
5. **Output** — Print results using `echo`.

**Syntax Example:**

```bash
num=5
if [ $((num % 2)) -eq 0 ]; then
  echo "$num is even"
else
  echo "$num is odd"
fi
```

---

## **Common Issues / Errors**

| Issue                              | Cause                             |
| ---------------------------------- | --------------------------------- |
| Wrong arithmetic results           | Using `$[]` or quotes incorrectly |
| Syntax error near unexpected token | Missing spaces around `[` or `]`  |
| Integer expression expected        | Using non-numeric input           |

---

## **Troubleshooting / Fixes**

* Always use `$(( ))` for arithmetic instead of legacy `$[]`.
* Validate input using regex (`[[ $var =~ ^[0-9]+$ ]]`).
* Add spaces around `[ ]` conditions.

---

## **Best Practices / Tips**

* Always validate user input.
* Use functions for reusability.
* Prefer `(( ))` for numeric comparison instead of `-eq`, `-lt` when possible.
* Avoid unnecessary external tools (`expr`, `bc`) unless precision is required.

---

## **Example Script 1: Print Even and Odd Numbers**

```bash
#!/bin/bash
# Script: even_odd.sh
# Purpose: Print even and odd numbers between 1 and 10

for num in {1..10}
do
  if [ $((num % 2)) -eq 0 ]; then
    echo "$num is Even"
  else
    echo "$num is Odd"
  fi
done
```

---

## **Example Script 2: Sum of Natural Numbers**

```bash
#!/bin/bash
# Script: sum_natural.sh
# Purpose: Calculate sum of first N natural numbers

echo "Enter a number:"
read N
sum=0

for (( i=1; i<=N; i++ ))
do
  sum=$((sum + i))
done

echo "Sum of first $N natural numbers = $sum"
```

---

## **Example Script 3: Factorial of a Number**

```bash
#!/bin/bash
# Script: factorial.sh
# Purpose: Calculate factorial of a given number

echo "Enter a number:"
read num
fact=1

for (( i=1; i<=num; i++ ))
do
  fact=$((fact * i))
done

echo "Factorial of $num = $fact"
```

---

## **Example Script 4: Check Prime Numbers (Optimized)**

```bash
#!/bin/bash
# Script: print_primes_best.sh
# Purpose: Print all prime numbers from 2 to 30
# Logic: 0 = Prime (success), 1 = Not Prime

for num in {2..30}
do
  is_prime=0

  # C-style inner loop; stop when i*i > num
  for (( i=2; i*i<=num; i++ ))
  do
    if [ $(( num % i )) -eq 0 ]; then
      is_prime=1
      break
    fi
  done

  if [ $is_prime -eq 0 ]; then
    echo "$num"
  fi
done
```

**Explanation:**

* Outer loop runs from 2 to 30.
* For each number, assume it is prime (`is_prime=0`).
* Inner loop checks divisibility from 2 to √num (`i*i <= num`).
* If divisible, mark as not prime (`is_prime=1`) and break.
* If not divisible by any number, it’s printed as prime.

---

## **Example Script 5: Sum of Digits**

```bash
#!/bin/bash
# Script: sum_of_digits.sh
# Purpose: Sum the digits of a number

echo "Enter a number:"
read num
sum=0

while [ $num -gt 0 ]
do
  digit=$((num % 10))
  sum=$((sum + digit))
  num=$((num / 10))
done

echo "Sum of digits = $sum"
```

---

These number-based scripts build your confidence in using **loops, conditionals, and arithmetic** — which are foundational for complex automation logic.

---
---

# ⚙️ Even/Odd Checks and Simple Math Conditions

### **Concept / What**

Even/Odd checks and basic math conditions are used in shell scripting to perform logic-based decisions on numeric values. They help classify numbers (even, odd, divisible, within range, etc.) and execute specific commands accordingly.

---

### **Why / Purpose / Use Case**

* Used for validating numeric inputs (IDs, counters, thresholds).
* Commonly applied in automation tasks like:

  * Checking system metrics (CPU %, memory thresholds).
  * Managing file counts or rotation limits.
  * Handling logic where numeric decisions drive flow (e.g., retry counts, loop conditions).
* Forms the foundation for understanding and building complex numeric logic such as prime number detection or factorials.

---

### **How it Works / Steps / Syntax**

1. **Get number input**

   * Using a loop (predefined range)
   * Or dynamically using `read -p`

2. **Apply arithmetic expansion** using `$(( ))` to evaluate expressions.

3. **Use conditional checks** with numeric operators (`-eq`, `-ne`, `-lt`, `-le`, `-gt`, `-ge`).

---

### **Example 1: Loop-Based Even/Odd Check**

```bash
#!/bin/bash
# even_odd_loop.sh
# Checks even/odd numbers from 1 to 10

for num in {1..10}
do
  if [ $(( num % 2 )) -eq 0 ]; then
    echo "$num is even"
  else
    echo "$num is odd"
  fi
done
```

---

### **Example 2: Dynamic User Input (read -p)**

```bash
#!/bin/bash
# even_odd_input.sh
# Accept user input and check even/odd

read -p "Enter a number: " num

if [ $(( num % 2 )) -eq 0 ]; then
  echo "$num is even"
else
  echo "$num is odd"
fi
```

💡 **Explanation:**
Here, instead of looping through a range, we dynamically take input using `read -p` and check the parity of the given number.

---

### **Example 3: Divisibility Check**

```bash
#!/bin/bash
# divisible_check.sh
# Check if a number is divisible by 5

read -p "Enter a number: " num

if [ $(( num % 5 )) -eq 0 ]; then
  echo "$num is divisible by 5"
else
  echo "$num is not divisible by 5"
fi
```

---

### **Example 4: Range Comparison**

```bash
#!/bin/bash
# range_check.sh
# Check if a number lies between 10 and 20

read -p "Enter a number: " num

if [ $num -ge 10 ] && [ $num -le 20 ]; then
  echo "$num is within range 10–20"
else
  echo "$num is outside range"
fi
```

---

### **Example 5: Prime Number Check (with sqrt optimization)**

```bash
#!/bin/bash
# prime_check.sh
# Prints prime numbers between 2–30 using sqrt logic

for num in {2..30}
do
  is_prime=0
  for (( i=2; i*i<=num; i++ ))
  do
    if [ $(( num % i )) -eq 0 ]; then
      is_prime=1
      break
    fi
  done

  if [ $is_prime -eq 0 ]; then
    echo "$num is a prime number"
  fi
done
```

🧠 **Explanation:**
Instead of checking divisibility up to the number itself, the script checks only up to the **square root** of the number (`i*i <= num`).
If no divisor is found in that range, the number is prime — making this method **faster and more efficient**.

---

### **Common Issues / Errors**

| Issue                         | Cause                                                   |
| ----------------------------- | ------------------------------------------------------- |
| "integer expression expected" | Non-numeric input passed to arithmetic expansion.       |
| Wrong results                 | Used string operators (`=`) instead of numeric (`-eq`). |
| Unexpected behavior in loops  | Missing spaces in `[ ]` or improper variable expansion. |

---

### **Troubleshooting / Fixes**

* Always validate numeric input using regex or conditions before arithmetic.

  ```bash
  [[ $num =~ ^[0-9]+$ ]] || { echo "Invalid input"; exit 1; }
  ```
* Use `set -x` to trace variable values during execution.
* Use `echo` debugging to confirm intermediate outputs.

---

### **Best Practices / Tips**

* Prefer `$(( ))` or `(( ))` over `expr` for modern scripts.
* Use `read -p` for cleaner, interactive scripts.
* Keep numeric logic readable by aligning conditions and loops.
* Use comments to describe logic flow, especially in nested loops.
* Always handle edge cases (e.g., `0`, `1`, or negative numbers).

---
---


