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
if command --search jump >/dev/null
    jump shell fish | source
end

# Update PATH for the Google Cloud SDK
if test -f (brew --prefix)/share/google-cloud-sdk/path.fish.inc
    source (brew --prefix)/share/google-cloud-sdk/path.fish.inc
end

# Configure starship
if command --search starship >/dev/null
    starship init fish | source
end

# Configure fzf
if command --search fzf >/dev/null
    fzf --fish | source
    bind --erase \cr
end
