#!/bin/bash
brew install openjdk@11
brew install openjdk@17
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
sudo ln -sfn /usr/local/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
echo 'alias java11="export JAVA_HOME=$(/usr/libexec/java_home -v 11); java -version"' >> ~/.zshrc
echo 'alias java17="export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version"' >> ~/.zshrc
