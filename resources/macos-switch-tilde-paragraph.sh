#!/bin/bash
FILEPATH=~/Library/LaunchAgents/pl.zarajczyk.TildeParagraphKeyRemappings.plist
if [ -f $FILEPATH ]; then
  echo "File $FILEPATH already exists"
  exit 1
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
