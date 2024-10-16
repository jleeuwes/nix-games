{ stdenv, bash, fetchFromGitHub, SDL2, datafiles }:
let
  engineSrc = fetchFromGitHub {
    owner = "usineur";
    repo = "hode";
    rev = "59f3c466923c6b8d49e29176ff697a91165e7efc";
    hash = "sha256-dk0VvMPwrlJryYsH1Nr5Hr3E/7k1y+B5NLmEQB85tjA=";
  };
  hodeIniSrc = ./hode.ini;
in stdenv.mkDerivation {
  pname = "hode";
  version = "0.2.9f+10commits";
  buildInputs = [ bash SDL2 ];
  nativeBuildInputs = [ ];
  src = engineSrc;
  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/appdata
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
    $out/bin/hode --datapath=${datafiles}/share/appdata --savepath="\$savepath" "\$@"
    EOF
    chmod a+x $out/bin/Heart_of_Darkness
    runHook postInstall
  '';
}
