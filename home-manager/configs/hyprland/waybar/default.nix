{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 8;
        spacing = 4;
        modules-left = [ "clock" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "cpu" "temperature" "wireplumber" "network" "custom/network-speed" "custom/internet-speed" "tray" ];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };
        
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
        };
        
        tray = {
          spacing = 5;
        };
        
        clock = {
          format = "  {:%H:%M   %e %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          today-format = "<b>{}</b>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#88c0d0'><b>{}</b></span>";
              days = "<span color='#d8dee9'><b>{}</b></span>";
              weeks = "<span color='#8fbcbb'><b>W{}</b></span>";
              weekdays = "<span color='#ebcb8b'><b>{}</b></span>";
              today = "<span color='#bf616a'><b><u>{}</u></b></span>";
            };
          };
        };
        
        cpu = {
          interval = 1;
          format = "{usage}%";
          max-length = 6;
          min-length = 6;
          tooltip = false;
        };
        
        temperature = {
          interval = 4;
          critical-threshold = 74;
          format = "{temperatureC}°C";
          format-icons = ["" "" ""];
          max-length = 6;
          min-length = 6;
        };
        
        network = {
          format-wifi = "  {essid}";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          family = "ipv4";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
          tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
        };
        
        wireplumber = {
          scroll-step = 3;
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };
        
        "custom/network-speed" = {
          interval = 2;
          format = "{}";
          exec = "bash -c 'RX1=$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd+ | bc); TX1=$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd+ | bc); sleep 1; RX2=$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd+ | bc); TX2=$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd+ | bc); RXD=$((RX2-RX1)); TXD=$((TX2-TX1)); if [ $RXD -gt 1048576 ]; then RX_UNIT=\"MB/s\"; RX_VAL=$(echo \"scale=1; $RXD/1048576\" | bc); elif [ $RXD -gt 1024 ]; then RX_UNIT=\"KB/s\"; RX_VAL=$(echo \"scale=0; $RXD/1024\" | bc); else RX_UNIT=\"B/s\"; RX_VAL=$RXD; fi; if [ $TXD -gt 1048576 ]; then TX_UNIT=\"MB/s\"; TX_VAL=$(echo \"scale=1; $TXD/1048576\" | bc); elif [ $TXD -gt 1024 ]; then TX_UNIT=\"KB/s\"; TX_VAL=$(echo \"scale=0; $TXD/1024\" | bc); else TX_UNIT=\"B/s\"; TX_VAL=$TXD; fi; printf \" %s%s | %s%s\" \"$RX_VAL\" \"$RX_UNIT\" \"$TX_VAL\" \"$TX_UNIT\"'";
          tooltip = false;
          max-length = 24;
          min-length = 24;
        };

        "custom/internet-speed" = {
          interval = 1800;
          format = "{}";
          exec = "bash -c 'SPEED_FILE=\"$HOME/.cache/waybar-internet-speed\"; if [ ! -f \"$SPEED_FILE\" ] || [ $(($(date +%s) - $(stat -c %Y \"$SPEED_FILE\" 2>/dev/null || echo 0))) -gt 1800 ]; then DOWN=$(speedtest-cli --simple 2>/dev/null | grep \"Download:\" | awk \"{printf \\\"%.1f\\\", \\$2}\"); UP=$(speedtest-cli --simple 2>/dev/null | grep \"Upload:\" | awk \"{printf \\\"%.1f\\\", \\$2}\"); echo \"↓$DOWN ↑$UP Mbps\" > \"$SPEED_FILE\"; fi; cat \"$SPEED_FILE\" 2>/dev/null || echo \"--- | ---\"'";
          tooltip = false;
          max-length = 24;
          min-length = 24;
        };
      };
    };
    
    style = ''
      @keyframes blink-warning {
          70% {
              color: @light;
          }
          to {
              color: @light;
              background-color: @warning;
          }
      }

      @keyframes blink-critical {
          70% {
            color: @light;
          }
          to {
              color: @light;
              background-color: @critical;
          }
      }

      /* COLORS - Nord Theme */
      @define-color bg #2E3440;
      @define-color light #D8DEE9;
      @define-color warning #ebcb8b;
      @define-color critical #BF616A;
      @define-color mode #434C5E;
      @define-color workspacesfocused #4C566A;
      @define-color tray @workspacesfocused;
      @define-color sound #EBCB8B;
      @define-color network #5D7096;
      @define-color memory #546484;
      @define-color cpu #596A8D;
      @define-color temp #4D5C78;
      @define-color layout #5e81ac;
      @define-color battery #88c0d0;
      @define-color date #434C5E;
      @define-color time #434C5E;
      @define-color backlight #434C5E;
      @define-color nord_bg #434C5E;
      @define-color nord_bg_blue #546484;
      @define-color nord_light #D8DEE9;
      @define-color nord_light_font #D8DEE9;
      @define-color nord_dark_font #434C5E;

      /* Reset all styles */
      * {
          border: none;
          border-radius: 3px;
          min-height: 0;
          margin: 0.1em 0.1em;
      }

      /* The whole bar */
      #waybar {
          background: @bg;
          color: @light;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 12px;
          font-weight: 600;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #custom-layout,
      #memory,
      #mode,
      #network,
      #wireplumber,
      #temperature,
      #custom-alsa,
      #custom-pacman,
      #custom-weather,
      #custom-gpu,
      #custom-network-speed,
      #custom-internet-speed,
      #tray,
      #backlight,
      #language,
      #custom-cpugovernor,
      #idle_inhibitor {
          padding-left: 0.4em;
          padding-right: 0.4em;
      }

      /* Each module that should blink */
      #mode,
      #memory,
      #temperature,
      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      /* Each critical module */
      #memory.critical,
      #cpu.critical,
      #temperature.critical,
      #battery.critical {
          color: @critical;
      }

      /* Each critical that should blink */
      #mode,
      #memory.critical,
      #temperature.critical,
      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      /* Each warning */
      #network.disconnected,
      #memory.warning,
      #cpu.warning,
      #temperature.warning,
      #battery.warning {
          background: @warning;
          color: @nord_dark_font;
      }

      /* Each warning that should blink */
      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #mode {
          color: @light;
          background: @mode;
      }

      /* Workspaces */
      #workspaces button {
          font-weight: bold;
          padding: 0;
          opacity: 0.3;
          background: none;
          font-size: 1em;
      }

      #workspaces button.active {
          background: @workspacesfocused;
          color: #D8DEE9;
          opacity: 1;
          padding: 0 0.4em;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
          opacity: 1;
      }

      #window {
          margin-right: 20px;
          margin-left: 20px;
          font-weight: normal;
      }

      #idle_inhibitor {
          background: @mode;
          font-weight: bold;
          padding: 0 0.4em;
      }

      #network {
          background: @nord_bg_blue;
      }

      #memory {
          background: @memory;
      }

      #cpu {
          background: @nord_bg;
          color: #D8DEE9;
      }

      #cpu.critical {
          color: @nord_dark_font;
      }

      #temperature {
          background-color: @nord_bg;
          color: #D8DEE9;
      }

      #temperature.critical {
          background: @critical;
      }

      #battery {
          background: @battery;
      }

      #clock {
          background: @nord_bg_blue;
          color: #D8DEE9;
      }

      #wireplumber {
          background: @nord_bg_blue;
          color: #D8DEE9;
      }

      #wireplumber.muted {
          background: #BF616A;
          color: #BF616A;
      }

      #wireplumber.source-muted {
          background: #D08770;
          color: #D8DEE9;
      }

      #custom-network-speed {
          background: @nord_bg_blue;
          color: #D8DEE9;
      }

      #custom-internet-speed {
          background: @network;
          color: #D8DEE9;
      }

      #tray {
          background: #434C5E;
      }
    '';
  };
}

