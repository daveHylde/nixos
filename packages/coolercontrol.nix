{ stdenv
, lib
, dpkg
, fetchurl
, autoPatchelfHook
, glib-networking
, openssl
, webkitgtk
, wrapGAppsHook
, cargo
, libappindicator-gtk3
}:

stdenv.mkDerivation rec {
  name = "coolercontrol";
  version = "1.1.0";

  src = fetchurl {
    url = "https://gitlab.com/coolercontrol/coolercontrol/-/releases/${version}/downloads/packages/coolercontrol_${version}_amd64_ubuntu.deb";
    sha256 = "519979278ff3f38e4cb81bde2c4411fcd6adc53570e823cab9806d454e6643c2";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    cargo
    libappindicator-gtk3
  ];

  buildInputs = [
    glib-networking
    openssl
    webkitgtk
    wrapGAppsHook
    cargo
  ];

  unpackCmd = "dpkg-deb -x $curSrc source";

  installPhase = "mv usr $out";

  meta = with lib; {
    description = "Open source fan and pump control";
    homepage = "https://github.com/cinnyapp/cinny-desktop";
    maintainers = [ maintainers.aveltras ];
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = platforms.linux;
    mainProgram = "cinny";
  };
}
