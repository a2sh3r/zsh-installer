export ZSH="/home/$USER/.oh-my-zsh"
# you can add other paths in your $PATH
export PATH=$PATH:/usr/local/go/bin
{ 
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/your_git_key
  ssh-add ~/.ssh/your_another_git_key
} &> /dev/null
# you can run any command you want, for example you can run fastfetch on opening terminal
# fastfetch
ZSH_THEME="darkblood"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting jsontools dirhistory)
source $ZSH/oh-my-zsh.sh
