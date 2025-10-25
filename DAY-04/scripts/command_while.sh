while read user; do
    echo "User: $user"
done < <(cut -d: -f1 /etc/passwd)

