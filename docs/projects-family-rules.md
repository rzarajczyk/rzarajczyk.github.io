# Family Rules

This is an ongoing project. It's a set of applications that help to manage a screen time for children.

Of course there are many commercial solutions for this, but I wanted to create something that will
allow to get usage statistics from all the devices I have at home (Windows, macOS, Android phone and tablet, Sony Bravia
TV) in one place.

It's designed in a client-server architecture, where the Server is the central point of managing the rules and
collecting statistics, and the clients are enforcing the rules on the devices. The clients are also sending the usage
statistics. The architecture is open, which means there's a well-defined REST API between a client and a server, so it's
possible to create a client for any device.

## This is an ongoing project. It has bugs!

It has still many bugs! I use it at home, but keep in mind that it's not a commercial product.

### Family Rules Server

A backend server that manages the rules and provides an API for clients. It also
provides the web UI for administrator. Written in Kotlin, distributed as Docker image.

Requires PostgreSQL.

Source code: [https://github.com/rzarajczyk/family-rules-server](https://github.com/rzarajczyk/family-rules-server)
Docker
hub: [https://hub.docker.com/r/rzarajczyk/family-rules-server](https://hub.docker.com/r/rzarajczyk/family-rules-server)

### Family Rules Client

A client application that enforces the rules on the client's computer.
Written in Python (PySide6), distributed as a standalone application in a Windows and macOS version.

What's interesting, to write this app I had to learn how to create a standalone application in Python.
I learned PySide6 and QtDesigner, how to package the app with PyInstaller, how to create installers for Windows and
macOS. Moreover, the "lock screen" required a bit of unusual code - it had to be a window, which covers the whole
screen,
it had to be on top of all other windows, and the child should not be able to close it.

It was a great learning experience.

The client allows the device to be in states:

- Active (default; usage is permitted)
- Locked (the lock screen is shown above all other windows, preventing the user from using the device)
- Locked with countdown (Locked, but before the lock screen is shown, a 60s countdown is displayed)
- Logged out (the user is forced to be logged out from the device)
- Logged out with countdown (Logged out, but before the lock screen is shown, a 60s countdown is displayed)
- App disabled (the app is completely disabled)

Source code: [https://github.com/rzarajczyk/family-rules-client](https://github.com/rzarajczyk/family-rules-client)
Downloads: [https://github.com/rzarajczyk/family-rules-client/releases](https://github.com/rzarajczyk/family-rules-client/releases)

### Family Rules Sony Bravia client

A simple Python-based client for a Sony Bravia TV. Tested on KD-49XH8505.

It should run on some server inside home network and communicates with the TV using the Sony API and Chromecast protocol.

Distributed as a Docker image.

Allows the TV to be in states:
 
 - Active (default; usage is permitted)
 - Turned off (the TV is turned off immediately after being turned on)

Link: [https://github.com/rzarajczyk/family-rules-sony-bravia-client](https://github.com/rzarajczyk/family-rules-sony-bravia-client)
Docker hub: [https://hub.docker.com/r/rzarajczyk/family-rules-sony-bravia-client](https://hub.docker.com/r/rzarajczyk/family-rules-sony-bravia-client)

### Family Rules Android

My playground in Android development. A FamilyRules client for Android devices and GitHub Copilot.
**Doesn't work yet!**

Link: [https://github.com/rzarajczyk/family-rules-android](https://github.com/rzarajczyk/family-rules-android)