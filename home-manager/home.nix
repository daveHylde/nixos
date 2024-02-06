{pkgs, ...}: let
  username = "david";
in {
  imports = [
    ./configs
  ];

  fonts = {
    fontconfig = { 
      enable = true;
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";

    packages = with pkgs; [
      cargo
      discord
      dotnet-sdk_8
      docker
      fd
      file
      firefox
      flameshot
      git
      gcc
      kitty
      libsForQt5.kdeconnect-kde
      keepassxc
      kubectl
      kubernetes-helm
      lf
      lm_sensors
      nerdfonts
      nodejs
      minikube
      openlens
      openrgb
      openssl
      python3Full
      ripgrep
      slack
      spotify
      thunderbird
      vscode
      wget
      xclip
      yarn
    ];
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./neovim/options.lua}
    '';

    extraPackages = with pkgs; [
      lua-language-server
      xclip
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      telescope-nvim
      
      (nvim-treesitter.withPlugins (p: [
	p.tree-sitter-nix
	p.tree-sitter-bash
	p.tree-sitter-lua
	p.tree-sitter-json
	p.tree-sitter-c-sharp
	p.tree-sitter-typescript
	p.tree-sitter-javascript
	p.tree-sitter-html
	p.tree-sitter-css
	p.tree-sitter-scss
	p.tree-sitter-dockerfile
	p.tree-sitter-yaml
      ]))

      vim-nix
    ];
  };
 };
}
