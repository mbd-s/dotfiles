function asdf_plugin_update -d "Update outdated asdf plugins"
    echo $BOLD"Updating outdated asdf plugins"$RESET_COLOR
    asdf plugin-update --all
    set -l plugins (asdf latest --all)
    for plugin in $plugins
        switch $plugin
            case "*missing"
                set -l missing_plugin (string match -r '[a-z]+' $plugin)
                echo $BOLD"Installing latest version of $missing_plugin"$RESET_COLOR
                asdf install $missing_plugin latest
        end
    end
end
