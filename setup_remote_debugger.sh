#!/bin/bash

DEST="$HOME/Library/xcodebuild.nvim"
SOURCE="$HOME/.local/share/nvim/lazy/xcodebuild.nvim/tools/remote_debugger"
ME="$(whoami)"

echo "Installing remote_debugger script..."
sudo install -d -m 755 -o root "$DEST"
sudo install -m 755 -o root "$SOURCE" "$DEST"
sudo bash -c "echo \"$ME ALL = (ALL) NOPASSWD: $DEST/remote_debugger\" >> /etc/sudoers"

echo "Done! Remote debugger installed and secured."
