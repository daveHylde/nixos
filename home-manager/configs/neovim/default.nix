{pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ 
      ps.magick
      ps.lua-curl
    ];
    extraPackages = with pkgs; [
      nixd
      fd
      file
      gcc
      netcoredbg
      ripgrep
      lua-language-server
    ];
  };
}
