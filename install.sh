#!/usr/bin/env bash
set -euo pipefail

# Simple installer for zsh-chatgpt
REPO_URL="https://github.com/youruser/zsh-chatgpt"
DEST="$HOME/.zsh-chatgpt"

# Remove any existing installation
if [ -d "$DEST" ]; then
  rm -rf "$DEST"
fi

# Clone repository
git clone "$REPO_URL" "$DEST"

# Add source line to .zshrc if not already present
if ! grep -q "source $DEST/chatgpt.plugin.zsh" "$HOME/.zshrc"; then
  echo "source $DEST/chatgpt.plugin.zsh" >> "$HOME/.zshrc"
fi

echo "zsh-chatgpt installed. Please restart your shell."
