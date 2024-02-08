{ fetchFromGitHub
, buildDotnetModule
, lib
, dotnetCorePackages
}:

buildDotnetModule rec {
  pname = "Swashbuckle.AspNetCore.Cli";
  version = "6.5.0";
 
  nugetDeps = ./deps.nix;

  src = fetchFromGitHub {
    owner = "domaindrivendev";
    repo = "Swashbuckle.AspNetCore" ;
    rev = "v${version}";
    sha256 = "sha256-pSxq+V6l+lsl0T4PrldeoLWhJ6quUcJ0j0dzI6vU6g0=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  useDotnetFromEnv = true;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  shellHook = ''
    echo "I'm the shell"
    export DOTNET_ROLL_FORWARD=LatestMajor
  '';

  projectFile = "src/Swashbuckle.AspNetCore.Cli/Swashbuckle.AspNetCore.Cli.csproj";

  meta = with lib; {
    homepage = "https://github.com/domaindrivendev/Swashbuckle.AspNetCore";
    description = "Dotnet Swagger CLI tool";
    license = licenses.mit;
  };
}
