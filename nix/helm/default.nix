{ pkgs }:
let
  helm_2 = import ./2.nix;
in {
  packages = {
    "2.15.1" = pkgs.callPackage ./2 {
      version = "2.15.1";
      sha256 = "1afbymgpax7kgjjv1c9xb4dm7gcrhn2g69piamdq1k0ng348k5w0";
    };
  };
}
