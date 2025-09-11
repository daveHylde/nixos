{ user, ... }:

{
  imports = [
	./waybar
	./wofi
	./hyprpaper
	./swaync
	./hyprlock
  ];

	home.file."/home/${user}/.config/hypr/hyprland.conf".source = ./hyprland.conf;
}