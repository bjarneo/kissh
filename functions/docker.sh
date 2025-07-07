# Stop and remove all containers
dclean-containers() {
  if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    return 1
  fi

  local containers=$(docker ps -q 2>/dev/null)
  if [ -z "$containers" ]; then
    echo "No running containers to clean up."
    return 0
  fi

  echo "Stopping and removing all containers..."
  if docker stop $containers 2>/dev/null && docker rm $containers 2>/dev/null; then
    echo "Container cleanup complete."
  else
    echo "Error: Failed to clean up some containers"
    return 1
  fi
}

# Remove all Docker images (use with caution!)
dclean-images() {
  if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    return 1
  fi

  local images=$(docker images -q 2>/dev/null)
  if [ -z "$images" ]; then
    echo "No images to remove."
    return 0
  fi

  echo "WARNING: This will remove ALL Docker images!"
  echo "Are you sure you want to continue? (y/N)"
  read -r response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Removing all Docker images..."
    if docker rmi -f $images 2>/dev/null; then
      echo "Image cleanup complete."
    else
      echo "Error: Failed to remove some images"
      return 1
    fi
  else
    echo "Image cleanup cancelled."
  fi
}

# Clean up all stopped containers and dangling images/networks
dprune() {
  if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    return 1
  fi

  echo "Pruning Docker system..."
  if docker system prune -af; then
    echo "Docker system prune completed."
  else
    echo "Error: Docker system prune failed"
    return 1
  fi
}

# Execute a shell in a running container
dexec() {
  if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    return 1
  fi

  if [ -z "$1" ]; then
    echo "Usage: dexec <container_name_or_id> [shell_command]"
    echo "Default shell is bash."
    return 1
  fi

  local container="$1"
  local cmd=${2:-"bash"}
  
  # Check if container exists and is running
  if ! docker ps --format "table {{.Names}}\t{{.ID}}" | grep -q "$container"; then
    echo "Error: Container '$container' is not running or doesn't exist"
    return 1
  fi

  docker exec -it "$container" "$cmd"
}

# Get the IP address of a container
dip() {
  if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    return 1
  fi

  if [ -z "$1" ]; then
    echo "Usage: dip <container_name_or_id>"
    return 1
  fi

  local container="$1"
  
  # Check if container exists
  if ! docker ps -a --format "table {{.Names}}\t{{.ID}}" | grep -q "$container"; then
    echo "Error: Container '$container' doesn't exist"
    return 1
  fi

  local ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$container" 2>/dev/null)
  if [ -z "$ip" ]; then
    echo "Error: Could not get IP address for container '$container'"
    return 1
  fi

  echo "$ip"
}
