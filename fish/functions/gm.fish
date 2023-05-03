function gm -d "Update various dependencies and reclaim disk space"
    brewski && echo
    docker_clean && echo
    asdf plugin update --all && echo
    fisher update
end
