{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; 
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# Neovim plugins
		# plugin-tailwind-tools = {
		# 	url = "github:luckasRanarison/tailwind-tools.nvim";
		# 	flake = false;
		# };
		# plugin-nx = {
		# 	url = "github:Equilibris/nx.nvim";
		# 	flake = false;
		# };
		# plugin-vim-razor = {
		# 	url = "github:jlcrochet/vim-razor";
		# 	flake = false;
		# };
		# plugin-cmp-ai = {
		# 	url = "github:tzachar/cmp-ai";
		# 	flake = false;
		# };
		# plugin-git-file-history = {
		# 	url = "github:isak102/telescope-git-file-history.nvim";
		# 	flake = false;
		# };
  };

  outputs =
    inputs @ { self
    , nixpkgs
		, nixpkgs-unstable
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
					inherit inputs self user;
					pkgs-unstable = import nixpkgs-unstable {
						inherit system;
						config.allowUnfree = true;
					}; 
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
					inherit inputs self user; 
					pkgs-unstable = import nixpkgs-unstable {
						inherit system;
						config.allowUnfree = true;
					}; 
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
					inherit inputs self user; 
					pkgs-unstable = import nixpkgs-unstable {
						inherit system;
						config.allowUnfree = true;
					}; 
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
					inherit inputs self user; 
					pkgs-unstable = import nixpkgs-unstable {
						inherit system;
						config.allowUnfree = true;
					}; 
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

