{
  description = "Razor language server";
  inputs = {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
      razor = {
          url = "github:dotnet/razor";
          flake = false;
      };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    razor,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0_1xx;
        dotnet-runtime = pkgs.dotnetCorePackages.runtime_8_0;
        projectFile = "${razor}/Razor.sln";
        version = "17.6.1";
        pname = "rzls";
      in {
        packages = {
          fetchDeps = let
            runtimeIds = map (system: pkgs.dotnetCorePackages.systemToDotnetRid system) dotnet-sdk.meta.platforms;
          in
            pkgs.writeShellScriptBin "fetch-${pname}-deps" (builtins.readFile (pkgs.substituteAll {
              src = ./nix/fetchDeps.sh;
              pname = pname;
              binPath = pkgs.lib.makeBinPath [pkgs.coreutils dotnet-sdk (pkgs.nuget-to-nix.override {inherit dotnet-sdk;})];
              projectFiles = toString (pkgs.lib.toList projectFile);
              rids = pkgs.lib.concatStringsSep "\" \"" runtimeIds;
              packages = dotnet-sdk.packages;
              storeSrc = pkgs.srcOnly {
                src = razor;
                pname = pname;
                version = version;
              };
            }));
          default = pkgs.buildDotnetModule {
            pname = pname;
            version = version;
            src = razor;
            projectFile = projectFile;
            nugetDeps = ./nix/deps.nix;
            doCheck = true;
            dotnet-sdk = dotnet-sdk;
            dotnet-runtime = dotnet-runtime;
          };
        };
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [pkgs.dotnet-sdk_8 pkgs.git pkgs.alejandra pkgs.nodePackages.markdown-link-check];
          };
        };
      }
    );
}
