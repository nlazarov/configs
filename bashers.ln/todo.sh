#! /usr/bin/env zsh

local TODO_PATH=~/notes/todo.md
[[ ! -e "$TODO_PATH" ]] && touch "$TODO_PATH"
function todo() {
  case $1 in

    edit)
      n "$TODO_PATH"
      ;;

    add)
      echo "* [ ] $2" >> "$TODO_PATH"
      ;;

    *)
      mdown "$TODO_PATH"
      ;;
  esac
}
