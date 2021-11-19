#!/bin/sh

ln -s $PWD/zshrc $HOME/.zshrc
ln -s $PWD/aliases $HOME/.aliases
! [ -L $HOME/.functions ] && ln -s $PWD/zsh-functions $HOME/.functions
ln -s $PWD/envrc $HOME/.envrc
ln -s $PWD/gitconfig $HOME/.gitconfig
ln -s $PWD/zshenv $HOME/.zshenv

exit 0
