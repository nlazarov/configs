PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='$(git_prompt_info) %F{blue}]%F{cyan}$(todo_count) %F{green}%D{%H:%M}'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function todo_count() {
  [[ -n $(command -v todo) ]] && echo "($(todo count '#today' | sed 's/ //g')|$(todo count | sed 's/ //g'))"


}
