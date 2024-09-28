{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
  
      preload =
        [ "/home/david/Pictures/space1.png" "/home/david/Pictures/space2.png" ];
  
      wallpaper = [
        "DP-3,/home/david/Pictures/space1.png"
        "DP-1,/home/david/Pictures/space2.png"
      ];
    };
  };
}

