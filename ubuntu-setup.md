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
sudo apt install -y httpie wget curl screen jq
sudo apt install -y magic-wormhole
sudo apt install -y virtualbox

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

## Python (using pyenv)
```shell
sudo apt install -y make \
  build-essential \
  gcc \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  xz-utils \
  tk-dev
  
curl https://pyenv.run | bash
```

Add to `.bashrc`:
```shell
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

Then:
```shell
pyenv install --list
# choose the newest, f.ex. 3.10.7
pyenv install 3.10.7
pyenv global 3.10.7
```
  
## GUI Tools

* [Google Chrome](https://www.google.pl/chrome) - Google Chrome
* [Slack](https://slack.com/downloads/linux) - Slack (note: use DEB version; do not use Snap version, it's buggy!)
* [KeePassXC](https://keepassxc.org/download/#linux) - password manager
* [Shutter](https://shutter-project.org/downloads/third-party-packages/) - screenshooting tool. **Very limitted functionality with the Wayland displat manager**, but has a cool Drawing tool.
* [IntelliJ IDEA](https://www.jetbrains.com/idea/download/#section=linux) - IDE


## Gnome Extentions

* [Dash-to-panel](https://extensions.gnome.org/extension/1160/dash-to-panel/) - makes Gnome look more like Windows (one horizontal bar at the bottom)
* [gTile](https://extensions.gnome.org/extension/28/gtile/) - neat window placement manager, alternative to [WinDivvy](https://mizage.com/windivvy/)/[Divvy](https://mizage.com/divvy/) for MacOS

## OneDrive sync

1. First, install this command line tool: https://github.com/abraunegg/onedrive
2. Then, download this GUI tool: https://github.com/bpozdena/OneDriveGUI

**Note:** GUI is not an installer - it's a executable that just runs :-) So probably you'd like to move it to some `~/bin` folder before running.

