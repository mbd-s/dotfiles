function brewski -d "Update Homebrew and its packages"
    brew update
    brew upgrade --greedy --ignore-pinned
    brew cleanup --prune=all
end
