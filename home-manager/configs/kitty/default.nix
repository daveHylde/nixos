{
  programs.kitty = {
    enable = true;
    themeFile = "Obsidian";
    shellIntegration = {
      enableBashIntegration = true;
    };
    extraConfig = ''
      background_opacity 0.9
    '';
  };
}
