{ pkgs }:
let
  helm_2 = import ./2.nix;
in {
  packages = {
    "2.11.0" = pkgs.callPackage ./2 {
      version = "2.11.0";
      sha256 = "1z810a6mxyrrw4i908dip8aqsj95c0kmv6xpb1wwhskg1zmf85wk";
    };
  };
}
