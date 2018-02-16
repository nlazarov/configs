#!/bin/bash

#install the build dependencies for vim
sudo apt-get build-dep vim
sudo apt-get install libncurses5-dev libncursesw5-dev python-dev python3-dev cmake
sudo apt-get install libx11-dev libxtst-dev

sudo apt-get remove -y vim vim-runtime gvim

cd ~
git clone git@github.com:vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp=dynamic \
            --enable-python3interp=dynamic \
            --enable-perlinterp \
            --enable-gtk2-check \
            --enable-gnome-check \
            --enable-gui=auto \
            --enable-cscope \
            --prefix=/usr \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \

make VIMRUNTIMEDIR=/usr/share/vim/vim80
sudo make install

#make default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
