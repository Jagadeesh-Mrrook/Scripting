# Day 8 — Functions

## Concept 1: Define and Call Functions

### Concept / What

A **function** in shell scripting is a named block of reusable code that performs a specific task. You define it once and call it multiple times in your script. It can contain any shell logic — commands, loops, or conditionals.

### Why / Purpose / Use Case

Functions are used for:

* **Reusability:** Avoid repeating the same logic multiple times in a script.
* **Organization:** Define all functions first, then call them later for a clean, readable flow.
* **Maintainability:** Update logic in one place instead of changing code in many spots.
* **Modularity:** Split long scripts into smaller, logical sections.

**Real-world use cases:**

* Automating setup, deployment, and cleanup steps.
* Implementing reusable utilities like `log_info`, `check_service`, or `retry_command`.
* Centralizing repeated commands for readability and debugging.

### How it Works / Steps / Syntax

Two common syntaxes:

**1️⃣ Standard Bash syntax (recommended):**

```bash
my_function() {
  # commands
}
```

**2️⃣ Alternate syntax:**

```bash
function my_function {
  # commands
}
```

**To call a function:**

```bash
my_function          # no arguments
my_function arg1 arg2   # with arguments
```

**Execution flow:**

* Bash reads all function definitions first.
* Functions are executed only when called.
* Define functions before calling them to maintain clarity and avoid runtime issues.

### Common Issues / Errors

| Problem                                 | Example                      | Fix                                  |
| --------------------------------------- | ---------------------------- | ------------------------------------ |
| Typo in function name                   | `myfunc` vs `my_function`    | Use consistent naming conventions    |
| Called before definition (older shells) | Function used before defined | Define functions at the top          |
| Expecting `return` to output text       | `return "hello"`             | Use `echo` and capture with `$(...)` |
| Wrong shell                             | Missing `#!/bin/bash`        | Add shebang and run with bash        |

### Troubleshooting / Fixes

* Add `#!/bin/bash` at the top to ensure Bash syntax.
* Use `set -u` to catch undefined variables.
* Check if function exists using:

  ```bash
  declare -f my_function >/dev/null || echo "Function missing"
  ```
* When reusing across scripts, use `source /path/to/functions.sh` to import definitions.

### Best Practices / Tips

* Define all functions first, then call them later — improves organization and readability.
* Use **descriptive names** (e.g., `cleanup_logs`, `deploy_app`).
* Keep functions short, focused, and documented.
* Use **`set -euo pipefail`** for safer scripting.
* Avoid unnecessary global variables — prefer local variables.
* Place shared functions in a separate file (`functions.sh`) and source them.
* When sourcing, prefer dynamic path loading for reliability:

  ```bash
  source "$(dirname "$0")/../common/functions.sh"
  ```

### Using Functions Across Scripts

By default, functions exist only within the same script. To use them in another script, **source** the file that contains them:

```bash
source ./common_functions.sh
```

This executes the file in the **current shell**, making all its functions available.

**You can source using:**

* **Absolute path:** `/home/ec2-user/scripts/common/functions.sh`
* **Relative path:** `../common/functions.sh`
* **Dynamic path (recommended):** `source "$(dirname "$0")/../common/functions.sh"`

**Common issues:**

* “Function not found” → forgot to `source`.
* “No such file or directory” → wrong path → fix with correct absolute/dynamic path.

### Real-World Comparison (Jenkins Shared Library Analogy)

Conceptually, shell function files work like **Jenkins Shared Libraries**:

| Aspect              | Shell Scripting                 | Jenkins Shared Library                    |
| ------------------- | ------------------------------- | ----------------------------------------- |
| **Purpose**         | Store reusable bash functions   | Store reusable Groovy functions           |
| **Definition File** | `functions.sh`, `common.sh`     | `utilities.groovy`, `vars/`, `src/` files |
| **Usage**           | `source ./functions.sh`         | `@Library('shared-lib') _`                |
| **Scope**           | Current script (after sourcing) | Any Jenkinsfile that imports the library  |
| **Execution**       | Loaded into current shell       | Loaded dynamically by Jenkins             |

