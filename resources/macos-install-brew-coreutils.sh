#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  ## from https://brew.sh/index_pl
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/rafal.zarajczyk/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install coreutils
brew install watch
brew install wget
echo 'PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.zshrc
echo "Done, please reboot the system"
