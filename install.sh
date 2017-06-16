#!/bin/bash
# Installs vimrc by creating a symlink from homedir towards VimConfig file

if [ -e ~/.vimrc ] || [ -L ~/.vimrc ]; then
    echo "Removing existing vimrc file from homedir..."
    rm ~/.vimrc
fi

echo "Creating symlink..."
ln -s ~/VimConfig/vimrc ~/.vimrc

echo "Installation complete"

