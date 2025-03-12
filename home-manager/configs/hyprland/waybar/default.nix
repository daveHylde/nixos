{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 18;
        spacing = 4;
        modules-right = [ "tray" ];
        modules-center = [ "clock" "hyprland/workspaces" ];
        modules-left = [
          "network"
          "cpu"
          "memory"
          "temperature"
        ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}({name})";
          format-icons = {
            urgent = "🦊";
            active = "🐓";
            default = "🐤";
          };
        };
        tray = {
          icon-size = 18;
          spacing = 10;
        };
				clock = {
					format = "{:%d/%m %H:%M}";
					format-alt = "{:%A, %B %d, %Y (%R)}  ";
					tooltip-format = "<tt><small>{calendar}</small></tt>";
					calendar = {
						mode = "year";
						mode-mon-col = 3;
						weeks-pos = "right";
						on-scroll = 1;
						format = {
							months = "<span color='#ffead3'><b>{}</b></span>";
							days = "<span color='#ecc6d9'><b>{}</b></span>";
							weeks = "<span color='#99ffdd'><b>W{}</b></span>";
							weekdays = "<span color='#ffcc66'><b>{}</b></span>";
							today = "<span color='#ff6699'><b><u>{}</u></b></span>";
						};
					};
					actions = {
						on-click-right = "mode";
						on-scroll-up = "shift_up";    # Note: removed duplicate on-scroll-up
						on-scroll-down = "shift_down"; # Note: removed duplicate on-scroll-down
					};
				};
        cpu = {
          format = "CPU: {usage}% ";
          tooltip = false;
        };
        memory = {
          format = "MEM: {}% ";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
				wireplumber = {
					format = "{volume}%";
					format-muted = "";
					on-click = "helvum";
					max-volume = 100;
					scroll-step = 0.2;
				};
      };
    };
  };
}

