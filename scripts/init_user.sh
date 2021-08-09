#!/bin/sh

set -e

window_install() {
	git clone https://github.com/lightyen/arch.git $HOME/arch
	mkdir -p $HOME/.config
	cp -r $HOME/arch/user_config/* $HOME/.config
	chmod 644 $HOME/.config/sxhkd/sxhkdrc
	chmod 755 $HOME/.config/bspwm/bspwmrc
	rm -rf $HOME/arch
}

ohmyzsh_install() {
	rm -rf $HOME/.oh-my-zsh
	echo "y" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/1' $HOME/.zshrc
	sed -i 's/plugins=(git)/plugins=(git zsh-completions zsh-autosuggestions)/1' $HOME/.zshrc
	echo "autoload -U compinit && compinit" | zsh
}

vim_install() {
	rm -rf $HOME/.vim
	echo "vim vundle..."
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim 1>/dev/null 2>&1
	curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.vimrc -o $HOME/.vimrc
	vim +PluginInstall +qa! 1>/dev/null 2>&1
}

case "$1" in
    window) window_install ;;
    ohmyzsh) ohmyzsh_install ;;
    vim) vim_install ;;
    *) ;;
esac
