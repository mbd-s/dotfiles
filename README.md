# Dotfiles

My personal dotfiles for software development on macOS. You probably don't want to adopt these wholesale, but feel free to use what you like.

## Prerequisites

- Install [Homebrew](https://brew.sh/)
- You should be using `zsh` as your shell

## Installation

First, clone the project:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script works best on a clean install of macOS 12. It will install a bunch of Homebrew packages (as defined in the [Brewfile](Brewfile)); install and configure [asdf](https://github.com/asdf-vm/asdf) plugins; install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh); and symlink the config files:

```shell
make setup
```

The command is nondestructive, so it won't overwrite existing files. To delete any existing files, replacing them with the config files in this project, run `make setup-force`.

For other options, run `make help`.

## Configuration

### iTerm2

#### Profile

1. Open iTerm2.
2. Select `iTerm2 > Preferences`.
3. Select `Profiles`
4. Select the `...Other Actions` dropdown menu and click `Import JSON profiles...`
5. Choose the profile you want to use from the ones in `~/dotfiles/iterm/`.

#### Key mappings

1. Open iTerm2.
2. Select `iTerm2 > Preferences`.
3. Select `Profiles`, then `Keys`.
4. Select the `Presets...` dropdown menu and click `Import...`.
5. Choose `~/dotfiles/iterm/custom.itermkeymap`.
### Visual Studio Code

You can also synchronize your editor configuration across machines with [Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync).

### Git

To split home and work concerns in `git`, nest work-related repositories inside a `work/` directory and configure a different `git` user at `~/dotfiles/git/work/.gitconfig`. Example:

```
[user]
	email = your.name@example.com
```

## Uninstalling

To remove the symlinks and uninstall Oh My Zsh:

```shell
make clean
```

To just remove the symlinks:

```shell
make unlink
```
