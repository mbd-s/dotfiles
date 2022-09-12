# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
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
HIST_STAMPS="%d %B %Y %H:%M"
HISTSIZE=100000000
HISTFILESIZE=100000000

plugins=(
  asdf
  aws
  brew
  bundler
  colored-man-pages
  colorize
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

export ZSH_COLORIZE_TOOL=chroma # Pygments is the default
export ZSH_COLORIZE_STYLE=igor # Also nice: arduino, borland

export PATH=/usr/local/sbin:$PATH

export HOMEBREW_NO_ENV_HINTS=1

alias audit="bundle exec bundle-audit check --update" # Update bundle-audit when checking
alias be="bundle exec"
alias brewski="brew update && brew upgrade --greedy --ignore-pinned && brew cleanup && mas upgrade"
alias dc="docker-compose"
alias drc="docker-compose run --rm development bundle exec rails c"
alias drubocop="docker-compose run --rm development bundle exec rubocop"
alias dtest="docker-compose run --rm test"
alias exa="exa -a --icons"
alias exal="exa -lbha --icons --time-style=long-iso --color-scale"
alias exall="exa -lbhHigUmua --icons --time-style=long-iso --git --color-scale"
alias gti="git"
alias k="kubectl"
alias rd="docker-compose run --rm development"
alias serve="./server.sh"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias song="music playing" # Apple Music control via macos plugin
alias speedtest="networkQuality -v" # Test quality of network connection
alias zopen="vi $HOME/.zshrc"
alias zource="source $HOME/.zshrc"

# Relies on a function `creds` to refresh AWS credentials
aws_switch () {
    env_name=$1

    export AWS_PROFILE=$env_name
    export AWS_DEFAULT_REGION=eu-central-1

    kubectl config unset current-context > /dev/null

    echo "$(tput setaf 2)### AWS Identity ###$(tput sgr0)"
    aws sts get-caller-identity --no-cli-pager

    local exit_code=$?
    if [[ $exit_code == "253" ]]; then
        return
    elif [[ $exit_code == "254" ]]; then
        echo "Refreshing credentials..." && creds && sleep 10 && aws sts get-caller-identity --no-cli-pager || return
    fi

    clusters=($(aws eks list-clusters --query clusters --output text))
    clusters+=("The active cluster")
    PS3="$(tput setaf 2)Select a cluster by number: $(tput sgr0)"
    select cluster_name in ${clusters}; do
        break
    done

    if [[ "$cluster_name" == "The active cluster" ]]; then
        for cluster in ${clusters}; do
            if [ $(aws eks describe-cluster --name $cluster --query cluster.tags.active --output text) = true ]; then
                cluster_name=$cluster
                break
            fi
        done
    fi

    if [[ "$cluster_name" != "" ]]; then
        aws eks update-kubeconfig --name $cluster_name --region $AWS_DEFAULT_REGION
        echo "$(tput setaf 2)Connected to $cluster_name in the $env_name environment.$(tput sgr0)"
    else;
        echo "$(tput setaf 1)No valid cluster was selected, so kubeconfig was not updated.$(tput sgr0)"
    fi
}

pysetup () {
    if [ -d "$(pwd)/venv" ]; then
        source venv/bin/activate
    else
        python -m venv venv && source venv/bin/activate && pip install --upgrade pip
    fi
}

qq () {
    clear

    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi

    if [[ ! -f "$logpath" ]]; then
        echo 'Q LOG' > "$logpath"
    fi

    tail -100f -- "$logpath"
}

rmqq () {
    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi
    if [[ -f "$logpath" ]]; then
        rm "$logpath"
    fi
    qq
}

weather () {
    curl wttr.in/$1
}

moo () {
    fortune | cowsay -f "$(cowsay -l | sed '1 d' | tr ' ' '\n' | shuf -n 1)"
}

countdown () {
    if [[ $# -eq 0 ]] || ! [[ $1 =~ '^[0-9]+$' ]]; then
        echo "Usage: countdown <seconds>"
        return
    fi

    local now=$(date +%s)
    local end=$((now + $1))
    while (( now < end )); do
        printf "$(tput setaf 2)%s\r" "$(date -u -j -f %s $((end - now)) +%T)"
        sleep 0.25
        now=$(date +%s)
    done
    printf "Time's up!$(tput sgr0)"
    osascript -e 'display alert "Time'\''s up!"' > /dev/null
    echo
}

stopwatch () {
    case $1 in
        start)
            echo "Stopwatch running..."
            start=$SECONDS
            ;;
        stop)
            if [ -n "$start" ]; then
                stop=$SECONDS
                elapsed_time=$((stop - start))
                echo "Time elapsed: $(gdate -d@$elapsed_time -u +%H:%M:%S)"
            else
                echo "Stopwatch not started"
                return
            fi
            ;;
        *)
            echo "Usage: stopwatch start|stop"
            ;;
    esac
}

eval "$(direnv hook zsh)" # Set up direnv
eval "$(starship init zsh)" # Set up starship

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
