function man --wraps man --description "Colorize man pages"
    set -x LESS_TERMCAP_md (set_color --bold 8be9fd)
    set -x LESS_TERMCAP_me (set_color normal)
    set -x LESS_TERMCAP_us (set_color --underline bd93f9)
    set -x LESS_TERMCAP_ue (set_color normal)
    set -x LESS_TERMCAP_so (set_color --reverse f1fa8c)
    set -x LESS_TERMCAP_se (set_color normal)
    command man $argv
end
