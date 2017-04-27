# Dotfiles

My personal config.

## Dependencies
- `Homebrew`
- `Oh My Zsh`

## Installation
Clone the project:
```
# Make sure you're in the root directory
$ git clone https://github.com/mbd-s/dotfiles.git
$ cd dotfiles
```

Install [`Homebrew`](https://brew.sh/).

Run `brew bundle` to install Homebrew packages.

Install [`Oh My Zsh`](https://github.com/ohmyzsh/ohmyzsh#basic-installation).

Symlink the config files.

## Configuration

To split home and work concerns in `git`, nest work-related repositories inside a `work` directory and configure a work git user at `git/work/.gitconfig`.

## To-dos
- TODO: Makefile targets to install/uninstall `Homebrew`.
- TODO: Makefile targets to install/uninstall `Oh My Zsh`.
- TODO: Makefile targets to add/remove symlinks to config files.
