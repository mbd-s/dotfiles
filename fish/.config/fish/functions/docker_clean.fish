function docker_clean --description "Clean up Docker resources"
    echo $BOLD"Cleaning up Docker resources..."$NORMAL
    docker info &> /dev/null; or echo $RED"Docker isn't running"$NORMAL && return 1
    for container in $(docker ps --all --quiet)
        docker stop $container
    end

    docker container prune --force
    docker volume prune --all --force
    docker network prune --force
    docker image prune --all --force
    docker builder prune --all --force --verbose
    docker system prune --all --force
end
