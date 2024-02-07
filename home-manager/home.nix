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
      jdk
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lazygit
      libsForQt5.kdeconnect-kde
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
      vscode-fhs
      wget
      xclip
      yarn
    ];
 };
}
