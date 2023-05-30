#! /usr/bin/env bash

TODO_PATH=~/notes/todo.md
[[ ! -e "$TODO_PATH" ]] && touch "$TODO_PATH"
function todo() {
  case $1 in

    edit)
      n "$TODO_PATH"
      ;;

    add)
      local new_item="* [ ] ${2?'Please, provide text for the new item'}"
      sed -i -e "1s;^;$new_item\n;" "$TODO_PATH"
      ;;

    ls | list)
      if [ -z "$2" ]; then
        __pending_list < "$TODO_PATH"
      else
        ag --no-numbers --no-color --literal "$2" "$TODO_PATH" | __pending_list
      fi
      ;;

    all)
      mdown "$TODO_PATH"
      ;;

    *)
      __pending_list < "$TODO_PATH"
  esac
}

function __pending_list() {
  sed -ne '/^\* \[ \] /p' | mdown
}
