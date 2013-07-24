#!/bin/bash

# Bootstrap file for my own dotfiles.
# This files is idempotent and unimodal: no matter how many
# times you execute it it will produce the same output.

echo 'Fetch the latest master from dotfiles2'
git pull origin master

echo 'Simlink the config files to repo versions'
cd dots
for name in .*; do
  if [ "$name" != '.' ] && [ "$name" != '..' ]; then
    target="$HOME/$name"
    if [ -e "$target" ]; then
      if [ ! -L "$target" ]; then
        echo "WARNING: $target exists but is not a symlink."
      fi
    else
      echo "Simlinking $target"
      rm $target
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
cd ..

echo 'Add wombat color scheme ~/.vim/colors/wombat.vim'
mkdir -p ~/.vim/colors
cp ./vim/colors/wombat.vim ~/.vim/colors/wombat.vim

echo 'Install Vundle for VIM'
if [ ! -d ~/.vim/bundle/vundle ]; then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim +BundleInstall +qall
