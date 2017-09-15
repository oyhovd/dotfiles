#su
#adduser oyho sudo
#git clone https://github.com/oyhovd/dotfiles.git

cd $HOME
#install dependencies necessary for the installers in this file
sudo apt-get install zsh vim ctags curl

#zsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s $HOME/dotfiles/oyho.zsh-theme $HOME/.oh-my-zsh/themes/
mv $HOME/.zshrc $HOME/.zshrc_old
ln -s $HOME/dotfiles/debian_common.zshrc $HOME/.zshrc

#vim setup
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Run PluginInstall in vim
vim +PluginClean +qall
vim +PluginInstall +qall

#utils
mkdir -p $HOME/bin
ln -s $HOME/dotfiles/utils/* $HOME/bin/

#git setup
git config --global core.excludesfile $HOME/dotfiles/gitignore_global

sudo apt-get install terminator
