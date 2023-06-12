function docker_clean -d "Clean up Docker resources"
    echo $BOLD"Cleaning up Docker resources..."$RESET_COLOR
    for container in $(docker ps -aq)
        docker stop $container
    end
    docker system prune -f
end