So just like you maintain `utilities.groovy` in Jenkins for shared pipeline code, you maintain `functions.sh` in shell for shared reusable logic.

### Example Script: define_and_call.sh

```bash
#!/usr/bin/env bash

# Demo: Define and call functions in bash
set -euo pipefail

# Function definitions
greet() {
  echo "Hello! This is greet()"
}

add_numbers() {
  local a=${1:-0}
  local b=${2:-0}
  echo "$((a + b))"
}

# Main execution
greet
sum=$(add_numbers 5 7)
echo "5 + 7 = $sum"

for i in 1 2 3; do
  greet
done

exit 0
```

**How to run:**

```bash
chmod +x define_and_call.sh
./define_and_call.sh
```

**Output:**

```
Hello! This is greet()
5 + 7 = 12
Hello! This is greet()
Hello! This is greet()
Hello! This is greet()
```

---
---

## Rollout Pause, Resume, Undo - Detailed Explanation

### **Concept / What**

Kubernetes provides manual rollout control commands for Deployments: `pause`, `resume`, and `undo`. These commands allow you to manage ongoing rollouts safely. A rollout represents the process of updating a Deployment (for example, updating image versions or replicas).

| Command                  | Purpose                              |
| ------------------------ | ------------------------------------ |
| `kubectl rollout pause`  | Temporarily stop an ongoing rollout. |
| `kubectl rollout resume` | Continue a paused rollout.           |
| `kubectl rollout undo`   | Roll back to a previous revision.    |

These commands help ensure safer updates and enable manual validation during deployments.

---

### **Why / Purpose / Use Case**

* **Pause:** Used when you want to stop an active rollout temporarily to inspect or validate changes before continuing.
* **Resume:** Used after validation to allow Kubernetes to continue replacing pods with the new version.
* **Undo:** Used to revert to the previous or a specific stable version if the current rollout causes issues.

**Real-World Use Case:**
If a Jenkins pipeline deploys an application (`kubectl apply -f deployment.yaml`) and you notice pods failing health checks, you can manually pause the rollout, fix the issue, and then resume or undo it.

---

### **How It Works / Steps / Syntax**

1. **Check rollout status:**

   ```bash
   kubectl rollout status deployment/orders-api
   ```
2. **Pause rollout:**

   ```bash
   kubectl rollout pause deployment/orders-api
   ```
3. **Fix issue (if any):**
   Update image, config, or resource definitions.
4. **Resume rollout:**

   ```bash
   kubectl rollout resume deployment/orders-api
   ```
5. **Undo rollout:**

   ```bash
   kubectl rollout undo deployment/orders-api
   ```

   or roll back to a specific revision:

   ```bash
   kubectl rollout undo deployment/orders-api --to-revision=2
   ```

**Verification Commands:**

```bash
kubectl rollout history deployment/orders-api
kubectl get rs -l app=orders-api
```

---

### **Common Issues / Troubleshooting**

| Issue                        | Cause                                     | Fix                                 |
| ---------------------------- | ----------------------------------------- | ----------------------------------- |
| Rollout stuck                | Deployment paused or probe failures       | `kubectl rollout resume`            |
| Rollback failed              | Revision deleted due to low history limit | Increase `revisionHistoryLimit`     |
| Pods not updating            | Wrong image tag or context                | Check `kubectl describe deployment` |
| Rollout paused automatically | Misconfigured readiness/liveness probes   | Inspect deployment and fix probes   |

---

### **Best Practices / Tips**

* Use **pause → validate → resume** flow during sensitive updates.
* Always monitor rollout using `kubectl rollout status`.
* Combine with **readiness probes** to avoid serving traffic from unready pods.
* Set `revisionHistoryLimit` high enough for reliable rollback.
* Automate rollbacks for failed health checks in CI/CD.
* Document changes using `kubectl annotate deployment <name> kubernetes.io/change-cause="..."`.

