#! /usr/bin/env bash

TODO_PATH=~/notes/todo.md
[[ ! -e "$TODO_PATH" ]] && touch "$TODO_PATH"
function todo() {
  case $1 in

    edit)
      n "$TODO_PATH"
      ;;

    add)
      local new_item="1. [ ] ${2?'Please, provide text for the new item'}"
      sed -i -e "1s;^;$new_item\n;" "$TODO_PATH"
      ;;

    ls | list)
      if [ -z "$2" ]; then
        __pending_list < "$TODO_PATH"
      else
        ag --no-numbers --no-color --literal "$2" "$TODO_PATH" | __pending_list
      fi
      ;;

    done)
      local idx=${2?'Please, specify task index.'}

      # 1. mark row as done
      # 2. go to first done item
      # 3. move row as first done item
      ed -s $TODO_PATH << _done
        ${idx}s/\[ \]/[x]
        /\[x\]
        ${idx}m-1
        wq
_done
      echo "marked task #$idx as done"
      ;;

    all)
      mdown "$TODO_PATH"
      ;;

    *)
      __pending_list < "$TODO_PATH"
  esac
}

function __pending_list() {
  sed -ne '/^1\. \[ \] /p' | mdown
}
