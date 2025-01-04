#!/bin/bash

echo "Starting cc-container..."
echo
echo "Starting SSH..."
sudo service ssh start
echo "SSH started"

tail -f /dev/null
