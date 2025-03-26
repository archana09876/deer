#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Ensure the script runs with sudo privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Try: sudo $0"
   exit 1
fi

# Update and install necessary packages
apt update -y
apt install apache2 unzip wget -y

# Ensure Apache is started and enabled on boot
systemctl start apache2
systemctl enable apache2

# Navigate to the web root
cd /var/www/html/

# Remove any existing old files
rm -rf *

# Download the template
wget -O template.zip https://www.tooplate.com/download/2137_barista_cafe

# Extract the template
unzip template.zip

# Move extracted files if inside a subdirectory
if [ -d "2137_barista_cafe" ]; then
    mv 2137_barista_cafe/* .
    rm -rf 2137_barista_cafe
fi

# Clean up unnecessary files
rm -rf template.zip

# Rename the existing index.html if it exists
if [ -f index.html ]; then
    mv index.html index.html.old
fi

sudo mv /var/www/html/index.html.old /var/www/html/index.html

# Set correct ownership and permissions
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Restart Apache to apply changes
systemctl restart apache2

echo "Deployment completed successfully! Your website is now live."