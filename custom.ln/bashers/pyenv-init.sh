#!/usr/bin/env zsh

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"

[[ -d "$PYENV_ROOT" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if [[ -n $(command -v pyenv) ]]; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
