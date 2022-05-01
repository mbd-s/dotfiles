function hist
    history --show-time="$GREEN%d %B %Y %H:%M:%S $RESET_COLOR" $argv | less
end
