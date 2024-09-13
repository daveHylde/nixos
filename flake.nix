{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; 
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
			system = "x86_64-linux";
      user = "david";
      shared-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./home-manager/home.nix;
        home-manager.extraSpecialArgs = { 
					inherit inputs self user system;
				};
        home-manager.backupFileExtension = "backup";
      };
			overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations.desktop-work = nixpkgs.lib.nixosSystem {
        specialArgs = { 
					inherit inputs self user system; 
				};
        modules = [
          ./system/desktop/hardware-work.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
					{
						nixpkgs.overlays= overlays;
					}
        ];
      };
      nixosConfigurations.desktop-jobbi = nixpkgs.lib.nixosSystem {
        specialArgs = { 
					inherit inputs self user system; 
				};
        modules = [
          ./system/desktop/hardware-jobbi.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
					{
						nixpkgs.overlays= overlays;
					}
        ];
      };

      nixosConfigurations.laptop-work = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { 
					inherit inputs self user system; 
				};
        modules = [
          ./system/laptop/hardware.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
					{
						nixpkgs.overlays= overlays;
					}
        ];
      };
    };
}

