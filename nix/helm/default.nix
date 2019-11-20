{ pkgs }:
let
  helm_2 = import ./2.nix;
in {
  packages = {
    "2.15.1" = pkgs.callPackage ./2 {
      version = "2.15.1";
      sha256 = "0gx5gmj1470q3gj8v043dmm31skf83p1ckzdcfzx8wdjlglsljrj";
    };
  };
}
