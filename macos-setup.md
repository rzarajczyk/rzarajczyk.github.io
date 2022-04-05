# My favorite MacOS initial setup

## Buttons Home, End, Page Up i Page Down - like on Windows

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

## Polish characters like on Windows + switch tilde and paragraph
`~/Library/LaunchAgents/pl.example.KeyRemappings.plist`
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
        {"HIDKeyboardModifierMappingSrc":0x7000000e6,"HIDKeyboardModifierMappingDst":0x7000000e7},
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

* `0x7000000e7` - right Cmmand
* `0x7000000e6` - right Option
* `0x700000064` - button `§`
* `0x700000035` - button `~` (tilde)

## Key repeatting on long key press
```shell
defaults write -g ApplePressAndHoldEnabled -bool false
```

## Homebrew & coreutils installation
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  ## from https://brew.sh/index_pl
brew install coreutils
```
## Python installation
```shell

# docs: https://github.com/pyenv/pyenv#basic-github-checkout
 
brew install pyenv
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
pyenv install --list
# choose newest, np. 3.10.0
pyenv install 3.10.0
# use it
pyenv global 3.10.0
# verify
python --version
```

## Disable "drag to top" opening Mission Controll

Go to `System Preferences` > `Mission Control`
Uncheck "Displays have separate Spaces" then log out and back in again.

## Mouse settings

### Disable mouse scroll acceleration
Reading current value
```shell
defaults read .GlobalPreferences com.apple.scrollwheel.scaling
```
Disabling
```shell
defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1
```

## Shell
 - terminal: iTerm, color preset: Solarized Light 
 - shell: ZSH + oh-my-zsh
 - theme: agnoster.rzarajczyk [https://github.com/rzarajczyk/agnoster-zsh-theme](https://github.com/rzarajczyk/agnoster-zsh-theme)

## BetterTouchTool
 - preset: [btt.bttpreset](btt.bttpreset)

## Interesting Chrome Extensions
 - [Url Editor PRO](https://chrome.google.com/webstore/detail/url-editor-pro/maoigfcibanjdgnepaiiadjhgmejclea)
 - [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)
 - [ModHeader](https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj)
 - [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa)
 - [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg)

## Interesting MacOS Apps
 - [Tiles](https://www.sempliva.com/tiles/) Window Manager - freeware. Allows resizing windows by hotkeys or dragging
 - [Divvy](https://mizage.com/divvy/) Window Manager - paid. Allows resizing windows using nice diagram
 - [BetterTouchTool](https://folivora.ai/) allows customizing almost everything in MacOS, inclouding TouchBar.
