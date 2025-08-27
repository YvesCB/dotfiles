#!/bin/bash
# This script will output the current input method of fcitx

current_layout=$(fcitx5-remote -n)
case "$current_layout" in
    "keyboard-us") 
        output="us"
        ;;
    "keyboard-us-alt-intl")
        output="us_intl"
        ;;
    "mozc") 
        output="jp"
        ;;
    *)
        output="$current_layout"
        ;;
esac

echo "$output"
