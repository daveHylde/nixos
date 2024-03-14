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
      discord
      dotnetCorePackages.sdk_8_0
      docker
      figma-linux
      firefox
      flameshot
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
      libsForQt5.kdeconnect-kde
      libreoffice
      lm_sensors
      minikube
      nerdfonts
      nodejs
      openlens
      openrgb
      openssl
      python3Full
      slack
      spotify
      thunderbird
      vscode-fhs
      xclip
      yarn
      yubikey-personalization
      yubioath-flutter
      yq
      unzip
      zip
      (callPackage ./modules/keymapp/keymapp.nix {})
      
      # Stuff for NeoVim
      fd
      file
      gcc
      neovim
      lazydocker
      lazygit
      netcoredbg
      ripgrep
      lua-language-server
    ];
 };
}
