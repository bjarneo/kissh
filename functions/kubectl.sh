# Function to show the current kubectl context
function kube_context() {
  if ! command -v kubectl &>/dev/null; then
    echo "Error: kubectl is not installed or not in PATH"
    return 1
  fi

  local context=$(kubectl config current-context 2>/dev/null)
  if [ -z "$context" ]; then
    echo "Error: No kubectl context set or kubectl not configured"
    return 1
  fi

  echo "$context"
}

# Function to show the current kubectl namespace
function kube_namespace() {
  if ! command -v kubectl &>/dev/null; then
    echo "Error: kubectl is not installed or not in PATH"
    return 1
  fi

  local namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  if [ -z "$namespace" ]; then
    echo "default"
  else
    echo "$namespace"
  fi
}

# Function to show both context and namespace
function kube_info() {
  if ! command -v kubectl &>/dev/null; then
    echo "Error: kubectl is not installed or not in PATH"
    return 1
  fi

  local context=$(kube_context)
  local namespace=$(kube_namespace)
  
  if [ $? -eq 0 ]; then
    echo "Context: $context | Namespace: $namespace"
  else
    return 1
  fi
}
