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
