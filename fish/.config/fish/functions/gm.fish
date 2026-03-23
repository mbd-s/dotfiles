function gm --description "Update various dependencies"
    brew upgrade --greedy
    brew autoremove
    brew cleanup --prune=all
    brew doctor >/dev/null
    echo

    echo $BOLD"Updating outdated mise plugins"$NORMAL
    mise upgrade

    echo $BOLD"Updating skills"$NORMAL
    npx skills update

    mas upgrade 2>/dev/null
end
