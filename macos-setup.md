# My favorite MacOS initial setup

## Key switching: right Command and Option, aka Polish characters like on Windows

If you're used to typing Polish characters using a key right next to
spacebar (like on Windows/Linux), use the following script to switch
places of right Command and Option

<!--LISTING(resources/macos-switch-right-command-option.sh)-->
[⬇️ download](resources/macos-switch-right-command-option.sh)
```shell
#!/bin/zsh
FILEPATH=~/Library/LaunchAgents/pl.zarajczyk.RightCommandOptionKeyRemappings.plist
if [ -f $FILEPATH ]; then
  echo "File $FILEPATH already exists" && exit 1
fi

tee $FILEPATH << EOM
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.nanoant.KeyRemapping</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"UserKeyMapping":
    [
        {"HIDKeyboardModifierMappingSrc":0x7000000e7,"HIDKeyboardModifierMappingDst":0x7000000e6},
        {"HIDKeyboardModifierMappingSrc":0x7000000e6,"HIDKeyboardModifierMappingDst":0x7000000e7}
    ]
}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOM

echo "Done, please reboot the system"

```
<!--END LISTING-->
Note:
* `0x7000000e7` - right Command
* `0x7000000e6` - right Option
* other possibilities of key switching: [https://hidutil-generator.netlify.app/](https://hidutil-generator.netlify.app/)

## Key switching: tilde and paragraph
Switching places of tilde `~` and paragraph `§` buttons, 
for people used to US keyboard layout forced to work on EU keyboard.

<!--LISTING(resources/macos-switch-tilde-paragraph.sh)-->
[⬇️ download](resources/macos-switch-tilde-paragraph.sh)
```shell
#!/bin/zsh
FILEPATH=~/Library/LaunchAgents/pl.zarajczyk.TildeParagraphKeyRemappings.plist
if [ -f $FILEPATH ]; then
  echo "File $FILEPATH already exists" && exit 1
fi

tee $FILEPATH << EOM
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.nanoant.KeyRemapping</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"UserKeyMapping":
    [
        {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},
        {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}
    ]
}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOM

echo "Done, please reboot the system"

```
<!--END LISTING-->
Note:
* `0x700000064` - button `§`
* `0x700000035` - button `~` (tilde)
* other possibilities of key switching: [https://hidutil-generator.netlify.app/](https://hidutil-generator.netlify.app/)

## Buttons Home, End, Page Up i Page Down - like on Windows

On Windows pressing Home/End when entering a text in a website moves the caret position to the beginning/end of text field.
On MacOS, it will scroll the entire webpage.

<!--LISTING(resources/macos-home-end-buttons.sh)-->
[⬇️ download](resources/macos-home-end-buttons.sh)
```shell
#!/bin/bash
FILEPATH=~/Library/KeyBindings/DefaultKeyBinding.dict
if [ -f $FILEPATH ]; then
  echo "File $FILEPATH already exists" && exit 1
fi
if [[ $SHELL != '/bin/zsh' ]]; then
  echo "Please set ZSH as your default shell" && exit 1
fi

mkdir -p ~/Library/KeyBindings
tee $FILEPATH << EOM
{
  "\UF729"  = moveToBeginningOfParagraph:; // home
  "\UF72B"  = moveToEndOfParagraph:; // end
  "$\UF729" = moveToBeginningOfParagraphAndModifySelection:; // shift-home
  "$\UF72B" = moveToEndOfParagraphAndModifySelection:; // shift-end
  "^\UF729" = moveToBeginningOfDocument:; // ctrl-home
  "^\UF72B" = moveToEndOfDocument:; // ctrl-end
  "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // ctrl-shift-home
  "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // ctrl-shift-end
}
EOM

## Additional steps for iTerm2
echo "bindkey '\e[H'    beginning-of-line" >> ~/.zshrc
echo "bindkey '\e[F'    end-of-line" >> ~/.zshrc

echo "Done, please reboot the system"

```
<!--END LISTING-->

## Key repeating on long key press
<!--LISTING(resources/macos-key-repeating-on-long-press.sh)-->
[⬇️ download](resources/macos-key-repeating-on-long-press.sh)
```shell
#!/bin/zsh
defaults write -g ApplePressAndHoldEnabled -bool false
echo "Done, please reboot the system"
```
<!--END LISTING-->

## Homebrew & coreutils & command line tools installation
 * [Homebrew](https://brew.sh/) - must-have package manager for MacOS
 * [coreutils](https://www.gnu.org/software/coreutils/) - GNU version of coreutils; MacOS is shipped with custom
version of some of coreutils, but they work in a slightly different way than the GNU ones
 * other software of my choice

<!--LISTING(resources/macos-install-brew-coreutils.sh)-->
[⬇️ download](resources/macos-install-brew-coreutils.sh)
```shell
#!/bin/zsh
if [[ $SHELL != '/bin/zsh' ]]; then
  echo "Please set ZSH as your default shell" && exit 1
fi

if [ $(command -v brew) ]; then
  echo "brew already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  ## from https://brew.sh/
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew install coreutils
brew install watch
brew install wget
brew install screen
echo 'PATH="'$(brew --prefix coreutils)'/libexec/gnubin:$PATH"' >> ~/.zshrc
echo "Done, please reboot the system"

```
<!--END LISTING-->

## Python installation
Using [pyenv](https://github.com/pyenv/pyenv)

<!--LISTING(resources/macos-install-python.sh)-->
[⬇️ download](resources/macos-install-python.sh)
```shell
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

```
<!--END LISTING-->

## Java installation (JDK 11 and 17 at once)
<!--LISTING(resources/macos-install-java.sh)-->
[⬇️ download](resources/macos-install-java.sh)
```shell
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

```
<!--END LISTING-->

## Docker

See:
* [Docker without Docker Desktop on MacOS](macos-docker-without-docker-desktop.md)
* [Running amd64 Docker images on Apple M1/M2](macos-running-amd64-images-on-apple-m1)


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