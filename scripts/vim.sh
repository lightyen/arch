#!/bin/sh

echo "setup vim environment..."
rm -rf ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 1>/dev/null 2>&1
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.vimrc -o ~/.vimrc
yes | vim -c 'PluginInstall' -c 'qa!' 1>/dev/null 2>&1