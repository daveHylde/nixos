{ pkgs, pkgs-unstable, user, ... }:

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

		sessionVariables = {
			DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}";
		};

    packages = [
			pkgs-unstable.figma-linux
			pkgs-unstable.signal-desktop
			pkgs-unstable.lens
			pkgs-unstable.openrgb
			pkgs-unstable.slack
			pkgs-unstable.spotify
			pkgs-unstable.thunderbird
			pkgs-unstable.vscode-fhs
			pkgs-unstable.ollama
			pkgs.fzf
			pkgs.k9s
			pkgs.yubikey-manager-qt
      pkgs.cargo
      pkgs.chromium
      pkgs.dotnetCorePackages.sdk_8_0
      pkgs.firefox
      pkgs.flameshot
      pkgs.gimp
      pkgs.git
      pkgs.jq
      pkgs.keepassxc
      pkgs.kitty
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.lazydocker
      pkgs.libreoffice
      pkgs.lm_sensors
      pkgs.minikube
      pkgs.mysql80
      pkgs.nerdfonts
      pkgs.nodejs
      pkgs.openssl
			pkgs.postgresql
      pkgs.powershell
      pkgs.python3Full
      pkgs.tldr
      pkgs.unzip
      pkgs.wl-clipboard
      pkgs.yarn
      pkgs.yq
      pkgs.yubikey-personalization
      pkgs.yubioath-flutter
      pkgs.zip
    ];
  };
}
