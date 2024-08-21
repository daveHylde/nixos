{ pkgs-unstable, ... }:

{
	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.opengl = {

		# Mesa
		enable = true;

		# Vulkan
		driSupport = true;

		extraPackages = with pkgs-unstable; [
			rocmPackages.clr.icd
			amdvlk
		];
		extraPackages32 = with pkgs-unstable; [
			driversi686Linux.amdvlk
		];
	};
}
