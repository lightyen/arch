#!/bin/sh

cd $HOME

echo "vim environment..."
rm -rf $HOME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim 1>/dev/null 2>&1
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.vimrc -o $HOME/.vimrc
echo "y" | vim -c 'PluginInstall' -c 'qa!' 1>/dev/null 2>&1

ZSH=
rm -rf $HOME/.oh-my-zsh
echo "y" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/1' $HOME/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-completions zsh-autosuggestions)/1' $HOME/.zshrc
echo "autoload -U compinit && compinit" | zsh

mkdir -p $HOME/.config/alacritty
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/alacritty.yml -o $HOME/.config/alacritty/alacritty.yml

mkdir -p $HOME/.config/sxhkd
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sxhkdrc -o $HOME/.config/sxhkd/sxhkdrc
chmod 644 $HOME/.config/sxhkd/sxhkdrc

mkdir -p $HOME/.config/bspwm
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/bspwmrc -o $HOME/.config/bspwm/bspwmrc
chmod 755 $HOME/.config/bspwm/bspwmrc

fcitx
sed -i 's/^#Font=Sans/Font=Noto Sans CJK TC/1' $HOME/.config/fcitx/conf/fcitx-classic-ui.config
sed -i 's/^#MenuFont=Sans/MenuFont=Noto Sans Mono CJK TC/1' $HOME/.config/fcitx/conf/fcitx-classic-ui.config
sed -i 's/^#FontLocale=zh_CN.UTF-8/FontLocale=zh_TW.UTF-8/1' $HOME/.config/fcitx/conf/fcitx-classic-ui.config
sed -i 's/^#SkinType=default/SkinType=dark/1' $HOME/.config/fcitx/conf/fcitx-classic-ui.config
sed -i 's/^#SelectionKey=1234567890/SelectionKey=asdfghjkl;/1' $HOME/.config/fcitx/conf/fcitx-classic-ui.config
