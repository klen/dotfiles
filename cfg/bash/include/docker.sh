# Support docker
__is_cmd_exist docker && {

    dps () {
        docker ps --format="table {{.Names}}\t{{.Status}}" $@
    }

    dlogs () {
        docker logs -f --tail 1000 $@
    }

    dexec () {
        docker exec -it $@
    }

}
