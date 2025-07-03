# Plugin: kubectl.plugin.sh
# Adds aliases and functions for interacting with kubectl.

# General aliases
alias k='kubectl'

# Short aliases for common commands
alias kgp='kubectl get pods'
alias kgd='kubectl get deployment'
alias kgs='kubectl get service'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdn='kubectl describe node'
alias kl='kubectl logs'
alias kpf='kubectl port-forward'
alias kex='kubectl exec -it'

# Function to show the current kubectl context
function kube_context() {
  kubectl config current-context
}

# Function to show the current kubectl namespace
function kube_namespace() {
  kubectl config view --minify --output 'jsonpath={..namespace}'
}
