#!/bin/zsh
if [[ $SHELL != '/bin/zsh' ]]; then
  echo "Please set ZSH as your default shell" && exit 1
fi

# docs: https://github.com/pyenv/pyenv#basic-github-checkout

brew install pyenv
pyenv init --path
pyenv init -
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
# choose newest, f.ex. 3.10.0
NEWEST=$(pyenv install --list | grep -E "^\s*\d+\.\d+\.\d+$" | sort -V | tail -n 1 | xargs -I{} echo {})
echo "Will install Python $NEWEST as default"
pyenv install "$NEWEST"
# use it
pyenv global "$NEWEST"
# verify
python --version
echo "Done, please reboot the system"
