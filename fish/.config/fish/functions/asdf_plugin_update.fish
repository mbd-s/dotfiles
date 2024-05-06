function asdf_plugin_update --description "Update outdated asdf plugins"
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
end
