function brewski --description "Update Homebrew and its packages"
    brew update
    brew upgrade --greedy
    brew cleanup --prune=all
    brew doctor > /dev/null
end
