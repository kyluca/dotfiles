#!/bin/bash

pushd ~/repos/dotfiles

# Copy files (cp is aliased to cp -i by default, use /usr/bin/cp to avoid the interactive prompts)
/usr/bin/cp ~/.bash_aliases ./
/usr/bin/cp ~/.bashrc ./
/usr/bin/cp ~/.gitconfig ./
/usr/bin/cp ~/.inputrc ./
/usr/bin/cp ~/.pdbrc ./
/usr/bin/cp ~/.tmux.conf ./
/usr/bin/cp ~/.Xmodmap ./
/usr/bin/cp ~/.config/pip/pip.conf ./.config/pip/pip.conf
/usr/bin/cp ~/.config/alacritty/alacritty.yml ./.config/alacritty/alacritty.yml

# Copy powerline configs
rsync -avr ~/.config/powerline/ ./.config/powerline

# Copy Sublime Text configs except for Package Control caches, just Package Control settings
rsync -avr --exclude='*Package Control*' ~/.config/sublime-text-3/Packages/User/ ./.config/sublime-text-3/Packages/User
/usr/bin/cp ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings ./.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings

dconf dump /org/gnome/terminal/ > gnome_terminal_settings_backup.txt

popd
