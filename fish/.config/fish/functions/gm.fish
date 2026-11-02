function gm --description "Update various dependencies"
    brew upgrade --greedy
    brew autoremove
    brew cleanup --prune=all
    brew doctor >/dev/null
    echo

    echo $BOLD"Updating outdated mise plugins"$NORMAL
    mise upgrade

    mas upgrade 2>/dev/null
end
