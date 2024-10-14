{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
  
      preload =
        [ "~/Pictures/space1.jpeg" ];
  
      wallpaper = [
				" , ~/Pictures/space1.jpeg"
      ];
    };
  };
}

