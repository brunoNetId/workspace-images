#!/usr/bin/env bash
set -e

# Make /home/user writable for UID 1000 (required for VS Code terminal)
chown 1000:1000 /home/user
chmod 755 /home/user

# Install Camel CLI to a non-PVC location
export HOME=/opt/camel
curl -fsSL https://camel.apache.org/install.sh | sh
chmod -R a+r /opt/camel/.local/share/camel-cli
ln -s /opt/camel/.local/bin/camel /usr/local/bin/camel
camel version
