#!/bin/bash
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  ## from https://brew.sh/index_pl
brew install coreutils
echo 'PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.zshrc
echo "Done, please reboot the system"
