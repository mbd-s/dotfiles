function countdown --description "Command line timer" --argument-names seconds
    if not test (string match --regex '^[0-9]+$' "$seconds")
        echo "Usage: countdown <seconds>" && return
    end

    set --function now (date +%s)
    set --local end_time (math "$now"+"$seconds")

    while test $now -lt $end_time
        set --local display_time (math "$end_time"-"$now")
        printf $GREEN"%s\r" "$(date -u -j -f %s $display_time +%T)"
        sleep 0.25
        set --function now (date +%s)
    end

    printf "Time's up!"$NORMAL
    osascript -e 'display alert "Time\'s up!"' >/dev/null
    echo
end
