# Source any private .fish files
for fish_file in $__fish_config_dir/private/*.fish
    source $fish_file
end

# Source custom functions
set fish_function_path $fish_function_path $__fish_config_dir/custom_functions

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
set -g BOLD (set_color -o)
set -g RESET_COLOR (set_color normal)

# Include go.mod/go.work in asdf Go version selection
set -gx ASDF_GOLANG_MOD_VERSION_ENABLED true

# Configure jump
jump shell fish | source

# Configure asdf
source (brew --prefix)/opt/asdf/libexec/asdf.fish

# Configure gcloud
source (brew --prefix)/share/google-cloud-sdk/path.fish.inc

# Configure starship
starship init fish | source
