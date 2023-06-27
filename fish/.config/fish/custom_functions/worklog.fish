function worklog -d "Wrapper for jira worklog"
    set -l options h/help "o/offset=" "c/comment=" "i/issue=" "t/time=" "s/start="

    argparse $options -- $argv or return

    set -l usage ""
    set usage "Usage: worklog -i/issue <issue> -c/comment <comment> [options...]\n"
    set usage "$usage -i, --issue <issue>     The issue to log work to (required)\n"
    set usage "$usage -c, --comment <issue>   The comment on the worklog (required)\n"
    set usage "$usage -t, --time <time>       The time spent on the issue (default: 8h)\n"
    set usage "$usage -s, --start <time>      The date and time the work started (default: 09:00 today)\n"
    set usage "$usage -o, --offset <time>     Offset the start by a given amount of time (e.g., -1d, 30m)\n"
    set usage "$usage -h, --help              Show this help message"

    if set -q _flag_help
        printf "%b" $usage && return
    end

    if not set -q _flag_comment or not set -q _flag_issue
        printf "%b" $usage && return
    end

    if set -q _flag_offset
        set -f offset -v$_flag_offset
    end

    set -q _flag_time; or set -l _flag_time 8h
    set -q _flag_start; or set -l _flag_start 09:00

    jira worklog add --comment=$_flag_comment --time-spent=$_flag_time --started=$(date -u $offset +%Y-%m-%dT$_flag_start:00.000+0200) --noedit $_flag_issue
end
