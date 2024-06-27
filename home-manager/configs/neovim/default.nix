{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaPackages = luaPkgs: with luaPkgs; [
      jsregexp
      lua-curl
      lua-lsp
      luarocks
      luarocks-nix
      magick
      mimetypes
      rest-nvim
      rocks-nvim
      xml2lua
    ];
    extraPackages = with pkgs; [
      fd
      file
      gcc
      python3Full
      ripgrep
      wget
    ];
  };
}
