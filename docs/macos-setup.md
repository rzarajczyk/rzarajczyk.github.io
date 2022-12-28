# My favorite MacOS initial setup

## Key switching: right Command and Option, aka Polish characters like on Windows

If you're used to typing Polish characters using a key right next to
spacebar (like on Windows/Linux), use the following script to switch
places of right Command and Option

[⬇️ download](resources/macos-switch-right-command-option.sh)
```shell
--8<-- "resources/macos-switch-right-command-option.sh"
```
Note:

* `0x7000000e7` - right Command
* `0x7000000e6` - right Option
* other possibilities of key switching: [https://hidutil-generator.netlify.app/](https://hidutil-generator.netlify.app/)

## Key switching: tilde and paragraph
Switching places of tilde `~` and paragraph `§` buttons, 
for people used to US keyboard layout forced to work on EU keyboard.

[⬇️ download](resources/macos-switch-tilde-paragraph.sh)
```shell
--8<-- "resources/macos-switch-tilde-paragraph.sh"
```
Note:

* `0x700000064` - button `§`
* `0x700000035` - button `~` (tilde)
* other possibilities of key switching: [https://hidutil-generator.netlify.app/](https://hidutil-generator.netlify.app/)

## Buttons Home, End, Page Up i Page Down - like on Windows

On Windows pressing Home/End when entering a text in a website moves the caret position to the beginning/end of text field.
On MacOS, it will scroll the entire webpage.

[⬇️ download](resources/macos-home-end-buttons.sh)
```shell
--8<-- "resources/macos-home-end-buttons.sh"
```

## Key repeating on long key press
[⬇️ download](resources/macos-key-repeating-on-long-press.sh)
```shell
--8<-- "resources/macos-key-repeating-on-long-press.sh"
```

## Homebrew & coreutils & command line tools installation
 * [Homebrew](https://brew.sh/) - must-have package manager for MacOS
 * [coreutils](https://www.gnu.org/software/coreutils/) - GNU version of coreutils; MacOS is shipped with custom
version of some of coreutils, but they work in a slightly different way than the GNU ones
 * other software of my choice

[⬇️ download](resources/macos-install-brew-coreutils.sh)
```shell
--8<-- "resources/macos-install-brew-coreutils.sh"
```

## Python installation
Using [pyenv](https://github.com/pyenv/pyenv)

[⬇️ download](resources/macos-install-python.sh)
```shell
--8<-- "resources/macos-install-python.sh"
```

## Java installation (JDK 11 and 17 at once)
[⬇️ download](resources/macos-install-java.sh)
```shell
--8<-- "resources/macos-install-java.sh"
```

## Docker

See:

* [Docker without Docker Desktop on MacOS](macos-docker-without-docker-desktop.md)
* [Running amd64 Docker images on Apple M1/M2](macos-running-amd64-images-on-apple-m1.md)


## Disable "drag to top" opening Mission Controll

### MacOS 13 Ventura

Go to `System setting` > `Desktop and Dock`
Scroll to `Mission Control`
Uncheck "Displays have separate Spaces" then log out and back in again.

### Before MacOS 13 Ventura

Go to `System Preferences` > `Mission Control`
Uncheck "Displays have separate Spaces" then log out and back in again.

## Software
 - [Logi Options](https://www.logitech.com/pl-pl/software/options.html) app from Logitech for mouse and keyboard
 - [iTerm2](https://iterm2.com/) terminal, color preset: Solarized Light 
 - [Divvy](https://mizage.com/divvy/) window manager - paid. Allows resizing windows using a nice diagram
 - [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) - IDE
 - [Clipy](https://clipy-app.com/) multi-clipboard
 - [Tiles](https://www.sempliva.com/tiles/) Window Manager - freeware. Allows resizing windows by hotkeys or dragging
 - shell: ZSH + [oh-my-zsh](https://ohmyz.sh/)
 - [https://github.com/rzarajczyk/agnoster-zsh-theme](https://github.com/rzarajczyk/agnoster-zsh-theme) theme for oh-my-zsh: agnoster.rzarajczyk
 - [HP Drivers](https://support.apple.com/kb/DL1888?locale=en_US) - HP Drivers for older printers (see also [this link](https://h30434.www3.hp.com/t5/Printers-Knowledge-Base/Having-problems-installing-older-HP-Printers-on-later-macOS/ta-p/7946104))
 - [Adobe Reader](https://get.adobe.com/pl/reader/) - PDF reader

## Interesting Chrome Extensions
 - [Url Editor PRO](https://chrome.google.com/webstore/detail/url-editor-pro/maoigfcibanjdgnepaiiadjhgmejclea)
 - [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)
 - [ModHeader](https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj)
 - [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa)
 - [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg)

## Other interesting MacOS Apps
 - [BetterTouchTool](https://folivora.ai/) allows customizing almost everything in MacOS, including TouchBar.