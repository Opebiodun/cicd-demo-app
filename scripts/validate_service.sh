#!/bin/bash
echo "Validating service..."

# Check if Apache is running
if systemctl is-active --quiet httpd; then
    echo "Apache is running"
    
    # Check if index.html exists
    if [ -f /var/www/html/index.html ]; then
        echo "Application files deployed successfully"
        exit 0
    else
        echo "Error: Application files not found"
        exit 1
    fi
else
    echo "Error: Apache is not running"
    exit 1
fi