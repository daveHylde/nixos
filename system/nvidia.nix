{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
