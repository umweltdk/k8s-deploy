{ stdenv, lib, fetchFromGitHub, removeReferencesTo, which, go, go-bindata, makeWrapper, rsync
  , shortName ? "kubectl", version, sha256
  , components ? [
      "cmd/kubectl"
    ]
}:

with lib;

stdenv.mkDerivation {
  name = "kubernetes-${version}";
  version = version;

  src = fetchFromGitHub {
    owner = "kubernetes";
    repo = "kubernetes";
    rev = "v${version}";
    sha256 = sha256;
  };

  buildInputs = [ removeReferencesTo makeWrapper which go rsync go-bindata ];

  outputs = ["out" "man" "pause"];

  postPatch = ''
    substituteInPlace "hack/lib/golang.sh" --replace "_cgo" ""
    substituteInPlace "hack/update-generated-docs.sh" --replace "make" "make SHELL=${stdenv.shell}"
    # hack/update-munge-docs.sh only performs some tests on the documentation.
    # They broke building k8s; disabled for now.
    echo "true" > "hack/update-munge-docs.sh"
    patchShebangs ./hack
  '';

  WHAT="${concatStringsSep " " components}";

  postBuild = ''
    ./hack/update-generated-docs.sh
    (cd build/pause && cc pause.c -o pause)
  '';

  installPhase = ''
    mkdir -p "$out/bin" "$out/share/bash-completion/completions" "$out/share/zsh/site-functions" "$man/share/man" "$pause/bin"
    cp _output/local/go/bin/* "$out/bin/"
    cp build/pause/pause "$pause/bin/pause"
    cp -R docs/man/man1 "$man/share/man"
    cp cluster/addons/addon-manager/namespace.yaml $out/share
    cp cluster/addons/addon-manager/kube-addons.sh $out/bin/kube-addons
    patchShebangs $out/bin/kube-addons
    substituteInPlace $out/bin/kube-addons \
      --replace /opt/namespace.yaml $out/share/namespace.yaml
    wrapProgram $out/bin/kube-addons --set "KUBECTL_BIN" "$out/bin/kubectl"
    $out/bin/kubectl completion bash > $out/share/bash-completion/completions/kubectl
    $out/bin/kubectl completion zsh > $out/share/zsh/site-functions/_kubectl
  '';

  preFixup = ''
    find $out/bin $pause/bin -type f -exec remove-references-to -t ${go} '{}' +
  '';

  meta = {
    description = "Production-Grade Container Scheduling and Management";
    license = licenses.asl20;
    homepage = https://kubernetes.io;
    maintainers = with maintainers; [johanot offline];
    platforms = platforms.unix;
  };
}
