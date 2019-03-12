{ nixpkgs ? <nixpkgs> }:
let
  overlay = self: super: {
    kubernetes-helm-all = super.callPackage ./helm { };
    kubectl-all = super.callPackage ./kubernetes {};
  };
  pkgs = import nixpkgs { overlays = [ overlay ]; };
  lnpkgs = dir: all: pkgs.lib.mapAttrsToList (n: v: "ln -s ${v} $out/${dir}/${n}") all;
in
rec {
  helm = pkgs.kubernetes-helm-all.packages;
  kubectl = {
    "1.11.5" = pkgs.kubectl-all.packages."1.11.5";
  };
  all = pkgs.stdenvNoCC.mkDerivation {
    name = "k8s-deploy-dependencies";
    src = ./.;
    buildCommand = ''
      mkdir -p $out/helm
      mkdir -p $out/kubectl
      ${pkgs.lib.concatStringsSep "\n" (lnpkgs "helm" helm)}
      ${pkgs.lib.concatStringsSep "\n" (lnpkgs "kubectl" kubectl)}
    '';
  };
}
