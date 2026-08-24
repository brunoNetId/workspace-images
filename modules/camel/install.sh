#!/usr/bin/env bash
set -e

# Fix user home directory (workspace-base sets it to /projects, which is a PVC mount)
mkdir -p /home/user
chown 1000:1000 /home/user
chmod 755 /home/user
usermod -d /home/user user
cp /etc/skel/.bashrc /home/user/.bashrc
chown 1000:1000 /home/user/.bashrc
echo "export PS1='\W \`git branch --show-current 2>/dev/null | sed -r -e \"s@^(.+)@\(\1\) @\"\`\$ '" > /etc/profile.d/custom_prompt.sh
chmod 644 /etc/profile.d/custom_prompt.sh

# Install Camel CLI
export HOME=/home/user
curl -fsSL https://camel.apache.org/install.sh | sh
camel version
camel plugin add forage
chown -R 1000:1000 /home/user/.local
