# Support docker
_is_cmd_exist docker && {

    dps () {
        docker ps --format="table {{.Names}}\t{{.Status}}" $@
    }

    dlogs () {
        docker logs -f --tail 1000 $@
    }

    dexec () {
        docker exec -it $@
    }

    if [ "$OS" == "Darwin" ]; then
      export DOCKER_HOST=unix://"$HOME/.docker/run/docker.sock"
    fi

}
