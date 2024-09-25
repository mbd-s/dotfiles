function gm --description "Update various dependencies and reclaim disk space"
    brew update
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

    echo $BOLD"Updating outdated asdf plugins"$NORMAL
    asdf plugin-update --all >/dev/null
    set --local plugins (asdf plugin list)
    for plugin in $plugins
        set --local latest_version (asdf latest $plugin)
        set --local installed_versions (string match --regex "[0-9.]+" (asdf list $plugin))
        if contains $latest_version $installed_versions
            echo $GREEN"$plugin $latest_version is already installed"$NORMAL
        else
            echo $BOLD"Installing $plugin $latest_version"$NORMAL
            asdf install $plugin latest
        end
    end
    echo

    mas upgrade 2>/dev/null
    q doctor
end
