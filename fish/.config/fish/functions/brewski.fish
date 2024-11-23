function brewski --description "Update Homebrew and its packages"
    brew upgrade --greedy
    brew autoremove
    brew cleanup --prune=all
    brew doctor >/dev/null
end
