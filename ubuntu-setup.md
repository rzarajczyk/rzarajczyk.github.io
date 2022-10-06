# Ubuntu on Lenovo ThinkPad initial setup

**Note:** Under construction!

## Logitech MX Keys for Mac in Ubuntu 22.04

The **Logitech MX Keys for Mac** keyboard workd generally fine in Ubuntu using a standard Bluetooth connection,
however it has a bit different layout than the one Ubuntu expects. 

### Switching places of Win and Alt keys (a.k.a. remapping Win/Alt keys)

To do that, install the following tool:
```shell
sudo apt update && sudo apt install input-remapper
```

This application allows to remap all recived keypresses. So basically start the application and create rules that remap:
 * `Alt_L` into `Super_L`
 * `Super_L` into `Alt_L`
 * `ISO Level3 Shift` into `Super_R` (note: this is the name of `Alt_R` detected on my setup. Honestly, I don't know why)
 * `Super_R` into `Alt_R` (yeap, here you can use `Alt_R` name)

**Note on "`Super_L`" key**: Input Remapper is unable to capture Super_L ("Left Win") key, as it starts Gonme's launcher screen.
To avoid that, install **Gnome Tweaks** from Ubuntu Software and temporarily change launcher screen keyboard shortcut.

### Function keys without `fn`

One - the simplest - way is to use FnLock. There's a `FnLock` button on the keyboard (usually it's written on the `Esc` key)

Second option is to use Solaar:
```shell
sudo apt update && sudo apt install solaar
```
After installing, open the app, select your keyboard and check "Swap Fx function"

### Enabling PrintScreen button
Logi MX Keys for Mac has a PrintScreen button located above the keypad `=` button - on the same key as F17. However I find it more handy to remap the Eject button to create screenshots.

To do that, install Solaar:
```shell
sudo apt update && sudo apt install solaar
```
After installing, open the app, and click "Rules editor"

Create a user-defined rule as follows:
```text
User-defined rules
  Rule
    Key:       Screen Capture/Print Screen (00BF) (pressed)
    Keyp ress: Print
  Rule
    Key:       Eject (000D) (pressed)
    Key press: Print
```

## Logitech MX Vertical - making DPI button shows the `Activities` screen (similar to MacOS App Expose)

### Reacting on the DPI button

The first problem to conquer is that the MX Vertical DPI button does not trigger a stndard mouse event, but uses a propertiary Logitech protocol,
and therefore cannot be handled by a standard Linux tools.

To fight this, install the following software:
```shell
sudo apt update && sudo apt install solaar
```
Open the app and click "Rules editor"

Create a user-defined rule as follows:
```text
User-defined rules
  Rule
    Key:      DPI Switch (00FD) (released)
    Execute:  /bin/bash /home/<user>/dpi-button.sh
```

After this, each press of the DPI button on the mouse will execute a /home/<user>/dpi-button.sh script
  
### Showing Activities using command line in Ubuntu 22.04
First, switch Ubuntu to use X.org instead of Wayland as a display server. The following description is based on this thread: https://askubuntu.com/a/1354342

Note: Maybe there's some way to do this in Wayland, but I don not know it

Edit file `/etc/gdm3/custom.conf`
Uncomment line:
```text
#WaylandEnable=false  
```
Reboot
  
Now, when Ubuntu is using X.org (you can check it using `echo $XDG_SESSION_TYPE` command), you can use the following command to emulate pressing "Super" (aka Win) key on the keyboard:
```shell
xdotool key super
```
  
To sum up, the `/home/<user>/dpi-button.sh` should look like this:
```shell
#!/bin/bash
xdotool key super
```
  
## Background effects in MS Teams Linux

For some reason the MS Teams desktop client in Linux doesn't support backgrouind effects. The same applies do web client in Firefox. But the web client in Chrome does support them! So **simply use Chrome for Teams!**

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

