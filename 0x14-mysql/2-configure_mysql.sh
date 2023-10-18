#!/usr/bin/env bash
# This script configures MySQL and checks its status

# Enable and start MySQL service
sudo systemctl enable mysql
sudo systemctl start mysql

# Check MySQL status
mysql --version
