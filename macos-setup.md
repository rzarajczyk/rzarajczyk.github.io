# My favorite MacOS initial setup

## Key switching: right Command and Option, aka Polish characters like on Windows
[download a script](resources/macos-switch-right-command-option.sh)

`~/Library/LaunchAgents/pl.zarajczyk.RightCommandOptionKeyRemappings.plist`
```xml
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
```
where:
* `0x7000000e7` - right Command
* `0x7000000e6` - right Option
* others: [https://hidutil-generator.netlify.app/](https://hidutil-generator.netlify.app/)

## Key switching: tilde and paragraph
[download a script](resources/macos-switch-tilde-paragraph.sh)

`~/Library/LaunchAgents/pl.zarajczyk.RightCommandOptionKeyRemappings.plist`
```xml
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
```
where:
* `0x700000064` - button `§`
* `0x700000035` - button `~` (tilde)
* others: [https://hidutil-generator.netlify.app/](https://hidutil-generator.netlify.app/)

## Buttons Home, End, Page Up i Page Down - like on Windows
[download a script](resources/macos-home-end-buttons.sh)

On Windows pressing Home/End when entering a text in a website moves the caret position to the beginning/end of text field.
On MacOS, it will scroll the entire webpage.

`~/Library/KeyBindings/DefaultKeyBinding.dict`
```shell
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
```

Additionally - iTerm:
`~/.zshrc`
```shell
bindkey '\e[H'    beginning-of-line
bindkey '\e[F'    end-of-line
```

## Key repeating on long key press
[download a script](resources/macos-key-repeating-on-long-press.sh)
```shell
defaults write -g ApplePressAndHoldEnabled -bool false
```

## Homebrew & coreutils installation
[download a script](resources/macos-install-brew-coreutils.sh)
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  ## from https://brew.sh/index_pl
brew install coreutils
echo 'PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.zshrc
```
## Python installation
[downloas a script](resources/macos-install-python.sh)
```shell

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

## Java installation (three versions at once)
[downloas a script](resources/macos-install-java.sh)
```shell
brew install openjdk@8
brew install openjdk@11
brew install openjdk@17
sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
sudo ln -sfn /usr/local/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
echo 'alias java8="export JAVA_HOME=$(/usr/libexec/java_home -v 1.8); java -version"' >> ~/.zshrc
echo 'alias java11="export JAVA_HOME=$(/usr/libexec/java_home -v 11); java -version"' >> ~/.zshrc
echo 'alias java17="export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version"' >> ~/.zshrc
```

## Disable "drag to top" opening Mission Controll

Go to `System Preferences` > `Mission Control`
Uncheck "Displays have separate Spaces" then log out and back in again.

## Software
 - [Logi Options](https://www.logitech.com/pl-pl/software/options.html) app from Logitech for mouse and keyboard
 - [iTerm2](https://iterm2.com/) terminal, color preset: Solarized Light 
 - [Divvy](https://mizage.com/divvy/) window manager - paid. Allows resizing windows using a nice diagram
 - [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) - IDE
 - [Clipy](https://clipy-app.com/) multi-clipboard
 - [Tiles](https://www.sempliva.com/tiles/) Window Manager - freeware. Allows resizing windows by hotkeys or dragging
 - shell: ZSH + oh-my-zsh
 - [https://github.com/rzarajczyk/agnoster-zsh-theme](https://github.com/rzarajczyk/agnoster-zsh-theme) theme for oh-my-zsh: agnoster.rzarajczyk\
 - [HP Drivers](https://support.apple.com/kb/DL1888?locale=en_US) - HP Drivers for older printers (see also [this link](https://h30434.www3.hp.com/t5/Printers-Knowledge-Base/Having-problems-installing-older-HP-Printers-on-later-macOS/ta-p/7946104))
 - [Adobe Reader](https://get.adobe.com/pl/reader/) - PDF reader

## Interesting Chrome Extensions
 - [Url Editor PRO](https://chrome.google.com/webstore/detail/url-editor-pro/maoigfcibanjdgnepaiiadjhgmejclea)
 - [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)
 - [ModHeader](https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj)
 - [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa)
 - [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg)

## Other interesting MacOS Apps
 - [BetterTouchTool](https://folivora.ai/) allows customizing almost everything in MacOS, inclouding TouchBar. My preset: preset: [btt.bttpreset](resources/btt.bttpreset)

## Disable mouse scroll acceleration
#### Note: this is probably not needed when Logi Options software is installed
Reading current value
```shell
defaults read .GlobalPreferences com.apple.scrollwheel.scaling
```
Disabling
```shell
defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1
```
