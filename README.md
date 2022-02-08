# Dotfiles

My personal config.

## Installation
Clone the project:
```
# Make sure you're in the root directory
$ git clone https://github.com/mbd-s/dotfiles.git
$ cd dotfiles
```

Run `make` to install Homebrew and its packages; install Oh My Zsh; and symlink the config files.

Run `make unlink` to remove the config files.

## Configuration

To split home and work concerns in `git`, nest work-related repositories inside a `work` directory and configure a work git user at `git/work/.gitconfig`.
