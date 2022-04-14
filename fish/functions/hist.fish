function hist
    history --show-time="$GREEN%d %B %Y %H:%M:%S  $RESET" $argv | less
end
