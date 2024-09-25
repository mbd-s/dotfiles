function docker_clean --description "Clean up Docker resources"
    echo $BOLD"Cleaning up Docker resources..."$NORMAL
    docker info &> /dev/null; or echo $RED"Docker isn't running"$NORMAL && return 1

    for container in $(docker ps --quiet)
        docker stop $container
    end

    docker system prune --all --volumes --force
end
