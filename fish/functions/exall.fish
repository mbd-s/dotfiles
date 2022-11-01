function exall --wraps='exa -lbhHigUmua --icons --time-style=long-iso --git --color-scale' --description 'alias exall exa -lbhHigUmua --icons --time-style=long-iso --git --color-scale'
    exa -lbhHigUmua --icons --time-style=long-iso --git --color-scale -I .DS_Store $argv
end
