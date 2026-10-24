# AWS EC2 Website Deployment Using Apache Web Server

## Project Overview

This project demonstrates the deployment of a static eCommerce website on an Amazon Web Services (AWS) EC2 instance using the Apache2 Web Server.

The objective of this project was to provision an Ubuntu Linux server, configure network security, install and configure Apache2, securely transfer website files, and host the website using the EC2 instance's public IPv4 address.

## Technologies Used

| Technology | Purpose |
|---|---|
| AWS EC2 | Cloud server hosting |
| Ubuntu Linux | Server operating system |
| Apache2 | Web server |
| AWS Security Groups | Network traffic management |
| SSH | Secure server access |
| SCP | Secure file transfer |
| Linux Commands | File and server management |

## Project Architecture

```text
Local Machine
     |
     | SCP (Website ZIP File)
     v
AWS EC2 Instance (Ubuntu Linux)
     |
     v
Apache2 Web Server
     |
     v
/var/www/html/
     |
     | HTTP Port 80
     v
EC2 Public IPv4 Address
     |
     v
Zay eCommerce Website
```

## EC2 Instance Configuration

| Parameter | Configuration |
|---|---|
| Cloud Provider | AWS |
| Instance Name | web-hosting-mini-project |
| Operating System | Ubuntu Linux |
| Instance Type | t3.micro |
| Key Pair | xyz-key-ec2.pem |
| Web Server | Apache2 |
| HTTP Port | 80 |
| SSH Port | 22 |
| Document Root | /var/www/html/ |

## Step-by-Step Deployment Process

### Step 1: Launch AWS EC2 Instance

1. Logged in to the AWS Management Console.
2. Navigated to EC2 → Launch Instance.
3. Entered the instance name `web-hosting-mini-project`.
4. Selected Ubuntu Linux as the operating system.
5. Selected `t3.micro` as the instance type.
6. Configured the SSH key pair `xyz-key-ec2.pem`.
7. Launched the EC2 instance.

### Step 2: Configure Security Group

Configured the Security Group inbound rules to allow HTTP and SSH traffic.

| Rule Type | Protocol | Port |
|---|---|---|
| SSH | TCP | 22 |
| HTTP | TCP | 80 |

HTTP traffic allows users to access the hosted website through a web browser.

### Step 3: Connect to EC2 Instance

Connected to the Ubuntu EC2 instance using AWS EC2 Instance Connect.

After establishing the connection, accessed the Linux terminal to perform server configuration.

### Step 4: Install Apache2 Web Server

Updated the Ubuntu package repository:

```bash
sudo apt update
```

Installed Apache2:

```bash
sudo apt install apache2 -y
```

Verified Apache installation:

```bash
sudo systemctl status apache2
```

**Result:** Apache2 Web Server was successfully installed.

### Step 5: Transfer Website Files Using SCP

Transferred the Zay eCommerce website ZIP file from the local machine to the EC2 instance using Secure Copy Protocol (SCP).

Example command:

```bash
scp -i xyz-key-ec2.pem "website.zip" ubuntu@<PUBLIC-IP>:/home/ubuntu/
```

SCP provides secure file transfer between the local machine and the remote EC2 server.

### Step 6: Extract Website Files

Installed the unzip utility:

```bash
sudo apt install unzip -y
```

Extracted the website ZIP archive:

```bash
unzip website.zip
```

Verified the extracted project files:

```bash
ls -la
```

**Result:** The website files were extracted on the Ubuntu EC2 instance.

### Step 7: Deploy Website Using Apache

Navigated to the Apache document root:

```bash
cd /var/www/html/
```

Removed the default Apache index page:

```bash
sudo rm index.html
```

Copied the website project files into the Apache document root.

Example command when running inside the extracted website folder:

```bash
sudo cp -r . /var/www/html/
```

**Explanation:**

Removed the default Apache `index.html` file and copied the website project files into `/var/www/html/` to serve the custom eCommerce website.

The website's main `index.html` file must be located directly inside the Apache document root.

### Step 8: Verify Website Deployment

1. Opened a web browser.
2. Entered the EC2 instance's public IPv4 address.
3. Accessed the website using HTTP.

```text
http://<EC2-PUBLIC-IP>
```

4. Verified that the Zay eCommerce website loaded successfully.

**Result:** The website was successfully accessible through the EC2 public IPv4 address.

## Common Troubleshooting

| Issue | Possible Solution |
|---|---|
| Website not loading | Check HTTP port 80 in Security Groups |
| SSH connection failed | Verify key pair and SSH access |
| Apache not running | Check `sudo systemctl status apache2` |
| Website showing default page | Verify the custom index.html file |
| Permission denied | Check file and directory permissions |
| SCP transfer failed | Verify key path, public IP and SCP syntax |

## Project Outcome

Successfully deployed and hosted a static Zay eCommerce website on an AWS EC2 Ubuntu instance using Apache2 Web Server.

The website was accessible through the EC2 public IPv4 address over HTTP.

## Skills Demonstrated

- AWS EC2 instance provisioning
- Ubuntu Linux administration
- Apache2 web server installation and configuration
- AWS Security Group configuration
- SSH and SCP operations
- Linux file management
- Static website deployment
- Cloud infrastructure fundamentals
- Basic deployment troubleshooting

## Conclusion

This project provided hands-on experience with AWS cloud infrastructure, Linux server administration, Apache Web Server configuration, secure file transfer, and static website deployment.

It demonstrates the practical process of hosting a web application on an AWS EC2 instance and making it publicly accessible through HTTP.
