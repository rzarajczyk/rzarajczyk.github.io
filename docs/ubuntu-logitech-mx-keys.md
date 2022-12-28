# Ubuntu 22.04 and Logitech MX Keys for Mac

The **Logitech MX Keys for Mac** keyboard works generally fine in Ubuntu using a standard Bluetooth connection,
however it has a bit different key layout than Ubuntu expects. 

## Switching places of Win and Alt keys (a.k.a. remapping Win/Alt keys)

To do that, install the following tool:
```shell
sudo apt update && sudo apt install input-remapper
```

This application allows to remap all recived keypresses. So basically start the application and create rules that remap:

* `Alt_L` into `Super_L`
* `Super_L` into `Alt_L`
* `ISO Level3 Shift` into `Super_R` (note: this is the name of `Alt_R` detected on my setup. Honestly, I don't know why)
* `Super_R` into `Alt_R` (yeap, here you can use `Alt_R` name)

**Note on `Super_L` key**: Input Remapper is unable to capture Super_L ("Left Win") key, as it starts Gonme's launcher screen.
To avoid that, install **Gnome Tweaks** from Ubuntu Software and temporarily change launcher screen keyboard shortcut.

## Function keys without `fn`

One - **the simplest** - way is to use FnLock.
There should be a `FnLock` button on the keyboard (usually it's written on the `Esc` key) - at least on Lenovo ThinkPad there is.

Alternatively you can use Solaar:
```shell
sudo apt update && sudo apt install solaar
```
After installing, open the app, select your keyboard and check "Swap Fx function"

## `Eject` button as PrintScreen
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
