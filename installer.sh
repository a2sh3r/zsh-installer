#!/bin/bash

# Ensure Zsh is installed
if ! command -v zsh &> /dev/null; then
  echo "Zsh is not installed. Installing Zsh..."
  sudo apt update && sudo apt install -y zsh
else
  echo "Zsh is already installed."
fi

# Install Oh My Zsh interactively
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installation complete. Please run 'configure-zsh.sh' to apply plugins and theme."
