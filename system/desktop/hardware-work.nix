{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "jc42" "nct6775" ];
  boot.extraModulePackages = [ ];
	# boot.kernelPackages = pkgs.linuxPackages_latest;
  powerManagement.cpuFreqGovernor = "performance";

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/699290af-819f-40ae-8605-9e60cecc907d";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-555377a0-a42c-44f5-823a-fcf76ddb74a7".device = "/dev/disk/by-uuid/555377a0-a42c-44f5-823a-fcf76ddb74a7";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/0F45-3777";
      fsType = "vfat";
    };

  swapDevices = [ ];

  services = {
    openvpn.servers = {
      itf = {
        config = '' config /root/nixos/openvpn/officeVPN.conf '';
        updateResolvConf = true;
      };
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "desktop-work";
}
