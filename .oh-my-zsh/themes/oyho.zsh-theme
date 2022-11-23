# https://github.com/blinks zsh theme

local ret_color="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"

# This theme works with both the "dark" and "light" variants of the
# Solarized color schema.  Set the SOLARIZED_THEME variable to one of
# these two values to choose.  If you don't specify, we'll assume you're
# using the "dark" variant.

#case ${SOLARIZED_THEME:-dark} in
#    light) bkg=white;;
#    *)     bkg=black;;
#esac

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{green}%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{%F{red}%} * %{%f%}%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{%B%F{blue}%}"

PROMPT='%{%f%k%b%}
%{%B%F{green}%}%n@%m %{%b%F{yellow}%}%~%{%B%F{green}%}$(git_prompt_info_oyho)%E%{%f%k%b%}
%{%}%{%}!%{%B%F{cyan}%}%!%{%f%k%b%} ${ret_color}$%{%f%k%b%} '

# git_remote_status
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="-"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="+"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="<>"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="="
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED="true"

ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR="%F{green}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR="%F{red}"

function git_prompt_info_oyho() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_remote_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  else
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX Git status disabled $ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi

#echo $(git_prompt_info) $(git_remote_status)

#  ref=$(git symbolic-ref HEAD 2> /dev/null)
#  if [[ ! -z $ref ]] then
#    ref=${ref#refs/heads/}
#  else
#    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
#  fi
#  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

