{ stdenv
, lib
, fetchurl
, appimageTools
}:

appimageTools.wrapType2 rec {
  name = "coolercontrol";
  version = "1.0.0";
  src = fetchurl {
    url = "https://gitlab.com/coolercontrol/coolercontrol/-/releases/${version}/downloads/packages/CoolerControl-x86_64.AppImage";
    hash = "sha256-xdPEoyILoKfsygaovJrfSp6A5uA0XrHp45wT/gJf/UQ=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}
