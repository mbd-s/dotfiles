if status is-interactive
    if ! functions -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end
end

if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end

if [ -f $HOME/.config/fish/aliases/main.fish ]
    source $HOME/.config/fish/aliases/main.fish
end

set -g theme_color_scheme dracula
set fish_greeting # Disable fish_greeting

set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx LESS "-R"
set -g GREEN (tput setaf 2)
set -g RED (tput setaf 1)
set -g RESET_COLOR (tput sgr0)

jump shell fish | source # Configure jump

# Configure asdf
if test (arch) = 'arm64'
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
else
    source /usr/local/opt/asdf/libexec/asdf.fish
end

starship init fish | source # Configure starship
