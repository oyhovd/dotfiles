#su
#adduser oyho sudo
#git clone https://github.com/oyhovd/dotfiles.git

sudo apt-get install zsh vim

#vim setup
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Run PluginInstall in vim
vim +PluginInstall +qall
