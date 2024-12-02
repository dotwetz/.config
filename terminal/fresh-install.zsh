#Create an Untitled Document at Launch
defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

#Disable the sound effects on boot
defaults write com.apple.systemsound com.apple.sound.beep.volume -int 0

#clean dock
defaults write com.apple.dock static-only -bool true && killall Dock

#Show all file extensions
defaults write -g AppleShowAllExtensions -bool true

#show path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

#show ~/Library
chflags nohidden ~/Library

#show "quit" in finder
# defaults write com.apple.finder QuitMenuItem -bool true && killall Finder

#show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder

#show path bar
defaults write com.apple.finder ShowPathbar -bool true

#show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Hide the dock
defaults write com.apple.dock autohide -bool true

# dont create .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
