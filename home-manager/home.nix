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
      cargo
      discord
      dotnetCorePackages.sdk_8_0
      docker
      fd
      file
      firefox
      flameshot
      gcc
      git
      glib
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lazygit
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
      yubikey-personalization
      yubioath-flutter
      (callPackage ./modules/keymapp/keymapp.nix {})
    ];
 };
}
