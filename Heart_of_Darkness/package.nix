# TODO split into:
# - a hode package
# - a Heart_of_Darkness package with the appdata and hode.ini
{ stdenv, bash, fetchurl, fetchFromGitHub, unzip, p7zip, SDL2 }:
let
  engineSrc = fetchFromGitHub {
    owner = "usineur";
    repo = "hode";
    rev = "59f3c466923c6b8d49e29176ff697a91165e7efc";
    hash = "sha256-dk0VvMPwrlJryYsH1Nr5Hr3E/7k1y+B5NLmEQB85tjA=";
  };
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
  hodeIniSrc = ./hode.ini;
in stdenv.mkDerivation {
  name = "hode";
  buildInputs = [ bash SDL2 ];
  nativeBuildInputs = [ unzip p7zip ];
  src = engineSrc;
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
    cp ${hodeIniSrc} $out/share/appdata/hode.ini
    
    mkdir -p $out/bin
    cp hode $out/bin
    cat <<EOF > $out/bin/Heart_of_Darkness
    #!${bash}/bin/bash
    if [[ -z \$XDG_CONFIG_HOME ]]; then
      XDG_CONFIG_HOME="\$HOME"/.config
    fi
    savepath="\$XDG_CONFIG_HOME"/Heart_of_Darkness
    printf "savepath=%q\n" "\$savepath" >&2
    mkdir -p -- "\$savepath"
    if [[ ! -e \$savepath/hode.ini ]]; then
      printf "Copying default hode.ini to savepath\n" >&2
      cp $out/share/appdata/hode.ini -- "\$savepath"
      chmod u+w -- "\$savepath"/hode.ini
    fi
    cd -- "\$savepath" # because hode.ini is read from working dir
    $out/bin/hode --datapath=$out/share/appdata --savepath="\$savepath"
    EOF
    chmod a+x $out/bin/Heart_of_Darkness
    runHook postInstall
  '';
}
