export ZSH="$HOME/.oh-my-zsh"

# cd autocompletion
setopt auto_cd
cdpath+=($HOME/work $HOME/home $HOME)

# Enable completion
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Homebrew autocompletion
if type brew &>/dev/null; then
 fpath+=$(brew --prefix)/share/zsh/site-functions
fi

# zsh autocompletion
if type brew &>/dev/null; then
  fpath+=$(brew --prefix)/share/zsh-completions
fi

# zsh autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# kubectl autocompletion
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
complete -F __start_kubectl k

# terraform autocompletion
complete -o nospace -C /usr/local/bin/terraform terraform

ZSH_THEME=""

# zsh history
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  asdf
  aws
  brew
  bundler
  colored-man-pages
  command-not-found
  git
  golang
  helm
  kubectl
  macos
  python
  rails
  ruby
  terraform
  web-search
)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/sbin:$PATH

export HOMEBREW_NO_ENV_HINTS=1

alias brewski="brew update && brew upgrade --ignore-pinned && brew cleanup"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias ls="exa -a" # Format with color and show hidden files by default
alias lsh="exa -ld .?*" # Format with color and show only hidden files
alias zource="source $HOME/.zshrc"
alias zopen="vi $HOME/.zshrc"
alias be="bundle exec"
alias audit="bundle exec bundle-audit check --update" # Update bundle-audit when checking
alias serve="./server.sh"
alias ngrok="$HOME/./ngrok"
alias gti="git"
alias k="kubectl"
alias dc="docker-compose"
alias dtest="docker-compose run --rm test"
alias drubocop="docker-compose run --rm development bundle exec rubocop"
alias drc="docker-compose run --rm development bundle exec rails c"
alias rd="docker-compose run --rm development"

function aws_switch () {
  envname=$1

  export AWS_PROFILE=$envname
  export AWS_DEFAULT_REGION=eu-central-1

  kubectl config unset current-context > /dev/null

  aws sts get-caller-identity --no-cli-pager

  echo
  echo "Type the name of the cluster you want to connect to or:"
  echo " - Type 'list' (or 'l') to list available clusters"
  echo " - Type 'active' (or 'a') or hit the 'enter' key to connect to the active cluster"
  echo " - Type 'none' or 'n' to skip connecting to a cluster"
  read cluster_name
  echo

  if [[ "$cluster_name" == "active" || "$cluster_name" == "a" || "$cluster_name" == "" ]]; then
    cluster_name=""
    for cluster in $(aws eks list-clusters --query clusters --output text); do
      if [ $(aws eks describe-cluster --name $cluster --query cluster.tags.active --output text) = true ]; then
        cluster_name=$cluster
        break
      fi
    done
  fi

  if [[ "$cluster_name" == "none" || "$cluster_name" == "n" ]]; then
    cluster_name=""
  fi

  if [[ "$cluster_name" == "list" || "$cluster_name" == "l" ]]; then
    echo "Choose a cluster by number:"
    echo "0) None (skip this step)"
    cluster_name=""
    select cluster_name in $(aws eks list-clusters --query clusters --output text); do
      break
    done
  fi

  if [[ "$cluster_name" != "" ]]; then
    aws eks update-kubeconfig --name $cluster_name --region $AWS_DEFAULT_REGION
  fi
}

function pysetup () {
  if [ -d "$(pwd)/venv" ]; then
    source venv/bin/activate
  else
    python -m venv venv && source venv/bin/activate && pip install --upgrade pip
  fi
}

eval "$(starship init zsh)"
