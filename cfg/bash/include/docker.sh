# Support docker
__command docker && {

    dps () {
        docker ps --format="table {{.Names}}\t{{.Status}}" $@
    }

    dclean () {
        docker volume ls -qf dangling=true | xargs docker volume rm 
        docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
    }

}
