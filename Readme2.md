# Advanced Shell Scripting 20-Day Learning Plan (Interview-Ready for 5-Year DevOps Engineer)

This plan is designed to take you from basic shell scripting knowledge to **advanced, real-world scripting** suitable for DevOps-level interviews. Each day includes **concepts, checklists, and practical exercises**.

---

## Day 1: Advanced Conditionals & Regex

**Checklist:**

* [ ] Full regex operators (`^`, `$`, `.`, `*`, `+`, `?`, `{}`, `[]`, `|`, `()`)
* [ ] Bash `=~` operator for pattern matching
* [ ] Numeric and string validations
* [ ] Complex if/elif/else conditions
* [ ] Practice: validate number, IP address, date format

---

## Day 2: Advanced Loops & Iteration

**Checklist:**

* [ ] Nested loops
* [ ] `for`, `while`, `until` loops
* [ ] Looping over arrays, directories, files
* [ ] `break` and `continue` in nested loops
* [ ] Looping with command output

---

## Day 3: Arrays & Associative Arrays

**Checklist:**

* [ ] Indexed arrays
* [ ] Associative arrays
* [ ] Adding, removing, slicing, iterating arrays
* [ ] Multi-dimensional array handling (Bash workaround)
* [ ] Combining arrays with loops and conditionals

---

## Day 4: Advanced String Manipulation

**Checklist:**

* [ ] Substring extraction
* [ ] Trimming, padding, and replacing strings
* [ ] Case conversion
* [ ] Pattern matching in strings
* [ ] Practice: palindrome check, substring extraction from logs

---

## Day 5: File Handling & I/O

**Checklist:**

* [ ] Reading/writing files line-by-line
* [ ] Redirection (`>`, `>>`, `<`, `<<`, `<<<`)
* [ ] File descriptors (`0`, `1`, `2`, custom descriptors)
* [ ] Checking file properties (`-f`, `-d`, `-L`, `-r`, `-w`, `-x`, `-nt`, `-ot`)
* [ ] Processing logs, CSV/JSON files

---

## Day 6: Functions & Modular Scripts

**Checklist:**

* [ ] Defining and calling functions
* [ ] Passing arguments (`$1`, `$2`, `$@`, `$*`)
* [ ] Returning values or arrays
* [ ] Local vs global variables
* [ ] Modular scripts for reusability

---

## Day 7: Error Handling & Debugging

**Checklist:**

* [ ] `set -euo pipefail`
* [ ] Checking exit codes with `$?`
* [ ] Conditional execution (`&&`, `||`)
* [ ] `trap` for signals, cleanup, error reporting (SIGINT, SIGTERM)
* [ ] Debugging with `set -x`, `set -v`, and logging
* [ ] Profiling scripts with `time` command and PS4 tracing

---

## Day 8: Environment Variables & Shell Options

**Checklist:**

* [ ] Exported variables and PATH manipulation
* [ ] Sourcing files (`source`, `.`)
* [ ] Using `env` and `which`
* [ ] Shell options for portability and debugging
* [ ] Handling IFS and safe quoting for complex input

---

## Day 9: Advanced Arithmetic Operations

**Checklist:**

* [ ] Integer arithmetic with `$(( ))` and `expr`
* [ ] Floating-point arithmetic using `bc`
* [ ] Increment/decrement operators
* [ ] Using arithmetic inside loops and conditionals

---

## Day 10: Parsing Command-Line Arguments

**Checklist:**

* [ ] `$1`, `$2`, `$@`, `$*`
* [ ] `getopts` for option parsing
* [ ] Handling optional and required arguments
* [ ] Practice: simple script with flags and options

---

## Day 11: Cron Jobs & Scheduling

**Checklist:**

* [ ] Create cron jobs for automation
* [ ] Using `crontab` for user-level tasks
* [ ] Scheduling scripts with `at` and `batch`
* [ ] Logging cron outputs

---

## Day 12: System Monitoring & Automation Scripts

**Checklist:**

* [ ] Monitoring CPU, memory, disk usage
* [ ] Automating backups
* [ ] Automating log rotations
* [ ] Parsing system logs for errors
* [ ] Sending alerts based on thresholds

---

## Day 13: Process Management

**Checklist:**

* [ ] Listing and managing processes (`ps`, `top`, `pgrep`)
* [ ] Killing processes (`kill`, `killall`)
* [ ] Background and foreground jobs (`&`, `fg`, `bg`)
* [ ] Using `wait` in scripts
* [ ] Process substitution (`<(command)`, `>(command)`) and command substitution `$(command)`

---

## Day 14: Advanced File Manipulation

**Checklist:**

* [ ] Finding files (`find`, `locate`) with conditions
* [ ] Moving, copying, and archiving (`tar`, `gzip`)
* [ ] File permissions and ownership (`chmod`, `chown`)
* [ ] Symbolic and hard links
* [ ] Timestamp-based operations for backup scripts

---

## Day 15: Networking & Remote Automation

**Checklist:**

* [ ] Ping, traceroute, netstat for basic checks
* [ ] SSH-based automation
* [ ] SCP, Rsync for file transfers
* [ ] Automating remote commands
* [ ] Network diagnostics using curl, wget, netcat (nc)

---

## Day 16: Advanced Input & Output

**Checklist:**

* [ ] Here-documents and here-strings
* [ ] Reading user input with `read -p` and `read -r`
* [ ] Using `IFS` for custom field splitting
* [ ] Handling multi-line input
* [ ] Safe handling of special characters

---

## Day 17: Logging & Reporting

**Checklist:**

* [ ] Writing logs with timestamps
* [ ] Rotating log files
* [ ] Sending email notifications from scripts
* [ ] Summarizing output for reports
* [ ] Parsing and formatting logs for human-readable reports

---

## Day 18: Security & Best Practices

**Checklist:**

* [ ] Using `chmod` and `umask` properly
* [ ] Avoiding hardcoded passwords (Ansible Vault, env variables)
* [ ] Quoting and escaping variables
* [ ] Script portability and maintainability
* [ ] Minimizing UUOC and using shell built-ins efficiently

---

## Day 19: Performance Optimization

**Checklist:**

* [ ] Avoiding unnecessary external commands
* [ ] Using built-in shell operations efficiently
* [ ] Profiling script execution time
* [ ] Memory and resource-efficient scripts
* [ ] Optimizing loops, arrays, and file processing

---

## Day 20: Capstone Mini Project / Interview Prep

**Checklist:**

* [ ] Combine all concepts: variables, arrays, loops, functions, regex
* [ ] File and log processing automation
* [ ] Error handling and debugging implemented
* [ ] Automation scripts for real-world DevOps scenarios
* [ ] Practice answering interview-style scripting questions
* [ ] Include advanced topics: signals, process substitution, network automation, environment handling

---

**Note:**

* Each day should include **writing 10–20 small scripts** to practice the concepts.
* Daily scripts should include both **basic exercises and real-time problem scenarios**.
* By the end of Day 20, you should be capable of handling **any DevOps-level shell scripting interview question** and writing robust, real-world automation scripts.

