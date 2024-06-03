{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaPackages = luaPkgs: with luaPkgs; [
      magick
      lua-curl
      xml2lua
      jsregexp
      luarocks
      mimetypes
    ];
    extraPackages = with pkgs; [
      nixd
      fd
      file
      gcc
      netcoredbg
      python3Full
      ripgrep
      lua-language-server
      stylua
      prettierd
      lua
      gnumake
      wget
      libllvm
    ];
  };
}
