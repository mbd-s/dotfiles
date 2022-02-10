# Dotfiles

My personal config.

## Installation

Clone the project:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Install [Homebrew](https://brew.sh/) and its dependencies (listed in the [Brewfile](Brewfile)); install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh); and symlink the config files (without overwriting existing files):

```shell
make install
```

## Configuration

To split home and work concerns in `git`, nest work-related repositories inside a `work` directory and configure a different `git` user at `git/work/.gitconfig`. Example:

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
