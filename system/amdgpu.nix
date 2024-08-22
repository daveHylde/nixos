{ pkgs-unstable, ... }:

{
	hardware.opengl = {

		# Mesa
		enable = true;

		# Vulkan
		driSupport = true;
		driSupport32Bit = true;

		extraPackages = with pkgs-unstable; [
			rocmPackages.clr.icd
		];
	};
}
