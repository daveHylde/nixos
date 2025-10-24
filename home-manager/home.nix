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
			name = "Nordic";
			package = pkgs.nordic;
		};
		iconTheme = {
			name = "Nordzy";
			package = pkgs.nordzy-icon-theme;
		};
	};
	
	qt = {
		enable = true;
		platformTheme.name = "gtk";
	};

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.05";

		sessionPath = [
			"$HOME/.dotnet/tools"
		];

		sessionVariables = {
			DOTNET_ROOT = "${pkgs.dotnet-sdk_9}/share/dotnet";
			NIXOS_OZONE_WL = "1";
		};

    packages = with pkgs; [
		  (pkgs.flameshot.overrideAttrs (old: {
				cmakeFlags = old.cmakeFlags or [ ] ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
			}))
			grim
			slurp
			awscli2
			aichat
			audacity
			brave
			bat
			bc
			blueman
			cargo
			claude-code
			discord
			dotnet-sdk_9
			figma-linux
			file
			firefox
			fzf
			gimp3
			google-chrome
			home-manager
			htop
			hyprpaper
			imagemagick
			inotify-tools
			jq
			k9s
			keepassxc
			kubectl
			kubernetes-helm
			lazydocker
			lens
			lesspipe
			libreoffice
			librsvg
			lm_sensors
			minikube
			mono
			mpv
			netcoredbg
			networkmanagerapplet
			nixd
			nodejs_22
			obs-studio
			openrgb
			openssl
			pinta
			playerctl
			postgresql
			powershell
			python3
			resvg
			s3cmd
			signal-desktop
			skaffold
			slack
			speedtest-cli
			spotify
			sqlite
			tectonic
			thunderbird
			tldr
			unzip
			viu
			vscode-extensions.ms-dotnettools.csharp
			vscode-fhs
			wl-clipboard
			xdragon
			yarn
			yq
			yubikey-personalization
			yubioath-flutter
			zip
		];
	};
}
