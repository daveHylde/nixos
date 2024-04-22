{ pkgs, inputs, user, ... }:

{

  imports = [
    ./configs
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  fonts.fontconfig.enable = true;

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
      cargo
      discord
      dotnetCorePackages.sdk_8_0
      docker
      firefox
      flameshot
      git
      gimp
      glib
      glxinfo
      jq
      chromium
      k9s
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lazydocker
      lazygit
      libsForQt5.kdeconnect-kde
      libreoffice
      lm_sensors
      minikube
      mysql80
      nerdfonts
      nodejs
      openlens
      openrgb
      openssl
      powershell
      python3Full
      slack
      spotify
      tldr
      thunderbird
      vscode-fhs
      xclip
      yarn
      yubikey-personalization
      yubioath-flutter
      yq
      unzip
      zip
      plasma5Packages.plasma-thunderbolt
      yubikey-manager-qt
      zoxide
      (callPackage ./modules/keymapp/keymapp.nix { })
    ];
  };
}
