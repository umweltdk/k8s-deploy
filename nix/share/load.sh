if [ -n "${BASH_SOURCE}" ]; then
  DIR="$(dirname "${BASH_SOURCE[0]}")"
else
  DIR="/opt/k8s-deploy/share/k8s-deploy"
fi
echo $DIR
if [ -n "$HELM_VERSION" ]; then
  echo "Using: helm $HELM_VERSION"
  export PATH="$DIR/helm/$HELM_VERSION/bin:$PATH"
fi
if [ -n "$KUBERNETES_VERSION" ]; then
  echo "Using: kubectl $KUBERNETES_VERSION"
  export PATH="$DIR/kubectl/$KUBERNETES_VERSION/bin:$PATH"
fi
