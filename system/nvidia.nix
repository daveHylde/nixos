{config, ...}:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  boot.kernelPackages = unstable.linuxPackages_latest;

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
  };
}
