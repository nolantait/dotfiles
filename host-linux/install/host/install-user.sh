#!/bin/bash

set -euo pipefail

# Function to handle errors
handle_error() {
    echo "Error on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

TARGET=$1

{
  echo "Setting up root on target..."
  ssh -t $TARGET "cd ~/target && chmod +x ./*.sh && . ./init-user.sh"
}  >> ~/install-script.log 2>&1
