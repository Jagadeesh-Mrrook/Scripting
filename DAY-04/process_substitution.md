### Concept / What: Process Substitution

**Definition:**
Process substitution allows the output of a command to be treated like a temporary file that can be read or written by another command. It enables feeding command output as a “file” without creating a physical file.

**Syntax:**

* `<(command)` → provides output of `command` as a file for reading.
* `>(command)` → provides a file that, when written to, sends data to `command`.

---

### Why / Purpose / Use Case

* When a command expects a filename but you want to supply dynamic command output instead.
* Avoids creating temporary files manually.
* Common scenarios:

  * Comparing outputs with `diff`
  * Looping through dynamic output with `while read`
  * Feeding commands like `grep`, `sort`, `comm` that read from files

---

### How it Works / Steps / Syntax

**Example 1: Comparing two directories**

```bash
diff <(ls dir1) <(ls dir2)
```

* `<(ls dir1)` → virtual file containing output of `ls dir1`
* `<(ls dir2)` → virtual file containing output of `ls dir2`
* `diff` compares these virtual files

**Example 2: While loop reading dynamic output**

```bash
while read user; do
    echo "User: $user"
done < <(cut -d: -f1 /etc/passwd)
```

Steps:

1. `cut -d: -f1 /etc/passwd` outputs usernames.
2. `<(...)` creates a virtual file `/dev/fd/...` containing that output.
3. The `while` loop reads from this virtual file line by line.
4. `echo` prints each username.

---

### Common Issues / Errors

* Not supported in `/bin/sh` (use `bash` or `zsh`).
* Infinite loops if loop reads incorrectly.
* Complex nested substitutions can be hard to read.

---

### Troubleshooting / Fixes

* Ensure script uses `#!/bin/bash`.
* Test the command inside `<(...)` independently.
* For readability, assign the substitution to a variable:

```bash
users_file=<(cut -d: -f1 /etc/passwd)
while read user; do
    echo $user
done < "$users_file"
```

---

### Best Practices / Tips

* Use process substitution to avoid temporary files.
* Great for loops, comparisons, or feeding commands expecting files.
* Keep it simple; avoid deeply nested `<(...)` substitutions.

---

### Example Script

```bash
#!/bin/bash
# List all users in /etc/passwd using process substitution
while read user; do
    echo "User: $user"
done < <(cut -d: -f1 /etc/passwd)
```

**Output Example:**

```
User: root
User: daemon
User: bin
User: sys
...
```


