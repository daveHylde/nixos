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

		sessionVariables = {
			DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}";
		};

    packages = with pkgs; [
      clinfo
      cargo
      discord
      dotnetCorePackages.sdk_8_0
      firefox
      flameshot
			fzf
      git
      gimp
      glib
      glxinfo
      jq
      chromium
			figma-linux
      k9s
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lazydocker
      lua-language-server
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
			signal-desktop
      slack
      spotify
      tldr
      thunderbird
      vscode-fhs
      xclip
      yarn
			yubikey-manager-qt
      yubikey-personalization
      yubioath-flutter
      yq
      unzip
      zip
    ];
  };
}
