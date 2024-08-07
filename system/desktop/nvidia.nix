{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
