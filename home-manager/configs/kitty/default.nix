{ pkgs, ... }: 

{
  programs.kitty = {
    enable = true;
    themeFile = "Obsidian";
    font = {
      name = "Zed Mono";
			package = pkgs.nerd-fonts.zed-mono;
		};
    shellIntegration = {
      enableBashIntegration = true;
    };
    extraConfig = ''
      background_opacity 0.9
    '';
  };
}
