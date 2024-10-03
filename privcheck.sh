
#!/bin/bash

echo "================ PrivCheck: Privilege Escalation Checker ================"

# Check for SUID and SGID binaries
echo "[+] Checking for SUID/SGID binaries..."
find / -perm /6000 -type f 2>/dev/null
echo "[+] SUID/SGID check complete."
echo

# Check for world-writable files
echo "[+] Checking for world-writable files..."
find / -type f -perm -0002 2>/dev/null
echo "[+] World-writable files check complete."
echo

# Check for world-writable directories
echo "[+] Checking for world-writable directories..."
find / -type d -perm -0002 2>/dev/null
echo "[+] World-writable directories check complete."
echo

# Check for weak file permissions on sensitive files
echo "[+] Checking permissions for sensitive files (/etc/passwd and /etc/shadow)..."
ls -l /etc/passwd /etc/shadow
echo "[+] Sensitive files permission check complete."
echo

# Check for cron jobs owned by root but writable by others
echo "[+] Checking for cron jobs owned by root but writable by others..."
for cron_file in /etc/cron.d/* /var/spool/cron/crontabs/*; do
    if [ -w "$cron_file" ]; then
        echo "[!] $cron_file is writable!"
    fi
done
echo "[+] Cron job check complete."
echo

# Check for writable directories in the PATH
echo "[+] Checking for writable directories in PATH..."
for dir in $(echo $PATH | tr ":" "\n"); do
    if [ -w "$dir" ]; then
        echo "[!] Writable directory in PATH: $dir"
    fi
done
echo "[+] Writable PATH directories check complete."
echo

# Check kernel version for known vulnerabilities (optional)
echo "[+] Checking kernel version..."
uname -r
echo "Consider searching for known exploits for this kernel version at https://www.exploit-db.com/"
echo "[+] Kernel check complete."
echo

echo "================ PrivCheck Complete ==================="
