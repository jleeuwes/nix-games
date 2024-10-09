# for nix-build
let pkgs = (import <nixpkgs>) {};
in {
  hode = pkgs.callPackage ./package.nix {};
}
