{ stdenv, bash, fetchurl, unzip, p7zip }:
let
  isoSrc = fetchurl {
    name = "Heart-of-Darkness_Win_EN_ISO-Version-14-EU-Rerelease.zip";
    url = "https://d1.myabandonware.com/t/16b73eb9-3d0f-4ba9-9a10-fe0ccef5d7d2/Heart-of-Darkness_Win_EN_ISO-Version-14-EU-Rerelease.zip";
    hash = "sha256-2qYtAnl252z8wFA1xVmsd4mjNfH3hzn2ytxjlSGiIv4=";
  };
  ripSrc = fetchurl {
    name = "Heart-of-Darkness_Win_EN_RIP-Version.zip";
    url = "https://d1.myabandonware.com/t/72769615-3087-46cf-b89f-7191e2478077/Heart-of-Darkness_Win_EN_RIP-Version.zip";
    hash = "sha256-WWvyf5fJyKxKwmpuv0oXg74bsbDZ1YDSxRaH6ka606g=";
  };
in stdenv.mkDerivation {
  name = "Heart_of_Darkness-datafiles-myabandonware";
  nativeBuildInputs = [ unzip p7zip ];
  srcs = [];
  unpackPhase = ":";
  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/appdata
    unzip ${ripSrc}
    pushd Heart_of_Darkness
    mv *_hod.{lvl,sss,mst} setup $out/share/appdata
    popd
    mkdir iso
    pushd iso
    unzip ${isoSrc}
    7z x 'Heart of Darkness (Europe) (Rerelease).iso'
    mv paf $out/share/appdata
    popd
    
    runHook postInstall
  '';
}
