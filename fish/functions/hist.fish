function hist -d 'Display history in color, with timestamps'
    history --show-time="$GREEN%d %B %Y %H:%M:%S $RESET_COLOR" $argv | less
end
