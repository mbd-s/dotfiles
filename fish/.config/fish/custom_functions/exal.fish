function exal --description "exa with a few more options"
    command exa --long --binary --header --all --icons --time-style=long-iso --color-scale --ignore-glob .DS_Store $argv
end
