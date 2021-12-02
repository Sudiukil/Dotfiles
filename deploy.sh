#!/bin/sh

ln -s $PWD/zshrc $HOME/.zshrc
ln -s $PWD/zshenv $HOME/.zshenv
ln -s $PWD/aliases $HOME/.aliases
! [ -L $HOME/.functions ] && ln -s $PWD/zsh-functions $HOME/.functions
ln -s $PWD/gitconfig $HOME/.gitconfig

exit 0
