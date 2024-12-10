{ pkgs, user, ... }:

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

	gtk = {
	  enable = true;
	  theme = {
	    name = "Graphite-Dark";
	    package = pkgs.graphite-gtk-theme;
	  };
		iconTheme = {
			name = "Kora";
			package = pkgs.kora-icon-theme;
		};
	};

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";

		sessionVariables = {
			DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0}";
		};

    packages = with pkgs; [
			audacity
			blueman
			cargo
			chromium
			docker-compose
			dotnetCorePackages.sdk_9_0
			figma-linux
			firefox
			flameshot
			fzf
			gimp
			git
			gwenview
			hub
			home-manager
			htop
			hyprpaper
			hyprshot
			pinta
			inotify-tools
			jq
			k9s
			keepassxc
			kubectl
			kubernetes-helm
			lazydocker
			libreoffice
			lm_sensors
			minikube
			nerdfonts
			netcoredbg
			networkmanagerapplet
			nixd
			nodejs_22
			openrgb
			openssl
			playerctl
			postgresql
			powershell
			python3Full
			signal-desktop
			slack
			spotify
			thunderbird
			tldr
			unzip
			vscode-extensions.ms-dotnettools.csharp
			vscode-fhs
			wl-clipboard
			yarn
			yq
			yubikey-manager-qt
			yubikey-personalization
			yubioath-flutter
			zip
		];
	};
}
