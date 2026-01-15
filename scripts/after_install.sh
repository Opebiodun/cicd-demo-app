#!/bin/bash
echo "Installation complete, setting permissions..."
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html