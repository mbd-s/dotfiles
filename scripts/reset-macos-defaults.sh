#!/bin/bash

sudo -v

echo "• Don't show hidden files in the Finder"
defaults write com.apple.finder AppleShowAllFiles false

echo "• Hide all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool false

echo "• Hide the status bar"
defaults write com.apple.finder ShowStatusBar -bool false

echo "• Hide the path bar"
defaults write com.apple.finder ShowPathbar -bool false

echo "• Enable warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool true

echo "• Always show scroll bars"
defaults write -globalDomain AppleShowScrollBars -string Always

echo "• Click in the scroll bar to jump to the next page"
defaults write -globalDomain AppleScrollerPagingBehavior -bool false

echo "• Always display the Dock"
defaults write com.apple.dock autohide -bool false

echo "• Display recent applications in the Dock"
defaults write com.apple.dock show-recents -bool true

echo "• Resetting the default Finder location to the virtual Recents folder has to be done manually. Open Finder settings, select \"Sidebar,\" and check \"Recents.\""

echo "• Don't change the Appearance automatically (takes effect after the next restart)"
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool false

echo "• Reset the screenshot location to ~/Desktop"
defaults delete com.apple.screencapture location

echo "• Hide full URLs in Safari"
sudo defaults write com.apple.safari ShowFullURLInSmartSearchField -bool false

echo "• Don't ask websites not to track"
sudo defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool false

echo "• Show a warning when changing the file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

echo "• Enable auto-correct"
defaults write -globalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Restart Finder and Dock to apply changes
killall Finder
killall Dock
