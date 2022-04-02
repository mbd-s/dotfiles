# Dotfiles

My personal dotfiles for software development on macOS using a `fish` shell. You probably don't want to adopt these wholesale, but feel free to use what you like.

## Prerequisites

- Install [Homebrew](https://brew.sh/)
- Set [`fish`](https://fishshell.com/) as your default shell:

```shell
$ brew install fish
$ chsh -s $(which fish)
```

You can also use these dotfiles with `zsh`. See the [installation instructions](#zsh-shell).

## Installation

First, clone the project:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script works best on a clean install of macOS 12. It will install a bunch of Homebrew packages (as defined in the [Brewfile](Brewfile)); install and configure [asdf](https://github.com/asdf-vm/asdf) plugins; and symlink the config files:

```shell
make setup
```

The command is nondestructive, so it won't overwrite existing files. To delete any existing files, replacing them with the config in this project, run `make setup-force`.

### zsh shell

First, follow the above installation instructions. To switch to `zsh`, just run `$ zsh`. To set `zsh` as the default shell:

```shell
$ chsh -s $(which zsh)
```

Next, symlink the `.zshrc` file in this project to your home directory:

```shell
make zsh-link
```

Finally, install Oh My Zsh, passing the `--keep-zshrc` flag so it won't overwrite the existing `.zshrc` with a boilerplate one:

```shell
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ohmyzsh-install.sh; \
sh ohmyzsh-install.sh --keep-zshrc;
```

To switch back to `fish`, run `$ fish`.

## Configuration

### fish

Private configuration can be stored in `$HOME/.config/fish/private.fish`. It will be ignored by `git`. Example `private.fish`:

```shell
set -x CDPATH . ~ /path/to/directory/that/you/want/in/CDPATH

alias secret echo Something secret!
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
