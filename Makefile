.PHONY: asdf brew chip clean dracula fisher fonts help link setup

DOTFILES := $(shell pwd)

ASDF_PLUGINS := \
	golang \
	istioctl \
	kubectl \
	kubergrunt \
	nodejs \
	python \
	richgo \
	ruby \
	terraform \
	terragrunt

SYMLINK_DIRS := \
	asdf \
	bat \
	dig \
	fish \
	git \
	lf \
	starship \
	tmux \
	vim \
	vs-code

asdf: ## Installs latest versions of asdf plugins. Usage: `make asdf`.
	$(info Installing asdf plugins)
	@for plugin in $(ASDF_PLUGINS); do \
		asdf plugin add $$plugin || true; \
		asdf install $$plugin latest; \
	done

brew: Brewfile ## Installs Homebrew packages listed in the Brewfile. Usage: `make brew`.
	$(info Installing Homebrew packages)
	@brew bundle
	@brew cleanup

chip: ## Installs ARM-specific dependencies if necessary. Usage: `make chip-support`.
ifeq ($(shell arch),arm64)
	@[ ! -f /Library/Apple/usr/share/rosetta/rosetta ] && (echo "Installing ARM-specific dependencies" && softwareupdate --install-rosetta --agree-to-license) || echo "ARM-specific dependencies already installed"
else
	@echo "No extra dependencies needed for this architecture"
endif

clean: ## Removes all symlinked config files. Usage: `make clean`.
	$(info Unlinking symlinked config files)
	@for dir in $(SYMLINK_DIRS); do \
		stow -vD $$dir; \
	done

dracula: ## Installs Dracula theme for vim, fish, fzf, and k9s. Usage: `make dracula`.
	$(info Installing Dracula theme)
	@mkdir -p /tmp/dracula ~/.config/fish/themes ~/Library/Application\ Support/k9s ~/.vim/pack/themes/start
	@if [ ! -d ~/.vim/pack/themes/start/dracula ]; then \
		git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula; \
	fi
	@curl -sSL https://github.com/dracula/fish/archive/master.zip -o /tmp/dracula/fish.zip
	@unzip /tmp/dracula/fish.zip -d /tmp/dracula > /dev/null
	@mv /tmp/dracula/fish-master/themes/Dracula\ Official.theme ~/.config/fish/themes
	@rm -rf /tmp/dracula
	@fish -c 'set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"'
	@if [ ! -f ~/Library/Application\ Support/k9s/skin.yml ]; then \
		curl -o ~/Library/Application\ Support/k9s/skin.yml -L https://raw.githubusercontent.com/derailed/k9s/master/skins/dracula.yml; \
	fi

fisher: ~/.config/fish/fish_plugins ## Installs fisher and plugins. Usage: `make fisher`.
	$(info Installing fisher)
	@if fish -c "type -q fisher" >/dev/null; then \
		echo "fisher already installed"; \
	else \
		fish -c "curl -sL https://git.io/fisher | source && fisher install < ~/.config/fish/fish_plugins"; \
	fi

fonts: ## Installs Input fonts. Usage: `make fonts`.
	$(info Installing Input fonts from https://input.djr.com)
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
	@for dir in $(SYMLINK_DIRS); do \
		stow -v $$dir; \
	done

setup: link fisher chip dracula brew asdf fonts ## Symlinks config files and installs tools. Usage: `make setup`.

.DEFAULT_GOAL := help
