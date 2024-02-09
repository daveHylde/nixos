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
      gtk3
      haskellPackages.webkit2gtk3-javascriptcore
      jdk
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lazygit
      libsForQt5.kdeconnect-kde
      libusb1
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

      (let keymapp = import ./modules/wally.nix {}; in keymapp)
#      (callPackage ./modules/swagger/swagger.nix {}) # still issues with it complaining about .NET 7 missing. package bug.
    ];
 };
}
