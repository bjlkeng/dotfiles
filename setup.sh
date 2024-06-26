#!/bin/bash

params="-sf"

while getopts "vib" args; do
    case $args in
        v)
            params="$params -v"
            ;;
        i)
            params="$params -i"
            ;;
        b)
            params="$params -b"
            ;;
    esac
done

# Store where the script was called from so we can reference it later
script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update bash-it if it's already installed or download it if it's not
# if [ -d $HOME/.bash_it ]; then
#   cd $HOME/.bash_it
#   git pull
# else
#   git clone --depth=1 https://github.com/Bash-it/bash-it.git $HOME/.bash_it
# fi

# Add our custom aliases to bash-it
# ln $params $script_home/custom.aliases.bash $HOME/.bash_it/aliases/custom.aliases.bash

# Add solarized colors for vim if not present
if [ ! -f $HOME/.vim/colors/solarized.vim ]; then
    curl -fLo $HOME/.vim/colors/solarized.vim --create-dirs \
    https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
fi

# Add restructured text highlighting for vim if not present
if [ -d $HOME/.vim/syntax ] && [ ! -f $HOME/.vim/syntax/rst.vim ]; then
    cp rst.vim $HOME/.vim/syntax/rst.vim
    #curl -fLo $HOME/.vim/syntax/rst.vim --create-dirs \
    #https://raw.githubusercontent.com/marshallward/vim-restructuredtext/master/syntax/rst.vim
fi

# Symlink all of our dotfiles to the home directory
mkdir -p $HOME/.config
for i in .vimrc .gvimrc .dircolors .bashrc .bash_profile .config/flake8 .pylintrc .ctags ;
do
  ln $params $script_home/$i $HOME/$i
done
