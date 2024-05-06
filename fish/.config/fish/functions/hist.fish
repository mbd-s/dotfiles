function hist --description "Display history in color, with timestamps"
    history --show-time="$GREEN%d %B %Y %H:%M:%S $NORMAL" $argv | less
end
