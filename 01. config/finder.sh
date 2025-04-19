
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

# delete all .DS_Store
sudo find ~ -name ".DS_Store" -delete

killall Finder;