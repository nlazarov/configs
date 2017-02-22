#!/bin/bash

#install the build dependencies for vim
sudo apt-get build-dep vim

sudo apt-get remove -y vim vim-runtime gvim

cd ~
git clone git@github.com:vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --enable-python3interp \
            --enable-perlinterp \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim80
sudo make install

#make default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
