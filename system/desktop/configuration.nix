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
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  networking = {
    networkmanager.enable = true;
  }; 

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "nb_NO.UTF-8";
  console.keyMap = "no";

  services = {
    onedrive.enable = true;

    udev.packages = [ pkgs.openrgb ];

    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
      };
      desktopManager.plasma5.enable = true;
      xkb = {
        variant = "";
        layout = "no";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;
  };

  sound = {
    enable = true;
  };

  security = {
    rtkit.enable = true;
  };

  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "docker"
    ];
  };

  environment = {

    plasma5.excludePackages = with pkgs.libsForQt5; [
      plasma-browser-integration
      konsole
      oxygen
    ];
  };

  system = {
    stateVersion = "23.11";

    autoUpgrade = {
      enable = true;
      allowReboot = false;
    }; 
  };
}
