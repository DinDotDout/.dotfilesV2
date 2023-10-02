#!/bin/bash
sudo pacman --noconfirm --needed -S hyprland wl-clipboard xdg-desktop-portal-hyprland waybar grim slurp wofi
paru --noconfirm --needed -S swww swaylock-effects wlogout pyprland hyprpicker

stow -R hyprland-conf

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:(yY/nN)} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

isnvidia=$(lspci -k | grep -A 2 -E "nvidia")
if [ -z "$isnvidia" ]; then
  exit
fi

# add hyprand needed modifications
# open files to edit manually with instructions
echo "Add nvidia_drm.modeset=1 to GRUB_CMDLINE_LINUX_DEFAULT= in /etc/default/grub"
confirm "Do you want the command to be coppied to your clipboard?" && sudo vim -c "let @\"='GRUB_CMDLINE_LINUX_DEFAULT=nvidia_drm.modeset=1'" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "In /etc/mkinitcpio.conf add nvidia nvidia_modeset nvidia_uvm nvidia_drm to your MODULES"
confirm "Do you want the command to be coppied to your clipboard?" && sudo vim -c "let @\"='nvidia nvidia_modeset nvidia_uvm nvidia_drm'" /etc/mkinitcpio.conf
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

echo "Add a new line to /etc/modprobe.d/nvidia.conf (make it if it does not exist) and add the line options nvidia-drm modeset=1"
confirm "Do you want the command to be coppied to your clipboard?" && sudo vim -c "let @\"='options nvidia-drm modeset=1'" /etc/modprobe.d/nvidia.conf
echo "Done!"
echo "You can reboot to see the changes"
