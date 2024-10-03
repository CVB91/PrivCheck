
# PrivCheck - Privilege Escalation Checker

## Objective
PrivCheck is a Bash script that checks for common privilege escalation vectors on a Linux system. It scans for misconfigurations, weak file permissions, SUID/SGID binaries, and more, allowing system administrators or penetration testers to identify potential security risks.

## Features

### 1. SUID/SGID Binaries:
- Scans the system for binaries with SUID/SGID permissions, which can be exploited to escalate privileges.

### 2. World-Writable Files and Directories:
- Finds files and directories that are world-writable and could potentially be used for privilege escalation.

### 3. Weak Permissions on Sensitive Files:
- Checks the permissions of sensitive files like `/etc/passwd` and `/etc/shadow` to ensure they are not world-readable or writable.

### 4. Cron Job Misconfigurations:
- Detects cron jobs that are owned by root but are writable by other users.

### 5. Writable PATH Directories:
- Identifies directories in the system's PATH that are writable by users, which can allow attackers to hijack system commands.

### 6. Kernel Version Check:
- Displays the system's kernel version and recommends checking for known vulnerabilities associated with it.

## How to Use

1. Clone the repository or save the script to a file called `privcheck.sh`.

2. Make the script executable:
   ```bash
   chmod +x privcheck.sh
   ```

3. Run the script with:
   ```bash
   ./privcheck.sh
   ```

4. Review the output for any potential privilege escalation risks.

## Advanced Use

- You can automate the execution of PrivCheck by adding it to cron for regular scans, or by creating a systemd service to run it periodically.

## Systemd Service Example

1. Create a new service file in `/etc/systemd/system/privcheck.service`:
   ```bash
   sudo nano /etc/systemd/system/privcheck.service
   ```

2. Add the following content:
   ```ini
   [Unit]
   Description=PrivCheck - Privilege Escalation Checker

   [Service]
   ExecStart=/path/to/privcheck.sh
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

3. Reload the systemd daemon and enable the service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable privcheck.service
   ```

4. Start the service:
   ```bash
   sudo systemctl start privcheck.service
   ```

## License
This project is licensed under the MIT License.
