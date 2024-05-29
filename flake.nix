{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
      user = "david";
    in
    {
      nixosConfigurations.desktop-work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user; };
        modules = [
          ./system/desktop/hardware-work.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user; };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
      nixosConfigurations.desktop-jobbi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user; };
        modules = [
          ./system/desktop/hardware-jobbi.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user; };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      nixosConfigurations.laptop-work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user; };
        modules = [
          ./system/laptop/hardware.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user; };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}

