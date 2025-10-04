# Day 3: Conditionals (if, else, elif)

## Concept: Conditionals (if, else, elif)

### 🧩 What

Conditionals in shell scripting are **decision-making structures** that control which commands are executed based on whether a condition is **true or false**.
They are essential for creating dynamic, logical, and automated scripts.

Common conditional statements in Bash:

* `if`
* `else`
* `elif` (else if)

---

### 🎯 Why / Purpose / Use Case

Conditionals allow scripts to **react intelligently** to different situations.
They are used to:

* Validate user inputs
* Check file or directory existence
* Compare numeric or string values
* Handle different cases in automation (e.g., backup, deployment, monitoring)
* Decide execution flow based on system state

**Example use cases:**

* Check if a service is running before restarting it
* Verify disk usage before running cleanup jobs
* Confirm a file exists before copying it

---

### ⚙️ How it Works / Steps / Syntax

Conditionals evaluate an **expression or command** result.

If the condition is **true**, the commands inside that block execute.
If **false**, it moves to `elif` or `else` (if present).

**General Syntax:**

```bash
if [ condition ]; then
    commands
elif [ another_condition ]; then
    commands
else
    commands
fi
```

**Flow:**

1. Evaluate the first condition.
2. If true → run commands under `if`.
3. If false → check `elif` (if provided).
4. If none match → execute `else` (optional).
5. Close with `fi`.

---

### 🧱 Common Issues / Errors

| Issue                                     | Cause                                    |
| ----------------------------------------- | ---------------------------------------- |
| `syntax error near unexpected token 'fi'` | Missing or extra `fi`.                   |
| `[: missing ]`                            | Missing space after `[` or before `]`.   |
| `unary operator expected`                 | Variable not quoted and found empty.     |
| Wrong comparison                          | Using `=` for integers instead of `-eq`. |

---

### 🧰 Troubleshooting / Fixes

* Use `bash -n script.sh` → syntax check without running the script.
* Use `set -x` → enables debug mode, shows command execution.
* Always **quote variables**: `[ "$var" = "value" ]`.
* Verify condition types:

  * Strings → `=` or `!=`
  * Numbers → `-eq`, `-gt`, `-lt`, etc.

---

### 💡 Best Practices / Tips

* Always **indent inside if blocks** for clarity.
* Use `[[ ... ]]` instead of `[ ... ]` in Bash — supports pattern matching and avoids many quoting issues.
* Keep conditions simple and clear — don’t over-nest `if` statements.
* Combine `elif` instead of multiple nested `if`s for cleaner code.

---

### 📝 Example Script

```bash
#!/bin/bash
# Script: conditional_example.sh
# Purpose: Demonstrate if, elif, and else in action

echo "Enter a number:"
read num

if [ $num -gt 10 ]; then
    echo "Number is greater than 10"
elif [ $num -eq 10 ]; then
    echo "Number is exactly 10"
else
    echo "Number is less than 10"
fi
```

**Output Example:**

```
Enter a number:
7
Number is less than 10
```

---