---

### **Limitations / Trade-offs / Important Notes**

* Rollbacks re-create pods, so temporary latency is possible.
* Only revisions stored under `revisionHistoryLimit` can be rolled back.
* Rollout commands are **manual control mechanisms**; CI/CD systems like ArgoCD or Flux handle rollouts declaratively instead.
* In automated setups (like Jenkins), if the rollout is automated, these commands can still be run manually in parallel for troubleshooting.

---

### **Manual Rollout Operations in Real-World Setup**

In production setups, CI/CD pipelines (like Jenkins) run automatically on **Jenkins Agent EC2 instances**, which have all required tools — `kubectl`, `AWS CLI`, `Terraform`, `Ansible`, and `Maven`. DevOps engineers do not perform these operations from local laptops.

For manual interventions (pause, resume, undo):

1. **SSH into Bastion Host** (public subnet)

   ```bash
   ssh -i devops-key.pem ec2-user@<bastion-public-ip>
   ```
2. **SSH from Bastion → Jenkins Agent (private subnet)**

   ```bash
   ssh ec2-user@<jenkins-agent-private-ip>
   ```
3. **Run commands on Jenkins Agent**

   ```bash
   aws eks update-kubeconfig --name prod-cluster --region ap-south-1
   kubectl rollout pause deployment/orders-api
   kubectl rollout resume deployment/orders-api
   kubectl rollout undo deployment/orders-api
   ```

This multi-hop access model ensures security while allowing controlled manual operations.

**Why this model is used:**

* Jenkins Agent has all CLIs and IAM permissions.
* Bastion is the secure public entry point.
* Jenkins Agents are in private subnets (no direct SSH access).
* Ensures compliance and centralized auditing.

---

### **Summary Table**

| Command          | Purpose                        | Used In                        | Notes                            |
| ---------------- | ------------------------------ | ------------------------------ | -------------------------------- |
| `rollout pause`  | Temporarily freeze a rollout   | During manual inspection       | Safe and reversible              |
| `rollout resume` | Continue rollout               | After validation               | Ensures update continuation      |
| `rollout undo`   | Roll back to previous revision | During issue recovery          | Recreates old ReplicaSet         |
| Access Method    | Bastion → Jenkins Agent        | Secure production environments | No direct SSH from local laptops |

---

**Summary:** Rollout control commands (`pause`, `resume`, `undo`) are crucial for managing Kubernetes deployments safely. In real-world CI/CD setups, DevOps engineers connect securely via the Bastion host to the Jenkins agent EC2 (where kubectl and AWS CLI are installed) to manually execute these commands for debugging, rollback, or controlled release operations.

---
---

# Day 8 — Functions

## Concept 3: Return Values from Functions

### Concept / What

In shell scripting, a function can return **two kinds of results**:

1. **Exit status (numeric)** — indicates success (0) or failure (non-zero).
2. **Actual data (text or number)** — sent back using `echo` and captured with `$(...)`.

### Why / Purpose / Use Case

The `return` command is used when you want to control the **exit status** of a function — to indicate success, failure, or specific outcomes.
It’s especially helpful in **long, multi-step scripts**, where you might want to stop early or signal which part failed.

For **short/simple scripts**, you usually don’t need it — the **last command’s exit code** inside the function is enough to indicate success or failure.

### How it Works / Steps / Syntax

#### 1️⃣ Returning Exit Status (using `return`)

```bash
check_file() {
  if [ -f "$1" ]; then
    echo "File exists"
    return 0    # success
  else
    echo "File not found"
    return 1    # failure
  fi
}

check_file /etc/passwd
echo "Exit status: $?"
```

* `return 0` → success.
* `return 1` (or any non-zero) → failure.
* `$?` → captures the function’s exit status immediately after it runs.

#### 2️⃣ Returning Data (using `echo`)

