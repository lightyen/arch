#!/bin/sh
# autoload -U compinit && compinit

curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template" -o .zshrc
yes "" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/1' $HOME/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-completions zsh-autosuggestions)/1' $HOME/.zshrc
chsh -s $(which zsh)
