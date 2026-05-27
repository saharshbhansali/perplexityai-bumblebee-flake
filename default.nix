# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in
{
  bumblebee = pkgs.callPackage ./perplexityai-bumblebee.nix { };
}
