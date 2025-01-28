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
