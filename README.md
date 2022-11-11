# Dotfiles

My personal dotfiles for a `fish` shell on macOS 12 (or later), including basic tools and
opinionated settings. You probably don't want to adopt these wholesale, but feel free to use what
you like.

## Prerequisites

- [Homebrew](https://brew.sh/)
- [Xcode Command Line Tools](https://mac.install.guide/commandlinetools/index.html)
- [`fish`](https://fishshell.com/)

To configure `fish` as your default shell, run the following commands:

```shell
brew install fish # Install fish
echo $(which fish) | sudo tee -a /etc/shells # Add fish to the list of system shells
chsh -s $(which fish) # Set fish as the default shell
fish # Start a new fish shell
fish_add_path /opt/homebrew/bin # Add brew binaries to the PATH (for M1/M2 ARM architecture)
fish_add_path /usr/local/bin /usr/local/sbin # Add brew binaries to the PATH (for Intel x86 architecture)
```

You can also use these dotfiles with `zsh`. I use `fish` day-to-day but keep my (by now fairly
outdated) `zsh` config handy in case I need to drop into a POSIX-compliant shell. See the
[zsh installation instructions](#zsh-shell) below.

## Installation

First, clone the project and `cd` into the directory:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script bootstraps a new Mac. It will symlink the config files and install a bunch
of tools (iTerm2, Visual Studio Code, Go, etc.) via Homebrew and
[asdf](https://github.com/asdf-vm/asdf):

```shell
make setup
```

The command is nondestructive, so it won't overwrite existing files. To overwrite local files with
the config in this project, run `make setup-force`. Run `make help` to see all available commands.

### zsh shell

First, follow the [general installation instructions](#installation) above. To switch to `zsh`, just
run `zsh` in the terminal. To reset `zsh` as the default shell, run:

```shell
chsh -s $(which zsh)
```

Next, symlink the `.zshrc` in this project to your home directory:

```shell
make zsh-link
```

Finally, install Oh My Zsh, passing the `--keep-zshrc` flag so it won't overwrite the `.zshrc` you
just symlinked with a boilerplate one:

```shell
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ohmyzsh-install.sh; \
sh ohmyzsh-install.sh --keep-zshrc;
```

To switch back to `fish`, just type `fish`.

## Configuration

### fish

Private configuration can be stored in `~/.config/fish/private/` with the `.fish` extension. It will
be ignored by `git`. Example:

```shell
set -x CDPATH . ~ /path/to/directory/that/you/want/in/CDPATH

alias secret "Something secret!"
```

### git

Create a file at `~/dotfiles/git/.gitlocal` with your own `git` user details. Example:

```
[user]
        name = Your Name
        email = your-git-commit-email-address@example.com
[alias]
        mine = log --author='Your name'
```

To split home and work concerns, nest all work-related repositories inside a `work/` directory and
configure a `git` user for your work projects at `~/dotfiles/git/work/.gitconfig`. Example:

```
[user]
        email = your-work-git-commit-email-address@example.com
```

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

The Visual Studio Code settings file is copied rather than symlinked. I prefer copying over
symlinking because it gets around the mess created when you have a versioned file and also use VS
Code's [Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync) across multiple
machines.

## Uninstalling

To remove symlinked files:

```shell
make unlink
```
