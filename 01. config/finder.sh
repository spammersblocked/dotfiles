find ~/Downloads ~/Documents ~/Desktop /Library -name ".DS_Store" -delete

# show Library folder
chflags nohidden ~/Library

# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show folder in column view
defaults write com.apple.Finder FXPreferredViewStyle clmv

killall Finder;