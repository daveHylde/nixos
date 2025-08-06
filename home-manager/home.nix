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

  fonts = {
		fontconfig.enable = true;
		# packages = [ ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
	};

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
			DOTNET_ROOT = "${pkgs.dotnet-sdk_9}";
		};

    packages = with pkgs; [
			aichat
			audacity
			bat
			bc
			blueman
			cargo
			google-chrome
			claude-code
			discord
			dotnet-sdk_9
			figma-linux
			firefox
			(flameshot.override { enableWlrSupport = true; })
			fzf
			gimp
			git
			git-spice
			home-manager
			htop
			hub
			hyprpaper
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
			mermaid-cli
			netcoredbg
			networkmanagerapplet
			nixd
			nodejs_22
			openrgb
			openssl
			pinta
			playerctl
			postgresql
			powershell
			python3Full
			signal-desktop
			slack
			spotify
			sqlite
			tectonic
			thunderbird
			tldr
			unzip
			vscode-extensions.ms-dotnettools.csharp
			vscode-fhs
			wl-clipboard
			yarn
			yq
			yubikey-personalization
			yubioath-flutter
			zip
		];
	};
}
