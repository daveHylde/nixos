{ user, ... }:

{
  imports = [
    ./waybar
    ./wofi
		./hyprpaper
		./swaync
		./hyprlock
  ];

	home.file."/home/${user}/.config/hypr/hyprland.conf".text = ''
			################
			### MONITORS ###
			################

			# See https://wiki.hyprland.org/Configuring/Monitors/
			monitor=,preferred,auto,auto


			###################
			### MY PROGRAMS ###
			###################

			# See https://wiki.hyprland.org/Configuring/Keywords/

			# Set programs that you use
			$terminal = kitty
			$fileManager = dolphin
			$menu = wofi --show drun


			#################
			### AUTOSTART ###
			#################

			# Autostart necessary processes (like notifications daemons, status bars, etc.)
			# Or execute your favorite apps at launch like this:

			exec-once = waybar
			exec-once = swaync
			exec-once = keepassxc
			exec-once = openrgb --profile default --startminimized
			exec-once = nm-applet --indicator
			exec-once = blueman-applet

			exec-once = [workspace 1 silent] firefox
			exec-once = [workspace 1 silent] $terminal
			exec-once = [workspace 2 silent] slack
			exec-once = [workspace 2 silent] signal-desktop
			exec-once = [workspace 2 silent] thunderbird
			exec-once = dbus-update-activation-environment --systemd --all
			exec-once = hyprpaper


			#############################
			### ENVIRONMENT VARIABLES ###
			#############################

			# See https://wiki.hyprland.org/Configuring/Environment-variables/

			env = XCURSOR_SIZE,24
			env = HYPRCURSOR_SIZE,24
			env = XCURSOR_THEME,Kora


			#####################
			### LOOK AND FEEL ###
			#####################

			# Refer to https://wiki.hyprland.org/Configuring/Variables/

			# https://wiki.hyprland.org/Configuring/Variables/#general
			general { 
					gaps_in = 2
					gaps_out = 4

					border_size = 2

					# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
					col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
					col.inactive_border = rgba(595959aa)

					# Set to true enable resizing windows by clicking and dragging on borders and gaps
					resize_on_border = false 

					# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
					allow_tearing = false

					layout = dwindle
			}

			# https://wiki.hyprland.org/Configuring/Variables/#decoration
			decoration {
					rounding = 10

					# Change transparency of focused and unfocused windows
					active_opacity = 1.0
					inactive_opacity = 1.0

					drop_shadow = true
					shadow_range = 4
					shadow_render_power = 3
					col.shadow = rgba(1a1a1aee)

					# https://wiki.hyprland.org/Configuring/Variables/#blur
					blur {
							enabled = true
							size = 3
							passes = 1

							vibrancy = 0.1696
					}
			}

			# https://wiki.hyprland.org/Configuring/Variables/#animations
			animations {
					enabled = true

					# Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

					bezier = myBezier, 0.05, 0.9, 0.1, 1.05

					animation = windows, 1, 2, myBezier
					animation = windowsOut, 1, 2, default, popin 80%
					animation = border, 1, 3, default
					animation = borderangle, 1, 2, default
					animation = fade, 1, 2, default
					animation = workspaces, 1, 2, default
			}

			# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
			dwindle {
					pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
					preserve_split = true # You probably want this
			}

			# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
			master {
					new_status = master
			}

			# https://wiki.hyprland.org/Configuring/Variables/#misc
			misc { 
					force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
					disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
			}


			#############
			### INPUT ###
			#############

			# https://wiki.hyprland.org/Configuring/Variables/#input
			input {
					kb_layout = no
					kb_variant =
					kb_model = zsa-moonlander
					kb_options =
					kb_rules =

					follow_mouse = 1

					sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

					touchpad {
							natural_scroll = false
					}
			}

			# https://wiki.hyprland.org/Configuring/Variables/#gestures
			gestures {
					workspace_swipe = false
			}

			# Example per-device config
			# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
			device {
					name = epic-mouse-v1
					sensitivity = -0.5
			}


			###################
			### KEYBINDINGS ###
			###################

			# See https://wiki.hyprland.org/Configuring/Keywords/
			$mainMod = SUPER # Sets "Windows" key as main modifier

			# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
			bind = $mainMod, T, exec, $terminal
			bind = $mainMod, C, killactive,
			bind = $mainMod SHIFT, Q, exit,
			bind = $mainMod, E, exec, $fileManager
			bind = $mainMod, F, togglefloating,
			bind = $mainMod, R, exec, pidof $menu && hyprctl dispatch focuswindow $menu || $menu
			bind = $mainMod, P, pseudo, # dwindle
			bind = $mainMod, O, togglesplit, # dwindle
			bind = $mainMod, L, exec, hyprlock

			# Move focus with mainMod + arrow keys
			bind = $mainMod, left, movefocus, l
			bind = $mainMod, right, movefocus, r
			bind = $mainMod, up, movefocus, u
			bind = $mainMod, down, movefocus, d
			# Resize windows
			bind = $mainMod SHIFT, right, resizeactive, 50 0
			bind = $mainMod SHIFT, left, resizeactive, -50 0
			bind = $mainMod SHIFT, up, resizeactive, 0 -50
			bind = $mainMod SHIFT, down, resizeactive, 0 50
			bind = $mainMod SHIFT, right, resizeactive, 50 0
			# Move windows in the workspace
			bind = $mainMod CTRL, left, movewindow, l
			bind = $mainMod CTRL, right, movewindow, r
			bind = $mainMod CTRL, up, movewindow, u
			bind = $mainMod CTRL, down, movewindow, d

			bind = $mainMod SHIFT, S, exec, hyprshot -m region -- pinta

			# Switch workspaces with mainMod + [0-9]
			bind = $mainMod, 1, workspace, 1
			bind = $mainMod, 2, workspace, 2
			bind = $mainMod, 3, workspace, 3
			bind = $mainMod, 4, workspace, 4
			bind = $mainMod, 5, workspace, 5
			bind = $mainMod, 6, workspace, 6
			bind = $mainMod, 7, workspace, 7
			bind = $mainMod, 8, workspace, 8
			bind = $mainMod, 9, workspace, 9
			bind = $mainMod, 0, workspace, 10

			# Move active window to a workspace with mainMod + SHIFT + [0-9]
			bind = $mainMod SHIFT, 1, movetoworkspace, 1
			bind = $mainMod SHIFT, 2, movetoworkspace, 2
			bind = $mainMod SHIFT, 3, movetoworkspace, 3
			bind = $mainMod SHIFT, 4, movetoworkspace, 4
			bind = $mainMod SHIFT, 5, movetoworkspace, 5
			bind = $mainMod SHIFT, 6, movetoworkspace, 6
			bind = $mainMod SHIFT, 7, movetoworkspace, 7
			bind = $mainMod SHIFT, 8, movetoworkspace, 8
			bind = $mainMod SHIFT, 9, movetoworkspace, 9
			bind = $mainMod SHIFT, 0, movetoworkspace, 10

			# Move/resize windows with mainMod + LMB/RMB and dragging
			bindm = $mainMod, mouse:272, movewindow
			bindm = $mainMod, mouse:273, resizewindow

			# Laptop multimedia keys for volume and LCD brightness
			bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
			bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
			bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
			bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
			bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
			bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

			# Media control
      bindl = , XF86AudioPlay, exec, playerctl play-pause
	    bindl = , XF86AudioNext, exec, playerctl next
			bindl = , XF86AudioPrev, exec, playerctl previous
			bindl = , XF86AudioStop, exec, playerctl stop

			##############################
			### WINDOWS AND WORKSPACES ###
			##############################

			# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
			# See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

			# Example windowrule v1
			# windowrule = float, ^(kitty)$

			# Example windowrule v2
			# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

			windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
	''; 
}