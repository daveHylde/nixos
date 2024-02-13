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
      vscode-fhs
      wget
      xclip
      yarn
      yubikey-personalization
      yubioath-flutter
      yq
      (callPackage ./modules/keymapp/keymapp.nix {})
#      (callPackage ./modules/coolercontrol/coolercontrol.nix {}) # does not work
    ];
 };
}
