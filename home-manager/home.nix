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
    stateVersion = "24.05";

    packages = with pkgs; [
      cargo
      chromium
      clinfo
      discord
      dotnetCorePackages.sdk_8_0
      firefox
      flameshot
      gimp
      git
      glib
      glxinfo
      jq
      k9s
      keepassxc
      kitty
      kubectl
      kubernetes-helm
      lazydocker
      libreoffice
      lm_sensors
      minikube
      mysql80
      nerdfonts
      netcoredbg
      nodejs
      openlens
      openrgb
      openssl
      powershell
      python3Full
      slack
      spotify
      thunderbird
      tldr
      unzip
      vscode-fhs
      xclip
      yarn
      yq
      yubikey-manager-qt
      yubikey-personalization
      yubioath-flutter
      zip
    ];
  };
}
