{ stdenv, fetchurl, autoPatchelfHook }: 

stdenv.mkDerivation rec {
  pname = "wally";
  version = "2.1.3";

  src = fetchurl {
    url = "https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz";
    hash = "sha256-YpT2Ziw+wHe2rYf6NyPHSwX7iRPExykrWDS2WJdrrzs="
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D keymap-latest $out/bin/keymapp
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/zsa/wally";
    description = "ZSA flashing tool";
    platforms = platforms.linux;
  };
}
