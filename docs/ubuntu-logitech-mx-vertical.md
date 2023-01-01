# Ubuntu 22.04 and Logitech MX Vertical
The Logitech MX Vertical generally works fine in Ubuntu 22.04 out of the box.
The only thing that doesn't work is the DPI button.

Here I will show how to make the DPI button usable - it will show the `Activities` screen
(something similar to MacOS App Expose)

## Reacting on the DPI button

The first problem to conquer is that the MX Vertical DPI button does not trigger a standard mouse event,
but uses a proprietary Logitech protocol - and therefore cannot be handled by a standard Linux tools.

Luckily, there's a software able to handle it - [Solaar](https://pwr-solaar.github.io/Solaar/).

So first of all, let's install it:
```shell
sudo apt update && sudo apt install solaar
```
Once installed, open the app and click `Rules editor`

Create a user-defined rule as follows:
```text
User-defined rules
  Rule
    Key:      DPI Switch (00FD) (released)
    Execute:  /bin/bash /home/<user>/dpi-button.sh
```
After this, each press of the DPI button on the mouse will execute a `~/dpi-button.sh` script.

**Note:** you can use any command to be executed in reaction to button click. I find using a custom script
easier to maintain.

## Showing Activities using command line in Ubuntu 22.04
Now, let's put some useful code inside `~/dpi-button.sh`.

In my case I find it most useful to open an `Activities` screen, which shows all open windows.
In fact Ubuntu will show `Activities` by default as a reaction to pressing the _Super_ key
on the keyboard, so our job is in fact to emulate _Super_ key press.

The exact way of achieving it depends on the display manager you're using.

!!! info "How to check which display manager is used"

    ```shell
    # Checking which display manager is used 
    echo $XDG_SESSION_TYPE
    ```

### Wayland version (default)
If you're using Wayland as a display manager - which is probably the case, as Wayland is a default
display manager in Ubuntu 22.04 - you need to install the `ydotool` tool. **Do not install if using apt**, 
it's outdated and buggy (as of November 2022)! Instead, use the following instruction: [https://askubuntu.com/a/1413830](https://askubuntu.com/a/1413830)

Then you can emulate pressing _Super_ (aka _Win_) key using the following command
```shell
ydotool key 125:1 125:0
```

To sum up, the `~/dpi-button.sh` should look like this:
```shell title="~/dpi-button.sh"
#!/bin/bash
ydotool key 125:1 125:0
```

**Note:** if the ydotool doesn't work after the reboot, create a following file: `~/.config/autostart/ydotoold.desktop`
with the following content:
```text title="~/.config/autostart/ydotoold.desktop"
[Desktop Entry]
Type=Application
Terminal=false
Name=ydotool deamon
Exec=/usr/local/bin/ydotoold
Comment=Generic Linux command-line automation tool (no X!).
Categories=GNOME;GTK;System;

```


### X.org version
While X.org is not the default display manager in Ubuntu 22.04, however it's still available and possible to use.

!!! info "How to change Ubuntu 22.04 display manager to X.org"

    Source: [https://askubuntu.com/a/1354342](https://askubuntu.com/a/1354342)

    Edit the file `/etc/gdm3/custom.conf` and uncomment line:
    ```text
    #WaylandEnable=false  
    ```
    Reboot

    Note that if you're using X.org, you might encounter lower performance on 4K displays.

If you're using X.org, use the following command to emulate pressing _Super_ (aka _Win_) key on the keyboard:
```shell
xdotool key super
```
And by default Ubuntu shows the `Activities` screen.

To sum up, the `~/dpi-button.sh` should look like this:
```shell title="~/dpi-button.sh"
#!/bin/bash
xdotool key super
```
