# Workaround for sshing into bash
if [[ "$USERNAME" != "oyho" ]]
then
  #these must be in place so that cmake can find some tools
  NEW_PATHS=""
  NEW_PATHS="$NEW_PATHS:$(cygpath 'C:\Python34\')"
  NEW_PATHS="$NEW_PATHS:$(cygpath 'C:\Program Files (x86)\GNU Tools ARM Embedded\4.9 2015q3\bin\')"
  NEW_PATHS="$NEW_PATHS:$(cygpath 'C:\Program Files (x86)\CMake\bin\')"
  NEW_PATHS="$NEW_PATHS:$(cygpath 'C:\Program Files (x86)\MSBuild\14.0\Bin\')"
  export PATH="$NEW_PATHS:$PATH"

  #this is so git knows its key
  ssh-add ~/.ssh/id_rsa
fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/cygdrive/c/cygwin64/bin:$PATH"
export PATH="/cygdrive/c/cygwin64/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=/cygdrive/c/home/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="blinks"
ZSH_THEME="oyho"
#ZSH_THEME="oyho-remote"
#ZSH_THEME="crunch"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
#
plugins=(git history-substring-search globalias)

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# for printing git prompt quicker, potentially adding remote
#export OYHO_SHOW_FULL_PROMPT=''
#function git_prompt_info() {
#  #ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#  ref=$(git symbolic-ref HEAD 2> /dev/null)
#  if [[ ! -z $ref ]] then
#    ref=${ref#refs/heads/}
#  else
#    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
#  fi
#  if [[ $OYHO_SHOW_FULL_PROMPT ]] then
#    remote=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD) 2> /dev/null)
#    #remote=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD) 2> /dev/null) || return
#    remote_string=" (${remote})"
#    clean_string="$(parse_git_dirty)"
#  else
#    remote_string=""
#    clean_string=""
#    #echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/} ${ZSH_THEME_GIT_PROMPT_CLEAN}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
#  fi
#  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$remote_string$clean_string${ZSH_THEME_GIT_PROMPT_SUFFIX}"
#}
#
#export PATH="~/scripts:$PATH"

#bindkey -v

#common stash
source ~/dotfiles/.bashrc
source ~/scripts/setenv

export PATH="$HOME/scripts:$PATH"
export VisualStudioDisabled='true'

export PATH="$HOME/devel/g:/cygdrive/c/tedtools/ted:$PATH"
export PATH="$HOME/devel/fig:$PATH"
export PATH="$HOME/devel/f:$PATH"
export PATH="$HOME/devel/debug-tools:$PATH"

#for MinGW
export PATH="/cygdrive/c/MinGW/bin:/cygdrive/c/Program Files (x86)/cmocka/bin:/cygdrive/c/Program Files/7-Zip:$PATH"

#adding cygwin last in case we use MinGW and want to access the cygwin tools
export PATH="$PATH:/c/cygwin64/bin"

#zsh overrides of common .bashrc
alias gchs="fig -t \\[chs\\]"

source $HOME/.oh-my-zsh-custom/plugins/expand-aliases/expand-aliases.plugin.zsh

#hack to force terminal to UTF-8, see http://www.cl.cam.ac.uk/~mgk25/unicode.html#term
#print -n '\e%G'

#alias to ssh into virtualbox
alias debian="$HOME/scripts/debian.sh"
alias mbrupdate="$HOME/scripts/mbrupdate.sh"

#some fixes for git
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
