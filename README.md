# myzsh
oh-my-zsh auto-configurator with commonly used plugins

# Zsh installation

## Ubuntu
```bash
sudo apt-get install zsh
```

## OpenSUSE
```bash
sudo zypper install zsh 
```

# Install Oh My Zsh interactively 
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# Activate configuration and plugin download
```bash
git clone https://github.com/a2sh3r/zsh-installer.git
cd zsh-installer
sudo chmod +x configurator.sh
./configurator.sh
```
# Post-install 
You can clone .zashrc file in yours ~/
```bash
cp .zshrc ~/
```
