# Dotfiles

My personal dotfiles for an ARM or Intel Mac running macOS 12 and using a `fish` shell. You probably
don't want to adopt these wholesale, but feel free to use what you like.

## Prerequisites

- [Homebrew](https://brew.sh/)
- [Xcode Command Line Tools](https://mac.install.guide/commandlinetools/index.html)
- [`fish`](https://fishshell.com/)

To set up `fish` as your default shell, run the following commands. They will install `fish`, add it
to the list of system shells, set it as the default shell, and add `brew` binaries to the PATH:

```shell
brew install fish
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths # ARM
set -U fish_user_paths /usr/local/homebrew/bin $fish_user_paths # Intel
```

You can also use these dotfiles with `zsh`. I use `fish` day-to-day but keep my (by now fairly
outdated) `zsh` config handy in case I need to drop into a POSIX-compliant shell. See the
[installation instructions](#zsh-shell).

## Installation

First, clone the project and `cd` into the directory:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script bootstraps a new Mac. It will install a bunch of Homebrew packages (as defined in
the [Brewfile](Brewfile)); install and configure [asdf](https://github.com/asdf-vm/asdf) plugins;
and symlink the config files:

```shell
make setup
```

The command is nondestructive, so it won't overwrite existing files. To delete any existing files,
replacing them with the config in this project, run `make setup-force`.

### zsh shell

First, follow the above installation instructions. To switch to `zsh`, just run `zsh` in the
terminal. To set `zsh` as the default shell:

```shell
$ chsh -s $(which zsh)
```

Next, symlink the `.zshrc` file in this project to your home directory:

```shell
make zsh-link
```

Finally, install Oh My Zsh, passing the `--keep-zshrc` flag so it won't overwrite the existing
`.zshrc` with a boilerplate one:

```shell
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ohmyzsh-install.sh; \
sh ohmyzsh-install.sh --keep-zshrc;
```

To switch back to `fish`, run `fish`.

## Configuration

### fish

Private configuration can be stored in `$HOME/.config/fish/private/` with the `.fish` extension. It will be ignored by
`git`. Example:

```shell
set -x CDPATH . ~ /path/to/directory/that/you/want/in/CDPATH

alias secret "echo Something secret!"
```

### git

Make sure to update the `.gitconfig` with your own user details.

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

### Git

To split home and work concerns in `git`, nest work-related repositories inside a `work/` directory
and configure a different `git` user at `~/dotfiles/git/work/.gitconfig`. Example:

```
[user]
	email = your.name@example.com
```

## Uninstalling

To remove symlinked files:

```shell
make unlink
```
