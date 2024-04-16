function docker_clean --description "Clean up Docker resources"
    echo $BOLD"Cleaning up Docker resources..."$RESET_COLOR
    for container in $(docker ps --all --quiet)
        docker stop $container
    end
    docker system prune --force
end
