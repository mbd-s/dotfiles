# frozen_string_literal: true

# Taps
tap 'homebrew/bundle'
tap 'homebrew/cask-fonts'
tap 'homebrew/services'
tap 'kreuzwerker/taps'
tap 'kubecolor/tap'
tap 'qmk/qmk'

# Formulas
brew 'ansible' # Automate deployment, configuration, and upgrading
brew 'asdf' # Extendable version manager with support for Ruby, Node.js, Erlang & more
brew 'aws-iam-authenticator' # Use AWS IAM credentials to authenticate to Kubernetes
brew 'awscli' # Official Amazon AWS command-line interface
brew 'bat' # Clone of cat(1) with syntax highlighting and Git integration
brew 'cfssl' # CloudFlare's PKI toolkit
brew 'checkov' # Prevent cloud misconfigurations during build-time for IaC tools
brew 'coreutils' # GNU File, Shell, and Text utilities
brew 'cowsay' # Configurable talking characters in ASCII art
brew 'diff-so-fancy' # Good-lookin' diffs with diff-highlight and more
brew 'direnv' # Load/unload environment variables based on $PWD
brew 'etcd' # Key value store for shared configuration and service discovery
brew 'exa' # Modern replacement for `ls`
brew 'exercism' # Command-line tool to interact with exercism.io
brew 'fd' # Simple, fast and user-friendly alternative to find
brew 'figlet' # Banner-like program prints strings as ASCII art
brew 'fish' # User-friendly command-line shell for UNIX-like operating systems
brew 'fortune' # Infamous electronic fortune-cookie generator
brew 'fzf' # Command-line fuzzy finder written in Go
brew 'gh' # GitHub command-line tool
brew 'ghorg' # Quickly clone an entire org's or user's repositories into one directory
brew 'git' # Distributed revision control system
brew 'gitui' # Blazing fast terminal-ui for git written in rust
brew 'glab' # Open-source GitLab command-line tool
brew 'gnupg' # GNU Pretty Good Privacy (PGP) package
brew 'golangci-lint' # Fast linters runner for Go
brew 'gomplate' # Command-line Golang template processor
brew 'helm' # Kubernetes package manager
brew 'helmfile' # Deploy Kubernetes Helm Charts
brew 'htop' # Improved top (interactive process viewer)
brew 'httpie' # User-friendly cURL replacement (command-line HTTP client)
brew 'imagemagick' # Tools and libraries to manipulate images in many formats
brew 'ipcalc' # Calculate various network masks, etc. from a given IP address
brew 'jc' # Serializes the output of command-line tools to structured JSON output
brew 'jo' # JSON output from a shell
brew 'jq' # Lightweight and flexible command-line JSON processor
brew 'jump' # Helps you navigate your file system faster by learning your habits
brew 'k3d' # Little helper to run CNCF's k3s in Docker
brew 'k9s' # Kubernetes CLI to manage your clusters in style!
brew 'kreuzwerker/taps/m1-terraform-provider-helper' # CLI to support downloading and compiling Terraform providers for ARM-based Macs
brew 'kubecolor/tap/kubecolor' # Colorize your kubectl output
brew 'lf' # Terminal file manager
brew 'libsodium' # NaCl networking and cryptography library
brew 'lolcat' # Rainbows and unicorns in your console!
brew 'mailhog' # Web and API based SMTP testing tool
brew 'mas' # Mac App Store command-line interface
brew 'minikube' # Run a Kubernetes cluster locally
brew 'nmap' # Port scanning utility for large networks
brew 'peco' # Simplistic interactive filtering tool
brew 'pkg-config' # Manage compile and link flags for libraries
brew 'postgresql@14' # Object-relational database system
brew 'qmk/qmk/qmk' # Quantum Mechanical Keyboard (QMK) Firmware
brew 'ripgrep' # Search tool like grep and The Silver Searcher
brew 'shellcheck' # Static analysis and lint tool, for (ba)sh scripts
brew 'starship' # Cross-shell prompt for astronauts
brew 'telnet' # User interface to the TELNET protocol
brew 'terraform-docs' # Tool to generate documentation from Terraform modules
brew 'tig' # Text interface for Git repositories
brew 'tldr' # Simplified and community-driven man pages
brew 'tmux' # Terminal multiplexer
brew 'tree' # Display directories as trees (with optional color/HTML output)
brew 'wget' # Internet file retriever
brew 'yamllint' # Linter for YAML files
brew 'yarn' # JavaScript package manager
brew 'yq' # Process YAML documents from the CLI

# GUI apps
cask_args require_sha: true
cask 'adobe-acrobat-reader' # View, print, and comment on PDF documents
cask 'alfred' # Application launcher and productivity software
cask 'arc' # Chromium based browser
cask 'dbeaver-community' # Universal database tool and SQL client
cask 'docker' # App to build and share containerized applications and microservices
cask 'fig' # Fig adds IDE-style autocomplete to your existing terminal
cask 'firefox' # Web browser
cask 'font-hack-nerd-font' # A typeface designed for source code
cask 'google-chrome', args: { require_sha: false } # Web browser
cask 'google-cloud-sdk', args: { require_sha: false } # Set of tools to manage resources and applications hosted on Google Cloud
cask 'google-drive', args: { require_sha: false } # Client for the Google Drive storage service
cask 'iterm2' # Terminal emulator as alternative to Apple's Terminal app
cask 'libreoffice' # Office suite
cask 'postman' # Collaboration platform for API development
cask 'rectangle' # Move and resize windows using keyboard shortcuts or snap areas
cask 'slack' # Team communication and collaboration software
cask 'via' # Keyboard configurator
cask 'visual-studio-code' # Open-source code editor

# Mac App Store-managed apps
mas 'Bear', id: 1091189122 # Private Markdown Editor for iPhone, iPad and Mac
mas 'Save to Pocket', id: 1477385213 # Your save button for the internet
mas 'StuffIt Expander', id: 919269455 # Free tool to expand SITX, ZIP, ZIPX, SIT5, and RAR archives
mas 'Telephone', id: 406825478 # SIP softphone

# Home- and work-specific dependencies
if File.exist?('.home')
  cask '1password' # Password manager that keeps all passwords secure behind one password
  cask 'backblaze', args: { require_sha: false } # Data backup and storage service
  cask 'discord' # Voice and text chat software
  cask 'signal' # Instant messaging application focusing on security
  cask 'skype' # Video chat, voice call and instant messaging application
  cask 'torguard' # VPN client
  cask 'whatsapp' # Desktop client for WhatsApp
  cask 'zoom' # Video communication and virtual meeting platform

  mas 'Shazam', id: 897118787 # Identify the music playing around you
elsif File.exist?('.work')
  brew 'go-jira' # Simple jira command-line client in Go
end
