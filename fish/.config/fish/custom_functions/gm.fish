function gm -d "Update various dependencies and reclaim disk space"
    brewski && echo
    docker_clean && echo
    asdf_plugin_update && echo
    mas upgrade
end
