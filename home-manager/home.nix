{pkgs, ...}: let
  username = "david";
in {
  imports = [
    ./programs
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
      file
      firefox
      git
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lf
      lm_sensors
      libdbusmenu
      liquidctl
      libappindicator-gtk3
      nerdfonts
      nodejs
      minikube
      openrgb
      openssl
      python3Full
      slack
      spotify
      vscode
      wget
      xclip
      yarn
    ];
  };
}
