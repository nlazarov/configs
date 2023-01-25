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

    ls | list)
      if [ -z $2 ]; then;
        sed -ne '/^\* \[ \] /p' "$TODO_PATH" | mdown
      else
        ag --no-numbers --literal "$2" "$TODO_PATH" | __pending_list
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
