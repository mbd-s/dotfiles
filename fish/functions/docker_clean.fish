function docker_clean -d 'Clean up Docker resources'
    echo 'Cleaning up Docker resources...'
    for container in $(docker ps -aq)
        docker stop $container
    end
    docker system prune -f
end
