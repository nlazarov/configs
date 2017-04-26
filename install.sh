#!/bin/bash

#remap CAPS LOCK to Ctrl key
if test $(which setxkbmap); then
	setxkbmap -option caps:ctrl_modifier
fi

[ ! -e ~/.dotfiles/vim.ln/backup ] && mkdir -p ~/.dotfiles/vim.ln/backup

# creating symlinks
echo "Setting up config symlinks"
linkables=$( find -H ~/.dotfiles -name "*.ln" )
for file in $linkables ; do
    bsname=$(basename $file ".ln")
    target="$HOME/.$bsname"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Symlink for $file"
        ln -s $file $target
    fi
done

