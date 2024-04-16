function gm --description "Update various dependencies and reclaim disk space"
    brewski
    echo
    docker_clean
    echo
    asdf_plugin_update
    echo
    mas upgrade 2>/dev/null
    cw doctor
end
