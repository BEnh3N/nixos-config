#!/usr/bin/env bash

opt=`eww get screenshot-option`
location="/home/$USER/Pictures/Screenshots/$(date '+%F_%H-%M-%S_grim.png')"

if [[ $opt == "1" ]]; then
  hyprctl dispatch submap reset && sleep 0.5 && grim $location && notify-send -a Screenshooter "Screenshot Taken!"
elif [[ $opt == "2" ]]; then
  eww update screenshot-option=1
  hyprctl dispatch submap reset && sleep 3 && grim $location && notify-send -a Screenshooter "Screenshot Taken!"
elif [[ $opt == "3" ]]; then
  eww update screenshot-option=1
  hyprctl dispatch submap reset && grim -g "$(slurp)" $location && notify-send -a Screenshooter "Screenshot Taken!"
else
  notify-send "Screenshooter has encountered a problem!"
  eww update screenshot-option=1
fi
