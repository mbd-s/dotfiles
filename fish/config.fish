# Install and update fisher if it's not already installed
if status is-interactive
    if ! functions -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end
end

# Source the private config if it exists
if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end

# Source the alias definitions if they exist
if [ -f $HOME/.config/fish/aliases/main.fish ]
    source $HOME/.config/fish/aliases/main.fish
end

# Set dracula color scheme
set -g theme_color_scheme dracula
# Disable fish_greeting
set fish_greeting
# Disable Homebrew hints
set -gx HOMEBREW_NO_ENV_HINTS 1
# Set default options for less
set -gx LESS -FR
# Add aliases for colored text
set -g GREEN (tput setaf 2)
set -g RED (tput setaf 1)
set -g RESET_COLOR (tput sgr0)

# Configure jump
jump shell fish | source

# Configure asdf
if test (arch) = arm64
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
else
    source /usr/local/opt/asdf/libexec/asdf.fish
end

# Configure starship
starship init fish | source
