#!/bin/bash

sudo -v

echo "• Show hidden files in the Finder"
defaults write com.apple.finder AppleShowAllFiles true

echo "• Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "• Show the status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "• Show the path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "• Disable warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "• Show scroll bars only when scrolling"
defaults write -globalDomain AppleShowScrollBars -string WhenScrolling

echo "• Click in the scroll bar to jump to the spot that's clicked"
defaults write -globalDomain AppleScrollerPagingBehavior -bool true

echo "• Autohide the Dock"
defaults write com.apple.dock autohide -bool true

echo "• Don't display recent applications in the Dock"
defaults write com.apple.dock show-recents -bool false

echo "• Set the default Finder location to the Home folder"
defaults write com.apple.finder NewWindowTarget -string PfLo && defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME"

echo "• Set the Appearance to Auto (takes effect after the next restart)"
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

echo "• Set the screenshot location to ~/Documents/Screenshots"
mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture location -string "~/Documents/Screenshots"

echo "• Show full URLs (apart from the scheme) in Safari"
sudo defaults write com.apple.safari ShowFullURLInSmartSearchField -bool true

echo "• Ask websites not to track"
sudo defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "• Don't show a warning when changing the file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "• Disable auto-correct"
defaults write -globalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Restart Finder and Dock to apply changes
killall Finder
killall Dock
