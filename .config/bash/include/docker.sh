# Support for OrbStack
if [[ -d "$HOME/.orbstack" ]]; then
  source ~/.orbstack/shell/init.bash 2>/dev/null || :
fi

# Support for Docker commands and aliases
if command -v docker >/dev/null 2>&1; then

  # List all Docker containers
  dps() {
    docker ps --format="table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" "$@"
  }

  # View logs of a running container
  dlogs() {
    if [ -z "$1" ]; then
      echo "Usage: dlogs <container-name>"
      return 1
    fi
    docker logs -f --tail=1000 "$@"
  }

  # Exec into a running container
  dexec() {
    if [ -z "$1" ]; then
      echo "Usage: dexec <container-name> [shell]"
      return 1
    fi

    local shell="${2:-/bin/bash}"
    docker exec -it "$1" "$shell"
  }

  if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ -S "$HOME/.orbstack/run/docker.sock" ]]; then
      export DOCKER_HOST="unix://$HOME/.orbstack/run/docker.sock"
    elif [[ -S "$HOME/.docker/run/docker.sock" ]]; then
      export DOCKER_HOST="unix://$HOME/.docker/run/docker.sock"
    else
      unset DOCKER_HOST
    fi
  fi
fi
