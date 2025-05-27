{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		plugin-nx = {
			url = "github:Equilibris/nx.nvim";
			flake = false;
		};
		plugin-gp = {
			url = "github:Robitx/gp.nvim";
			flake = false;
		};
		plugin-vim-freemarker = {
			url = "github:andreshazard/vim-freemarker";
			flake = false;
		};
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      user = "david";

      shared-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./home-manager/home.nix;
        home-manager.extraSpecialArgs = { inherit inputs self user system; };
        home-manager.backupFileExtension = "hm-backup";
      };

      mkSystem = hardware: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self user system; };
        modules = [
          hardware
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
        ];
      };
    in
    {
      nixosConfigurations = {
        desktop-work = mkSystem ./system/desktop/hardware-work.nix;
        desktop-jobbi = mkSystem ./system/desktop/hardware-jobbi.nix;
        laptop-work = mkSystem ./system/laptop/hardware.nix;
      };
    };
}
