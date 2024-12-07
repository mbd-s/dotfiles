# Dotfiles

![Screenshot of my shell prompt](https://user-images.githubusercontent.com/13588399/248551301-5a08c7ba-de5c-4e3b-aafb-4dfaa27fcccd.png)

These are my personal dotfiles for a `fish` shell on an ARM-based Mac, including essential tools and opinionated
settings.

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
eval "$(/opt/homebrew/bin/brew shellenv)" # Set up Homebrew in fish
fish_add_path (brew --prefix)/bin (brew --prefix)/sbin # Add Homebrew binaries to $PATH
```

## 🔌 Installation

First, clone the project in your home directory and `cd` into it:

```shell
git clone https://github.com/mbd-s/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The setup script bootstraps a fresh installation of macOS. It will set sane defaults, symlink config files, and install
a bunch of tools (iTerm2, Visual Studio Code, Go, Terraform, Starship, etc.) via Homebrew and
mise:

```shell
make setup
```

The command is nondestructive, so it won't overwrite existing files. Run `make help` to see all available commands.

## ⚙️ Configuration

### fish

Private configuration can be stored in files with the `.fish` extension in `$DOTFILES/fish/.config/fish/private/`. If
you ran `make setup`, everything in this directory will be symlinked to `$__fish_config_dir/private/` but ignored by
`git`. Example:

```shell
set -x CDPATH . ~ path/to/directory/you/want/in/CDPATH

alias secret "Something secret!"
```

### git

Create a file at `$DOTFILES/git/.gitlocal` with your own `git` user details and any aliases or options you don't want to
check into version control. Example:

```
[user]
        name = Your Name
        email = your-git-commit-email-address@example.com
[alias]
        mine = log --author='Your Name'
```

To split home and work concerns, you could nest all work-related repositories inside a `work/` directory and configure a
`git` user for your work projects at `$DOTFILES/git/work/.gitlocal`. Example:

```
[user]
        email = your-work-git-commit-email-address@example.com
```

### Homebrew

I've split Homebrew packages similarly along home and work concerns. To install the home packages, create an empty
`.home` file in the root of this project. To install the work packages, create an empty `.work` file instead. (Both
files are ignored by `git`.) The common packages are installed in any case.

### iTerm2

1. Open iTerm2
2. Select `iTerm2 > Preferences`
3. Select `Profiles`
4. Select the `Other Actions...` dropdown menu and click `Import JSON profiles...`
5. Choose the profile you want to use from the ones in `$DOTFILES/iterm/`

### Visual Studio Code

I find it's best to manage your VS Code settings with profiles and settings sync. The config here is just for reference.

## ✂️ Uninstalling

To remove symlinked files:

```shell
make clean
```

## 🦀 Contributing

If you notice something that doesn't work, please let me know by
[opening an issue](https://github.com/mbd-s/dotfiles/issues/new/choose)!
