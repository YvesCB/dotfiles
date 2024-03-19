#!/usr/bin/env bash
languages=`echo "bash c cpp lua nodejs rust tmux typescript" | tr ' ' '\n'`
core_utils=`echo "awk find mv sed" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf "$languages" | grep -qs $selected; then
  tmux neww -n "cheat sheet" bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
else 
  tmux neww -n "cheat sheet" bash -c "curl cht.sh/$selected/`echo $selected~$query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
fi
