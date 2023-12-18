function brewski --description "Update Homebrew and its packages"
    brew update
    brew upgrade --greedy
    brew cleanup --prune=all
end
