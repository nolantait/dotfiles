#!/usr/bin/env bash

set -euo pipefail

# Function to handle errors
handle_error() {
    echo "Error on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

TARGET=$1
TARGET_FILES=$HOME/dotfiles/host-linux/install/target
HOST_FILES=$HOME/dotfiles/host-linux/install/host
USERNAME=nolan

echo "Copying files to $TARGET machine"
scp -r "$TARGET_FILES" "root@$TARGET:~"
echo "Files copied"

ssh "root@$TARGET" "cd ~/target && chmod +x ./*.sh && . ./install-arch.sh && reboot"

# Remove known hosts entry for the target machine
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$TARGET"

echo "Waiting for the target machine to reboot"

sleep 30

echo "Installing initial user..."
"$HOST_FILES/install-root.sh" $USERNAME "root@$TARGET"

echo "Installing user..."
"$HOST_FILES/install-user.sh" "$USERNAME@$TARGET"

echo "Done"
