source $HOME/dotfiles/vundle.vim
source $HOME/dotfiles/.vimrc

"Disable Eclim by default
autocmd VimEnter * EclimDisable

if getcwd() =~ 'zephyr'
  source ~/dotfiles/zephyr.vim
endif
