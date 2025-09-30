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
		# font = {
		#   name = "Archivo";
	  #   size = 11;
		# };
	};

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.05";

		sessionVariables = {
			DOTNET_ROOT = "${pkgs.dotnet-sdk_9}/share/dotnet";
			NIXOS_OZONE_WL = "1";
		};

    packages = with pkgs; [
			(flameshot.override { enableWlrSupport = true; })
			aichat
			audacity
			bat
			bc
			blueman
			cargo
			chafa
			claude-code
			discord
			dotnet-sdk_9
			lesspipe
			ffmpegthumbnailer
			figma-linux
			firefox
			file
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
			libreoffice
			librsvg
			lm_sensors
			mermaid-cli
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
			pandoc
			pinta
			playerctl
			poppler_utils
			postgresql
			powershell
			python3Full
			s3cmd
			s3fs
			signal-desktop
			skaffold
			slack
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
			whatsie
			yarn
			yq
			yubikey-personalization
			yubioath-flutter
			zip
		];
	};
}
