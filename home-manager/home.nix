{pkgs, ...}: 
let 
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
      clinfo
      discord
      dotnetCorePackages.sdk_8_0
      docker
      fd
      file
      figma-linux
      firefox
      flameshot
      gcc
      git
      gimp
      glib
      glxinfo
      jq
      google-chrome
      k9s
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lazygit
      libreoffice
      lf
      lm_sensors
      minikube
      nerdfonts
      nodejs
      openlens
      openrgb
      openssl
      python3Full
      ripgrep
      slack
      spotify
      thunderbird
      tree-sitter
      vscode-fhs
      xclip
      yarn
      yubikey-personalization
      yubioath-flutter
      yq
      nodePackages."@angular/cli"
      (callPackage ./modules/keymapp/keymapp.nix {})

      # Neovim
      vscode-langservers-extracted
      lua-language-server
      yaml-language-server
      nodePackages.vscode-json-languageserver-bin
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      nixd
      csharp-ls
      netcoredbg
    ];
 };
}
