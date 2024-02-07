{ fetchFromGitHub
, buildDotnetModule
, lib
}:

buildDotnetModule rec {
  pname = "Swashbuckle.AspNetCore.Cli";
  version = "6.5.0";


  src = fetchFromGitHub {
    owner = "domaindrivendev";
    repo = "Swashbuckle.AspNetCore" ;
    rev = "v${version}";
    sha256 = "sha256-pSxq+V6l+lsl0T4PrldeoLWhJ6quUcJ0j0dzI6vU6g0=";
  };

  projectFile = "Swashbuckle.AspNetCore.Cli/Swashbuckle.AspNetCore.Cli.csproj";

  meta = with lib; {
    homepage = "https://github.com/domaindrivendev/Swashbuckle.AspNetCore";
    description = "Dotnet Swagger CLI tool";
    license = licenses.mit;
  };
}

