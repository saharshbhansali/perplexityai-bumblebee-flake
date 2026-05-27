{
  description = "PerplexityAI Bumblebee";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
            };
          }
        );
    in
    {
      packages = forAllSystems (
        { pkgs }:
        {
          default = pkgs.callPackage ./default.nix { };
        }
      );

      apps = forAllSystems (
        { pkgs }:
        {
          default = {
            type = "app";
            program = "${self.packages.${pkgs.system}.default}/bin/bumblebee";
          };
        }
      );

      devShells = forAllSystems (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              go
              gopls
            ];
          };
        }
      );
    };
}
