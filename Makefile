.PHONY: asdf brew chip-support help link link-zshrc overwrite setup setup-force unlink vs-code

asdf: ## Adds asdf plugins and installs the latest versions of them. Usage: `make asdf`.
	$(info Installing asdf plugins...)
	@asdf plugin add golang https://github.com/kennyp/asdf-golang.git || true
	@asdf install golang latest
	@asdf plugin add istioctl https://github.com/virtualstaticvoid/asdf-istioctl.git || true
	@asdf install istioctl latest
	@asdf plugin add kubectl https://github.com/asdf-community/asdf-kubectl.git || true
	@asdf install kubectl latest
	@asdf plugin add kubergrunt https://github.com/NeoHsu/asdf-kubergrunt.git || true
	@asdf install kubergrunt latest
	@asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
	@asdf install nodejs latest
	@asdf plugin add python https://github.com/danhper/asdf-python.git || true
	@asdf install python latest
	@asdf plugin add richgo https://github.com/paxosglobal/asdf-richgo.git || true
	@asdf install richgo latest
	@asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git || true
	@asdf install ruby latest
	@asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git || true
	@asdf install terraform latest
	@asdf plugin add terragrunt https://github.com/ohmer/asdf-terragrunt || true
	@asdf install terragrunt latest

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

help: ## Shows this help message. Usage: `make help`.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

link: ## Links config files. Usage: `make link`.
	$(info Linking config files)
	@[ -f ~/.asdfrc ] || ln -sv $(PWD)/asdf/.asdfrc ~/.asdfrc
	@[ -f ~/.gitconfig ] || ln -sv $(PWD)/git/.gitconfig ~/.gitconfig
	@[ -f ~/.gitignore_global ] || ln -sv $(PWD)/git/.gitignore_global ~/.gitignore_global
	@[ -f ~/.vimrc ] || ln -sv $(PWD)/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@[ -f ~/.config/bat/config ] || ln -sv $(PWD)/bat/config ~/.config/bat/config
	@[ -f ~/.config/starship.toml ] || ln -sv $(PWD)/starship/starship.toml ~/.config/starship.toml
	@[ -d ~/.config/fish ] || ln -sv $(PWD)/fish ~/.config
	@mkdir -p ~/.config/peco
	@[ -f ~/.config/peco/config.json ] || ln -sv $(PWD)/peco/config.json ~/.config/peco/config.json
	@mkdir -p ~/.config/lf
	@[ -f ~/.config/lf/lfrc ] || ln -sv $(PWD)/lf/lfrc ~/.config/lf/lfrc
	@[ -f ~/.tmux.conf ] || ln -sv $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	@[ -f ~/.digrc ] || ln -sv $(PWD)/dig/.digrc ~/.digrc

link-zshrc: ## Links .zshrc. Usage: `make link-zshrc`.
	$(info Linking .zshrc)
	@[ -f ~/.zshrc ] || ln -sv $(PWD)/zsh/.zshrc ~/.zshrc

overwrite: ## Links config files, overwriting any existing files. Usage: `make overwrite`.
	$(info Overwriting config files)
	@ln -sfnv $(PWD)/asdf/.asdfrc ~/.asdfrc
	@ln -sfnv $(PWD)/git/.gitconfig ~/.gitconfig
	@ln -sfnv $(PWD)/git/.gitignore_global ~/.gitignore_global
	@ln -sfnv $(PWD)/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@ln -sfnv $(PWD)/bat/config ~/.config/bat/config
	@ln -sfnv $(PWD)/starship/starship.toml ~/.config/starship.toml
	@ln -sfnv $(PWD)/fish ~/.config
	@mkdir -p ~/.config/peco
	@ln -sfnv $(PWD)/peco/config.json ~/.config/peco/config.json
	@mkdir -p ~/.config/lf
	@ln -sfnv $(PWD)/lf/lfrc ~/.config/lf/lfrc
	@ln -sfnv $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	@ln -sfnv $(PWD)/dig/.digrc ~/.digrc

setup: | link chip-support brew vs-code asdf ## Links config files and installs Homebrew packages and asdf plugins. Usage: `make setup`.

setup-force: | overwrite chip-support brew vs-code-overwrite asdf ## Overwrites existing config files and installs Homebrew packages and asdf plugins. Usage: `make setup-force`.

unlink: ## Removes all symlinked config files. Usage: `make unlink`.
	$(info Unlinking symlinked config files)
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
	@[ ! -L ~/.tmux.conf ] || rm -v ~/.tmux.conf

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
