# Function to show the current kubectl context
function kube_context() {
  kubectl config current-context
}

# Function to show the current kubectl namespace
function kube_namespace() {
  kubectl config view --minify --output 'jsonpath={..namespace}'
}
