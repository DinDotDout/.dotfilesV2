#!/bin/bash
# WARN: My I3 configuration has been unmaintained for a while, proceed with caution
sudo pacman --needed --noconfirm -S polybar i3-gaps picom flameshot arandr xorg-xrandr xclip
paru --needed --noconfirm -S i3lock-color
stow -R conf-i3
echo "Addin permissions to lock screen script"
