#!/bin/bash

case "$1" in
    *.txt) highlight -O ansi "$1" ;;
    *.py) highlights --style=monokai "$1" ;;
    *.sh) highlight -O ansi --syntax=sh "$1" ;;
    *.c|*.h) highlight -O ansi --syntax=c "$1" ;;
    *.cpp|*.hpp) highlight -O ansi --syntax=cpp "$1" ;;
    *.go) highlight -O ansi --syntax=go "$1" ;;
    *.rb) highlight -O ansi --syntax=ruby "$1" ;;
    *Brewfile) highlight -O ansi --syntax=ruby "$1" ;;
    *Makefile) source-highlight --out-format=esc -o STDOUT -i "$1" ;;
    *.fish) highlight -O ansi --syntax=fish "$1" ;;
    *.yml|*.yaml) highlight -O ansi --syntax=yaml "$1" ;;
    *.json) highlight -O ansi --syntax=json "$1" ;;
    *.toml) highlight -O ansi --syntax=toml "$1" ;;
    *.md) highlight -O ansi --syntax=markdown "$1" ;;
    *.vimrc) highlight -O ansi --syntax=vim "$1" ;;
    *.tf) highlight -O ansi --syntax=terraform "$1" ;;
    *.hcl) highlight -O ansi --syntax=terraform "$1" ;;
    *.tfvars) highlight -O ansi --syntax=terraform "$1" ;;
    *.tfstate) highlight -O ansi --syntax=terraform "$1" ;;
    *.tfrs) highlight -O ansi --syntax=terraform "$1" ;;
    *.tgr) highlight -O ansi --syntax=terragrunt "$1" ;;
    *.tpl) highlight -O ansi --syntax=helm "$1" ;;
    *) cat "$1" ;; # Default behavior: simply display the file content
esac