```bash
add_numbers() {
  local sum=$(( $1 + $2 ))
  echo "$sum"
}

result=$(add_numbers 5 10)
echo "Sum is: $result"
```

Here, `echo` outputs data, and `$(...)` captures it in a variable.

#### 3️⃣ Combining Both

```bash
divide_numbers() {
  local a=$1
  local b=$2

  if [ "$b" -eq 0 ]; then
    echo "Division by zero error"
    return 1
  fi

  local result=$(( a / b ))
  echo "$result"
  return 0
}

output=$(divide_numbers 10 2)
status=$?

if [ $status -eq 0 ]; then
  echo "Result: $output"
else
  echo "Error: $output"
fi
```

### Common Issues / Errors

| Problem                   | Cause                                      | Fix                                   |
| ------------------------- | ------------------------------------------ | ------------------------------------- |
| `return` used with string | `return` only supports numbers             | Use `echo` for string data            |
| `$?` shows wrong value    | Checked after another command              | Check `$?` immediately after function |
| Missing `return`          | Function inherits last command’s exit code | Optional in simple cases              |

### Troubleshooting / Fixes

* Use `return` only when you need explicit success/failure codes.
* Let the last command’s exit status decide the result if that’s sufficient.
* Always check `$?` right after function execution.
* Use `echo` + `$(...)` to return actual text or computed values.

### Why `return` Exists (Purpose)

Although every command already has an exit code, `return` exists to:

1. **Override or customize exit codes** — when you don’t want to depend on the last command’s result.
2. **Set specific codes** for different outcomes:

   ```bash
   validate_file() {
     if [ ! -e "$1" ]; then
       return 1  # Missing
     elif [ ! -r "$1" ]; then
       return 2  # Permission issue
     else
       return 0  # OK
     fi
   }
   ```
3. **Stop execution early** in a function when a condition fails.
4. **Improve readability** by making success/failure explicit.
5. **Control complex logic** in multi-step functions.

### When to Use `return`

| Script Type               | `return` Usage     | Reason                                                        |
| ------------------------- | ------------------ | ------------------------------------------------------------- |
| **Short/simple scripts**  | Usually not needed | Let last command’s exit status handle it                      |
| **Large/complex scripts** | Very useful        | Control flow, handle multiple cases, exit early, custom codes |

### Best Practices / Tips

* Use `return` for **status control**, not for sending text.
* Use `echo` for **returning data**.
* Capture data with `result=$(function)`.
* Check function success/failure using `$?`.
* Prefer simple logic in small scripts; reserve `return` for big ones.

### Example: Long Script Use Case

```bash
deploy_app() {
  start_service || { echo "Service start failed"; return 1; }
  run_migrations || { echo "Migration failed"; return 2; }

  echo "Deployment successful!"
  return 0
}

if deploy_app; then
  echo "All good"
else
  echo "Deployment failed"
fi
```

### Summary

* `return` sets the **exit code** (0–255) — it’s about **success/failure**, not data.
* `$?` checks that status.
* `echo` sends **data output**.
* Use `return` when your function has **multiple logic paths** or you want to **override exit behavior**.
* For simple functions, **skip it** — just rely on the last command’s status.

---
---

# Day 8 — Functions

## Concept 4: Local vs Global Variables

### Concept / What

In shell scripting, variables can have two scopes:

* **Global Variables:** Accessible throughout the entire script — inside and outside functions.
* **Local Variables:** Accessible **only within the function** where they are defined.

By default, all variables in shell are **global** unless you explicitly declare them with the `local` keyword inside a function.

### Why / Purpose / Use Case

Using `local` helps avoid conflicts and accidental overwriting of variable values in large scripts with multiple functions. It makes your code safer, cleaner, and easier to debug.

**Use cases:**

* Use **global** variables for values shared across multiple functions (e.g., config, environment, constants).
* Use **local** variables for temporary or function-specific calculations or loops.

### How it Works / Steps / Syntax

#### 1️⃣ Global Variables (Default)

