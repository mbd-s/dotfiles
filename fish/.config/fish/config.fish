# Source any private .fish files
for fish_file in $__fish_config_dir/private/*.fish
    source $fish_file
end

# Set Dracula Official color scheme if it's installed
if test -e "$__fish_config_dir/themes/Dracula Official.theme"
    fish_config theme choose "Dracula Official"
else
    fish_config theme choose Dracula
end

# Disable fish_greeting
set fish_greeting

# Disable Homebrew hints
set --global --export HOMEBREW_NO_ENV_HINTS 1

# Disable Homebrew ask mode
set --global --export HOMEBREW_NO_ASK 1

# Set default options for less
set --global --export LESS -FR

# Add aliases for colored text
set --global CYAN (set_color 8be9fd)
set --global GREEN (set_color 50fa7b)
set --global ORANGE (set_color ffb86c)
set --global PINK (set_color ff79c6)
set --global PURPLE (set_color bd93f9)
set --global RED (set_color ff5555)
set --global YELLOW (set_color f1fa8c)
set --global BOLD (set_color --bold)
set --global NORMAL (set_color normal)

# Configure krew
fish_add_path $HOME/.krew/bin

# Configure jump
# jump's `j` uses `builtin cd`, which bypasses fish's cd function and so never
# appends to $dirprev. That leaves `cd -` popping a stale entry, or failing
# outright when nothing was ever recorded. Rewrite it to the cd function.
if command --search jump >/dev/null
    jump shell fish | string replace --all 'builtin cd' cd | source

    # jump's completion offers cd's matches ahead of its own database. cd
    # completes across $CDPATH and fuzzy-matches, so `j inc` finds a
    # subsequence match such as ~/dotfiles-work-review-dependencies and never
    # asks jump. Keep only the cd matches that start with the typed term.
    function __jump_hint
        set -l term (commandline --cut-at-cursor --current-token)
        set -l prefix '^'(string escape --style=regex -- $term)
        set -l local_dirs (complete --do-complete "cd $term" | string match --regex -- '.*/$' | string match --regex --ignore-case --entire -- $prefix)

        if test (count $local_dirs) -gt 0
            printf '%s\n' $local_dirs
        else if not string match -q '*/*' -- $term
            jump hint "$term" | head -1
        end
    end
end

# Update PATH for the Google Cloud SDK
if test -f (brew --prefix)/share/google-cloud-sdk/path.fish.inc
    source (brew --prefix)/share/google-cloud-sdk/path.fish.inc
end

# Suppress deprecation warning by pointing gcloud at a 3.10+ python3, resolved dynamically to work across machines
set --global --export CLOUDSDK_PYTHON (command -s python3)

# Configure starship
if command --search starship >/dev/null
    starship init fish | source
end

# Configure fzf
if command --search fzf >/dev/null
    fzf --fish | source
    bind --erase \cr
end
