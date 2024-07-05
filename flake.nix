{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# Neovim plugins
		plugin-tailwindcss-colorizer-cmp = {
			url = "github:roobert/tailwindcss-colorizer-cmp.nvim";
			flake = false;
		};
		plugin-nx = {
			url = "github:Equilibris/nx.nvim";
			flake = false;
		};
		plugin-vim-razor = {
			url = "github:jlcrochet/vim-razor";
			flake = false;
		};
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
      user = "david";
      shared-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./home-manager/home.nix;
        home-manager.extraSpecialArgs = { inherit inputs self user; };
        home-manager.backupFileExtension = "backup";
      };
    in
    {
      nixosConfigurations.desktop-work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user; };
        modules = [
          ./system/desktop/hardware-work.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
        ];
      };
      nixosConfigurations.desktop-jobbi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user; };
        modules = [
          ./system/desktop/hardware-jobbi.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
        ];
      };

      nixosConfigurations.laptop-work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user; };
        modules = [
          ./system/laptop/hardware.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          shared-config
        ];
      };
    };
}

