# Project 1
## Part 1: Local Server Configuration
### 📌 Objectives: Virtualized Server Security Setup

* Configure a **Bridge Network** in virtualization software (e.g., VirtualBox) to allow external network access
* Enable and configure both **SSH** and **FTP** services
* Set up **SSH access using public/private key authentication** for a specific user
* Test **FTP protocol functionality** using an FTP client or command line
* Install a **web server (Apache or Nginx)** and verify it works via a browser
* Set up a **firewall using UFW** (with iptables backend) and test its effectiveness
* Test firewall rules by **denying port 80**, verify web server becomes inaccessible, then **allow port 80** again to restore access
* Install and configure an **Intrusion Detection/Prevention System (Fail2Ban)** to protect services like SSH from brute-force attacks
* Verify Fail2Ban is running correctly and simulates blocking unauthorized attempts

---

### 1. Network Configuration

Configure bridge network settings.
> Go to Settings ➡ Network ➡ Adapter 1 ➡ Attached to: *Bridged Adapter*

### 2. SSH Configuration

Steps for SSH setup with public/private key authentication:

1. Install SSH Server

    ```bash
    sudo apt update
    sudo apt install openssh-server -y
    ```

2. Edit `/etc/ssh/sshd_config`:

    ```bash
    sudo vim /etc/ssh/sshd_config
    ```
    Update or add the following:
    ```ini
    PermitRootLogin no
    PasswordAuthentication no
    ```

3. Generate SSH key pair on client machine:
    
    ```bash
    ssh-keygen -t rsa -b 4096
    ```

4. Set the public key to the server `.ssh/authorized_keys`
5. On server, verify:

    ```bash
    cat /home/secureuser/.ssh/authorized_keys
    ```

6. Verify IP with:

    ```bash
    ip a
    ```

7. Verify SSH connection using key authentication

### 3. FTP Setup

1. Install FTP server (vsftpd):
    
    ```bash
    sudo apt install vsftpd -y
    sudo systemctl enable vsftpd
    sudo systemctl start vsftpd
    ```

2. Edit `/etc/vsftpd.conf`:

    ```bash
    sudo vim /etc/vsftpd.conf
    ```
    Ensure the following:
    ```ini
    write_enable=YES
    local_enable=YES
    chroot_local_user=YES
    anonymous_enable=NO
    ```

3. Restart:

   ```bash
   sudo systemctl restart vsftpd
   ```

5. Check status:

    ```bash
    sudo systemctl status vsftpd
    ```

6. Test FTP connection with a client:

    ```bash
    ftp <server_ip>
    ```

### 4. Web Server Installation

1. Nginx Installation
    
    ```bash
    sudo apt install nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    ```

2. Verify web server is working by accessing `http://<server_ip>`

### 5. Firewall Configuration (UFW)

1. Install UFW:
    
    ```bash
    sudo apt install ufw
    ```
    
2. Configure basic rules:
    
    ```bash
    sudo ufw allow 22
    sudo ufw allow 21
    sudo ufw allow 80
    sudo ufw enable
    ```
    
3. Test firewall by denying port 80:
    
    ```bash
    sudo ufw deny 80
    ```
    
4. Verify website is inaccessible
5. Re-enable port 80:
    
    ```bash
    sudo ufw allow 80
    ```

### 6. Fail2Ban (IDS/IPS) Setup

1. Install Fail2Ban:
    
    ```bash
    sudo apt install fail2ban
    ```

2. Start Fail2Ban:
    
    ```bash
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
    ```

3. Copy configuration file:

   ```bash
   sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   ```

4. Edit `/etc/fail2ban/jail.local`:

    ```bash
    sudo vim /etc/fail2ban/jail.local
    ```
    Ensure the following:
    ```ini
    [sshd]
    enabled = true
    port    = ssh
    filter  = sshd
    logpath = /var/log/auth.log
    maxretry = 3
    ```

5. Restart:

    ```bash
    sudo systemctl restart fail2ban
    ```

6. Check status:

    ```bash
    sudo fail2ban-client status sshd
    ```

7. Test Fail2Ban by attempting multiple failed SSH logins.


## Part 2: Cloud Based Server Configuration

### 📌 Project Exercise: Cloud Server Security Management (AWS)

* Deploy and manage a secure **cloud-based Linux server** (e.g., AWS EC2)
* Use **Linux at an administrator level** to configure system settings and enforce security policies
* Create and manage **user accounts** based on assigned roles (e.g., developer, analyst, admin)
* Set appropriate **file system permissions** and ownership to restrict access based on user responsibilities
* Harden the server and **secure SSH access**, including key-based authentication
* Defend against attacks such as **SSH brute-force attempts** using tools like Fail2Ban (testing without actual brute-forcing)
* Install, configure, and manually manage a **basic HTML-based website** using a web server (Nginx or Apache)
* Ensure all services are secured and monitored, following best practices for **cloud security and access control**

---
