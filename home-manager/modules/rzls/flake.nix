{
	description = "Flake for building Razor Language Server (rzls) from source";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
		razor-src = {
			url = "github:dotnet/razor";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, flake-utils, razor-src }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = nixpkgs.legacyPackages.${system};
				dotnetSdk = pkgs.dotnetCorePackages.sdk_9_0;
			in
				{
				packages.rzls = pkgs.stdenv.mkDerivation {
					pname = "rzls";
					version = "8.0.0"; # Update this version as needed

					src = razor-src;

					nativeBuildInputs = [ dotnetSdk ];

					unpackPhase = ''
						echo "Starting unpack phase..."
						cp -r $src ./source
						chmod -R +w ./source
						cd ./source
						echo "Unpack phase completed."
						'';

					configurePhase = ''
						echo "Starting configure phase..."
						export HOME=$(mktemp -d)
						export DOTNET_CLI_TELEMETRY_OPTOUT=1
						export DOTNET_NOLOGO=1
						export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

						# Ensure the script can find itself
						patchShebangs .

						# Modify build scripts to use the correct paths
						sed -i 's|scriptroot=.*|scriptroot="$(cd "$(dirname "$0")" && pwd)"|g' ./eng/common/build.sh
						sed -i 's|. "$scriptroot/eng/common/tools.sh"|. "./eng/common/tools.sh"|g' ./eng/common/build.sh

						echo "Configure phase completed."
						'';

					buildPhase = ''
						echo "Starting build phase..."
						if [ -f ./eng/build.sh ]; then
						echo "Found eng/build.sh, executing..."
						bash ./eng/build.sh --restore --build --pack --no-build-native || { echo "eng/build.sh failed"; exit 1; }
						elif [ -f ./build.sh ]; then
						echo "Found build.sh, executing..."
						bash ./build.sh --restore --build --pack --no-build-native || { echo "build.sh failed"; exit 1; }
						else
						echo "No build script found. Falling back to manual build."
						cd src/Razor/src/Microsoft.AspNetCore.Razor.LanguageServer
						dotnet build -c Release || { echo "Manual build failed"; exit 1; }
						fi
						echo "Build phase completed."
						'';

					installPhase = ''
						echo "Starting install phase..."
						mkdir -p $out/bin
						if [ -f ./artifacts/bin/rzls/Release/net7.0/rzls ]; then
						echo "Found rzls in artifacts/bin"
						cp ./artifacts/bin/rzls/Release/net7.0/rzls $out/bin/
						elif [ -f ./src/Razor/src/Microsoft.AspNetCore.Razor.LanguageServer/bin/Release/net7.0/rzls ]; then
						echo "Found rzls in src/Razor/src/"
						cp ./src/Razor/src/Microsoft.AspNetCore.Razor.LanguageServer/bin/Release/net7.0/rzls $out/bin/
						else
						echo "rzls binary not found in expected locations."
						find . -name rzls
						exit 1
						fi
						chmod +x $out/bin/rzls
						echo "Install phase completed."
						'';

					meta = with pkgs.lib; {
						description = "Razor Language Server";
						homepage = "https://github.com/dotnet/razor";
						license = licenses.mit;
						maintainers = with maintainers; [ ]; # Add your name if you want
					};
				};

				defaultPackage = self.packages.${system}.rzls;

				devShell = pkgs.mkShell {
					buildInputs = [ dotnetSdk ];
				};
			});
}
