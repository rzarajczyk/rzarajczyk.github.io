# Ubuntu initial setup

## Logitech MX Keys Mac in Ubuntu 22.04

The **Logitech MX Keys Mac** keyboard workd generally fine in Ubuntu, however it has a bit different layout than the one Ubuntu expects.

Especially, two changes are required for smooth work:
 * switch Win and Alt keys
 * use Eject key as PrintScreen

### GUI tool for remapping the keyboard
```shell
sudo apt update && sudo apt install input-remapper
```
![](resources/ubuntu-input-remapper.png)

**Note on "Left Win" key**: Input Remapper is unable to capture "Left Win" key, as it starts Gonme's launcher screen.
To avoid that, install **Gnome Tweaks** from Ubuntu Software and temporarily change launcher screen keyboard shortcut.

### Function keys without `fn`

There's a `FnLock` button on the keyboard (usually it's written on the `Esc` key)

## Background effects in MS Teams Linux

For some reason the MS Teams desktop client in Linux doesn't support backgrouind effects. The same applies do web client in Firefox. But the web client in Chrome does support them! So simply use Chrome form Teams!

## OpenJDK 17 installation and command line tools
```shell
sudo apt update
sudo apt install -y openjdk-17-jdk
sudo apt install -y git
```

## Gnome Extentions

https://extensions.gnome.org/extension/1160/dash-to-panel/

