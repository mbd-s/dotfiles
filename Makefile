SHELL=/bin/zsh

.PHONY: homebrew link bundle omz unlink uninstall_homebrew

install: homebrew link bundle omz

homebrew:
	@echo "Looking for Homebrew..."
ifneq (, $(shell which brew))
	@echo "Homebrew is already installed"
else
	@echo "Installing Homebrew..."
	@/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"
endif

link:
	@echo "Linking config files..."
	@[ -f ~/.asdfrc ] || ln -s -v $(PWD)/asdf/.asdfrc ~/.asdfrc
	@[ -f ~/.gitconfig ] || ln -s -v $(PWD)/git/.gitconfig ~/.gitconfig
	@[ -f ~/.gitignore_global ] || ln -s -v $(PWD)/git/.gitignore_global ~/.gitignore_global
	@[ -f ~/.vimrc ] || ln -s -v $(PWD)/vim/.vimrc ~/.vimrc
	@[ -f ~/.zshrc ] || ln -s -v $(PWD)/zsh/.zshrc ~/.zshrc

	@mkdir -p ~/.config
	@mkdir -p ~/.config/bat
	@[ -f ~/.config/bat/config ] || ln -s -v $(PWD)/bat/config ~/.config/bat/config
	@[ -f ~/.config/starship.toml ] || ln -s -v $(PWD)/starship/starship.toml ~/.config/starship.toml

bundle:
	@echo "Installing Homebrew packages..."
	@brew bundle
	@brew cleanup

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
	@[ ! -L ~/.zshrc ] || rm -v ~/.zshrc

uninstall_homebrew:
	@echo "Uninstalling Homebrew..."
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall)"
