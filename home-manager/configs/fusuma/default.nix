{pkgs, ...}:

{
  services.fusuma = {
    enable = true;
    extraPackages = with pkgs; [ coreutils xdotool xorg.xprop ];
    settings = {
      swipe = {
        "3" = {
          up = {
            command = "xdotool key ctrl+Tab";
          };
          down = {
            command = "xdotool key ctrl+shift+Tab";
          };
          right = {
            command = "xdotool key alt+Left";
          };
          left = {
            command = "xdotool key alt+Right";
          };
        };

        "4" = {
          up = {
            command = "xdotool key super+F8";
          };
          down = {
            command = "xdotool key super+F8";
          };
          left = {
            command = "xdotool key super+Tab";
          };
          right = {
            command = "xdotool key super+shift+Tab";
          };
        };
      };
      pinch = {
        "4" = {
          "in" = {
            command = "xdotool key ctrl+F12";
          };
          out = {
            command = "xdotool key ctrl+F12";
          };
        };
      };
    };
  };
}
