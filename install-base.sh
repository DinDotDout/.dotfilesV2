#!/bin/bash
clear

welcome_message() {
	clear
	echo "  ____        _   ____        _    __ _ _           "
	echo " |  _ \  ___ | |_|  _ \  ___ | |_ / _(_) | ___  ___ "
	echo " | | | |/ _ \| __| | | |/ _ \| __| |_| | |/ _ \/ __|"
	echo " | |_| | (_) | |_| |_| | (_) | |_|  _| | |  __/\__ \\"
	echo ' |____/ \___/ \__|____/ \___/ \__|_| |_|_|\___||___/'
	echo "-----------------------------------------------------"
	echo ""
}

get_user_input() {
	window_manager=""
	while true; do
		read -rp "Do you want to install i3 or hyprland? (hH/iI/Xx(None)): " hin
		case $hin in
		[hH]*)
			echo "Hyprland configuration started."
			window_manager="install-hyprland.sh"
			break
			;;
		[iI]*)
			echo "I3 configuration started."
			window_manager="install-i3.sh"
			break
			;;
		[nN]*)
			break
			;;
		*) echo "Please answer i, h or x." ;;
		esac
	done
}

install_paru_and_aur_pcks() {
	echo "Installing paru!"
	git clone https://aur.archlinux.org/paru-git.git
	(cd paru-git && makepkg -si)
	echo "DONE!"

	echo "Installing Paru pckgs!"
	paru_packages=(neovim-remote stow
		catppuccin-gtk-theme-macchiato catppuccin-cursors-mocha
		protonup-qt timeshift zram-generator preload pywal rofi-calc
		sddm-sugar-candy-git autofirma-bin vlc flatpak
	) # May need java-8-openjdk

	paru --noconfirm --needed -S "${paru_packages[@]}" || {
		echo 'Failed to install paru packages.'
		exit 1
	}
	echo "DONE!"
}

configure_flatpak_and_add_repos() {
	flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install --user flathub com.github.tchx84.Flatseal
	flatpak install --user flathub com.microsoft.Edge
}

add_zram() {
	echo "Adding zram"
	if [ -f "/etc/systemd/zram-generator2.conf" ]; then
		echo "/etc/systemd/zram-generator.conf already exists!"
	else
		sudo touch /etc/systemd/zram-generator.conf
		sudo bash -c 'echo "[zram0]" >> /etc/systemd/zram-generator.conf'
		sudo bash -c 'echo "zram-size = ram / 2" >> /etc/systemd/zram-generator.conf'
		sudo systemctl daemon-reload
		sudo systemctl start /dev/zram0
	fi
	echo "DONE!"
}

prepare_dotfiles() {
	stow -R conf-base
	xdg-user-dirs-update
}

change_to_zsh_shell() {
	echo "Changing to zsh shell"
	chsh -s /usr/bin/zsh
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
}

change_display_manager() {
	echo "Changing to sddm display manager"
	dpmpath='ExecStart=/usr/bin/'
	servicename=$(grep $dpmpath /etc/systemd/system/display-manager.service)
	if [ -n "$service" ]; then
		echo "Disabling current display manager service"
		servicename="${servicename#"$dpmpath"}.service"
		systemctl disable "$servicename"
	fi
	echo "Enabling new display manager service"
	systemctl enable sddm.service
}

add_window_manager() {
	if [[ -n $window_manager ]]; then
		# shellcheck disable=SC1090
		source "$window_manager"
	fi
}

main() {
	get_user_input
	install_paru_and_aur_pcks
	configure_flatpak_and_add_repos
	add_zram
	prepare_dotfiles
	change_to_zsh_shell
	change_display_manager
	add_window_manager
	echo "Finished"
	echo "All options will be enabled after rebooting"
}