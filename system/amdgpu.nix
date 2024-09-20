{ pkgs, ... }:

{
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
		#		extraPackages = with pkgs; [
		#			rocmPackages.clr.icd
		#		];
	};

	systemd.services.lactd.wantedBy = ["multi-user.target"];
	environment.systemPackages = with pkgs; [ lact ];
	systemd.packages = with pkgs; [ lact ];

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
