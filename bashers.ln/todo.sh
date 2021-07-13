#! /usr/bin/env bash

TODO_PATH=~/notes/todo.md
[[ ! -e "$TODO_PATH" ]] && touch "$TODO_PATH"
function todo() {
  case $1 in

    edit)
      n "$TODO_PATH"
      ;;

    add)
      local new_item="* [ ] $2"
      sed -i -e "1s;^;$new_item\n;" "$TODO_PATH"
      ;;

    *)
      mdown "$TODO_PATH"
      ;;
  esac
}
