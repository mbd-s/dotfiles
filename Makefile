.PHONY: asdf brew chip-support dracula fisher fonts help link overwrite setup setup-force unlink vs-code

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

asdf: ## Installs latest versions of asdf plugins. Usage: `make asdf`.
	$(info Installing asdf plugins)
	@for plugin in $(ASDF_PLUGINS); do \
		asdf plugin add $$plugin || true; \
		asdf install $$plugin latest; \
	done

brew: ## Installs Homebrew packages listed in the Brewfile. Usage: `make brew`.
	$(info Installing Homebrew packages...)
	@brew bundle
	@brew cleanup

chip-support: ## Installs ARM-specific dependencies if necessary. Usage: `make chip-support`.
ifeq ($(shell arch),arm64)
	@[ ! -f /Library/Apple/usr/share/rosetta/rosetta ] && (echo "Installing ARM-specific dependencies" && softwareupdate --install-rosetta --agree-to-license) || echo "ARM-specific dependencies already installed"
else
	@echo "No extra dependencies needed for this architecture"
endif

dracula: ## Installs Dracula theme. Usage: `make dracula`.
	$(info Installing Dracula theme for vim, fish, and fzf)
	@if [ ! -d ~/.vim/pack/themes/start/dracula ]; then \
		mkdir -p ~/.vim/pack/themes/start && \
		git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula; \
	fi
	@mkdir -p /tmp/dracula && \
	curl -sSL https://github.com/dracula/fish/archive/master.zip -o /tmp/dracula/fish.zip
	@unzip /tmp/dracula/fish.zip -d /tmp/dracula > /dev/null
	@mv /tmp/dracula/fish-master/themes/Dracula\ Official.theme ~/.config/fish/themes
	@rm -rf /tmp/dracula
	@fish -c 'set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"'

fisher: ## Installs fisher and plugins. Usage: `make fisher`.
	$(info Installing fisher...)
	@fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
	@fish -c "fisher update"

help: ## Shows this help message. Usage: `make help`.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[38;5;117m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

