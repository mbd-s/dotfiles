.PHONY: brew chip clean dracula fonts help link mac mac-reset mise omz setup

DOTFILES := $(shell pwd)

MISE_PLUGINS := \
	go \
	kubectl \
	nodejs \
	python \
	ruby \
	terraform \
	terragrunt

SYMLINK_DIRS := \
	bat \
	fish \
	git \
	lf \
	starship \
	tmux \
	vim

export __fish_config_dir := ${HOME}/.config/fish

brew: Brewfile ## Installs Homebrew packages. Usage: `make brew`.
	$(info Installing Homebrew packages)
	@brew bundle
	@brew cleanup

chip: ## Installs ARM dependencies. Usage: `make chip`.
ifeq ($(shell arch),arm64)
	@[ ! -f /Library/Apple/usr/share/rosetta/rosetta ] && (echo "Installing ARM-specific dependencies" && softwareupdate --install-rosetta --agree-to-license) || echo "ARM-specific dependencies already installed"
else
	@echo "No extra dependencies needed for this architecture"
endif

clean: ## Removes symlinked config files. Usage: `make clean`.
	$(info Unlinking symlinked config files)
	@read -p "Are you sure you want to unlink symlinked config files? [y/N] " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		for dir in $(SYMLINK_DIRS); do \
			stow --verbose --delete $$dir; \
		done; \
	else \
		echo "Aborted"; \
	fi

dracula: ## Installs Dracula theme. Usage: `make dracula`.
	$(info Installing Dracula theme)
	@mkdir -p /tmp/dracula $${__fish_config_dir}/themes ~/Library/Application\ Support/k9s ~/.vim/pack/themes/start ~/.oh-my-zsh/custom/themes
	@if [ ! -d ~/.vim/pack/themes/start/dracula ]; then \
		git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula; \
	fi
	@curl -sSL https://github.com/dracula/fish/archive/master.zip -o /tmp/dracula/fish.zip
	@unzip /tmp/dracula/fish.zip -d /tmp/dracula > /dev/null
	@mv /tmp/dracula/fish-master/themes/Dracula\ Official.theme $${__fish_config_dir}/themes
	@curl -sSL https://github.com/dracula/zsh/archive/master.zip -o /tmp/dracula/oh-my-zsh.zip
	@unzip /tmp/dracula/oh-my-zsh.zip -d /tmp/dracula > /dev/null
	@mv /tmp/dracula/zsh-master/dracula.zsh-theme ~/.oh-my-zsh/themes
	@rsync -a /tmp/dracula/zsh-master/lib ~/.oh-my-zsh/themes
	@sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="dracula"/' ~/.zshrc
	@rm -rf /tmp/dracula
	@fish -c 'set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"'
	@if [ ! -f ~/Library/Application\ Support/k9s/skin.yml ]; then \
		curl -o ~/Library/Application\ Support/k9s/skin.yml -L https://raw.githubusercontent.com/derailed/k9s/master/skins/dracula.yml; \
	fi

fonts: ## Installs Input fonts. Usage: `make fonts`.
	$(info Installing Input fonts)
	@# Input has 168 TrueType files in its current installation
	@count=$$(find ~/Library/Fonts -type f -name "Input*" | wc -l); \
	if [ $$count -eq 168 ]; then \
		echo "Input already installed"; \
	else \
		mkdir -p /tmp/input-font; \
		curl 'https://input.djr.com/build/?basic=1&fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&lineHeight=1.2&accept=I+do' --output /tmp/input-font/Input-Font.zip; \
		unzip /tmp/input-font/Input-Font.zip -d /tmp/input-font > /dev/null; \
		cp -R /tmp/input-font/Input_Fonts/*/*/* ~/Library/Fonts; \
		rm -rf /tmp/input-font; \
	fi

help: ## Shows this help message. Usage: `make help`.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[38;5;117m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

link: ## Symlinks config files. Usage: `make link`.
	$(info Linking config files)
	@brew list stow > /dev/null 2>&1 || brew install stow
	@for dir in $(SYMLINK_DIRS); do \
		stow --verbose --no-folding $$dir; \
	done

mac: ## Applies new macOS settings. Usage: `make mac`.
	$(info Setting new macOS defaults)
	@./scripts/set-macos-defaults.sh

mac-reset: ## Resets macOS defaults. Usage: `make mac-reset`.
	$(info Resetting macOS defaults)
	@./scripts/reset-macos-defaults.sh

mise: ## Installs mise plugins. Usage: `make mise`.
	$(info Installing mise plugins)
	@for plugin in $(MISE_PLUGINS); do \
		mise install $$plugin@latest; \
	done

omz: ## Installs Oh My Zsh. Usage: `make omz`.
	$(info Installing Oh My Zsh)
	@if [ -d ~/.oh-my-zsh ]; then \
		echo "Oh My Zsh already installed"; \
	else \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	fi

setup: chip mac link brew mise omz dracula fonts ## Symlinks config files and installs tools. Usage: `make setup`.

.DEFAULT_GOAL := help
