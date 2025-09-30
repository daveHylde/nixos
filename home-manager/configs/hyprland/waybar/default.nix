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
        modules-right = [ "cpu" "temperature" "pulseaudio" "network" "tray" ];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
          format-icons = {
            urgent = "⚠️";
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
          format = "  {usage}%";
          max-length = 13;
          min-length = 13;
          tooltip = false;
        };
        
        temperature = {
          interval = 4;
          critical-threshold = 74;
          format-critical = "  {temperatureC}°C";
          format = "{icon}  {temperatureC}°C";
          format-icons = ["" "" ""];
          max-length = 7;
          min-length = 7;
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
        
        pulseaudio = {
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
          on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
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
          font-family: "Cantarell", "Font Awesome 5 Pro";
          font-size: 10px;
          font-weight: bold;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #custom-layout,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #custom-alsa,
      #custom-pacman,
      #custom-weather,
      #custom-gpu,
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

      #pulseaudio {
          background: @nord_bg_blue;
          color: #D8DEE9;
      }

      #pulseaudio.muted {
          background: #BF616A;
          color: #BF616A;
      }

      #pulseaudio.source-muted {
          background: #D08770;
          color: #D8DEE9;
      }

      #tray {
          background: #434C5E;
      }
    '';
  };
}

