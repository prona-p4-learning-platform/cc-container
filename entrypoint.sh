#!/bin/bash

echo "Starting cc-container..."
echo

echo "Checking for KUBECONFIG..."
if [ -n "$KUBECONFIG_BASE64" ]; then
  echo "Decoding KUBECONFIG_BASE64..."
  mkdir -p /home/p4/.kube
  echo "$KUBECONFIG_BASE64" | base64 -d >/home/p4/.kube/config
  chmod 600 /home/p4/.kube/config
  export KUBECONFIG=/home/p4/.kube/config
  echo "Kubeconfig written to /home/p4/.kube/config"
else
  echo "No KUBECONFIG_BASE64 provided. Skipping kubeconfig setup."
fi

echo "Starting SSH..."
sudo service ssh start
echo "SSH started"

tail -f /dev/null