```bash
#!/bin/bash

name="Jagga"   # Global variable

say_hello() {
  echo "Hello, $name"
}

say_hello
echo "Outside function: $name"
```

**Output:**

```
Hello, Jagga
Outside function: Jagga
```

#### 2️⃣ Local Variables

```bash
#!/bin/bash

say_hello() {
  local name="Jagga"
  echo "Inside function: $name"
}

say_hello
echo "Outside function: $name"
```

**Output:**

```
Inside function: Jagga
Outside function:
```

#### 3️⃣ Local Variable Overrides Global (Scope Separation)

```bash
#!/bin/bash

name="DevOps Engineer"

show_role() {
  local name="AWS Engineer"
  echo "Inside function: $name"
}

show_role
echo "Outside function: $name"
```

**Output:**

```
Inside function: AWS Engineer
Outside function: DevOps Engineer
```

### Common Issues / Errors

| Problem                             | Cause                                         | Fix                                    |
| ----------------------------------- | --------------------------------------------- | -------------------------------------- |
| Variable value changes unexpectedly | Function overwrote a global variable          | Use `local` inside function            |
| Value missing outside function      | Variable declared `local` inside function     | Use normal variable for global scope   |
| Forgot `local`                      | Function accidentally changes global variable | Always use `local` for internal values |

### Troubleshooting / Fixes

* If a variable is showing unexpected values, check if a function changed it — add `local` inside functions.
* Use `set -u` at the top to catch unset variable references.
* Avoid reusing the same variable name in multiple places unless intentionally global.

### Best Practices / Tips

✅ Use `local` for all variables declared inside functions (unless you need them outside).
✅ Define global variables at the top of your script for clarity.
✅ Use descriptive variable names — avoid short generic ones like `data` or `temp`.
✅ Remember: `local` only works **inside functions** — not outside.

### Example Script 1: Using Global Variable for Shared Data

```bash
#!/bin/bash

env="dev"

deploy_app() {
  echo "Deploying to $env environment..."
}

deploy_app
```

**Output:**

```
Deploying to dev environment...
```

### Example Script 2: Using Local Variable to Prevent Conflict

```bash
#!/bin/bash

count=5

increment() {
  local count=10
  ((count++))
  echo "Inside function: $count"
}

increment
echo "Outside function: $count"
```

**Output:**

```
Inside function: 11
Outside function: 5
```

### Example Script 3: Without local (Conflict Example)

```bash
#!/bin/bash

count=5

increment() {
  count=10
  ((count++))
  echo "Inside function: $count"
}

increment
echo "Outside function: $count"
```

**Output:**

```
Inside function: 11
Outside function: 11
```

Here the global `count` got changed because we didn’t use `local`.

### Summary Table

| Type       | Declared With          | Visible Where              | Use Case                         |
| ---------- | ---------------------- | -------------------------- | -------------------------------- |
| **Global** | `variable=value`       | Everywhere (entire script) | Shared config, constants         |
| **Local**  | `local variable=value` | Inside that function only  | Temporary values, internal logic |

### Key Takeaway

> In shell scripting, **all variables are global by default**.
> Use the **`local` keyword** inside functions to prevent accidental overwriting and to keep your scripts modular and reliable.

---
---

# Day 8 — Functions

## Concept 5: Combining Functions with Loops, Conditionals, and File Checks

### Concept / What

Functions can include control structures like **conditionals (`if`, `else`)**, **loops (`for`, `while`)**, and **file checks (`-f`, `-d`, `-e`)**.
This allows your script to make decisions, repeat actions, and perform validations within reusable function blocks.

### Why / Purpose / Use Case

Real-world scripts often need to:

* Check if a service or file exists before proceeding.
* Loop through multiple files or items.
* Make decisions based on conditions.

Combining these structures inside functions makes scripts **dynamic, reusable, and modular**.

### How it Works / Steps / Syntax

#### 1️⃣ Function with Conditionals

