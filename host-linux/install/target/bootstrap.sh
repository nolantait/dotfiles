# Sets up a new machine to be ssh-able from a live ISO

KEYS_URL="https://github.com/nolantait.keys"

set -euo pipefail # Exit on error

echo "Installing openssh"
pacman -Sy openssh

echo "Starting sshd"
systemctl start sshd

echo "Disabling password authentication"
if ! grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    systemctl restart sshd
    echo "Password authentication disabled."
else
    echo "SSH password authentication is already disabled."
fi

echo "Installing keys"
mkdir -p ~/.ssh
curl $KEYS_URL >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo "Keys installed"
