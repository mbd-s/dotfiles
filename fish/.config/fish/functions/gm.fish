function gm --description "Update various dependencies and reclaim disk space"
    brew upgrade --greedy
    brew autoremove
    brew cleanup --prune=all
    brew doctor >/dev/null
    echo

    echo $BOLD"Cleaning up Docker resources..."$NORMAL
    if docker info &> /dev/null
        for container in $(docker ps --quiet)
            docker stop $container
        end
        docker system prune --all --volumes --force
    else
        echo $RED"Docker isn't running"$NORMAL
    end
    echo

    echo $BOLD"Updating outdated mise plugins"$NORMAL
    mise upgrade

    mas upgrade 2>/dev/null
end
