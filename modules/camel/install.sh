#!/usr/bin/env bash
set -e
export HOME=/opt/camel
curl -fsSL https://camel.apache.org/install.sh | sh
chmod -R a+r /opt/camel/.local/share/camel-cli
ln -s /opt/camel/.local/bin/camel /usr/local/bin/camel
camel version
