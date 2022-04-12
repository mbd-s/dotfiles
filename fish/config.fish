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
set fish_greeting

set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx LESS "-R"
set -g GREEN (tput setaf 2)
set -g RED (tput setaf 1)
set -g RESET (tput sgr0)

source /usr/local/opt/asdf/libexec/asdf.fish
starship init fish | source
