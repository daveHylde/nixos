{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-nx-nvim = {
      url = "github:Equilibris/nx.nvim";
      flake = false;
    };

    plugin-neotest-playwright = {
      url = "github:thenbe/neotest-playwright";
      flake = false;
    };

    plugin-bulma-cmp = {
      url = "github:garyhurtz/cmp_bulma.nvim";
      flake = false;
    };

    plugin-flexoki-theme = {
      url = "github:kepano/flexoki-neovim";
      flake = false;
    };

    plugin-vim-fugitive = {
      url = "github:tpope/vim-fugitive";
      flake = false;
    };

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: 
    let
      user = "david";
    in {
    nixosConfigurations.desktop-work = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self user;};
      modules = [
       ./system/desktop/hardware-work.nix
       ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.david = import ./home-manager/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs self user;};
        }
      ];
    };
    nixosConfigurations.desktop-jobbi = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self user;};
      modules = [
       ./system/desktop/hardware-jobbi.nix
       ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.david = import ./home-manager/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs self user;};
        }
      ];
    };

    nixosConfigurations.laptop-work = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self user;};
      modules = [
       ./system/laptop/hardware.nix
       ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.david = import ./home-manager/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs self user;};
        }
      ];
    };
  };
}

