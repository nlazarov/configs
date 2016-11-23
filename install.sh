#!/bin/sh

#remap CAPS LOCK to Ctrl key
if test $(which setxkbmap); then
	setxkbmap -option caps:ctrl_modifier
fi

# creating symlinks
echo "Setting up config symlinks"
linkables=$( find -H ~/.dotfiles -type f -name *.ln )
for file in $linkables ; do
    target="$HOME/.$( basename $file ".ln" )"
    if [ -e $target ]; then
        echo "~${$target#$HOME} already exists... Skipping."
    else
        echo "Symlink for $file"
        ln -s $file $target
    fi
done

