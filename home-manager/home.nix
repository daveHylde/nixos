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
      pkgs.clinfo
      pkgs.cargo
      pkgs.dotnetCorePackages.sdk_8_0
      pkgs.firefox
      pkgs.flameshot
			pkgs.fzf
      pkgs.git
      pkgs.gimp
      pkgs.glib
      pkgs.glxinfo
      pkgs.jq
      pkgs.chromium
			pkgs-unstable.figma-linux
			pkgs.k9s
      pkgs.kitty
      pkgs.keepassxc
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.lazydocker
      pkgs-unstable.lua-language-server
      pkgs.libreoffice
      pkgs.lm_sensors
      pkgs.minikube
      pkgs.mysql80
      pkgs.nerdfonts
			pkgs-unstable.netcoredbg
      pkgs.nodejs
      pkgs-unstable.openlens
      pkgs-unstable.openrgb
      pkgs.openssl
      pkgs.powershell
      pkgs.python3Full
			pkgs-unstable.signal-desktop
      pkgs-unstable.slack
      pkgs-unstable.spotify
      pkgs.tldr
      pkgs-unstable.thunderbird
      pkgs-unstable.vscode-fhs
      pkgs.wl-clipboard
      pkgs.yarn
			pkgs.yubikey-manager-qt
      pkgs.yubikey-personalization
      pkgs.yubioath-flutter
      pkgs.yq
      pkgs.unzip
			pkgs.xwayland
      pkgs.zip
    ];
  };
}
