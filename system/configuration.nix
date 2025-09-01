# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs,lib, ... }:

{
  nix = {
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "Weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "i2c-piix4" "i2c-dev" ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
		graphics = {
			enable = true;
			enable32Bit = true;
		};
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };

  networking = {
    firewall = rec {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
    };
  };

  time.timeZone = "Europe/Oslo";
  console.keyMap = "no";

	systemd.services.lactd.wantedBy = ["multi-user.target"];

	# For unstable or 25.05
	fonts = {
     packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
	};

  services = {
    pulseaudio.enable = false;
    onedrive.enable = true;
    pcscd.enable = true;
    printing.enable = true;
    displayManager.sddm.enable = true;
    hardware.bolt.enable = true;
		dbus.enable = true;
		desktopManager.plasma6.enable = true;

    udev = {
      packages = [
        pkgs.openrgb
        pkgs.yubioath-flutter
        pkgs.coolercontrol.coolercontrold
      ];
      extraRules = ''
        ${builtins.readFile ./50-zsa.rules}
      '';
    };

    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "no";
        extraLayouts = {
          workman-no-num = {
            description = "Norwegian Workman layout with symbols";
            languages = [ "nob" "nno" "nor" ];
            symbolsFile = ./workman-no;
          };
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

		# ollama = {
		# 	enable = true;
		# 	loadModels = [ "llama3.2" ];
		# };
  };

  programs = {
    ssh.startAgent = true;
    coolercontrol.enable = true;
    dconf.enable = true;
		hyprland = {
			enable = true;
			xwayland.enable = true;
		};
  };

  security = {
    rtkit.enable = true;

    pki = {
      certificateFiles = [
        ./certs/jobbiLocalCA.pem
      ];
    };

    pam = {
      services = {
        sudo.u2fAuth = false;
      };

      yubico = {
        enable = true;
        debug = false;
        mode = "challenge-response";
        id = [ "26631457" ];
      };
    };

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };

  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "plugdev"
      "input"
      "tss"
      "libvirtd"
      "vboxusers"
			"video"
    ];
  };

  environment = rec {

		systemPackages = with pkgs; [
			lact 
			clinfo
			kdePackages.kdeconnect-kde
			kdePackages.kservice
			kdePackages.qtsvg
			xwayland
      glib
      glxinfo
			gpu-viewer
			vulkan-tools
			wayland-utils
		];	

		plasma6.excludePackages = with pkgs.kdePackages; [
			spectacle
			plasma-browser-integration
			konsole
			oxygen
			elisa
			okular
		];

    variables = {
      MINIKUBE_STATIC_IP = "192.168.49.2";
      EDITOR = "nvim";
    };

    etc = {
      "NetworkManager/dnsmasq.d/minikube.conf".text = "server=/jb/${variables.MINIKUBE_STATIC_IP}";
    };
  };

  system = {
    stateVersion = "23.11";

    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
      allowReboot = false;
    };
  };
}
