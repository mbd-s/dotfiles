.PHONY: asdf brew chip-support help link link-zshrc overwrite setup setup-force unlink vs-code

asdf: ## Adds asdf plugins, installs specified versions of them, and sets global versions. Usage: `make asdf`.
	$(info Installing asdf plugins...)
	@asdf plugin-add golang || true
	@asdf install golang latest
	@asdf global golang latest
	@asdf plugin-add python || true
	@asdf install python latest
	@asdf global python latest
	@asdf plugin-add richgo || true
	@asdf install richgo latest
	@asdf global richgo latest
	@asdf plugin-add ruby || true
	@asdf install ruby latest
	@asdf global ruby latest
	@asdf plugin-add terraform || true
	@asdf install terraform latest
	@asdf plugin-add istioctl || true
	@asdf install istioctl latest
	@asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git || true
	@asdf install kubectl latest
	@asdf plugin-add terragrunt https://github.com/ohmer/asdf-terragrunt || true
	@asdf install terragrunt latest
	@asdf plugin-add kubergrunt || true
	@asdf install kubergrunt latest

brew: ## Installs Homebrew packages listed in the Brewfile. Usage: `make brew`.
	$(info Installing Homebrew packages)
	@brew bundle
	@brew cleanup

chip-support: ## Installs ARM-specific dependencies if necessary. Usage: `make chip-support`.
ifeq ($(shell arch),arm64)
	@[ ! -f /Library/Apple/usr/share/rosetta/rosetta ] && (echo "Installing ARM-specific dependencies" && softwareupdate --install-rosetta --agree-to-license) || echo "ARM-specific dependencies already installed"
else
	@echo "No extra dependencies needed for this architecture"
endif

help: ## Shows this help message. Usage: `make help`.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

link: ## Links config files. Usage: `make link`.
	$(info Linking config files...)
	@[ -f ~/.asdfrc ] || ln -s -v $(PWD)/asdf/.asdfrc ~/.asdfrc
	@[ -f ~/.gitconfig ] || ln -s -v $(PWD)/git/.gitconfig ~/.gitconfig
	@[ -f ~/.gitignore_global ] || ln -s -v $(PWD)/git/.gitignore_global ~/.gitignore_global
	@[ -f ~/.vimrc ] || ln -s -v $(PWD)/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@[ -f ~/.config/bat/config ] || ln -s -v $(PWD)/bat/config ~/.config/bat/config
	@[ -f ~/.config/starship.toml ] || ln -s -v $(PWD)/starship/starship.toml ~/.config/starship.toml
	@[ -d ~/.config/fish ] || ln -s -v $(PWD)/fish ~/.config/fish
	@mkdir -p ~/.config/peco
	@[ -f ~/.config/peco/config.json ] || ln -s -v $(PWD)/peco/config.json ~/.config/peco/config.json
	@mkdir -p ~/.config/lf
	@[ -f ~/.config/lf/lfrc ] || ln -s -v $(PWD)/lf/lfrc ~/.config/lf/lfrc

link-zshrc: ## Links .zshrc. Usage: `make link-zshrc`.
	$(info Linking .zshrc...)
	@[ -f ~/.zshrc ] || ln -s -v $(PWD)/zsh/.zshrc ~/.zshrc

overwrite: ## Links config files, overwriting any existing files. Usage: `make overwrite`.
	$(info Overwriting config files...)
	@ln -sfn $(PWD)/asdf/.asdfrc ~/.asdfrc
	@ln -sfn $(PWD)/git/.gitconfig ~/.gitconfig
	@ln -sfn $(PWD)/git/.gitignore_global ~/.gitignore_global
	@ln -sfn $(PWD)/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@ln -sfn $(PWD)/bat/config ~/.config/bat/config
	@ln -sfn $(PWD)/starship/starship.toml ~/.config/starship.toml
	@ln -sfn $(PWD)/fish ~/.config
	@mkdir -p ~/.config/peco
	@ln -sfn $(PWD)/peco/config.json ~/.config/peco/config.json
	@mkdir -p ~/.config/lf
	@ln -sfn $(PWD)/lf/lfrc ~/.config/lf/lfrc

setup: | link chip-support brew vs-code asdf ## Links config files and installs Homebrew packages and asdf plugins. Usage: `make setup`.

setup-force: | overwrite chip-support brew vs-code asdf ## Overwrites existing config files and installs Homebrew packages and asdf plugins. Usage: `make setup-force`.

unlink: ## Removes all symlinked config files. Usage: `make unlink`.
	$(info Unlinking symlinked config files...)
	@[ ! -L ~/.asdfrc ] || rm -v ~/.asdfrc
	@[ ! -L ~/.config/bat/config ] || rm -v ~/.config/bat/config
	@[ ! -L ~/.gitconfig ] || rm -v ~/.gitconfig
	@[ ! -L ~/.gitignore_global ] || rm -v ~/.gitignore_global
	@[ ! -L ~/.config/starship.toml ] || rm -v ~/.config/starship.toml
	@[ ! -L ~/.vimrc ] || rm -v ~/.vimrc
	@[ ! -L ~/.zshrc ] || rm -v ~/.zshrc
	@[ ! -L ~/.config/fish ] || rm -rfv ~/.config/fish
	@[ ! -L ~/.config/peco/config.json ] || rm -v ~/.config/peco/config.json
	@[ ! -L ~/.config/lf/lfrc ] || rm -v ~/.config/lf/lfrc

vs-code: ## Sets up Visual Studio Code config files. Usage: `make vs-code`.
	$(info Setting up Visual Studio Code config)
	@[ -f ~/Library/Application\ Support/Code/User/settings.json ] || cp $(PWD)/vs-code/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@[ -f ~/Library/Application\ Support/Code/User/snippets/go.json ] || ln -s -v $(PWD)/vs-code/snippets/go.json ~/Library/Application\ Support/Code/User/snippets/go.json

.DEFAULT_GOAL := help
