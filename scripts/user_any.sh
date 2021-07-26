#!/bin/sh

cd $HOME

echo "setup vim environment..."
rm -rf ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 1>/dev/null 2>&1
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.vimrc -o ~/.vimrc
yes "" | vim -c 'PluginInstall' -c 'qa!' 1>/dev/null 2>&1

ZSH=
rm -rf $HOME/.oh-my-zsh
curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template" -o .zshrc
echo "y" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/1' $HOME/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-completions zsh-autosuggestions)/1' $HOME/.zshrc
echo $1 | chsh -s $(which zsh)
echo "autoload -U compinit && compinit" | zsh

mkdir -p $HOME/.config/alacritty
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/alacritty.yml -o $HOME/.config/alacritty/alacritty.yml

mkdir -p $HOME/.config/sxhkd
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sxhkdrc -o $HOME/.config/sxhkd/sxhkdrc
chmod 644 $HOME/.config/sxhkd/sxhkdrc

mkdir -p $HOME/.config/bspwm
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/bspwmrc -o $HOME/.config/bspwm/bspwmrc
chmod 755 $HOME/.config/bspwm/bspwmrc