```bash
#!/bin/bash

check_service() {
  local service=$1

  if systemctl is-active --quiet "$service"; then
    echo "$service is running"
  else
    echo "$service is not running"
  fi
}

check_service nginx
```

**Output:**

```
nginx is running
```

#### 2️⃣ Function with Loops

```bash
#!/bin/bash

check_multiple_services() {
  for svc in "$@"; do
    if systemctl is-active --quiet "$svc"; then
      echo "$svc: running"
    else
      echo "$svc: stopped"
    fi
  done
}

check_multiple_services nginx sshd docker
```

**Output:**

```
nginx: running
sshd: running
docker: running
```

#### 3️⃣ Function with File Checks

```bash
#!/bin/bash

check_file() {
  local file=$1

  if [ -f "$file" ]; then
    echo "✅ File exists: $file"
  elif [ -d "$file" ]; then
    echo "📁 Directory exists: $file"
  else
    echo "❌ Not found: $file"
  fi
}

check_file /etc/passwd
check_file /home
check_file /fake/path
```

**Output:**

```
✅ File exists: /etc/passwd
📁 Directory exists: /home
❌ Not found: /fake/path
```

#### 4️⃣ Combining All (Conditionals + Loops + File Checks)

```bash
#!/bin/bash

check_logs() {
  local dir=$1

  if [ ! -d "$dir" ]; then
    echo "Directory not found: $dir"
    return 1
  fi

  for file in "$dir"/*.log; do
    if [ -f "$file" ]; then
      echo "Checking $file..."
      if grep -q "ERROR" "$file"; then
        echo "❗ Error found in $file"
      else
        echo "✅ No errors in $file"
      fi
    fi
  done
}

check_logs "/var/log"
```

### Handling Function Input (Arguments vs `read -p`)

You can provide input to functions in two ways:

#### 🟢 1. Pass Arguments (Static Input)

```bash
deploy_app() {
  local env=$1
  echo "Deploying to $env environment..."
}

deploy_app dev
```

✅ Best for automation or CI/CD scripts (non-interactive).

#### 🟢 2. Use `read -p` (Dynamic Input)

```bash
deploy_app() {
  local env
  read -p "Enter environment (dev/stage/prod): " env
  echo "Deploying to $env environment..."
}

deploy_app
```

✅ Best for manual scripts where users enter values.

#### 🟢 3. Combine Both (Hybrid Method)

```bash
check_service() {
  local service=$1
  if [ -z "$service" ]; then
    read -p "Enter service name: " service
  fi

  if systemctl is-active --quiet "$service"; then
    echo "$service is running"
  else
    echo "$service is not running"
  fi
}

check_service nginx
check_service
```

✅ Works both interactively and with arguments.

### Common Issues / Errors

| Problem                       | Cause                            | Fix                                 |
| ----------------------------- | -------------------------------- | ----------------------------------- |
| File or path check fails      | Missing quotes                   | Always quote variables in `[ ]`     |
| Loop breaks early             | Incorrect variable usage         | Verify `$@` or loop condition       |
| No input when using `read -p` | Script running non-interactively | Use arguments for automated scripts |

### Troubleshooting / Fixes

* Add `echo` debug statements to confirm which branch runs.
* Always check file paths with quotes.
* For loops over files, use `"$@"` to pass all safely.

### Best Practices / Tips

✅ Always use `local` variables in functions.
✅ Validate input before processing (`if [ -z "$1" ]; then ... fi`).
✅ Quote all variables to avoid word-splitting.
✅ Keep functions small and combine them logically.
✅ Use arguments for automation, `read -p` for interactive input.

### Example: Real-World Use Case

```bash
#!/bin/bash

cleanup_old_files() {
  local path=$1
  local days=$2

  if [ ! -d "$path" ]; then
    echo "Directory not found!"
    return 1
  fi

  echo "Cleaning files older than $days days in $path..."
  for file in $(find "$path" -type f -mtime +$days); do
    echo "Deleting: $file"
    rm -f "$file"
  done
  echo "Cleanup completed!"
}

cleanup_old_files /tmp 7
```

