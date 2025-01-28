#!/bin/zsh
if [[ $SHELL != '/bin/zsh' ]]; then
  echo "Please set ZSH as your default shell" && exit 1
fi

if [ $(command -v brew) ]; then
  echo "brew already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  ## from https://brew.sh/
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew install coreutils
brew install watch
brew install wget
brew install screen
echo 'PATH="'$(brew --prefix coreutils)'/libexec/gnubin:$PATH"' >> ~/.zshrc
echo "Done, please reboot the system"
