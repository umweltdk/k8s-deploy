{ nixpkgs ? <nixpkgs> }:
let
  overlay = self: super: {
    kubernetes-helm-all = super.callPackage ./helm { };
    kubectl-all = super.callPackage ./kubernetes {};
  };
  pkgs = import nixpkgs { overlays = [ overlay ]; };
  lnpkgs = dir: all: pkgs.lib.mapAttrsToList (n: v: "ln -s ${v} $out/${dir}/${n}") all;
in
{
  helm = pkgs.kubernetes-helm-all.packages;
  kubectl = pkgs.kubectl-all.packages;
  all = pkgs.stdenvNoCC.mkDerivation {
    name = "k8s-deploy-dependencies";
    src = ./.;
    buildCommand = ''
      mkdir -p $out/helm
      mkdir -p $out/kubectl
      ${pkgs.lib.concatStringsSep "\n" (lnpkgs "helm" pkgs.kubernetes-helm-all.packages)}
      ${pkgs.lib.concatStringsSep "\n" (lnpkgs "kubectl" pkgs.kubectl-all.packages)}
    '';
  };
}
