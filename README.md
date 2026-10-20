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

To version these files without making them public, keep them in a private overlay repo instead: a stow package that links them into `$__fish_config_dir/private/` with `--no-folding`, so they sit next to anything linked from this repo.

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

`.gitconfig` includes `~/.gitlocal`, so the file can also come from a private overlay repo that links it there.

To split home and work concerns, you could nest all work-related repositories inside a `work/` directory and configure a
`git` user for your work projects at `$DOTFILES/git/work/.gitlocal`. Example:

```
[user]
        email = your-work-git-commit-email-address@example.com
```

### Claude Code

`~/.claude/settings.json` isn't symlinked, because Claude Code writes to it (`/config` values, the model). Instead, settings come in layers in `~/.claude/settings.d/`, and `make claude-settings` merges them into `settings.json` in lexical order:

- `00-base.json`, tracked in `claude/` and symlinked via `make link`, holds preferences, tool permissions and hooks.
- Other layers can come from another stow repo or be plain files, such as `90-local.json` for hooks that tools on this machine install with absolute paths.

Objects merge, arrays concatenate without duplicates, and a later layer's value wins. Keys that no layer defines, such as `model`, are kept from the existing `settings.json`. The target shows a diff and asks before writing, and keeps the previous file as a timestamped `settings.json.bak-*`.

To merge the layers, run:

```shell
make claude-settings
```

The target runs `make link` first, so the symlinked `00-base.json` is in place before the merge.

Hooks referenced from `00-base.json` live in `claude/.claude/hooks/`.

To install skills, first create `~/.claude/skills/skills.conf` with one `SKILL,REPO` entry per line:

```
example-claude-skill,https://github.com/example/example-claude-skill
```

Then run:

```shell
make skills
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
5. Choose the profile you want to use from the ones in `$DOTFILES/iterm2/`

## ✂️ Uninstalling

To remove symlinked files:

```shell
make clean
```

## 🦀 Contributing

If you notice something that doesn't work, please let me know by
[opening an issue](https://github.com/mbd-s/dotfiles/issues/new/choose)!
