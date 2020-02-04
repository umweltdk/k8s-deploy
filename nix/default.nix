{ nixpkgs ? <nixpkgs> }:
let
  overlay = self: super: {
    kubernetes-helm-all = super.callPackage ./helm { };
    kubectl-all = super.callPackage ./kubernetes {};
  };
  pkgs = import nixpkgs { overlays = [ overlay ]; };
  lnpkgs = dir: all: pkgs.lib.mapAttrsToList (n: v: "ln -s ${v} $out/share/k8s-deploy/${dir}/${n}") all;
  selectAttrs = set: list: builtins.listToAttrs (map (x: {name = x; value = set.${x}; }) list);
in
rec {
  inherit overlay;
  dependencies = pkgs.buildEnv {
    name = "k8s-deploy-bin";
    paths = with pkgs; [ ./. lastpass-cli gawk perl awscli aws-iam-authenticator ];
    pathsToLink = [ "/bin" ];
  };
  all = {
    helm = pkgs.kubernetes-helm-all.packages;
    kubectl = pkgs.kubectl-all.packages;
  };
  supported = {
    helm = selectAttrs all.helm ["2.15.1"];
    kubectl = selectAttrs all.kubectl ["1.11.5" "1.14.3" "1.14"];
  };
  package = pkgs.stdenvNoCC.mkDerivation {
    name = "k8s-deploy";
    src = ./.;
    buildCommand = ''
      mkdir -p $out/share/k8s-deploy
      cp -a $src/share/* $out/share/k8s-deploy/
      mkdir -p $out/share/k8s-deploy/helm
      mkdir -p $out/share/k8s-deploy/kubectl
      ${pkgs.lib.concatStringsSep "\n" (lnpkgs "helm" supported.helm)}
      ${pkgs.lib.concatStringsSep "\n" (lnpkgs "kubectl" supported.kubectl)}
      ln -s ${dependencies}/bin $out/bin
    '';
  };
}
