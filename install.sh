#!/bin/bash

# Bootstrap file for my own dotfiles.
# This files is idempotent and unimodal: no matter how many
# times you execute it it will produce the same output.

echo 'Fetch the latest master from dotfiles2'
#git pull origin master

echo 'Simlink the config files to repo versions'
cd dots
for name in .*; do
  if [ "$name" != '.' ] && [ "$name" != '..' ]; then
    target="$HOME/$name"
    if [ -e "$target" ]; then
      if [ ! -L "$target" ]; then
        echo "WARNING: $target exists but is not a symlink. Backing it up!"
        mv $target "$target.backup"
        ln -s "$PWD/$name" "$target"
      fi
    else
      echo "Simlinking $target"
      rm $target
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
cd ..

#echo 'Add wombat color scheme ~/.vim/colors/wombat.vim'
#mkdir -p ~/.vim/colors
#cp ./vim/colors/wombat.vim ~/.vim/colors/wombat.vim

echo 'Install Vundle for VIM'
if [ ! -d ~/.vim/bundle/vundle ]; then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim +BundleInstall +qall

echo 'Install solarized for the terminal'
# Dark
PALETTE="#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
BG_COLOR="#00002B2B3636"
FG_COLOR="#65657B7B8383"

gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "$PALETTE"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "$BG_COLOR"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "$FG_COLOR"
