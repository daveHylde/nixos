{ pkgs, ... }:

{
	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.opengl = {
		# Mesa
		enable = true;

		# Vulkan
		driSupport = true;

		extraPackages = with pkgs; [
			rocmPackages.clr.icd
			amdvlk
		];
		extraPackages32 = with pkgs; [
			driversi686Linux.amdvlk
		];
	};
}
