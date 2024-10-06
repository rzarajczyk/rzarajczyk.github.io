# Family Rules

This is an ongoing project. It's a set of applications that help to manage a screen time for children.

Of course there are many commercial solutions for this, but I wanted to create something that will
allow to get usage statistics from all the devices I have at home (Windows, macOS, Android phone and tablet, Sony Bravia
TV) in one place.

It's designed in a client-server architecture, where the Server is the central point of managing the rules and
collecting statistics, and the clients are enforcing the rules on the devices. The clients are also sending the usage
statistics. The architecture is open, which means there's a well-defined REST API between a client and a server, so it's
possible to create a client for any device.

!!! warning "This is an ongoing project. It has bugs!"

    It has still many bugs! I use it at home, but keep in mind that it's not a commercial product.

## Components

  * [Family Rules Server](projects-family-rules-server.md) - the central point of managing the rules and collecting
    statistics.
  * [Family Rules Client](projects-family-rules-client.md) - the client for Windows and macOS.
  * [Family Rules Sony Bravia client](projects-family-rules-sony-bravia-tv.md) - the client for Sony Bravia TV.
  * [Family Rules Android](projects-family-rules-android.md) - the Android client (not working yet).

## Third party alternatives

There are many commercial solutions for managing screen time for children. Taking into account possibilities
and price, I can recommend:

#### Android

* [Google Family Link](https://families.google.com/familylink/) - is a free software from Google. If you're looking for
  parental control for Android, this is the first thing you should try.
* [Eset Parental Control](https://www.eset.com/int/parental-control-android/) - it's unique feature is the ability to
  group the apps info "unrestricted" and "time limited" groups, and set the time limits for the whole group. So you can
  set limits for all games and streamings at once, while leaving the educational apps unrestricted. It's a paid app,
  however it has a generous free tier - it's very likely you won't need to pay for Premium, if you combine it with the
  Family Link.

#### Windows

* [Microsoft Family Safety](https://account.microsoft.com/family/) - it's free, and it's built-in in Windows 10 and 11.
  It's a good starting point. 
