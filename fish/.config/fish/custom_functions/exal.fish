function exal --wraps='exa -lbha --icons --time-style=long-iso --color-scale' --description 'alias exal exa -lbha --icons --time-style=long-iso --color-scale'
    exa -lbha --icons --time-style=long-iso --color-scale -I .DS_Store $argv
end
