# Dotfiles

My personal dotfiles for a `fish` shell on a Silicon Mac running macOS 13, including basic tools and
opinionated settings. You probably don't want to adopt these wholesale, but feel free to use what
you like.

## 🧭 Prerequisites

- [Homebrew](https://brew.sh/)
- [Xcode Command Line Tools](https://mac.install.guide/commandlinetools/index.html)
- [`fish`](https://fishshell.com/)

To configure `fish` as your default shell, run the following commands:

```shell
brew install fish # Install fish via Homebrew
echo $(which fish) | sudo tee -a /etc/shells # Add fish to the list of system shells
chsh -s $(which fish) # Set fish as the default shell
fish # Start a new fish shell
set fish_user_paths (brew --prefix)/bin (brew --prefix)/sbin $fish_user_paths
 # Add brew binaries to $PATH
```

## 🔌 Installation

First, clone the project in your home directory and `cd` into it:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script bootstraps a new Mac. It will symlink the config files and install a bunch of tools
(iTerm2, Visual Studio Code, Go, Terraform, Starship, etc.) via Homebrew and
[asdf](https://github.com/asdf-vm/asdf):

```shell
make setup
```

The command is nondestructive, so it won't overwrite existing files. If you want to overwrite your
local files with the config in this project, run `make setup-force`. Run `make help` to see all
available commands.

## ⚙️ Configuration

### fish

Private configuration can be stored in files with the `.fish` extension in `$__fish_config_dir/private/`.
(Everything in this directory will be ignored by `git`.) Example `secret-config.fish`:

```shell
set -x CDPATH . ~ path/to/directory/you/want/in/CDPATH

alias secret "Something secret!"
```

### git

Create a file at `git/.gitlocal` with your own `git` user details and any aliases or options you
don't want to check into version control. Example:

```
[user]
        name = Your Name
        email = your-git-commit-email-address@example.com
[alias]
        mine = log --author='Your Name'
```

To split home and work concerns, you could nest all work-related repositories inside a `work/`
directory and configure a `git` user for your work projects at `git/work/.gitlocal`. Example:

```
[user]
        email = your-work-git-commit-email-address@example.com
```

### Homebrew

I've split Homebrew packages similarly along home and work concerns. To install the home packages,
create an empty `.home` file in the root of this project. To install the work packages, create an
empty `.work` file instead. (Both files are ignored by `git`.) The common packages are installed in
any case.

### iTerm2

#### Profile

1. Open iTerm2
2. Select `iTerm2 > Preferences`
3. Select `Profiles`
4. Select the `Other Actions...` dropdown menu and click `Import JSON profiles...`
5. Choose the profile you want to use from the ones in `~/dotfiles/iterm/`

#### Key mappings

1. Open iTerm2
2. Select `iTerm2 > Preferences`
3. Select `Profiles`, then `Keys`
4. Select the `Presets...` dropdown menu and click `Import...`
5. Choose `~/dotfiles/iterm/custom.itermkeymap`

### Visual Studio Code

The Visual Studio Code settings file is copied rather than symlinked. I prefer copying over
symlinking because it gets around the mess created when you have a versioned file and also use VS
Code's [Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync) across multiple
machines.

## ✂️ Uninstalling

To remove symlinked files:

```shell
make unlink
```

## 🦀 Contributing

If you notice something that doesn't work, please let me know by
[opening an issue](https://github.com/mbd-s/dotfiles/issues/new/choose)!
