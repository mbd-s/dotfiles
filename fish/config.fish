# Install and update fisher if it's not already installed
if status is-interactive
    if ! functions -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end
end

# Source any .fish files in the private config directory
for fish_file in $HOME/.config/fish/private/*.fish
    source $fish_file
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
source (brew --prefix)/opt/asdf/libexec/asdf.fish
# Configure gcloud
source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
# Configure starship
starship init fish | source
