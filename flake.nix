{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    nickel.url = "github:tweag/nickel/1.2.2";
  };

  outputs = { self, nixpkgs, nickel }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            pkgs.nickel
            # nickel.packages.${system}.default
          ];
        };
      };

    };
}
