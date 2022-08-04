function countdown -d "Command line timer" -a seconds
    if not test (string match -r '^[0-9]+$' "$seconds")
        echo "Usage: countdown <seconds>" && return
    end

    set -f now (date +%s)
    set -l end_time (math "$now"+"$seconds")

    while test $now -lt $end_time
        set -l display_time (math "$end_time"-"$now")
        printf $GREEN"%s\r" "$(date -u -j -f %s $display_time +%T)"
        sleep 0.25
        set -f now (date +%s)
    end

    printf "Time's up!"$RESET_COLOR
    osascript -e 'display alert "Time\'s up!"' > /dev/null
    echo
end
