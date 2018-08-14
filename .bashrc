#only do if interactive
if [ ! -z "$PS1" ]; then

  ###########################################################
  #cygwin stuff, work specific
  if [ -f "$HOME/.is_cygwin" ]; then
    if [ -f "$HOME/.is_work" ]; then
        #Nothing
    fi
  fi

  ###########################################################
  #cygwin stuff, general
  if [ -f "$HOME/.is_cygwin" ]; then

    alias cs=cygstart

    export PATH="$HOME/scripts:$PATH"
    export PATH="$HOME/devel/g:/cygdrive/c/tedtools/ted:$PATH"
    export PATH="$HOME/devel/fig:$PATH"
    export PATH="$HOME/devel/f:$PATH"

    #for MinGW
    export PATH="/cygdrive/c/MinGW/bin:/cygdrive/c/Program Files (x86)/cmocka/bin:/cygdrive/c/Program Files/7-Zip:$PATH"

    #adding cygwin last in case we use MinGW and want to access the cygwin tools
    export PATH="$PATH:/c/cygwin64/bin"

    #override this on cygwin
    export TESTHARNESSPY="/bin/python"

    #cygwin python
    alias cygpy="/cygdrive/c/cygwin64/bin/python"

    #Segger embedded studio
    export PATH="$PATH:/cygdrive/c/Program Files/SEGGER/SEGGER Embedded Studio 3.30/bin/"

  fi

  ###########################################################
  #Debian stuff, work related
  if ! [ -f "$HOME/.is_cygwin" ]; then
    if [ -f "$HOME/.is_work" ]; then
        alias wireshark="sudo -v && sudo wireshark > /dev/null 2>&1 &"
        alias logic="sudo -v && sudo ~/opt/Logic/Logic > /dev/null 2>&1 &"
    fi
  fi

  ###########################################################
  #Debian stuff, general
  if ! [ -f "$HOME/.is_cygwin" ]; then
      #turn off nagging for password (turn of energy star)
      xset -dpms > /dev/null 2>&1

      alias xs="xdg-open $1 >/dev/null 2>&1"

      export PATH="$PATH:/usr/share/segger_embedded_studio_for_arm_3.50/bin/"
  fi

  ###########################################################
  #work stuff, platform independent
  if [ -f "$HOME/.is_work" ]; then
      #Nothing
  fi
  ##########################
  #zephyr-stuff
  source $HOME/devel/zephyr/zephyr-env.sh > /dev/null 2>&1

  ###########################################################
  #General stuff, platform independent

  #hack to force terminal to UTF-8, see http://www.cl.cam.ac.uk/~mgk25/unicode.html#term
  #print -n '\e%G'

  #some fixes for git
  export LC_CTYPE=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  #ninja with nice
  alias ninja="nice -n19 ninja"

  #show all git branches with last commiter
  alias glogallnames="git for-each-ref --sort=-committerdate  --format='%(committername) %(committerdate)   %(refname)' refs/remotes/origin"

  alias gl="git log --graph --decorate"
  alias gl1="git log -n1 --decorate"
  # Exclude all files in nuke-exclude from gnuke
  alias gnuke="git clean -xdf $(for line in `cat $HOME/dotfiles/gnuke-exclude`; do echo -n "--exclude=\"$line\" "; done)"

  alias gchs='grep -r --include "*.[chsS]"'

  alias j='jobs'

  #adding private bin for overloading tools etc
  export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

  #default editor for fc command
  export FCEDIT=vim

  export HISTSIZE=90000
  export SAVEHIST=90000

  #self update. Sleep is ugly hack to avoid conflicts.
  if [ "$(cd ~/dotfiles; git status --porcelain | wc -l 2>/dev/null)" -ne "0" ]; then
    #If status not empty
    echo "Dotfiles status dirty. Autoupdate not performed."
  elif [ "$(cd ~/dotfiles; git rev-list @{u}.. | wc -l 2>/dev/null)" -ne "0" ]; then
    #If we have unpushed commits
    echo "Dotfiles have unpushed commits. Autoupdate not performed."
  else
    ( (cd ~/dotfiles; sleep 1; git pull --rebase > /dev/null 2>&1; if [ $? -ne 0 ]; then echo "Dotfiles self update failed. Check status and stash."; fi;) & )
  fi

fi #if interactive
