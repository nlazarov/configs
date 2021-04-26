#!/usr/bin/env bash

#remap CAPS LOCK to Ctrl key
if test "$(which setxkbmap)"; then
	setxkbmap -option caps:ctrl_modifier
fi

[ ! -e ~/.dotfiles/vim.ln/backup ] && mkdir -p ~/.dotfiles/vim.ln/backup

# creating symlinks
echo "Setting up config symlinks"
linkables=$( find -H ~/.dotfiles -name "*.ln" )
for file in $linkables ; do
    bsname=$(basename "$file" ".ln")
    target="$HOME/.$bsname"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Symlink for $file"
        ln -s "$file" "$target"
    fi
done

# symlinks in $HOME/.config
DOTS_CONFIG="$HOME/.config"
[ ! -d "$DOTS_CONFIG" ] && mkdir -p "$DOTS_CONFIG"

for file in "$0"/config.home/*; do
  [ ! -e "$DOTS_CONFIG/$file" ] && ln -s "$0/config.home/$file" "$DOTS_CONFIG/$file"
done

NVIM_SHARE_SITE="$HOME"/.local/share/nvim/site
mkdir -p $NVIM_SHARE_SITE
ln -s "$0/vim.ln/autoload" "$NVIM_SHARE_SITE/autoload"

[ ! -e ~/.fonts ] && git clone git@github.com:powerline/fonts ~/.fonts
cd ~/.fonts && ./install.sh
