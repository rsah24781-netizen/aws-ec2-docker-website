# AWS EC2 Docker Website Hosting — Mini Project

## Objective
Deploy a static website to an AWS EC2 Linux instance using Docker and Nginx.

## Project files
- `index.html` — sample website.
- `Dockerfile` — builds an Nginx image and copies the website into it.
- `.dockerignore` — excludes unnecessary files from the build context.
- `deploy.sh` — builds the image and starts/replaces the container.
- `README.md` — this guide.

## Architecture
Browser → EC2 Public IPv4 address:8080 → Docker port mapping 8080:80 → Nginx container → index.html

## Prerequisites
- AWS account with permission to create EC2 and security groups.
- An EC2 instance running Amazon Linux 2023 (recommended for this guide).
- SSH access to the instance.
- Docker installed and running.

## 1. Launch an EC2 instance
1. Open AWS Console → EC2 → Launch instance.
2. Name it `docker-website-demo`.
3. Select Amazon Linux 2023.
4. For a learning demo, choose an eligible small instance type within your budget/free-tier eligibility.
5. Create or select a key pair and keep the private key secure.
6. In the security group, allow SSH (TCP 22) only from **My IP**.
7. Add a custom inbound rule for TCP port `8080` from `0.0.0.0/0` only if you intend the demo website to be public. For real deployments, restrict access as appropriate.
8. Launch the instance and note its Public IPv4 address.

## 2. Connect over SSH
From a terminal on your computer (replace the key path and public IP):

```bash
chmod 400 my-key.pem
ssh -i my-key.pem ec2-user@YOUR_EC2_PUBLIC_IP
```

Do not upload your private key to GitHub or share it.

## 3. Install and start Docker (Amazon Linux 2023)
Run on the EC2 instance:

```bash
sudo dnf update -y
sudo dnf install -y docker git
sudo systemctl enable --now docker
sudo docker --version
sudo docker ps
```

For simplicity and least-privilege awareness, use `sudo docker ...` commands. You can configure non-root Docker access separately, but membership in the `docker` group effectively grants root-level control.

## 4. Get the project files onto EC2
Option A — create files directly on EC2: create a folder and use a text editor to create `index.html`, `Dockerfile`, `.dockerignore`, and `deploy.sh` using the contents supplied in this project.

Option B — after uploading this project to your own Git repository, clone it:

```bash
git clone YOUR_PUBLIC_REPOSITORY_URL
cd aws-ec2-docker-website-mini-project
```

Do not use a placeholder URL; replace it with your actual repository URL.

## 5. Deploy
From the folder containing `Dockerfile` and `index.html`:

```bash
chmod +x deploy.sh
sudo ./deploy.sh
```

Or run the Docker commands manually:

```bash
sudo docker build -t aws-ec2-website:v1 .
sudo docker run -d --restart unless-stopped --name aws-ec2-website -p 8080:80 aws-ec2-website:v1
sudo docker ps
curl http://localhost:8080
```

If the container name already exists, remove it before running the manual command again:

```bash
sudo docker rm -f aws-ec2-website
```

## 6. Open the website
In your browser, visit:

`http://YOUR_EC2_PUBLIC_IP:8080`

Replace the placeholder with the instance's actual Public IPv4 address. The EC2 security group must allow inbound TCP 8080, and the instance must have a reachable public IPv4 address and route.

## 7. Troubleshooting
```bash
sudo docker ps -a
sudo docker logs aws-ec2-website
sudo ss -tulnp
curl -I http://localhost:8080
```

- Browser timeout: verify EC2 public IPv4, internet route, and security-group TCP 8080 rule.
- Container exits: inspect `sudo docker logs aws-ec2-website`.
- Port conflict: use `HOST_PORT=8081 sudo -E ./deploy.sh` or edit the script/commands to map `8081:80`, and allow TCP 8081 in the security group.
- SSH failure: confirm the key pair, username `ec2-user`, and SSH source-IP rule.

## Security and cost cleanup
- Do not open SSH (22) to everyone (`0.0.0.0/0`).
- Port 8080 is exposed publicly in this demo; for production, use HTTPS, a domain, and a properly configured reverse proxy/load balancer.
- AWS charges may apply while resources are running, depending on your account and region.
- When finished, stop or terminate the EC2 instance if you no longer need it, and remove unused resources. Termination deletes the instance's local data unless separately preserved.

