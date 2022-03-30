.PHONY: bundle clean help link omz overwrite plugins setup setup-force unlink

bundle: ## Installs Homebrew packages listed in the Brewfile. Usage: `make bundle`.
	$(info Installing Homebrew packages)
	@brew bundle
	@brew cleanup

clean: unlink ## Removes all symlinked config files and uninstalls Oh My Zsh. Usage: `make clean`.
	$(info Removing symlinked config files and uninstalling Oh My Zsh...)
	@uninstall_oh_my_zsh

help: ## Shows this help message. Usage: `make help`.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

link: ## Links config files to the home directory. Usage: `make link`.
	$(info Linking config files...)
	@[ -f ~/.asdfrc ] || ln -s -v $(PWD)/asdf/.asdfrc ~/.asdfrc
	@[ -f ~/.gitconfig ] || ln -s -v $(PWD)/git/.gitconfig ~/.gitconfig
	@[ -f ~/.gitignore_global ] || ln -s -v $(PWD)/git/.gitignore_global ~/.gitignore_global
	@[ -f ~/.vimrc ] || ln -s -v $(PWD)/vim/.vimrc ~/.vimrc
	@[ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s -v $(PWD)/vs-code/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@[ -f ~/Library/Application\ Support/Code/User/snippets/go.json ] || ln -s -v $(PWD)/vs-code/snippets/go.json ~/Library/Application\ Support/Code/User/snippets/go.json
	@[ -f ~/.zshrc ] || ln -s -v $(PWD)/zsh/.zshrc ~/.zshrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@[ -f ~/.config/bat/config ] || ln -s -v $(PWD)/bat/config ~/.config/bat/config
	@[ -f ~/.config/starship.toml ] || ln -s -v $(PWD)/starship/starship.toml ~/.config/starship.toml
	@[ ! -d "~/.config/fish" ] && ln -s -v $(PWD)/fish ~/.config

omz: ## Installs Oh My Zsh if it's not already installed. Usage: `make omz`.
	$(info Looking for Oh My Zsh...)
	@if [ -d ~/.oh-my-zsh ]; then \
		$(info Oh My Zsh is already installed. Run `make overwrite` to overwrite your existing .zshrc with the one in this project.); \
	else \
		echo "Installing Oh My Zsh..."; \
		curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ohmyzsh-install.sh; \
		sh ohmyzsh-install.sh --keep-zshrc; \
		cd ~/dotfiles; \
	fi

overwrite: ## Links config files to the home directory, overwriting any existing files. Usage: `make overwrite`.
	$(info Overwriting config files...)
	@ln -sfn $(PWD)/asdf/.asdfrc ~/.asdfrc
	@ln -sfn $(PWD)/git/.gitconfig ~/.gitconfig
	@ln -sfn $(PWD)/git/.gitignore_global ~/.gitignore_global
	@ln -sfn $(PWD)/vim/.vimrc ~/.vimrc
	@ln -sfn $(PWD)/vs-code/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@ln -sfn $(PWD)/vs-code/snippets/go.json ~/Library/Application\ Support/Code/User/snippets/go.json
	@ln -sfn $(PWD)/zsh/.zshrc ~/.zshrc
	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@ln -sfn $(PWD)/bat/config ~/.config/bat/config
	@ln -sfn $(PWD)/starship/starship.toml ~/.config/starship.toml
	@ln -sfn $(PWD)/fish ~/.config

plugins: ## Adds various asdf plugins, installs specified versions of them, and sets global versions. Usage: `make plugins`.
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
	@asdf install terraform 0.14.7
	@asdf plugin-add istioctl || true
	@asdf install istioctl latest
	@asdf install istioctl 1.11.4

setup: | link bundle plugins omz ## Links config files and installs Homebrew packages, asdf plugins, and Oh My Zsh. Usage: `make setup`.

setup-force: | overwrite bundle plugins omz ## Overwrites config files and installs Homebrew packages, asdf plugins, and Oh My Zsh. Usage: `make setup-force`.

unlink: ## Removes all symlinked config files. Usage: `make unlink`.
	$(info Unlinking symlinked config files...)
	@[ ! -L ~/.asdfrc ] || rm -v ~/.asdfrc
	@[ ! -L ~/.config/bat/config ] || rm -v ~/.config/bat/config
	@[ ! -L ~/.gitconfig ] || rm -v ~/.gitconfig
	@[ ! -L ~/.gitignore_global ] || rm -v ~/.gitignore_global
	@[ ! -L ~/.config/starship.toml ] || rm -v ~/.config/starship.toml
	@[ ! -L ~/.vimrc ] || rm -v ~/.vimrc
	@[ ! -L ~/Library/Application\ Support/Code/User/settings.json ] || rm -v ~/Library/Application\ Support/Code/User/settings.json
	@[ ! -L ~/Library/Application\ Support/Code/User/snippets/go.json ] || rm -v ~/Library/Application\ Support/Code/User/snippets/go.json
	@[ ! -L ~/.zshrc ] || rm -v ~/.zshrc
	@[ ! -L ~/.config/fish ] || rm -rfv ~/.config/fish

.DEFAULT_GOAL := help
