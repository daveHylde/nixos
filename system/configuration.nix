# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

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
    hostName = "desktop";
    networkmanager.enable = true;
  }; 

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "nb_NO.UTF-8";
  console.keyMap = "no";

  services = {
    flatpak.enable = true;
    
    udev.packages = [ pkgs.openrgb ];

    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  environment = {

    variables = {
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      neovim
      cargo
      discord
      dotnet-sdk_8
      docker
      file
      firefox
      git
      kitty
      keepassxc
      kubectl
      kubernetes-helm
      lf
      lm_sensors
      libdbusmenu
      liquidctl
      libappindicator-gtk3
      nerdfonts
      nodejs
      minikube
      openrgb
      openssl
      python3Full
      slack
      spotify
      vscode
      wget
      xclip
      yarn
    #  (let coolercontrol = pkgs.callPackage (import ./packages/coolercontrol.nix) {}; in coolercontrol) 
    ];
  };

  system.stateVersion = "23.11";
}
