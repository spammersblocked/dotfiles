brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

brew install mas starship tree

# cask
brew install --cask 1password
brew install --cask bartender
brew install --cask iina
brew install --cask maccy
brew install --cask spotify
brew install --cask brew install --cask aldente
brew install --cask appcleaner
brew install --cask folx
brew install --cask intellij-idea
brew install --cask postman
brew install --cask textsniper
brew install --cask alfred
brew install --cask arc
brew install --cask google-drive
brew install --cask iterm2
brew install --cask rectangle
brew install --cask visual-studio-code

# install powerlevel10k theme
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
sed -i '' 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
source ~/.zshrc

# mas install
# "WhatsApp" = 310633997;
mas install 310633997
# "Bandwidth+" = 490461369;
mas install 490461369
# "1Password for Safari" = 1569813296;
mas install 1569813296
# "Keka" = 470158793;
mas install 470158793
# "Dropover" = 1355679052;
mas install 1355679052