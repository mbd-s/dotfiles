SHELL=/bin/zsh

.PHONY: homebrew link bundle omz unlink uninstall_homebrew

all: homebrew link bundle omz

homebrew:
	@echo "Looking for Homebrew..."
ifneq (, $(shell which brew))
	@echo "Homebrew already installed"
else
	@echo "Installing Homebrew..."
	@/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"
endif

link:
	@echo "Linking config files..."
	@[ -f ~/.asdfrc ] || ln -s $(PWD)/asdf/.asdfrc ~/.asdfrc
	@[ -f ~/.gitconfig ] || ln -s $(PWD)/git/.gitconfig ~/.gitconfig
	@[ -f ~/.gitignore_global ] || ln -s $(PWD)/git/.gitignore_global ~/.gitignore_global
	@[ -f ~/.vimrc ] || ln -s $(PWD)/vim/.vimrc ~/.vimrc
	@[ -f ~/.zshrc ] || ln -s $(PWD)/zsh/.zshrc ~/.zshrc

	@mkdir -p ~/.config
	@[ -f ~/.config/starship.toml ] || ln -s $(PWD)/starship/starship.toml ~/.config/starship.toml

bundle:
	@echo "Installing Homebrew packages..."
	brew bundle

omz:
	@echo "Looking for Oh My Zsh installation..."
	@if [ -d ~/.oh-my-zsh ]; then \
		echo "Oh My Zsh is already installed"; \
	else \
		echo "Installing Oh My Zsh..."; \
		curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ohmyzsh-install.sh; \
		sh ohmyzsh-install.sh KEEP_ZSHRC=yes; \
	fi

unlink:
	@echo "Unlinking config files..."
	@[ ! -L ~/.asdfrc ] || rm -v ~/.asdfrc
	@[ ! -L ~/.gitconfig ] || rm -v ~/.gitconfig
	@[ ! -L ~/.gitignore_global ] || rm -v ~/.gitignore_global
	@[ ! -L ~/.config/starship.toml ] || rm -v ~/.config/starship.toml
	@[ ! -L ~/.vimrc ] || rm -v ~/.vimrc
	@[ ! -L ~/.zshrc ] || rm -v ~/.zshrc

uninstall_homebrew:
	@echo "Uninstalling Homebrew..."
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall)"
