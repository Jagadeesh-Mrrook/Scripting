# Day 1: Shell Basics and Script Setup

## Concept 1: Purpose of Shell Scripting

### Concept / What
Shell scripting is writing a series of commands in a file to be executed by the shell (like Bash). It automates repetitive tasks, simplifies system administration, and allows you to combine multiple commands into a single executable file.

### Why / Purpose / Use Case
- Automate repetitive tasks like backups, file management, or deployments.
- Perform complex sequences of commands with a single script.
- Schedule tasks using `cron` or systemd timers.
- Ensure consistency and reduce manual errors.
- Useful in DevOps for CI/CD pipelines, server provisioning, and monitoring.

**Practical Scenarios**
- Automating log cleanup every week.
- Deploying applications to multiple servers with one command.
- Generating reports from system logs daily.

### How it Works / Steps / Syntax
1. Create a plain text file with commands you want to execute.
2. Make the file executable.
3. Run the script via the shell.

No special syntax is required for the purpose itself — the commands inside define what it does.

### Common Issues / Errors
- Running a script without execute permissions.
- Forgetting the shebang line (script may not run with the intended shell).
- Mixing shell syntaxes (e.g., Bash vs sh) — commands may fail.

### Troubleshooting / Fixes
- Use `chmod +x script.sh` to add execute permission.
- Include a proper shebang line: `#!/bin/bash`.
- Test scripts with `bash -x script.sh` for debugging.

### Best Practices / Tips
- Keep scripts modular and readable.
- Comment your code for clarity.
- Test commands individually before adding them to the script.
- Use meaningful filenames and follow a consistent naming convention.

### Example Script (Including How to Run)
```bash
#!/bin/bash
# Purpose: Demonstrate the use of shell scripting

echo "This is a simple shell script."
echo "Shell scripts help automate tasks and save time."

# How to run:
# 1. Save this file as purpose_demo.sh
# 2. Make it executable: chmod +x purpose_demo.sh
# 3. Execute it: ./purpose_demo.sh

