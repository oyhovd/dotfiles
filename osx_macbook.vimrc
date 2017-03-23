source $HOME/dotfiles/vundle.vim
source $HOME/dotfiles/.vimrc

"Disable Eclim by default
if exists(":EclimDisable")
  autocmd VimEnter * EclimDisable
endif

if getcwd() =~ 'zephyr'
  source ~/dotfiles/zephyr.vim
endif
