# Connect-Bluetooth-Device

If you have the error br-connection-profile-unavailable in your computer each time you try to connect with a bluetooth device that you had already paired.

The solution I have found is to put my device in pairing mode each time I poweron the computer, and connect it manually or by command line with `bluetoothctl`
For it I have created this script.

## Installation
1. Download the script in `~/bin` or `~/.local/bin`
```
  mkdir ~/bin
  git clone "https://github.com/alberto-765/Connect-Bluetooth-Device.git"
  cd Connect-Bluetooth-Device && mv connect_keyboard.sh ~/bin
```
2. Replace the MAC with you devices MAC
```
  nano ~/bin/connect_keyboard.sh
```
4. Add the script to autostart or create a one with you DE tool, as me with KDE and autostart
```
  mv Connect-Bluetooth-Device/connect_keyboard.sh.desktop ~/.config/autostart/
```
4. Create log file folder
```
  mkdir $HOME/.local/state/connect_keyboard
```

## Use
You have to put your device in pairing mode each time you are going to power on you computer. At this way the script are goint to:
1. Check if bluetooth is activated, if not it will exit.
2. Check if the device as been paired correctly before:
  1. If yes: it will try to connect with the device
  2. If not: it will remove the device for make a correct pair again, will scan bluetooth netwrok for 5 seconds, and will try to **pair, connect and trus** the device.
  The next times it will only make the pass 1.

**The script won't active the bluetooth automatically**, in my system I have configured to restore the bluetooth previous data. So if it was, it will be activated, when the system powered on again. I am using KDE.
### Active bluetooth each time system power on
You can add this to the beginning of the script

```
  #!/bin/bash
  bluetoothctl power on
```



## Questions
1. How see my devices MAC?
  1. By the GUI of your distribution
  2. Command line, you need to scan all devices before:
```
  bluetoothctl
  scan on
  devices # You will see your devices MAC and name
  info <MAC> # More information about the name and aliases
```
