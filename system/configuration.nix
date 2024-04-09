# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
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
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
    };
  };

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "nb_NO.UTF-8";
  console.keyMap = "no";

  services = {
    hardware.bolt.enable = true;
    onedrive.enable = true;
    pcscd.enable = true;
    printing.enable = true;
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };

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
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
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
  };

  sound = {
    enable = true;
  };

  programs = {
    ssh.startAgent = true;
    coolercontrol.enable = true;
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
        login.u2fAuth = false;
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
    ];
  };

  environment = rec {

    plasma5.excludePackages = with pkgs.libsForQt5; [
      spectacle
      plasma-browser-integration
      konsole
      oxygen
      elisa
      okular
      ksshaskpass
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
