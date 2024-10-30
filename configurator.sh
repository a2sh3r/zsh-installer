#!/bin/bash

# Define your preferred theme and plugins
ZSH_THEME="darkblood"
PLUGINS=(git zsh-autosuggestions zsh-syntax-highlighting jsontools dirhistory)

# Ensure Oh My Zsh directory exists for the current user
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed for the current user. Please run install-zsh.sh first."
  exit 1
fi

# Download plugins if they don't already exist
echo "Downloading plugins..."
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
        TEMP_DIR=$(mktemp -d)
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$TEMP_DIR"
        cp -r "$TEMP_DIR/plugins/jsontools" "$ZSH_CUSTOM/plugins/jsontools"
        rm -rf "$TEMP_DIR"
      fi
      ;;
    dirhistory)
      if [ ! -d "$ZSH_CUSTOM/plugins/dirhistory" ]; then
        TEMP_DIR=$(mktemp -d)
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$TEMP_DIR"
        cp -r "$TEMP_DIR/plugins/dirhistory" "$ZSH_CUSTOM/plugins/dirhistory"
        rm -rf "$TEMP_DIR"
      fi
      ;;
  esac
done

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

# Start a new Zsh session to apply the configuration
echo "Starting a new Zsh session to apply changes..."
exec zsh
