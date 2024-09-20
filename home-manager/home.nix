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

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";

		sessionVariables = {
			DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}";
		};

    packages = with pkgs; [
			figma-linux
			signal-desktop
			lens
			openrgb
			slack
			spotify
			thunderbird
			vscode-fhs
			ollama
			fzf
			k9s
			yubikey-manager-qt
			cargo
			chromium
			dotnetCorePackages.sdk_8_0
			firefox
			flameshot
			gimp
			git
			jq
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
			nodejs
			openssl
			postgresql
			powershell
			python3Full
			tldr
			unzip
			wl-clipboard
			yarn
			yq
			yubikey-personalization
			yubioath-flutter
			zip
			vscode-extensions.ms-dotnettools.csharp
		];
  };
}
