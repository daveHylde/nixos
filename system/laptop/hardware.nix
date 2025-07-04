# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a106e856-9724-4fce-85e7-b74e6dce9c7a";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-401dea83-122b-48f8-9ed1-bfb990b933a3".device = "/dev/disk/by-uuid/401dea83-122b-48f8-9ed1-bfb990b933a3";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0740-E0BA";
      fsType = "vfat";
    };

  swapDevices = [ ];

	services = {
		fprintd = {
			enable=true;
		};
	};

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services = {
    fwupd.enable = true;
    thinkfan.enable = true;
    openvpn.servers = {
      itf = {
        config = '' config /root/nixos/openvpn/officeVPN.conf '';
        updateResolvConf = true;
        autoStart = false;
      };
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.hostName = "laptop-work";
}
