#!/bin/bash

# Update the package list to ensure we get the latest version of the packages
sudo apt-get update

# Install Nginx, a popular web server
sudo apt-get -y install nginx

# Allow HTTP traffic through the firewall for Nginx
sudo ufw allow 'Nginx HTTP'

# Create the required directory structure
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/

# Create a directory for a test release and add an HTML file for testing
sudo mkdir -p /data/web_static/releases/test/
echo "<html>
        <head>
        </head>
        <body>
        Holberton School
        </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link from the test release directory to a 'current' directory
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ directory to the 'ubuntu' user and group
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content of the 'current' directory
sudo sed -i '/listen 80 default_server;/a \\\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart Nginx to apply the changes
sudo service nginx restart

