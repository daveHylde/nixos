{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaPackages = ps: [
      ps.magick
      ps.lua-curl
      ps.xml2lua
      ps.jsregexp
      ps.luarocks
      ps.mimetypes
    ];
    extraPackages = with pkgs; [
      nixd
      fd
      file
      gcc
      netcoredbg
      python3
      ripgrep
      lua-language-server
      stylua
      prettierd
      lua
      gnumake
      wget
    ];
  };
}
