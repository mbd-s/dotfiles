# Dotfiles

My personal dotfiles for software development on macOS. You probably don't want to adopt these wholesale, but feel free to use what you like.

## Prerequisites

You should be running macOS.

## Installation

First, clone the project:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script will install [Homebrew](https://brew.sh/) and its packages (as defined in the [Brewfile](Brewfile)); install and configure [asdf](https://github.com/asdf-vm/asdf) plugins; install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh); and symlink a bunch of config files (without overwriting existing files):

```shell
make setup
```

## Configuration

### iTerm2

1. Open iTerm2.
2. Select `iTerm2 > Preferences`.
3. Under the heading `Profiles`, select `...Other Actions`.
4. Select `Import JSON profiles...` and choose the one you want in `~/dotfiles/iterm/`.

### Visual Studio Code

You can also synchronize your editor configuration across machines with [Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync).

### Git

To split home and work concerns in `git`, nest work-related repositories inside a `work/` directory and configure a different `git` user at `~/dotfiles/git/work/.gitconfig`. Example:

```
[user]
	email = your.name@example.com
```

## Uninstalling

Remove the symlinks:

```shell
make clean
```

Uninstall Oh My Zsh:

```shell
uninstall_oh_my_zsh
```

Uninstall Homebrew (this can have unintended consequences if you're managing applications with Cask):

```shell
make uninstall_homebrew
```
