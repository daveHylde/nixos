{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./yazi.toml);
  };
}

