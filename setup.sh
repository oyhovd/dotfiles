#!/bin/sh

#su
#adduser oyho sudo
#git clone https://github.com/oyhovd/dotfiles.git

last_invalid()
{
  if [ $? -ne 0 ]; then
    echo "Last command failed. Press ENTER to continue or Ctrl-C to quit."
    read DUMMY
  fi
}

cd $HOME
last_invalid

#install dependencies necessary for the installers in this file
sudo apt-get -y install zsh vim ctags curl
last_invalid

#zsh and oh-my-zsh setup if not already done
if ! [ -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  last_invalid
  ln -s $HOME/dotfiles/oyho.zsh-theme $HOME/.oh-my-zsh/themes/
  last_invalid
  mv $HOME/.zshrc $HOME/.zshrc_old
  last_invalid
  ln -s $HOME/dotfiles/debian_common.zshrc $HOME/.zshrc
  last_invalid
fi

#vim setup
if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  last_invalid
  ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
  last_invalid
  mkdir -p $HOME/.vim/swapfiles
  last_invalid
fi

#Run PluginInstall in vim
vim +PluginInstall +qall
last_invalid
vim +PluginClean +qall
last_invalid

#utils
mkdir -p $HOME/bin
last_invalid
ln -s $HOME/dotfiles/utils/* $HOME/bin/
last_invalid

#git setup
git config --global core.excludesfile $HOME/dotfiles/gitignore_global
last_invalid
git config --global core.editor "vim"
last_invalid

#For GDB dashboard:
wget -P ~ git.io/.gdbinit
#(or git clone https://github.com/cyrus-and/gdb-dashboard.git and symlink it)
last_invalid


#other installs
sudo apt-get -y install terminator python-dev python-pip python3-dev python3-pip
last_invalid
pip install thefuck
last_invalid
pip install matplotlib
last_invalid

#copy all config files
#first create all folders
cd dotfiles
last_invalid
find .config -type d -exec mkdir -p {} $HOME/{} \;
last_invalid
for file in find .config -type f; do
  ln -s $file $HOME/$file
  last_invalid
done
cd ..

#cleanup
sudo apt-get clean
last_invalid

echo "Setup done"

