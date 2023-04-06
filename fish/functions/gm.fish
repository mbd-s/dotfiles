function gm -d "Update various dependencies and reclaim disk space"
    brewski
    docker_clean
    asdf plugin update --all
    fisher update
end
