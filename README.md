# Project 1
## Part 1

### Bridge Network Setup Documentation

#### 1. Network Configuration

Configure bridge network settings.
> Go to Settings → Network → Adapter 1 → Attached to: *Bridged Adapter*

#### 2. SSH Configuration

Steps for SSH setup with public/private key authentication:

1. Install SSH Server

    ```bash
    sudo apt update
    sudo apt install openssh-server -y
    ```

2. Edit `/etc/ssh/sshd_config`:

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

#### 3. FTP Setup

1. Install FTP server (vsftpd):
    
    ```bash
    sudo apt install vsftpd -y
    sudo systemctl enable vsftpd
    sudo systemctl start vsftpd
    ```

2. Check status:

    ```bash
    sudo systemctl status vsftpd
    ```
3. Test FTP connection with a client:

    ```bash
    ftp <server_ip>
    ```

### 4. Web Server Installation

1. Nginx Installation
    
    ```bash
    sudo apt install nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
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
    sudo systemctl start fail2ban
    sudo systemctl enable fail2ban
    ```

3. Check status:

    ```bash
    sudo fail2ban-client status sshd
    ```

4. Test Fail2Ban by attempting multiple failed SSH logins.
