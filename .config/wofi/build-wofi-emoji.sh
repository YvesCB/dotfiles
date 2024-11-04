#!/bin/zsh
sed -i '/^### DATA ###$/q' ~/.config/wofi/wofi-emoji.sh

curl https://raw.githubusercontent.com/muan/emojilib/v3.0.12/dist/emoji-en-US.json \
  | jq --raw-output '. | to_entries | .[] | .key + " " + (.value | join(" ") | sub("_"; " "; "g"))' \
  >> ~/.config/wofi/wofi-emoji.sh
