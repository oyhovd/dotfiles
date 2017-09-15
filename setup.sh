#su
#adduser oyho sudo
#git clone https://github.com/oyhovd/dotfiles.git

cd $HOME
sudo apt-get install zsh vim ctags

#zsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s $HOME/dotfiles/oyho.zsh-theme $HOME/.oh-my-zsh/themes/
mv $HOME/.zshrc $HOME/.zshrc_old
ln -s /Users/hovdsveen/dotfiles/debian_common.zshrc $HOME/.zshrc

#vim setup
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Run PluginInstall in vim
vim +PluginInstall +qall

#utils
mkdir -p $HOME/bin
ln -s $HOME/dotfiles/utils/* $HOME/bin/
