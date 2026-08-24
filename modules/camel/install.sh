#!/usr/bin/env bash
set -e

# Fix user home directory (workspace-base sets it to /projects, which is a PVC mount)
mkdir -p /home/user
chown 1000:1000 /home/user
chmod 755 /home/user
usermod -d /home/user user
cp /etc/skel/.bashrc /home/user/.bashrc
chown 1000:1000 /home/user/.bashrc
mkdir -p /etc/bashrc.d
echo "export PS1='\W \`git branch --show-current 2>/dev/null | sed -r -e \"s@^(.+)@\(\1\) @\"\`\$ '" > /etc/bashrc.d/custom_prompt.sh
chmod 644 /etc/bashrc.d/custom_prompt.sh

# Install Camel CLI to a non-PVC location
export HOME=/opt/camel
curl -fsSL https://camel.apache.org/install.sh | sh
chmod -R a+r /opt/camel/.local/share/camel-cli
ln -s /opt/camel/.local/bin/camel /usr/local/bin/camel
camel version
