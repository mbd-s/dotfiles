function docker_clean --description "Clean up Docker resources"
    echo $BOLD"Cleaning up Docker resources..."$RESET_COLOR
    docker info &> /dev/null; or echo $RED"Docker isn't running"$RESET_COLOR && return 1
    for container in $(docker ps --all --quiet)
        docker stop $container
    end
    docker system prune --force
end