### Summary

| Technique                 | Purpose                                  |
| ------------------------- | ---------------------------------------- |
| **Conditionals**          | Make decisions based on checks           |
| **Loops**                 | Repeat actions for lists or files        |
| **File Checks**           | Validate files/directories before acting |
| **Arguments / `read -p`** | Control how inputs are received          |

✅ **In short:** Combine these structures inside functions to make your scripts powerful, reusable, and production-ready.

---
---

# Day 8 — Functions

## Real-World Example: Log Cleanup Script (Simple Modular Script)

### Concept / What

This example shows how to use **modularization** in shell scripting to create reusable scripts for common operational tasks like log cleanup.

We'll use two files:

1. **`functions.sh`** → contains reusable helper functions.
2. **`cleanup_logs.sh`** → main script that imports and uses those functions.

### Why / Purpose / Use Case

In real-world DevOps tasks, repetitive actions like cleaning old log files or checking directories can be reused across many scripts.
Instead of writing them repeatedly, we modularize them into one file and reuse them using the `source` command.

### How It Works / Steps / Syntax

#### 🧱 Step 1 — Create a Common File (`functions.sh`)

```bash
#!/bin/bash

# Print formatted info messages
log_info() {
  echo "[INFO] $1"
}

# Check if directory exists
check_directory() {
  local dir=$1
  if [ -d "$dir" ]; then
    return 0   # success
  else
    return 1   # failure
  fi
}
```

#### 🧱 Step 2 — Create the Main Script (`cleanup_logs.sh`)

```bash
#!/bin/bash

# Load reusable functions
source ./functions.sh

cleanup_logs() {
  local log_dir=$1
  local days_old=$2

  # Check if directory exists before cleaning
  if ! check_directory "$log_dir"; then
    log_info "Directory not found: $log_dir"
    return 1
  fi

  log_info "Cleaning up log files older than $days_old days in $log_dir..."
  find "$log_dir" -type f -name "*.log" -mtime +$days_old -exec rm -f {} \;
  log_info "Cleanup complete!"
}

# Run the function
cleanup_logs "/tmp" 7
```

#### 🧪 Step 3 — Run the Script

```bash
chmod +x functions.sh cleanup_logs.sh
./cleanup_logs.sh
```

**Output:**

```
[INFO] Cleaning up log files older than 7 days in /tmp...
[INFO] Cleanup complete!
```

If the directory doesn’t exist:

```
[INFO] Directory not found: /wrong/path
```

### Common Issues / Errors

| Problem                     | Cause                                 | Fix                                             |
| --------------------------- | ------------------------------------- | ----------------------------------------------- |
| "command not found"         | Forgot to `source` the functions file | Add `source ./functions.sh` at the top          |
| "No such file or directory" | Wrong path                            | Use correct or dynamic path with `dirname "$0"` |
| No files deleted            | Path wrong or permissions missing     | Use `sudo` or correct directory                 |

### Troubleshooting / Fixes

* Use `echo` statements to debug file paths.
* Add `set -x` temporarily to trace execution.
* Confirm that `functions.sh` and main script are in the same folder.

### Best Practices / Tips

✅ Keep all reusable functions in one folder, e.g., `common/`.
✅ Always use `source ./functions.sh` (or dynamic path) to load functions.
✅ Keep your functions short, descriptive, and modular.
✅ Use `chmod +x` on both files to make them executable.
✅ Test your script manually before scheduling via cron.

### Real-World Use Case

This modular script can be used in production for automatic log cleanup.
Example cron job:

```
0 1 * * * /home/ec2-user/scripts/cleanup_logs.sh >> /var/log/cleanup.log 2>&1
```

Runs daily at 1 AM and logs the output to `/var/log/cleanup.log`.

### Summary

> Modularizing scripts helps reuse common logic (like logging or checks) across multiple tasks.
> This real-world example demonstrates how `functions.sh` and `cleanup_logs.sh` work together to keep your scripts simple, clean, and reusable.

