FROM nixorg/nix
RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
ARG nixpkgs
WORKDIR /opt
ENV USER root
COPY . /opt/nix/
RUN nix-env --version && \
  cachix use k8s-deploy && \
  nix-build -I nixpkgs=$nixpkgs -o k8s-deploy -A linked /opt/nix/default.nix