fonts: ## Installs Input fonts. Usage: `make fonts`.
	$(info Installing Input fonts from https://input.djr.com)
	@mkdir -p /tmp/input-font
	@curl 'https://input.djr.com/build/?basic=1&fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&lineHeight=1.2&accept=I+do' --output /tmp/input-font/Input-Font.zip
	@unzip /tmp/input-font/Input-Font.zip -d /tmp/input-font > /dev/null
	@cp -R /tmp/input-font/Input_Fonts/*/*/* ~/Library/Fonts
	@rm -rf /tmp/input-font

link: ## Symlinks config files. Usage: `make link`.
	$(info Linking config files)
	@[ -f ~/.asdfrc ] || ln -sv $(PWD)/asdf/.asdfrc ~/.asdfrc
	@[ -f ~/.gitconfig ] || ln -sv $(PWD)/git/.gitconfig ~/.gitconfig
	@[ -f ~/.gitignore_global ] || ln -sv $(PWD)/git/.gitignore_global ~/.gitignore_global
	@[ -f ~/.vimrc ] || ln -sv $(PWD)/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@[ -f ~/.config/bat/config ] || ln -sv $(PWD)/bat/config ~/.config/bat/config
	@[ -f ~/.config/starship.toml ] || ln -sv $(PWD)/starship/starship.toml ~/.config/starship.toml
	@[ -d ~/.config/fish/custom_functions ] || ln -sfnv $(PWD)/fish/custom_functions ~/.config/fish/custom_functions
	@[ -d ~/.config/fish/private ] || ln -sfnv $(PWD)/fish/private ~/.config/fish/private
	@[ -f ~/.config/fish/config.fish ] || ln -sv $(PWD)/fish/config.fish ~/.config/fish/config.fish
	@[ -f ~/.config/fish/conf.d/abbreviations.fish ] || ln -sfnv $(PWD)/fish/abbreviations.fish ~/.config/fish/conf.d/abbreviations.fish
	@[ -f ~/.config/fish/fish_plugins ] || ln -sfnv $(PWD)/fish/fish_plugins ~/.config/fish/fish_plugins
	@mkdir -p ~/.config/lf
	@[ -f ~/.config/lf/lfrc ] || ln -sv $(PWD)/lf/lfrc ~/.config/lf/lfrc
	@[ -f ~/.config/lf/icons ] || ln -sv $(PWD)/lf/icons ~/.config/lf/icons
	@[ -f ~/.config/lf/pv.sh ] || ln -sv $(PWD)/lf/pv.sh ~/.config/lf/pv.sh
	@[ -f ~/.tmux.conf ] || ln -sv $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	@[ -f ~/.digrc ] || ln -sv $(PWD)/dig/.digrc ~/.digrc

overwrite: ## Symlinks config files, replacing any existing files. Usage: `make overwrite`.
	$(info Overwriting config files)
	@ln -sfnv $(PWD)/asdf/.asdfrc ~/.asdfrc
	@ln -sfnv $(PWD)/git/.gitconfig ~/.gitconfig
	@ln -sfnv $(PWD)/git/.gitignore_global ~/.gitignore_global
	@ln -sfnv $(PWD)/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@ln -sfnv $(PWD)/bat/config ~/.config/bat/config
	@ln -sfnv $(PWD)/starship/starship.toml ~/.config/starship.toml
	@ln -sfnv $(PWD)/fish/custom_functions ~/.config/fish/custom_functions
	@ln -sfnv $(PWD)/fish/private ~/.config/fish/private
	@ln -sfnv $(PWD)/fish/config.fish ~/.config/fish/config.fish
	@ln -sfnv $(PWD)/fish/abbreviations.fish ~/.config/fish/conf.d/abbreviations.fish
	@ln -sfnv $(PWD)/fish/fish_plugins ~/.config/fish/fish_plugins
	@mkdir -p ~/.config/lf
	@ln -sfnv $(PWD)/lf/lfrc ~/.config/lf/lfrc
	@ln -sfnv $(PWD)/lf/icons ~/.config/lf/icons
	@ln -sfnv $(PWD)/lf/pv.sh ~/.config/lf/pv.sh
	@ln -sfnv $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	@ln -sfnv $(PWD)/dig/.digrc ~/.digrc

setup: | link fisher chip-support dracula brew vs-code asdf fonts ## Symlinks config files and installs Homebrew packages and asdf plugins. Usage: `make setup`.

setup-force: | overwrite fisher chip-support dracula brew vs-code-overwrite asdf fonts ## Overwrites existing config files and installs Homebrew packages and asdf plugins. Usage: `make setup-force`.

unlink: ## Removes all symlinked config files. Usage: `make unlink`.
	$(info Unlinking symlinked config files)
	@[ ! -L ~/.asdfrc ] || rm -v ~/.asdfrc
	@[ ! -L ~/.config/bat/config ] || rm -v ~/.config/bat/config
	@[ ! -L ~/.gitconfig ] || rm -v ~/.gitconfig
	@[ ! -L ~/.gitignore_global ] || rm -v ~/.gitignore_global
	@[ ! -L ~/.config/starship.toml ] || rm -v ~/.config/starship.toml
	@[ ! -L ~/.vimrc ] || rm -v ~/.vimrc
	@[ ! -L ~/.config/fish/custom_functions ] || rm -rfv ~/.config/fish/custom_functions
	@[ ! -L ~/.config/fish/config.fish ] || rm -v ~/.config/fish/config.fish
	@[ ! -L ~/.config/fish/conf.d/abbreviations.fish ] || rm -v ~/.config/fish/conf.d/abbreviations.fish
	@[ ! -L ~/.config/fish/fish_plugins ] || rm -v ~/.config/fish/fish_plugins
	@[ ! -L ~/.config/lf/lfrc ] || rm -v ~/.config/lf/lfrc
	@[ ! -L ~/.config/lf/icons ] || rm -v ~/.config/lf/icons
	@[ ! -L ~/.config/lf/pv.sh ] || rm -v ~/.config/lf/pv.sh
	@[ ! -L ~/.tmux.conf ] || rm -v ~/.tmux.conf
	@[ ! -L ~/.digrc ] || rm -v ~/.digrc

vs-code: ## Sets up VS Code config files. Usage: `make vs-code`.
	$(info Setting up VS Code config)
	@[ -f ~/Library/Application\ Support/Code/User/settings.json ] || cp $(PWD)/vs-code/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@[ -f ~/Library/Application\ Support/Code/User/snippets/go.json ] || ln -sv $(PWD)/vs-code/snippets/go.json ~/Library/Application\ Support/Code/User/snippets/go.json

vs-code-overwrite: ## Overwrites VS Code config files. Usage: `make vs-code-overwrite`.
	$(info Overwriting local VS Code settings)
	@cp $(PWD)/vs-code/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@ln -sfv $(PWD)/vs-code/snippets/go.json ~/Library/Application\ Support/Code/User/snippets/go.json

vs-code-local: ## Overwrites this repo's VS Code config with local settings. Useful for managing changes when sync is disabled. Usage: `make vs-code-local`.
	$(info Overwriting this repo's VS Code settings with the local settings)
	@cp ~/Library/Application\ Support/Code/User/settings.json $(PWD)/vs-code/settings.json

.DEFAULT_GOAL := help
