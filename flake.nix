{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		snacks-overlay = {
			url = "github:folke/snacks.nvim";
			flake = false;
		};
		plugin-rzls = {
			url = "github:tris203/rzls.nvim";
			flake = false;
		};
		plugin-roslyn-lsp = {
			url = "github:seblj/roslyn.nvim";
			flake = false;
		};
		plugin-tailwind-tools = {
			url = "github:luckasRanarison/tailwind-tools.nvim";
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
		plugin-conform = {
			url = "github:stevearc/conform.nvim";
			flake = false;
		};
		plugin-gp = {
			url = "github:Robitx/gp.nvim";
			flake = false;
		};
		plugin-git-file-history = {
			url = "github:isak102/telescope-git-file-history.nvim";
			flake = false;
		};
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      user = "david";

			overlays = [
        (final: prev: {
          vimPlugins = prev.vimPlugins // {
            snacks-nvim = prev.vimUtils.buildVimPlugin {
              name = "snacks-nvim";
              src = inputs.snacks-overlay;  # Use from inputs
            };
          };
        })
      ];

      shared-config = {
				nixpkgs.overlays = overlays;
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
