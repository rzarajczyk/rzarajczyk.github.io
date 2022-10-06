# Ubuntu 22.04 and Logitech MX Vertical
The Logitech MX Vertical generally works fine in Ubuntu 22.04 out of the box.
The only thing that doesn't work is the DPI button.

Here I will show how to make the DPI button usable - it will show the `Activities` scree
(something similar to MacOS App Expose)

### Reacting on the DPI button

The first problem to conquer is that the MX Vertical DPI button does not trigger a standard mouse event,
but uses a proprietary Logitech protocol - and therefore cannot be handled by a standard Linux tools.

Luckily, there's a software able to handle Logitech protocol in Linux - [Solaar](https://pwr-solaar.github.io/Solaar/).

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
After this, each press of the DPI button on the mouse will execute a `/home/<user>/dpi-button.sh` script.

**Note:** you can use any command to be executed in reaction to button click. I find using a custom script
easier to maintain.

### Showing Activities using command line in Ubuntu 22.04
Now, let's put some useful code inside `/home/<user>/dpi-button.sh`.

In my case I find it most useful to open an `Activities` screen, which shows all open windows.
In fact Ubuntu will show `Activities` by default as a reaction to pressing the _Super_ key
on the keyboard, so our job is in fact to emulate _Super_ key press. 

First of all, we must switch Ubuntu to use _X.org_ instead of _Wayland_ as a display server.
The following description is based on this thread: https://askubuntu.com/a/1354342

**Note:** Maybe there's some way to do this in _Wayland_, but I don't know it

Edit the file `/etc/gdm3/custom.conf` and uncomment line:
```text
#WaylandEnable=false  
```
Reboot

Now, when Ubuntu is using _X.org_ (you can check it using `echo $XDG_SESSION_TYPE` command),
you can use the following command to emulate pressing _Super_ (aka _Win_) key on the keyboard:
```shell
xdotool key super
```
And by default Ubuntu shows the `Activities` screen.

To sum up, the `/home/<user>/dpi-button.sh` should look like this:
```shell
#!/bin/bash
xdotool key super
```