{pkgs, inputs, user, ...}: 

{

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
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "23.11";

    packages = with pkgs; [
      clinfo
      csharp-ls
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
      libsForQt5.kdeconnect-kde
      libreoffice
      lf
      lm_sensors
      minikube
      neovim
      nerdfonts
      netcoredbg
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
      unzip
      zip
      (callPackage ./modules/keymapp/keymapp.nix {})
    ];
 };
}
