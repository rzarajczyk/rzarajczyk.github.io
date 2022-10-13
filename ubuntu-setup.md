# Ubuntu on Lenovo ThinkPad initial setup

**Note:** Under construction!

## Logitech MX Keys for Mac in Ubuntu 22.04
See [this description](logitech-mx-keys-ubuntu.md)

## Logitech MX Vertical
See [this description](logitech-mx-vertical-ubuntu.md)
  
## Background effects in MS Teams Linux

For some reason the MS Teams desktop client in Linux doesn't support background effects. The same applies to web client in Firefox. But the web client in Chrome does support them! So **simply use Chrome for Teams!**

## OpenJDK 17, Docker, git installation + command line tools
```shell
sudo apt update
  
sudo apt install -y openjdk-17-jdk
sudo apt install -y git
sudo apt install -y httpie

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF
dockerd-rootless-setuptool.sh install
docker context use rootless
echo 'echo "" >> ~/.bashrc' >> ~/.bashrc
echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' >> ~/.bashrc
```

Remember to set up git:
```shell
git config --global user.name "<name>"
git config --global user.email "<email>"
```
  
## GUI Tools

* [Google Chrome](https://www.google.pl/chrome) - Google Chrome
* [Slack](https://slack.com/downloads/linux) - Slack (note: use DEB version; do not use Snap version, it's buggy!)
```shell
snap install intellij-idea-ultimate --classic
```


## Gnome Extentions

* [Dash-to-panel](https://extensions.gnome.org/extension/1160/dash-to-panel/) - makes Gnome look more like Windows (one horizontal bar at the bottom)

