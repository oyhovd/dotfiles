#su
#adduser oyho sudo
#git clone https://github.com/oyhovd/dotfiles.git

cd $HOME
#install dependencies necessary for the installers in this file
sudo apt-get -y install zsh vim ctags curl

#zsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s $HOME/dotfiles/oyho.zsh-theme $HOME/.oh-my-zsh/themes/
mv $HOME/.zshrc $HOME/.zshrc_old
ln -s $HOME/dotfiles/debian_common.zshrc $HOME/.zshrc

#vim setup
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Run PluginInstall in vim
vim +PluginInstall +qall
vim +PluginClean +qall

#utils
mkdir -p $HOME/bin
ln -s $HOME/dotfiles/utils/* $HOME/bin/

#git setup
git config --global core.excludesfile $HOME/dotfiles/gitignore_global


#For GDB dashboard:
wget -P ~ git.io/.gdbinit
#(or git clone https://github.com/cyrus-and/gdb-dashboard.git and symlink it)


#other installs
sudo apt-get -y install terminator python-dev python-pip python3-dev python3-pip
pip install thefuck
