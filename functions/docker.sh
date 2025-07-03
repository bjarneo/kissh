# Stop and remove all containers
dclean-containers() {
  echo "Stopping and removing all containers..."
  docker stop $(docker ps -q) &>/dev/null
  docker rm $(docker ps -a -q) &>/dev/null
  echo "Container cleanup complete."
}

# Remove all Docker images (use with caution!)
dclean-images() {
  echo "Removing all Docker images..."
  docker rmi -f $(docker images -q) &>/dev/null
  echo "Image cleanup complete."
}

# Clean up all stopped containers and dangling images/networks
dprune() {
  echo "Pruning Docker system..."
  docker system prune -af
}

# Execute a shell in a running container
dexec() {
  if [ -z "$1" ]; then
    echo "Usage: dexec <container_name_or_id> [shell_command]"
    echo "Default shell is bash."
    return 1
  fi
  local cmd=${2:-"bash"}
  docker exec -it "$1" "$cmd"
}

# Get the IP address of a container
dip() {
  if [ -z "$1" ]; then
    echo "Usage: dip <container_name_or_id>"
    return 1
  fi
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}
