#!/bin/bash

# Ensure Zsh is installed
if ! command -v zsh &> /dev/null; then
  echo "Zsh is not installed. Installing Zsh..."
  sudo apt update && sudo apt install -y zsh
else
  echo "Zsh is already installed."
fi

# Define your preferred theme and plugins
ZSH_THEME="darkblood"
PLUGINS=(git zsh-autosuggestions zsh-syntax-highlighting jsontools dirhistory)

# Download plugins if they don't already exist
echo "Downloading plugins..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
mkdir -p "$ZSH_CUSTOM/plugins"

for plugin in "${PLUGINS[@]}"; do
  case $plugin in
    zsh-autosuggestions)
      if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
      fi
      ;;
    zsh-syntax-highlighting)
      if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
      fi
      ;;
    jsontools)
      if [ ! -d "$ZSH_CUSTOM/plugins/jsontools" ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
        cp -r "$HOME/.oh-my-zsh/plugins/jsontools" "$ZSH_CUSTOM/plugins/jsontools"
      fi
      ;;
    dirhistory)
      if [ ! -d "$ZSH_CUSTOM/plugins/dirhistory" ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
        cp -r "$HOME/.oh-my-zsh/plugins/dirhistory" "$ZSH_CUSTOM/plugins/dirhistory"
      fi
      ;;
  esac
done

# Install Oh My Zsh in non-interactive mode
echo "Installing Oh My Zsh..."
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Apply configuration to .zshrc
ZSHRC_PATH="$HOME/.zshrc"
if [ -f "$ZSHRC_PATH" ]; then
  cp "$ZSHRC_PATH" "$ZSHRC_PATH.backup"  # Backup current .zshrc
fi

echo "Configuring .zshrc..."
cat << EOF > "$ZSHRC_PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="$ZSH_THEME"
plugins=(${PLUGINS[*]})
source \$ZSH/oh-my-zsh.sh
EOF

# Set Zsh as default shell for current user
echo "Setting Zsh as the default shell..."
chsh -s "$(which zsh)" "$USER"

# Verify the default shell
if [ "$(echo $SHELL)" = "$(which zsh)" ]; then
  echo "Zsh has been set as the default shell."
else
  echo "The default shell is currently set to $SHELL."
  echo "Please log out and log back in, or restart your terminal to apply the changes."
fi

echo "Installation complete. Restart your terminal or log out and back in to ensure Zsh is the default shell."

