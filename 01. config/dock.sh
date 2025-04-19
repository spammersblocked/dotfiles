# auto hide
defaults write com.apple.dock autohide-time-modifier -float 0;

# app size and magnifier
defaults write com.apple.dock tilesize -int 25;
defaults write com.apple.dock largesize -int 130;

# remove all apps
defaults delete com.apple.dock persistent-apps;

# add apps
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>System/Applications/App Store.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>';
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/IntelliJ Idea.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>';
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>';
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Arc.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>';

killall Dock