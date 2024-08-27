#!/bin/bash
# Update the system and install necessary tools
yum update -y
yum install -y gcc openssl-devel bzip2-devel libffi-devel wget make

# Install Python 3.9 (or another version if desired)
yum install -y python39

# Install Django using pip
pip3 install django

# Install PHP and necessary extensions
yum install -y php php-cli php-fpm php-mysqlnd php-xml php-mbstring php-json php-gd php-opcache php-curl

# Enable and start the PHP FPM service
systemctl enable php-fpm
systemctl start php-fpm

# Install and configure a web server (e.g., Apache)
yum install -y httpd

# Enable and start the Apache HTTP server
systemctl enable httpd
systemctl start httpd

# Open HTTP and HTTPS ports in the firewall
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# Install any additional tools needed
yum install -y git

# Install PostgreSQL client if needed to connect to the Cloud SQL instance
yum install -y postgresql

# Install Node.js and npm
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Verify Node.js and npm installation
node -v
npm -v

# Install global Node.js packages if needed (optional)
# npm install -g some-global-package

# Final system update
yum update -y
