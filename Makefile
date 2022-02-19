SHELL=/bin/zsh

.PHONY: link bundle plugins omz clean

setup: link bundle plugins omz

link:
	@echo "Linking config files..."
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

bundle:
	@echo "Installing Homebrew packages..."
	@brew bundle
	@brew cleanup

# Adds various asdf plugins, installs needed versions of them, and sets global versions. Usage: `make plugins`.
plugins:
	@echo "Installing asdf plugins..."
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
	@asdf global terraform 0.14.7

omz:
	@echo "Looking for Oh My Zsh..."
	@if [ -d ~/.oh-my-zsh ]; then \
		echo "Oh My Zsh is already installed"; \
	else \
		echo "Installing Oh My Zsh..."; \
		curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ohmyzsh-install.sh; \
		sh ohmyzsh-install.sh KEEP_ZSHRC=yes; \
	fi

clean:
	@echo "Unlinking symlinked config files..."
	@[ ! -L ~/.asdfrc ] || rm -v ~/.asdfrc
	@[ ! -L ~/.config/bat/config ] || rm -v ~/.config/bat/config
	@[ ! -L ~/.gitconfig ] || rm -v ~/.gitconfig
	@[ ! -L ~/.gitignore_global ] || rm -v ~/.gitignore_global
	@[ ! -L ~/.config/starship.toml ] || rm -v ~/.config/starship.toml
	@[ ! -L ~/.vimrc ] || rm -v ~/.vimrc
	@[ ! -L ~/Library/Application\ Support/Code/User/settings.json ] || rm -v ~/Library/Application\ Support/Code/User/settings.json
	@[ ! -L ~/Library/Application\ Support/Code/User/snippets/go.json ] || rm -v ~/Library/Application\ Support/Code/User/snippets/go.json
	@[ ! -L ~/.zshrc ] || rm -v ~/.zshrc
