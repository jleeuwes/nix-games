# this file can be nix-build
let pkgs = (import <nixpkgs>) {};
in rec {
  datafiles_myabandonware = pkgs.callPackage ./datafiles.nix {};
  hode = pkgs.callPackage ./hode.nix {
    datafiles = datafiles_myabandonware;
  };
}
