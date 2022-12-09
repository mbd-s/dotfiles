# Install fisher if it's not already installed
if status is-interactive
    if ! functions -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end
end

# Source any .fish files in the private directory
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
set -g GREEN (set_color green)
set -g RED (set_color red)
set -g RESET_COLOR (set_color normal)

# Configure jump
jump shell fish | source
# Configure asdf
source (brew --prefix)/opt/asdf/libexec/asdf.fish
# Configure gcloud
source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
# Configure starship
starship init fish | source
