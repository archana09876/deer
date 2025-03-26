# Barista Cafe Web Application Deployment

## 📌 Project Overview
This practice project involves setting up an AWS infrastructure and deploying the **Barista Cafe** web application on an EC2 instance. Students will create a custom **VPC** with a **public subnet**, configure an **Internet Gateway (IGW)**, **Network ACL (NACL)**, **Route Table**, and **Security Groups** to ensure proper network access.

## 🏗️ Infrastructure Setup
### 1️⃣ **VPC Configuration**
- **VPC CIDR:** `172.16.0.0/16`
- **Public Subnet CIDR:** `172.16.1.0/24`
- **Internet Gateway (IGW):** Attach to VPC
- **Network ACL (NACL):** Control inbound/outbound traffic
- **Route Table:** Configure for public access via IGW

### 2️⃣ **EC2 Instance Setup**
- **Instance Type:** `t2.micro`
- **AMI:** Amazon Linux 2 / Ubuntu 22.04
- **Security Group:** Allow SSH (port `22`) and HTTP (port `80`)
- **Elastic IP:** Associate with EC2 for public access

## 🌐 Deployment Steps
### **Step 1: Setup VPC and Networking**
1. Create a **VPC** with CIDR `172.16.0.0/16`
2. Create a **Public Subnet** with CIDR `172.16.1.0/24`
3. Attach an **Internet Gateway (IGW)** to the VPC
4. Create a **Route Table**, associate it with the subnet, and add a route to the IGW (`0.0.0.0/0 → IGW`)
5. Configure a **Network ACL (NACL)** to allow HTTP and SSH traffic

### **Step 2: Launch and Configure EC2 Instance**
1. Launch an **EC2 instance** in the public subnet
2. Allow inbound rules for:
   - **SSH:** TCP `22` (for access)
   - **HTTP:** TCP `80` (for web traffic)
3. Assign an **Elastic IP** to the EC2 instance

### **Step 3: Install and Deploy the Web App**
1. **SSH into EC2:**
   ```bash
   ssh -i your-key.pem ec2-user@your-ec2-ip
   ```
2. **Install dependencies:**
   ```bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl start httpd
   sudo systemctl enable httpd
   ```
3. **Download and extract the web app:**
   ```bash
   cd /var/www/html
   sudo curl -O https://www.tooplate.com/download/2137_barista_cafe.zip
   sudo unzip 2137_barista_cafe.zip
   sudo mv 2137_barista_cafe/* .
   sudo rm -rf 2137_barista_cafe 2137_barista_cafe.zip
   ```
4. **Restart Apache:**
   ```bash
   sudo systemctl restart httpd
   ```

## 🎯 Verification
- Access the **Barista Cafe** web application in the browser using the **Elastic IP** of your EC2 instance.
- Example: `http://your-ec2-public-ip`

