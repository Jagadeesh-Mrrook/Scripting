# Q1. Log Scanner Task — Question & Answer

## **Question**

Your application generates a log file called `app.log`.
Each line in the log contains either:

* INFO
* WARN
* ERROR

Write a script that:

* Reads the log file line‑by‑line
* Prints only the `ERROR` lines
* Stops the script immediately if it encounters a line containing:
  `CRITICAL: shutdown`

**No user input. No arguments.**
Use the filename directly inside the script.

---

## **Corrected Script (Answer)**

```bash
#!/bin/bash

while IFS= read -r line
do
    if echo "$line" | grep -q "CRITICAL: shutdown"; then
        echo "CRITICAL found — stopping script"
        exit 1
    fi

    if echo "$line" | grep -q "ERROR"; then
        echo "$line"
    fi

done < app.log
```

