{ stdenv
, lib
, fetchurl
, autoPatchelfHook
, libgcc
, glib
, gtk3
, libusb1
, webkitgtk
}:

stdenv.mkDerivation rec {
  pname = "keymapp";
  version = "latest";

  src = fetchurl {
    url = "https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz";
    sha256 = "sha256-tbRlJ65hHPBDwoXAXf++OdcW67RcqR1x1vfhbPCo1Ls=";
  };
  
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    libgcc
    glib
    gtk3
    libusb1
    webkitgtk
  ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp keymapp $out/bin
  '';
}