---
---

# Day 8 — Functions

## Concept 7: Command Substitution (`$(command)` and backticks `` `command` ``)

### Concept / What

**Command substitution** allows you to run a command and use its **output** as a value inside another command or store it in a variable.

In simple terms — the shell runs the command first and replaces it with its result.

Two ways to do this:

* Modern way → `$(command)` ✅ (recommended)
* Old way → `` `command` `` (still works but harder to read)

### Why / Purpose / Use Case

It helps make scripts **dynamic** and **automatic** — no need to hardcode values.

**Use cases:**

* Store the output of commands (date, user, hostname, etc.)
* Use one command’s output as input to another command
* Generate folder names or filenames dynamically

### How it Works / Steps / Syntax

#### 1️⃣ Storing Command Output

```bash
#!/bin/bash

current_date=$(date)
echo "Today's date is: $current_date"
```

**Output:**

```
Today's date is: Mon Nov 10 18:05:02 IST 2025
```

#### 2️⃣ Using Inside Another Command

```bash
#!/bin/bash

echo "Your home directory has $(ls | wc -l) items."
```

**Output:**

```
Your home directory has 20 items.
```

#### 3️⃣ Old Style Backticks (Not Recommended)

```bash
#!/bin/bash

current_user=`whoami`
echo "Running as user: $current_user"
```

**Output:**

```
Running as user: ubuntu
```

✅ Works fine, but backticks are harder to read — prefer `$(...)`.

#### 4️⃣ Inside a Function

```bash
#!/bin/bash

show_system_info() {
  local user=$(whoami)
  local host=$(hostname)
  local date_now=$(date +%Y-%m-%d)

  echo "User: $user"
  echo "Host: $host"
  echo "Date: $date_now"
}

show_system_info
```

**Output:**

```
User: ubuntu
Host: myserver
Date: 2025-11-10
```

#### 5️⃣ Nested Command Substitution

```bash
#!/bin/bash

echo "Current directory is: $(basename $(pwd))"
```

**Output:**

```
Current directory is: scripts
```

### Common Issues / Errors

| Problem                   | Cause                | Fix                           |
| ------------------------- | -------------------- | ----------------------------- |
| Extra newlines or spaces  | Output includes `\n` | Use `echo -n` or `tr -d '\n'` |
| Confusing syntax          | Nested backticks     | Use `$(...)` instead          |
| Unquoted values splitting | Spaces in output     | Quote it: `"$(command)"`      |

### Troubleshooting / Fixes

* Run the command alone first to test its output.
* Use quotes around `$(command)` when using inside strings.
* Avoid deeply nested command substitutions — use intermediate variables instead.

### Best Practices / Tips

✅ Prefer `$(command)` — it’s modern and readable.
✅ Always quote the result — `"$(command)"`.
✅ Keep commands simple — test them before using inside substitution.
✅ Use substitution for dynamic variables like `$(date)`, `$(whoami)`, `$(hostname)`.

### Real-World Example — Dynamic Log Backup Script

```bash
#!/bin/bash

backup_logs() {
  local backup_dir="/tmp/backup_$(date +%Y%m%d)"
  mkdir -p "$backup_dir"

  echo "Backing up logs to: $backup_dir"
  cp /var/log/*.log "$backup_dir" 2>/dev/null
  echo "Backup completed at $(date '+%H:%M:%S')"
}

backup_logs
```

**Output:**

```
Backing up logs to: /tmp/backup_20251110
Backup completed at 18:12:45
```

### Summary

| Symbol          | Meaning                          | Example             | Recommended |
| --------------- | -------------------------------- | ------------------- | ----------- |
| `$(command)`    | Runs command and uses its output | `user=$(whoami)`    | ✅ Yes       |
| `` `command` `` | Older form (same function)       | `` user=`whoami` `` | ❌ Avoid     |

✅ **Command substitution** makes your script dynamic by capturing command output automatically and using it in real-time.

---
---
---


