#!/bin/bash

#install the build dependencies for vim
sudo apt-get build-dep vim
sudo apt-get install libncurses5-dev libncursesw5-dev python-dev python3-dev cmake
sudo apt-get install libx11-dev libxtst-dev

sudo apt-get remove -y vim vim-runtime gvim vim-gnome

cd ~
git clone git@github.com:vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-python3interp=yes \
            --enable-perlinterp \
            --enable-gnome-check \
            --enable-gui=auto \
            --enable-cscope \
            --host="$HOST" \
            --prefix="$CONDA_PREFIX" \

make VIMRUNTIMEDIR=/usr/share/vim/vim81
sudo make install

#make default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
