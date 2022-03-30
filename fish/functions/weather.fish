function weather
    if count $argv > /dev/null
        curl wttr.in/(string join + $argv)
    else
        curl wttr.in/
    end
end
