#!/usr/bin/env bash
set -e

set -x
rm -rf ~/.vim
rm -f ~/.vimrc

cp vimrc ~/.vimrc

mkdir -p ~/.vim/colors
cp mouse.vim ~/.vim/colors/

mkdir -p ~/.vim/bundle && \
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall

#  YouCompleteMe install
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.sh --clang-completer
