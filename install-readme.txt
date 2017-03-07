sudo apt-get install neovim python-dev python-pip python3-dev python3-pip git zsh python-pip python3-pip curl silversearcher-ag terminator

#python support for neovim
pip install neovim
pip3 install neovim

#for dev pcs
sudo apt-get install minicom gcc-arm-none-eabi gdb-multiarch

#for work computer only
sudo apt-get install subversion ssh-pass

#other:
#ozone

#create a .vimrc and .zshrc based on the common ones
#symlink .vimrc and zshrc

#Getting https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s $HOME/dotfiles/oyho.zsh-theme $HOME/.oh-my-zsh/themes/
