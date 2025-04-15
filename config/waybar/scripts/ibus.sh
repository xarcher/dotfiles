#!/bin/bash

if [[ "$1" == "click" ]]; then
  if ! pgrep -x "ibus-daemon" >/dev/null; then
    ibus-daemon -drx &
    notify-send "Waybar" "Ibus is running!"
  else
    if [ $(ibus engine) == 'Bamboo::Us' ]; then
      ibus engine xkb:us::eng
    else
      ibus engine Bamboo::Us
    fi
  fi
  exit 0
fi

if ! pgrep -x "ibus-daemon" >/dev/null; then
  echo '{"text": "UNK", "tooltip": "ibus-daemon is not running"}'
  exit 0
fi

CURRENT_LANG="UNK"
if [ $(ibus engine) == 'Bamboo::Us' ]; then
  CURRENT_LANG="VIE"
elif [ $(ibus engine) == 'xkb:us::eng' ]; then
  CURRENT_LANG="ENG"
fi

echo "{\"text\": \"$CURRENT_LANG\", \"tooltip\": \"Current IBus Engine: $CURRENT_LANG\"}"
