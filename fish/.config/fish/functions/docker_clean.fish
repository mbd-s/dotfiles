function docker_clean --description "Clean up Docker resources"
    echo $YELLOW"Cleaning up unused Docker resources..."$NORMAL
    docker info &> /dev/null; or echo $RED"Docker isn't running"$NORMAL && return 1

    echo
    echo $YELLOW"Unused networks (not auto-removed):"$NORMAL
    docker network ls --filter "dangling=true"

    set --local pre_clean_df (docker system df)

    echo
    echo $YELLOW"Removing stopped containers"$NORMAL
    docker container prune --force

    echo
    echo $YELLOW"Removing dangling images"$NORMAL
    docker image prune --force

    echo
    echo $YELLOW"Removing build cache"$NORMAL
    docker builder prune --force

    echo
    echo $YELLOW"Removing unused local volumes"$NORMAL
    docker volume prune --force

    echo
    echo $YELLOW"Before cleanup:"$NORMAL
    printf "%s\n" $pre_clean_df

    echo
    echo $YELLOW"After cleanup:"$NORMAL
    docker system df
end
