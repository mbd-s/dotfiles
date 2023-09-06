function exall --description "eza with a lot of options"
    command eza --long --binary --header --links --inode --group --created --modified --accessed --git --all --icons --time-style=long-iso --color-scale --ignore-glob .DS_Store $argv
end
