# https://github.com/blinks zsh theme

local ret_color="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"

# This theme works with both the "dark" and "light" variants of the
# Solarized color schema.  Set the SOLARIZED_THEME variable to one of
# these two values to choose.  If you don't specify, we'll assume you're
# using the "dark" variant.

case ${SOLARIZED_THEME:-dark} in
    light) bkg=white;;
    *)     bkg=black;;
esac

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{${bkg}}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{${bkg}}%B%F{green}%}%n@%m %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}
%{%K{${bkg}}%}%{%K{${bkg}}%}!%{%B%F{cyan}%}%!%{%f%k%b%} ${ret_color}$%{%f%k%b%} '

# for printing git prompt quicker, but also printing detached heads
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ ! -z $ref ]] then
    ref=${ref#refs/heads/}
  else
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

