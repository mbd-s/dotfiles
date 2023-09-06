function exal --description "eza with a few more options"
    command eza --long --binary --header --all --icons --time-style=long-iso --color-scale --ignore-glob .DS_Store $argv
end
