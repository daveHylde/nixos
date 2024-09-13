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

	services = {
		ollama = {
			enable = true;
			acceleration = "rocm";
			environmentVariables = {
				HCC_AMDGPU_TARGET = "gfx1031";
			};
			rocmOverrideGfx = "10.3.1";
		};
	};
}
