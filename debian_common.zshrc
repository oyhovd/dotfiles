# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="oyho"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# git: git stuff
# history-substring-search: type characters and press up arrow
plugins=(git history-substring-search thefuck)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source $HOME/dotfiles/.bashrc

#Open html files in default app
alias -s html=xdg-open

#turn off nagging for password (turn of energy star)
xset -dpms > /dev/null 2>&1

#Keil stuff
export KEIL_PATH=/home/oyho/armstuff
export FAMILY_PACK_PATH=/home/oyho/armstuff/ARM/Pack/NordicSemiconductor/nRF_DeviceFamilyPack/8.9.0/Device
export CMSIS_PATH=/home/oyho/armstuff/ARM/Pack/ARM/CMSIS/4.1.0/CMSIS


#zephyr-stuff
export ZEPHYR_BASE="$HOME/devel/zephyr"
export ZEPHYR_SDK_INSTALL_DIR="$HOME/opt/zephyr-sdk"
export ZEPHYR_GCC_VARIANT=zephyr
source $HOME/devel/zephyr/zephyr-env.sh > /dev/null 2>&1

function cpatch()                                                              
{                                                                              
  echo $1                                                                
  find $1 -type f -exec ~/devel/zephyr/scripts/checkpatch.pl -f {} \;      
}                                                                              

function fnit()                                                                
{                                                                              
  echo $1                                                                
  echo $1zephyr.hex                                                      
  pyocd-flashtool -d debug -t nrf52 -ce && pyocd-flashtool -d debug -t nrf52 $1zephyr.hex
}                                                                              

function fdk52()                                                                
{                                                                              
  echo $1                                                                
  echo $1zephyr.hex                                                      
  nrfjprog --eraseall -f nrf52 && nrfjprog --program $1zephyr.hex -f nrf52 && nrfjprog -r -f nrf52
}                                                                              

function fdk51()                                                                
{                                                                              
  echo $1                                                                
  echo $1zephyr.hex                                                      
  nrfjprog --eraseall -f nrf51 && nrfjprog --program $1zephyr.hex -f nrf51 && nrfjprog -r -f nrf51
}                                                                              

function dbg52()                                                                
{                                                                              

  JLinkGDBServer -device nrf52 -if swd -speed 4000 &                      
  /home/carles/prog/zephyr-sdk/sysroots/i686-pokysdk-linux/usr/bin/arm-poky-eabi/arm-poky-eabi-gdb
}

#YouCompleteMe
export CMAKE_EXPORT_COMPILE_COMMANDS=ON

export FCEDIT=nvim
