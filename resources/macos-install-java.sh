#!/bin/zsh
if [[ $SHELL != '/bin/zsh' ]]; then
  echo "Please set ZSH as your default shell" && exit 1
fi

brew install openjdk@11
brew install openjdk@17
sudo ln -sfn $(brew --prefix openjdk@11)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
sudo ln -sfn $(brew --prefix openjdk@17)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
echo 'alias java11="export JAVA_HOME=$(/usr/libexec/java_home -v 11); java -version"' >> ~/.zshrc
echo 'alias java17="export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version"' >> ~/.zshrc
