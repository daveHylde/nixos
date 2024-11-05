{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
  
      preload =
        [ "~/Pictures/space2.jpeg" ];
  
      wallpaper = [
				" , ~/Pictures/space2.jpeg"
      ];
    };
  };
}

