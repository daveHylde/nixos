{ pkgs, ... }:

{
	hardware.graphics = {

		# Mesa
		enable = true;

		# Vulkan
		enable32Bit = true;

		extraPackages = with pkgs; [
			rocmPackages.clr.icd
		];
	};
}
